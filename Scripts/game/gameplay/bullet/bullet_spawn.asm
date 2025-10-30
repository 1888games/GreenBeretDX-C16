.namespace BULLET {


		// a = bullet type?

	Fire: {

		pha


		ldx #MAX_SPRITES

		Loop:

			lda ZP.SpriteX, x
			bmi Found

			inx
			cpx #MAX_BULLETS + MAX_SPRITES
			bcc Loop

			ldx #MAX_SPRITES

		Found:

			pla
			sta ZP.SpriteState, x
			tay
			lda BulletCharColour, y
			sta ZP.SpriteColour, x

			lda #1
			sta ZP.SpriteTimer, x
			sta ZP.BulletXSpeed - MAX_SPRITES, x

			lda #255
			sta ZP.BulletStoredChars - MAX_SPRITES, x

			lda #0
			sta ZP.SpriteVelocity, x
			sta ZP.BulletSource - MAX_SPRITES, x


			// caller to set direction and position?


		rts
	}
}