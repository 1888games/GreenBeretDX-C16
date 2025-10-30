.namespace ENEMY {

	
	SpawnGrenadier: {

		jsr SetupGrenadier


		jmp SpawnSupplyRunner.CrouchingEnemy


	}

	SpawnBossGrenadier: {

		jsr SetupGrenadier

		dec ZP.SpriteTime, x
		rts

	}

	SetupGrenadier: {


		lda #0
		sta ZP.SpriteBullets, x

		lda #2
		sta ZP.SpriteTime, x

		lda #WEAPON_GRENADE
		sta ZP.SpriteWeapon, x

		rts

	}

}