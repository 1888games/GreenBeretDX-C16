.namespace ACTOR {



	GoLeft: {

		cpx #0
		bne Okay

		lda ZP.PlayerX
		beq Exit

		//ldy ZP.ScrollStopFlag
		//beq Okay

		//cmp #10
		//beq Exit

	Okay:

		lda ZP.SpriteState, x
		cmp #STATE_CROUCH_LEFT
		beq Exit

	NotCrouching:

		cmp #STATE_CROUCH_RIGHT
		bne NotCrouchRight

		lda #STATE_CROUCH_LEFT
		sta ZP.SpriteState, x
		

	Exit:

		rts

	NotCrouchRight:

		cmp #STATE_CLIMB
		beq Exit

		cmp #STATE_KICK_LEFT
		bne NotKick

		lda ZP.Counter
		and #%00000001
		bne NotMoved

		jmp Move

	NotKick:

		cpx #0
		bne NoScroll

		jsr SCREEN.CheckScrollAdjust

	NoScroll:

		lda #STATE_WALK_LEFT
		sta ZP.SpriteState, x

		lda ZP.SpriteFrame, x
		clc
		adc #1
		and #%00000011
		sta ZP.SpriteFrame, x
		bne NotMoved

	Move:

		dec ZP.SpriteX, x	
	

	NotMoved:

		jmp SetWalkTime

	}
}