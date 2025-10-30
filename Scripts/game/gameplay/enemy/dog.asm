.namespace ENEMY {


	SpawnDog: {

		lda ZP.SpriteState, x
		cmp #STATE_WALK_RIGHT
		beq GoRight


	GoLeft:

		lda #STATE_DOG_LEFT
		jmp Exit

	GoRight:

		lda #STATE_DOG_RIGHT
		
	Exit:

		sta ZP.SpriteState, x
		sta ZP.SpriteLastFrameState, x

		inc ZP.SpriteCrawling, x
		inc ZP.SpriteY, x
		inc ZP.SpriteY, x
		dec ZP.SpriteX, x

		lda #1
		sta ZP.SpriteTime, x

		rts
	}
	
	.label DOG_THRESHOLD = 6
	.label JUMP_VELOCITY = 77

	Dog_Update: {	

		lda #FLOOR_ROW
		sta ZP.SpriteY, x

		lda ZP.SpriteFrame, x
		eor #%00000001
		sta ZP.SpriteFrame, x
		
		lda ZP.SpriteState, x
		cmp #STATE_DOG_LEFT
		beq GoLeft

	GoRight:

		inc ZP.SpriteX, x

		lda ZP.PlayerX
		sec
		sbc ZP.SpriteX, x
		cmp #DOG_THRESHOLD
		bcc Jump

		jmp NoJump

	GoLeft:

		dec ZP.SpriteX, x

		lda ZP.SpriteX, x
		sec
		sbc ZP.PlayerX
		cmp #DOG_THRESHOLD
		bcs NoJump

	Jump:

		jsr MAIN.Random
		cmp #124
		bcs NoJump

		dec ZP.SpriteY, x

		lda ZP.SpriteWeapon + 2
		bne NoJump

		lda #DOG_TRAINER
		sta ZP.SpriteOffset + 2
		sta ZP.SpriteWeapon + 2

	NoJump:

		lda ZP.SpriteTime, x
		sta ZP.SpriteTimer, x

		

	Exit:


	 	rts

	}

	
}

