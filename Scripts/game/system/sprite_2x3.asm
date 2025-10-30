.namespace SPRITE {


	BackupChars: {

		ldy #0
		lda (ZP.ScreenAddress), y
		sta ZP.SpriteStoredChars + 0, x

		lda (ZP.ColourAddress), y
		sta ZP.SpriteStoredColours + 0, x

		iny 
		lda (ZP.ScreenAddress), y
		sta ZP.SpriteStoredChars + (MAX_SPRITES * 1), x 

		lda (ZP.ColourAddress), y
		sta ZP.SpriteStoredColours + (MAX_SPRITES * 1), x

		lda ZP.SpriteCrawling, x
		beq TwoByThree
	
		jmp Backup3x1

	TwoByThree:

		ldy #40
		lda (ZP.ScreenAddress), y
		sta ZP.SpriteStoredChars + (MAX_SPRITES * 2), x 

		lda (ZP.ColourAddress), y
		sta ZP.SpriteStoredColours + (MAX_SPRITES * 2), x 

		iny 
		lda (ZP.ScreenAddress), y
		sta ZP.SpriteStoredChars + (MAX_SPRITES * 3), x 

		lda (ZP.ColourAddress), y
		sta ZP.SpriteStoredColours + (MAX_SPRITES * 3), x 

		ldy #80
		lda (ZP.ScreenAddress), y
		sta ZP.SpriteStoredChars + (MAX_SPRITES * 4), x 

		lda (ZP.ColourAddress), y
		sta ZP.SpriteStoredColours +(MAX_SPRITES * 4), x 

		iny 
		lda (ZP.ScreenAddress), y
		sta ZP.SpriteStoredChars + (MAX_SPRITES * 5), x 

		lda (ZP.ColourAddress), y
		sta ZP.SpriteStoredColours + (MAX_SPRITES * 5), x 


		rts
	}

	RestoreChars: {


		jsr CalculatePositionAddresses

		ldy #0
		lda ZP.SpriteStoredChars + (MAX_SPRITES * 0), x
		cmp #PLAYER_CHAR_START
		bcs Skip1
		sta (ZP.ScreenAddress), y
		lda ZP.SpriteStoredColours + (MAX_SPRITES * 0), x
		sta (ZP.ColourAddress), y

	Skip1:

		iny 
		lda ZP.SpriteStoredChars + (MAX_SPRITES * 1), x
		cmp #PLAYER_CHAR_START
		bcs Skip2
		sta (ZP.ScreenAddress), y
		lda ZP.SpriteStoredColours + (MAX_SPRITES * 1), x
		sta (ZP.ColourAddress), y

	Skip2:

		lda ZP.SpriteLastFrameState, x
		and #%11101111
		cmp #STATE_CROUCH_RIGHT
		bcc TwoByThree

		cmp #STATE_GRENADES
		beq ThreeByOne

		cmp #STATE_MINE
		bcs ThreeByOne

		cmp #DIR_OFFSET
		bcs TwoByThree

		cmp #STATE_KICK_RIGHT
		beq TwoByThree

		cmp #STATE_SHOOT_RIGHT
		beq TwoByThree

	ThreeByOne:
	
		jmp Restore3x1

	TwoByThree:

		lda ZP.SpriteY, x
		cmp #22
		bcc Okay

		rts

	Okay:

		ldy #40
		lda ZP.SpriteStoredChars + (MAX_SPRITES * 2), x
		cmp #PLAYER_CHAR_START
		bcs Skip3
		sta (ZP.ScreenAddress), y
		lda ZP.SpriteStoredColours + (MAX_SPRITES * 2), x
		sta (ZP.ColourAddress), y

	Skip3:
		iny 
		lda ZP.SpriteStoredChars + (MAX_SPRITES * 3), x
		cmp #PLAYER_CHAR_START
		bcs Skip4
		sta (ZP.ScreenAddress), y
		lda ZP.SpriteStoredColours + (MAX_SPRITES * 3), x
		sta (ZP.ColourAddress), y

	Skip4:

		ldy #80
		lda ZP.SpriteStoredChars + (MAX_SPRITES * 4), x
		cmp #PLAYER_CHAR_START
		bcs Skip5
		sta (ZP.ScreenAddress), y
		lda ZP.SpriteStoredColours + (MAX_SPRITES * 4), x
		sta (ZP.ColourAddress), y

	Skip5:

		iny 
		lda ZP.SpriteStoredChars + (MAX_SPRITES * 5), x
		cmp #PLAYER_CHAR_START
		bcs Skip6
		sta (ZP.ScreenAddress), y
		lda ZP.SpriteStoredColours + (MAX_SPRITES * 5), x
		sta (ZP.ColourAddress), y

	Skip6:

		rts
	}

	PlaceChars: {

		lda ZP.SpriteCrawling, x
		beq TwoByThree
		

		jmp Place3x1


	TwoByThree:

		lda ZP.SpriteY, x
		cmp #22
		bcc Okay

		rts

		//.break
		//nop
		//nop

	Okay:

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
		ldy #40

		sta (ZP.ScreenAddress), y

		iny
		adc #1
		sta (ZP.ScreenAddress), y

		ldy #80
		adc #1
		sta (ZP.ScreenAddress), y

		iny
		adc #1
		sta (ZP.ScreenAddress), y

		lda ZP.Colour

		ldy #1
		sta (ZP.ColourAddress), y

		ldy #40
		sta (ZP.ColourAddress), y

		iny
		sta (ZP.ColourAddress), y

		ldy #80
		sta (ZP.ColourAddress), y

		iny
		sta (ZP.ColourAddress), y


		rts


		
	}







}