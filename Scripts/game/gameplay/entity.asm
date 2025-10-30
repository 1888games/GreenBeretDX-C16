.namespace ENTITY {

	* = * "Entity"

	Entity:
	
	FrameUpdate: {

			lda ZP.IsDead
			bne Exit

			sta ZP.EnemyCount

			jsr UpdateSprites

			lda #0
			sta ZP.JustScrolled

		Exit:

			lda ZP.PlayerState
			sta ZP.PlayerLastFrameState


		rts
	}



	* = * "Check Surroundings"
	CheckSurroundings: {

			// x = spriteID

		lda ZP.SpriteState, x
		and #%11101111
		cmp #STATE_DEAD_RIGHT
		beq Exit

		lda #0
		sta ZP.OverLadder
		sta ZP.OnGround
		sta ZP.LadderBelow

		ldy #80

		lda (ZP.ScreenAddress), y
		//sta ZP.Temp1
		cmp MAP.LeftLadders
		bcc NotLadder

		cmp MAP.RightLadders
		bcs NotLadder

		sta ZP.OverLadder

	NotLadder:
		
		ldy #120
		lda (ZP.ScreenAddress), y
		cmp MAP.LeftLadders
		bcs NotFloor

	IsFloor:

		inc ZP.OnGround

		cpx #0
		beq OnGround
	
		jsr ENEMY.CheckJump
		jmp OnGround

	NotFloor:

		lda ZP.SpriteVelocity, x
		bne Exit

		lda ZP.SpriteTimer, x
		bne Exit

		lda ZP.SpriteState, x
		and #%11101111
		cmp #STATE_CROUCH_RIGHT
		bcs Exit

		inc ZP.SpriteY, x

	Exit:

		rts

	OnGround:

		ldy #160
		lda (ZP.ScreenAddress), y 
		cmp MAP.LeftLadders
		bcc CantClimbDown

		cmp MAP.RightLadders
		bcs CantClimbDown


		inc ZP.LadderBelow


	CantClimbDown:



		rts
	}


	UpdateSprites: {

		ldx #1


		EnemyLoop:

			jsr ENEMY.Update

			lda ZP.SpriteState, x
			sta ZP.SpriteLastFrameState, x

	
		EndEnemyLoop:

			inx
			cpx #MAX_SPRITES
			bcc EnemyLoop


		BulletLoop:

			jsr BULLET.Update

		EndBulletLoop:

			inx
			cpx #MAX_SPRITES + MAX_BULLETS
			bcc BulletLoop



		rts
	}

	

	EntityEnd:
	.print ("ENTITY......" + (EntityEnd - Entity))



}