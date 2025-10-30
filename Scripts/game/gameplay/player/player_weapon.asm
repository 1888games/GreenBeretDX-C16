.namespace PLAYER {

	.var ammoPos = "Top"

	WeaponMax:	.byte 4, 3, 3

	WeaponChar:

	.if (ammoPos == "Top") {
		.byte 32, 32, 88, 65, 81

	} else { 

		.byte 32, 32, 253, 254, 255
	}
	
	GainWeapon: {

		// x = spriteID of Weapon...

		lda ZP.SpriteMasterState, x
		tay

	ByY:

		lda WeaponMax - 2, y
		sta ZP.PlayerBullets

		tya

		sty ZP.PlayerWeapon

		lda #1
		jsr SCORE.AddThousands

		jmp DrawAmmo

	}

	


	DrawAmmo: {

		ldy ZP.PlayerWeapon
		ldx #0
	
		lda BULLET.BulletCharColour, y

		.if (ammoPos == "Top") {
			sec
			sbc #8

		}
		sta ZP.Colour

		lda WeaponChar, y
		tay

		Loop:

			cpx ZP.PlayerBullets
			bcc DrawBullet

			lda #32
			jmp Draw

		DrawBullet:

			tya

		Draw:

			.if (ammoPos == "Top") {

				sta SCREEN_RAM + (40 * 2) + 3, x

				lda ZP.Colour
				sta TED.COLOR_RAM + (40 * 2) + 3, x

			}
			else {

				sta SCREEN_RAM + (40 * 24) + 1, x

				lda ZP.Colour
				sta TED.COLOR_RAM + (40 * 24) + 1, x

			}

			inx
			cpx #4
			bcc Loop

		ldx #0


		rts
	}
}