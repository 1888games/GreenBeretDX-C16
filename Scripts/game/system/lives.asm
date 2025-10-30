.namespace LIVES {



	Decrease: {

		dec ZP.LivesRemaining

	DrawLives:

		lda ZP.LivesRemaining
		sta SCREEN_RAM + 48

	CheckDead:

		cmp #48
		bne Okay

		ldx #$F6
		txs
		jmp GAME_OVER.Show
		
	Okay:

		rts
	}


	Increase: {

		inc ZP.LivesRemaining
		jmp Decrease.DrawLives
	}
}