.namespace ENEMY {




	CannonFodder_Update: {


	DoneDead:

		lda ZP.ScrollStopFlag
		beq NotBoss

		lda ZP.SpriteOffset, x
		cmp #DOG_TRAINER
		bne NotTrainer

	IsTrainer:

		cmp ZP.SpriteWeapon, x
		beq MakeCrouch

		lda #FAST_FLAG
		sta ZP.SpriteOffset, x

		jmp ACTOR.MakeWalk
		//jmp NotSlow
	
	MakeCrouch:

		lda ZP.SpriteState, x
		and #%00010000
		clc
		adc #STATE_SHOOT_RIGHT
		sta ZP.SpriteState, x

		lda #0
		sta ZP.SpriteFrame, x

		lda #32
		sta ZP.SpriteTimer, x
		sta ZP.SpriteWeapon, x

	Exit:
		rts

	NotTrainer:

		cmp #FAST_FLAG
		bne NotSlow

		inc ZP.SpriteFrame, x
		jmp NotSlow

	NotBoss:

		cpx #4
		beq Slow

		cpx #7
		beq Slow

		jmp NotSlow

	Slow:

		lda ZP.SpriteTime, x
		eor #%00000001
		sta ZP.SpriteTime, x

	NotSlow:
		
		jmp ACTOR.Control
		

	
	}

}