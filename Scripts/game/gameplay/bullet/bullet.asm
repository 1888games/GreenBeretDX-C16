.namespace BULLET {

	* = * "Bullet"	

	Bullet:

	#import "scripts/game/gameplay/bullet/bullet_collision.asm"
	#import "scripts/game/gameplay/bullet/bullet_spawn.asm"
	#import "scripts/game/gameplay/bullet/bullet_move.asm"

	BulletCharColour:	.byte WHITE + LUMINANCE_7 + 8
						.byte WHITE + LUMINANCE_7 + 8
						.byte YELLOW + LUMINANCE_6 + 8
						.byte WHITE + LUMINANCE_7 + 8
						.byte BLUE + LUMINANCE_5 + 8
						

	Initialise: {

		ldx #MAX_BULLETS + MAX_SPRITES - 2

		lda #$FF

		Loop:

			sta ZP.EnemyX, x

			dex
			bpl Loop

		Exit:

		rts

	}


	Update: {

			stx ZP.SpriteID

			lda ZP.SpriteX, x
			bmi Initialise.Exit


			lda ZP.JustScrolled
			bpl NoScroll2

			dec ZP.SpriteX, x
			jmp CheckBulletReady

			
		NoScroll2:

			jsr SPRITE.Restore1x1 

		CheckBulletReady:

			lda ZP.SpriteTimer, x
			beq BulletReady

			dec ZP.SpriteTimer, x
			jmp DrawBullet

		BulletReady:

			//inc TED.BORDER_COLOR

			jsr AI

			lda ZP.SpriteX, x
			bmi Exit

		DrawBullet:

			//inc TED.BORDER_COLOR
			jsr CheckCollisions
			
			lda ZP.SpriteX, x
			bmi Exit

			jsr SPRITE.Draw1x1
		


		Exit:


		rts
	}

	AI: {


			jsr SPRITE.CalculatePositionAddresses

			lda ZP.BulletStoredChars - MAX_SPRITES, x
			cmp #255
			beq IsFirstFrame

		NotFirstFrame:
		
			jsr Move

		IsFirstFrame:

			rts
			//rts
	}

	

	CancelBullet: {

			lda #$FF
			sta ZP.SpriteX, x
			rts


	}

	

	BulletEnd:
	.print ("BULLET......" + (BulletEnd - Bullet))

}