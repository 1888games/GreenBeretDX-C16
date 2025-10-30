.namespace MAP {

	* = * "Mapload"

	MapLoad:

	StageBackgrounds:	.byte LUMINANCE_5 + 13, WHITE + LUMINANCE_4, 12 + LUMINANCE_6, 12 + LUMINANCE_6
	

	CalculateMapAddresses: {

		lda #<MAP_LOCATION
		sta ZP.SourceAddress

		lda #>MAP_LOCATION
		sta ZP.SourceAddress + 1

		ldy MAIN.CurrentStage
		lda StageBackgrounds, y
		sta ZP.StageBackgroundColour

		ldy #0
		sty ZP.CurrentSectorID
		sty ZP.CurrentSectorNumber
		sty ZP.ScrollSectorNumber
		sty ZP.SectorXOffset
		sty ZP.CurrentSectorDrawn

		lda (ZP.SourceAddress), y
		sta ZP.NumSectors


		lda ZP.SourceAddress
		clc
		adc #16
		clc
		adc ZP.NumSectors
		sta ZP.SectorDataAddress

		inc ZP.NumSectors

		lda ZP.SourceAddress + 1
		adc #0
		sta ZP.SectorDataAddress + 1


		rts
	}

	CopyMapTo200: {


		ldx #0
	
		Loop:

			lda $3000, x
			sta MAP_ADDRESS + $0, x

			lda $3100, x
			sta MAP_ADDRESS + $100, x

			lda $3200, x
			sta MAP_ADDRESS + $200, x

			lda $3300, x
			sta MAP_ADDRESS + $300, x

			lda $3400, x
			sta MAP_ADDRESS + $400, x

			lda $3500, x
			sta MAP_ADDRESS + $500, x

			lda $3600, x
			sta MAP_ADDRESS + $600, x

			lda $3700, x
			sta MAP_ADDRESS + $700, x

		

			inx
			bne Loop

			inc MAIN.MapCopied


		rts

	}

	GetSectorData: {

		lda SectorIDs, x
		sta ZP.CurrentSectorID

		asl
		asl
		tay

		lda (ZP.SectorDataAddress), y
		sta ZP.CurrentSectorLength

		iny
		lda (ZP.SectorDataAddress), y
		sta ZP.Colour

		iny
		lda (ZP.SectorDataAddress), y 
		sta ZP.SectorMapAddress

		iny
		lda (ZP.SectorDataAddress), y
		sta ZP.SectorMapAddress + 1

		cpx ZP.ScrollSectorNumber
		bne NotFirst


		lda ZP.CurrentSectorLength
		sta ZP.ScrollSectorLength

	NotFirst:


		rts
	}


	

	DrawSector: {

		ldx ZP.CurrentSectorNumber
		
		jsr GetSectorData

		lda ZP.SectorMapAddress
		clc
		adc ZP.ThisSectorXOffset
		sta LoadChar + 1

		lda ZP.SectorMapAddress + 1
		adc #0
		sta LoadChar + 2

		lda ZP.CurrentSectorLength
		sec
		sbc ZP.ThisSectorXOffset
		sta ZP.CurrentSectorTruncate
		clc
		adc ZP.ScreenColumnsDrawn

	CheckLoop:
		cmp #40
		bcc Okay

		dec ZP.CurrentSectorTruncate
		sec
		sbc #1
		jmp CheckLoop

	Okay:

		ldx #0
		ldy #0

	CharLoop:

		//sty ZP.RowsDrawn

		LoadChar:		lda $BEEF, x
		StoreChar:  	sta $BEEF, x


		lda ZP.Colour
		clc
		adc Luminances, y
		StoreColour: 	sta $BEEF,x 

		inx
		cpx ZP.CurrentSectorTruncate
		bcc CharLoop

		iny
		cpy #12
		bcs Done

		lda LoadChar + 1
		clc
		adc ZP.CurrentSectorLength
		sta LoadChar + 1

		lda LoadChar + 2
		adc #0
		sta LoadChar + 2


		lda StoreChar + 1
		clc
		adc #40
		sta StoreChar + 1
		sta StoreColour + 1


		lda StoreChar + 2
		adc #0
		sta StoreChar + 2
		sec
		sbc #4
		sta StoreColour + 2

		ldx #0

		jmp CharLoop
	
	Done:




		rts
	}


	FillScreen: {

		lda MAIN.GameMode
		cmp #GAME_MODE_PLAY
		bne NotSky

		jsr SCREEN.ClearSky

	NotSky:

		lda ZP.ScrollSectorNumber
		sta ZP.CurrentSectorNumber
		lda ZP.SectorXOffset
		sta ZP.ThisSectorXOffset

		lda #0
		sta ZP.ScreenColumnsDrawn
		sta ZP.CurrentSectorDrawn
		sta ZP.RowsDrawn


	SectorLoop:

		lda #<(SCREEN_RAM + (40 * 12)) 
		sta DrawSector.StoreChar + 1
		sta DrawSector.StoreColour + 1

		lda #>(SCREEN_RAM + (40 * 12))
		sta DrawSector.StoreChar + 2
		sta DrawSector.StoreColour + 2

		lda DrawSector.StoreChar + 1
		clc
		adc ZP.ScreenColumnsDrawn
		sta DrawSector.StoreChar + 1
		sta DrawSector.StoreColour + 1

		lda DrawSector.StoreChar + 2
		adc #0
		sta DrawSector.StoreChar + 2
		sec
		sbc #4
		sta DrawSector.StoreColour + 2


		jsr DrawSector


		lda ZP.ScreenColumnsDrawn
		clc
		adc ZP.CurrentSectorTruncate
		sta ZP.ScreenColumnsDrawn

		cmp #39
		bcs DoneAll

		lda #0
		sta ZP.RowsDrawn
		sta ZP.ThisSectorXOffset

		inc ZP.CurrentSectorNumber

		lda ZP.CurrentSectorNumber
		cmp ZP.NumSectors
		bne NotLast

	ReachedEnd:

		jsr ENEMY.UpdateBoss.SetTime
		inc ZP.ScrollStopFlag

	NotLast:

		jmp SectorLoop

	DoneAll:

		//jmp SCREEN.ClearSky

		rts
	}

	MapLoadEnd:
	.print ("MAPLOAD....." + (MapLoadEnd - MapLoad))
}



