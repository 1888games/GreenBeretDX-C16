.namespace ENEMY {


	MineSpawn: {

		lda #STATE_MINE
		sta ZP.SpriteState, x
		sta ZP.SpriteLastFrameState, x
	
		lda #FLOOR_ROW
		sta ZP.SpriteY, x

		lda #1
		sta ZP.SpriteTimer, x
		sta ZP.SpriteCrawling, x

		lda #4
		sta ZP.SpriteTime, x


		rts
	}


	Mine_Update: {

		lda ZP.SpriteState, x
		cmp #STATE_DEAD_RIGHT
		bne NotDead

		jmp AI.Delete

	NotDead:

		lda ZP.SpriteFrame, x
		eor #%00000001
		sta ZP.SpriteFrame, x

		lda ZP.SpriteTime, x
		sta ZP.SpriteTimer, x

		lda ZP.SpriteColour, x
		eor #%00000001
		sta ZP.SpriteColour, x

		rts
	}


}