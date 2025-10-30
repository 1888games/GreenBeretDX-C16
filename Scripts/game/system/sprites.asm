

.label NUM_CHARS_FACE = 44


.label FACE_RIGHT_OFFSET = 0
.label FACE_LEFT_OFFSET = NUM_CHARS_FACE

.var method = "Blue"


.namespace SPRITE {

	* = * "Sprite"

	Sprite:

	#import "scripts/game/system/sprite_2x3.asm"
	#import "scripts/game/system/sprite_3x1.asm"
	#import "scripts/game/system/sprite_1x1.asm"

	RowStart_LSB: .fill 25, <i * 40
	RowStart_MSB: .fill 25, >i * 40

	SpriteStart:  			.fill MAX_SPRITES, PLAYER_CHAR_START + (i * 6)

	* = * "Sprite Char Addresses"

	SpriteCharAddress_LSB:	.fill MAX_SPRITES, <[CHARSET_ADDRESS + ([PLAYER_CHAR_START + (i * 6)] * 8)]
							.fill MAX_BULLETS, <[[CHARSET_ADDRESS + ([PLAYER_CHAR_START + (MAX_SPRITES * 6)] * 8)] + (i * 8)]

	SpriteCharAddress_MSB:	.fill MAX_SPRITES, >[CHARSET_ADDRESS + ([PLAYER_CHAR_START + (i * 6)] * 8)]
							.fill MAX_BULLETS, >[[CHARSET_ADDRESS + ([PLAYER_CHAR_START + (MAX_SPRITES * 6)] * 8)] + (i * 8)]



	Draw: {

		
		jsr CommonDraw

		jsr BackupChars
		jsr CopySpriteData

		ldx ZP.SpriteID

		jmp PlaceChars
		
	}


	CommonDraw: {

		stx ZP.SpriteID

		lda ZP.SpriteColour, x
		sta ZP.Colour

		jmp CalculatePositionAddresses


	}


	GetBgCharAddress: {

		.if (method == "Blue") {

	

			//lda (ZP.ScreenAddress), y
			sta CopyCharBytes.Branch.Bg + 1

			lda #0
			sta CopyCharBytes.Branch.Bg + 2

			asl CopyCharBytes.Branch.Bg + 1      
			rol CopyCharBytes.Branch.Bg + 2
			asl CopyCharBytes.Branch.Bg + 1      
			rol CopyCharBytes.Branch.Bg + 2
			asl CopyCharBytes.Branch.Bg + 1      
			rol CopyCharBytes.Branch.Bg + 2

			lda CopyCharBytes.Branch.Bg + 2
			clc
			adc #$38
			sta CopyCharBytes.Branch.Bg + 2

		
		}


		rts
	}


	//DirOffset:	.byte 0, 16 - 1

	* = * "CopySpriteData"

	CopySpriteData: {

			lda SpriteCharAddress_LSB, x
			sta CopyCharBytes.Branch.Dest + 1

			lda SpriteCharAddress_MSB, x
			sta CopyCharBytes.Branch.Dest + 2

			lda #0
			cpx #0
			bne NoStab

			ldy ZP.Stabbing
			bne NoBullets

		NoStab:

			lda ZP.SpriteBullets, x
			beq NoBullets

			lda #4

		NoBullets:

			clc
			adc ZP.SpriteState, x
			adc ZP.SpriteFrame, x
			sta ZP.Frame



		TopLeft:

			ldy #0

			lda ZP.SpriteStoredChars + (MAX_SPRITES * 0), x
			jsr GetBgCharAddress

			ldx ZP.Frame
			lda TopLeftCharsLSB, x
			sta CopyCharBytes.Branch.Source + 1

			lda TopLeftCharsMSB, x
			sta CopyCharBytes.Branch.Source + 2

			jsr CopyCharBytes

		TopRight:

			ldx ZP.SpriteID

			lda ZP.SpriteStoredChars + (MAX_SPRITES * 1), x
			jsr GetBgCharAddress

	
			ldx ZP.Frame
			lda TopRightCharsLSB, x
			sta CopyCharBytes.Branch.Source + 1

			lda TopRightCharsMSB, x
			sta CopyCharBytes.Branch.Source + 2

			jsr CopyCharBytes

		MiddleLeft:

			ldx ZP.SpriteID

	

			lda ZP.SpriteStoredChars + (MAX_SPRITES * 2), x
			jsr GetBgCharAddress


			ldx ZP.Frame
			lda MiddleLeftCharsLSB, x
			sta CopyCharBytes.Branch.Source + 1

			lda MiddleLeftCharsMSB, x
			sta CopyCharBytes.Branch.Source + 2

			jsr CopyCharBytes

		MiddleRight:

* = * "Check Frame"

			ldx ZP.SpriteID

			lda ZP.SpriteCrawling, x
			beq TwoByThree
	
			//and #%11101111
			//cmp #STATE_CROUCH_RIGHT
			//bcc TwoByThree

			//
			//cmp #STATE_CLIMB
			//bcs TwoByThree

			//cmp #STATE_KICK_RIGHT
			//beq TwoByThree

			rts

		TwoByThree:

			//ldy #41

			lda ZP.SpriteStoredChars + (MAX_SPRITES * 3), x
			jsr GetBgCharAddress
//
		

			ldx ZP.Frame
			lda MiddleRightCharsLSB, x
			sta CopyCharBytes.Branch.Source + 1

			lda MiddleRightCharsMSB, x
			sta CopyCharBytes.Branch.Source + 2

			jsr CopyCharBytes

		BottomLeft:


			ldx ZP.SpriteID
			//ldy #80

			lda ZP.SpriteStoredChars + (MAX_SPRITES * 4), x
			jsr GetBgCharAddress

	
			ldx ZP.Frame
			lda BottomLeftCharsLSB, x
			sta CopyCharBytes.Branch.Source + 1

			lda BottomLeftCharsMSB, x
			sta CopyCharBytes.Branch.Source + 2

			jsr CopyCharBytes

		BottomRight:

			ldx ZP.SpriteID
			//ldy #81

			lda ZP.SpriteStoredChars + (MAX_SPRITES * 5), x
			jsr GetBgCharAddress

			ldx ZP.Frame
			lda BottomRightCharsLSB, x
			sta CopyCharBytes.Branch.Source + 1

			lda BottomRightCharsMSB, x
			sta CopyCharBytes.Branch.Source + 2

			jmp CopyCharBytes

		



		
	}


	CopyCharBytes: {

		ldx #0

		Loop:

		Branch: .if (method == "Blue") {

			stx ZP.Temp2

			Bg:		lda $BEEF, x
					pha

			Source: lda $BEEF, x
					sta ZP.Temp1

					tax

					pla
					and MaskTable, x
					ora ZP.Temp1

					ldx ZP.Temp2

			Dest:   sta $BEEF, y


		}

		else {

			Source: lda $BEEF, x
			Dest:	sta $BEEF, y

		}



		inx
		iny
		cpx #8
		bcc Loop

		rts
	}



	
		// x = sprite ID

	CalculatePositionAddresses: {

		lda ZP.SpriteY, x
		tay

		lda RowStart_LSB, y
		clc
		adc ZP.SpriteX, x

	StoreAddresses:

		sta ZP.ScreenAddress
		sta ZP.ColourAddress

		lda RowStart_MSB, y
		adc #>SCREEN_RAM
		sta ZP.ScreenAddress + 1
		sec
		sbc #4
		sta ZP.ColourAddress + 1

		rts


	}

	SpriteEnd:
	.print ("SPRITE CODE." + (SpriteEnd - Sprite))
	
}