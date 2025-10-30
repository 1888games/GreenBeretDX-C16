.namespace ACTOR {

	GoUp: {

		lda ZP.SpriteState,x 
		cmp #STATE_CLIMB
		beq AlreadyClimbing



	NotClimbingYet:

		lda ZP.OverLadder
		beq NoLadder

	JoinLadder:

		jmp SetClimbState

	NoLadder:

		lda ZP.OnGround
		beq Exit

		lda ZP.SpriteVelocity, x
		bne Exit

		lda #123
		sta ZP.SpriteVelocity, x
		sta ZP.SpriteOffset, x

		lda ZP.SpriteJoystick, x
		eor #INPUT.joyUpMask
		sta ZP.SpriteJoystick, x

	Exit:

		rts

	AlreadyClimbing:

		lda ZP.OverLadder
		beq FinishClimbing

		dec ZP.SpriteY, x
		jmp SetClimbTime
	

	FinishClimbing:

		dec ZP.SpriteY, x

		jmp ResetAfterClimb

	}
}