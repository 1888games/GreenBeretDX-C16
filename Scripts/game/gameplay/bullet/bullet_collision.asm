.namespace BULLET {


	YSize:	.byte 3, 1
	XSize:	.byte 2, 3

	CheckPlayerCollision: {


		ldy ZP.PlayerCrawling
		beq NotCrawling

		lda ZP.PlayerY
		cmp ZP.SpriteY, x
		bne NoCollision

		jmp CheckX


	NotCrawling:

		lda ZP.SpriteY, x
		sec
		sbc ZP.PlayerY
		cmp #3
		bcs NoCollision

	CheckX:

		lda ZP.SpriteX, x
		sec
		sbc ZP.PlayerX
		cmp XSize, y
		bcs NoCollision

		jmp PLAYER.SetDead

	NoCollision:

		rts
	}

	CheckCollisions: {

		lda ZP.SpriteTimer, x
		cmp #3
		bcs CheckPlayerCollision.NoCollision

		lda ZP.BulletSource - MAX_SPRITES, x
		beq EnemyBullet

		jmp CheckPlayerCollision

	EnemyBullet:

		ldy #0

		Loop:

			lda ZP.EnemyX, y
			bmi EndLoop

			lda ZP.SpriteX, x
			sec
			sbc ZP.EnemyX, y
			cmp #2
			bcs EndLoop

			lda ZP.SpriteY, x
			sec
			sbc ZP.EnemyY, y
			cmp #3
			bcs EndLoop

			jsr KillEnemy

			lda ZP.EnemyOffset, y
			cmp #WEAPON_HOLDER_FLAG
			bne EndLoop

			stx ZP.Temp2

			jsr ENEMY.SpawnWeapon

			ldx ZP.Temp2
			rts
	
		EndLoop:

			iny
			cpy #MAX_SPRITES - 2
			bcc Loop



		rts
	}

	KillEnemy: {

			lda ZP.EnemyState, y
			and #%11101111
			cmp #STATE_DEAD_RIGHT
			beq EndLoop 

			cmp #STATE_CANNON_DEAD
			beq EndLoop

			lda ZP.SpriteState, x
			and #%00000111
			cmp #WEAPON_KNIFE
			bne NotKnife

			jsr Move.IsKnife

			lda #2
			jmp DoScore

		NotKnife:
			lda #3
		DoScore:
			jsr SCORE.AddHundreds

			ldx ZP.SpriteID

			lda ZP.EnemyState, y
			and #%00010000
			clc
			adc #STATE_DEAD_RIGHT
			sta ZP.EnemyState, y

			lda #8
			sta ZP.EnemyTime, y

		NotCrawling:
			
			lda #0
			sta ZP.EnemyFrame, y
			sta ZP.EnemyBullets, y
			sta ZP.EnemyTimer, y
			sta ZP.SpriteVelocity, x

		
			lda #255
			sta ZP.EnemyJoystick, y

		EndLoop:

			rts

	}


	GrenadeCollisionPlayer: {

		lda ZP.SpriteX, x
		sec
		sbc ZP.PlayerX
		clc
		adc #3
		cmp #7
		bcs NoCollision

		lda ZP.SpriteY, x
		sec
		sbc ZP.PlayerY
		clc
		adc #3
		cmp #7
		bcs NoCollision

		ldy ZP.PlayerCrawling

		jsr PLAYER.SetDead

	NoCollision:

		jmp CancelBullet
	}


	GrenadeCollisionEnemies: {

		ldy #MAX_SPRITES - 2
		stx ZP.SpriteID

		Loop:

			lda ZP.SpriteX, x
			sec
			sbc ZP.SpriteX, y
			clc
			adc #3
			cmp #7
			bcs NoCollision

			lda ZP.SpriteY, x
			sec
			sbc ZP.SpriteY, y
			clc
			adc #3
			cmp #7
			bcs NoCollision

			jsr KillEnemy

		NoCollision:

			dey
			bpl Loop



		jmp CancelBullet
	}

}