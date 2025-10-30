.namespace ACTOR {


	GoRight: {

	
		lda ZP.SpriteState, x
		cmp #STATE_WALK_RIGHT
		beq AlreadyWalking

		cmp #STATE_CROUCH_RIGHT
		beq Exit

	NotCrouching:

		cmp #STATE_CROUCH_LEFT
		bne NotCrouchingLeft

		lda #STATE_CROUCH_RIGHT
		sta ZP.SpriteState, x
	
	Exit:

		rts

	NotCrouchingLeft:

		cmp #STATE_CLIMB
		beq Exit

		cmp #STATE_KICK_RIGHT
		bne NotKick

		lda ZP.Counter
		and #%00000001
		bne NotMoved

		jmp MoveSprite

	NotKick:

		cpx #0
		bne SkipScroll

		lda #0
		sta ZP.PlayerFrame

		lda ZP.FineScroll
		cmp #7
		beq SkipScroll

		jsr GAME.ResetFineScroll

	SkipScroll:

		lda #STATE_WALK_RIGHT
		sta ZP.SpriteState, x

	AlreadyWalking:

		cpx #0
		bne NotPlayer

	IsPlayer:

		lda ZP.PlayerX
		cmp #37
		bcs Exit

	Okay:

		jsr AdvanceFrame
		bne PlayerNotMoved

	PlayerMoved:

		jsr SCREEN.Scroll
		bpl MoveSprite

		ldx #0
		jmp NotMoved

	PlayerNotMoved:

		jsr SCREEN.Scroll
		jmp NotMoved

	NotPlayer:

		jsr AdvanceFrame
		bne NotMoved

	MoveSprite:

		inc ZP.SpriteX, x

	NotMoved:


	}

	SetWalkTime: {

		lda ZP.SpriteTime, x
		sta ZP.SpriteTimer, x

		rts

	}


	AdvanceFrame: {

		inc ZP.SpriteFrame, x
		lda ZP.SpriteFrame, x
		and #%00000011
		sta ZP.SpriteFrame, x
		rts

	}
}