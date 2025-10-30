.namespace ENEMY {


	SpawnRocketLauncher: {


		lda #2
		sta ZP.SpriteBullets, x
		sta ZP.SpriteTime, x

		lda #WEAPON_ROCKET
		sta ZP.SpriteWeapon, x

		jmp SpawnSupplyRunner.CrouchingEnemy


	}

	

	SpawnFlameThrower: {


		lda #2
		sta ZP.SpriteBullets, x
		sta ZP.SpriteTime, x

		dec ZP.SpriteTime, x

		lda #WEAPON_FLAME
		sta ZP.SpriteWeapon, x

		rts


	}


	RocketLauncher_Update: {

		lda ZP.SpriteState, x
		cmp #STATE_CROUCH_LEFT
		bne NoLongerCrouching

	IsCrouching:

		lda MAIN.CurrentStage
		asl
		clc
		adc #4

		jmp CheckTriggered

	NoLongerCrouching:

		jmp Gunner_Update.NotSlow

		Exit:

		rts
	}

}