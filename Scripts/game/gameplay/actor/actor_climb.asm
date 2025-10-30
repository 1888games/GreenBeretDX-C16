.namespace ACTOR {




	ResetAfterClimb: {

		inc ZP.OnGround

		lda #STATE_WALK_RIGHT
		sta ZP.SpriteState, x

		lda ZP.SpriteMasterState, x
		sta ZP.SpriteFrame, x

		lda #5
		sta ZP.SpriteTimer, x

		cpx #0
		beq Exit

		lda ZP.EnemyType - 1, x
		cmp #ENEMY_SUPPLY_FLAME
		beq GoLeft

		lda ZP.PlayerX
		cmp ZP.SpriteX, x
		bcs GoRight

	GoLeft:

		lda #INPUT.JOY_LEFT
		sta ZP.SpriteJoystick, x

	Exit:
		rts

	GoRight:

		lda #INPUT.JOY_RIGHT
		sta ZP.SpriteJoystick, x
		rts



	}


	SetClimbTime: {

		lda ZP.SpriteFrame, x
		eor #%00000001

	Skip:
		sta ZP.SpriteFrame, x

		lda #CLIMB_TIME
		sta ZP.SpriteTimer, x

		rts


	}


	SetClimbState: {

		lda #STATE_CLIMB
		sta ZP.SpriteState,x

		lda ZP.SpriteFrame, x
		sta ZP.SpriteMasterState, x

		lda #0		
		jmp SetClimbTime.Skip

	}


}