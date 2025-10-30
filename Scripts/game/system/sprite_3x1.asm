.namespace SPRITE {



	Backup3x1: {

		iny 
		lda (ZP.ScreenAddress), y
		sta ZP.SpriteStoredChars + (MAX_SPRITES * 2), x 

		lda (ZP.ColourAddress), y
		sta ZP.SpriteStoredColours + (MAX_SPRITES * 2), x 

		rts
	}


	Restore3x1: {

		iny 
		lda ZP.SpriteStoredChars + (MAX_SPRITES * 2), x
		cmp #PLAYER_CHAR_START
		bcs Skip
		sta (ZP.ScreenAddress), y
		lda ZP.SpriteStoredColours + (MAX_SPRITES * 2), x
		sta (ZP.ColourAddress), y

	Skip:

		rts
	}

	Place3x1: {

		ldy #0

		lda ZP.Colour
		sta (ZP.ColourAddress), y
	
		lda SpriteStart, x	
		sta (ZP.ScreenAddress), y

		clc
		adc #1
		iny

		sta (ZP.ScreenAddress), y

		adc #1
		iny
		sta (ZP.ScreenAddress), y


		lda ZP.Colour

		ldy #1
		sta (ZP.ColourAddress), y

		iny
		sta (ZP.ColourAddress), y

		rts

		
	}

	Copy3x1: {


		lda ZP.SpriteStoredChars + (MAX_SPRITES * 2), x
		jsr GetBgCharAddress

		ldx ZP.Frame
		lda MiddleLeftCharsLSB, x
		sta CopyCharBytes.Branch.Source + 1

		lda MiddleLeftCharsMSB, x
		sta CopyCharBytes.Branch.Source + 2

		jmp CopyCharBytes

	}



}