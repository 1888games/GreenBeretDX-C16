.namespace ACTOR {


	GoDown: {

		lda ZP.SpriteState, x
		cmp #STATE_CLIMB
		bne NotClimbing

		lda ZP.OnGround
		beq NotLanded

		jmp ResetAfterClimb

	NotLanded:

		inc ZP.SpriteY, x
		jmp SetClimbTime

	NotClimbing:

		lda ZP.OnGround
		beq AlreadyCrouching

		lda ZP.LadderBelow
		beq DontJoinLadder

		inc ZP.SpriteY, x

		jmp SetClimbState

	DontJoinLadder:

		lda ZP.SpriteState, x
		and #%11101111
		cmp #STATE_CROUCH_RIGHT
		beq AlreadyCrouching

		
		lda ZP.SpriteFrame, x
		sta ZP.SpriteOffset, x

		inc ZP.SpriteY, x
		inc ZP.SpriteY, x
		dec ZP.SpriteX, x

		lda #0
		sta ZP.SpriteFrame, x

		lda ZP.SpriteState, x
		sta ZP.SpriteMasterState, x
		clc
		adc #STATE_CROUCH_RIGHT
		sta ZP.SpriteState, x

		cpx #0
		bne AlreadyCrouching
		

	IsPlayer:

		inc ZP.PlayerCrawling

	AlreadyCrouching:

		rts
	}


	CheckReleaseDown: {


		lda ZP.SpriteState, x
		and #%11101111
		cmp #STATE_CROUCH_RIGHT
		bne NotCrouching

		lda ZP.SpriteOffset, x
		sta ZP.SpriteFrame, x

		dec ZP.SpriteY, x
		dec ZP.SpriteY, x
		inc ZP.SpriteX, x

		lda ZP.SpriteMasterState, x
		sta ZP.SpriteState, x
		
		cpx #0
		bne NotCrouching

	IsPlayer:

		dec ZP.PlayerCrawling

	NotCrouching:

		rts


	}
	



}