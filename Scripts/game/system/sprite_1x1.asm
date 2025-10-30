.namespace SPRITE {

	BulletCharLSB:		.fill 10, <[$0EC8 + (i * 8)]
	BulletCharMSB:		.fill 10, >[$0EC8 + (i * 8)]

	.label BULLET_CHAR_START = 243

	
	Draw1x1: {

		lda ZP.SpriteColour, x
		sta ZP.Colour

		jsr CalculatePositionAddresses


	BackupChar:

		ldy #0
		lda (ZP.ScreenAddress), y
		sta ZP.BulletStoredChars - MAX_SPRITES, x

		lda (ZP.ColourAddress), y
		sta ZP.BulletStoredColours - MAX_SPRITES, x

	CreateMaskedChar:

		jsr Copy1x1

	PlaceChars:

		ldy #0

		lda ZP.Colour
		sta (ZP.ColourAddress), y
	
		lda ZP.SpriteID
		tax
		clc
		adc #BULLET_CHAR_START - MAX_SPRITES
		sta (ZP.ScreenAddress), y


		rts
	}



	Restore1x1: {

		jsr CalculatePositionAddresses

		ldy #0
		lda ZP.BulletStoredChars - MAX_SPRITES, x
		cmp #PLAYER_CHAR_START
		bcs Skip
		sta (ZP.ScreenAddress), y

		lda ZP.BulletStoredColours - MAX_SPRITES, x
		sta (ZP.ColourAddress), y

	Skip:
	

		rts

	}



	Copy1x1: {

		// x = spriteID, y = 0

		lda SpriteCharAddress_LSB, x
		sta CopyCharBytes.Branch.Dest + 1

		lda SpriteCharAddress_MSB, x
		sta CopyCharBytes.Branch.Dest + 2


		lda ZP.BulletStoredChars - MAX_SPRITES, x
		jsr GetBgCharAddress

		lda ZP.SpriteState, x
		cmp #5
		bcc Okay

		and #%00001111
		clc
		adc #5

	Okay:

		tax

		lda BulletCharLSB, x
		sta CopyCharBytes.Branch.Source + 1

		lda BulletCharMSB, x
		sta CopyCharBytes.Branch.Source + 2

		jmp CopyCharBytes


	}



}