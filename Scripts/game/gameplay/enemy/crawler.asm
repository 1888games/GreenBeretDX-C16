.namespace ENEMY {



	SpawnCrawler: {

		jsr SpawnSupplyRunner

		lda #0
		sta ZP.SpriteOffset, x

		lda #6
		sta ZP.SpriteTime, x

		rts
	}



	Crawler_Update: {

		
		lda ZP.SpriteFrame, x
		eor #%00000011
		sta ZP.SpriteFrame, x
		beq NoMove

		dec ZP.SpriteX, x

	NoMove:

		lda ZP.SpriteTime, x
		sta ZP.SpriteTimer, x

	Exit:

		rts
	}


}