.namespace SCREEN {

	* = * "Screen"

	Screen:


	DrawFloor: {

		ldx #0
	

	FloorLoop:

		lda #1
		sta SCREEN_RAM + (40 * 24), x

		lda #LUMINANCE_7 + WHITE + 8
		sta TED.COLOR_RAM + (40 * 24), x

		inx
		cpx #40
		bcc FloorLoop

	Exit:

		rts
	}


	ClearSky: {

	

		ldx #9

		lda #32

		Loop:

			sta SCREEN_RAM + (40 * 6), x
			sta SCREEN_RAM + (40 * 7), x
			sta SCREEN_RAM + (40 * 8), x
			sta SCREEN_RAM + (40 * 9), x
			sta SCREEN_RAM + (40 * 10), x
			sta SCREEN_RAM + (40 * 11), x

			sta SCREEN_RAM + (40 * 6) + 20, x
			sta SCREEN_RAM + (40 * 7) + 20, x
			sta SCREEN_RAM + (40 * 8) + 20, x
			sta SCREEN_RAM + (40 * 9) + 20, x
			sta SCREEN_RAM + (40 * 10) + 20, x
			sta SCREEN_RAM + (40 * 11) + 20, x

			sta SCREEN_RAM + (40 * 6) + 10, x
			sta SCREEN_RAM + (40 * 7) + 10, x
			sta SCREEN_RAM + (40 * 8) + 10, x
			sta SCREEN_RAM + (40 * 9) + 10, x
			sta SCREEN_RAM + (40 * 10) + 10, x
			sta SCREEN_RAM + (40 * 11) + 10, x

			sta SCREEN_RAM + (40 * 6) + 30, x
			sta SCREEN_RAM + (40 * 7) + 30, x
			sta SCREEN_RAM + (40 * 8) + 30, x
			sta SCREEN_RAM + (40 * 9) + 30, x
			sta SCREEN_RAM + (40 * 10) + 30, x
			sta SCREEN_RAM + (40 * 11) + 30, x

			dex
			bpl Loop


		rts
	}

	CheckScrollAdjust: {

		lda ZP.FineScroll
		cmp #7
		beq DrawFloor.Exit

		clc
		adc #2
		sta ZP.FineScroll

		jmp SetFineScroll

	}

	SetFineScroll: {

		lda $FF07
		and #%11111000
		ora ZP.FineScroll
		sta $FF07

		rts

	}

	ScrollLookup:	.byte 7, 5, 3, 1

	Scroll: {
		
		lda ZP.PlayerX
		cmp #SCROLL_THRESHOLD
		bcs DoScroll

	NoScroll:

		lda #0
		sta ZP.JustScrolled
		rts

	DoScroll:

		lda ZP.ScrollStopFlag
		bne NoScroll

		ldy ZP.PlayerFrame
		lda ScrollLookup, y
		cmp #7
		bne NoWrap

		inc ZP.SectorXOffset
		lda ZP.SectorXOffset

		cmp ZP.ScrollSectorLength
		bcc NotNextSector

		inc ZP.ScrollSectorNumber

		lda #0
		sta ZP.SectorXOffset
	

	NotNextSector:

		lda #7

	NoWrap:


		sta ZP.FineScroll

		jsr SetFineScroll
		
		lda ZP.FineScroll
		cmp #7
		beq Scroll

		lda #1
		sta ZP.JustScrolled 
		sta ZP.HurryTimer
		rts

	Scroll:

		jsr MAP.FillScreen

		lda #$FF
		sta ZP.JustScrolled
		rts

	}
	


	Clear: {

		ldx #250
		lda #32

		Loop:

	
			sta SCREEN_RAM - 1, x
			sta SCREEN_RAM + 249, x
			sta SCREEN_RAM + 499, x
			sta SCREEN_RAM + 749, x

			dex
			bne Loop


		rts	


	}

	ScreenEnd:

	.print ("SCREEN......" + (ScreenEnd - Screen))


}