.namespace GAME_OVER {


	* = * "Game Over"


	GameOver:


	Show: {

		jsr TITLE.SetMode
		
		jsr DrawText

		cli

		jmp Loop
	}




 	.encoding "screencode_upper"

 	Row0:	.text "GAME  OVER"
	
	.label NameRow = 6
	.label CharStart = 15

	

	DrawText: {

		ldx #9
		
		Loop:

			lda Row0, x
			sta SCREEN_RAM + (NameRow * 40) + CharStart, x

			lda #WHITE + LUMINANCE_7
			sta TED.COLOR_RAM + (NameRow * 40) +  CharStart, x

			dex
			bpl Loop
		
		rts
	}





	Loop: {


		jsr MAIN.WaitForIRQ
	
		jsr COMPLETE.CanFire
		bcs Loop

		sei

		lda MAIN.CurrentStage
		beq Okay

		lda #0
		sta MAIN.MapCopied
		sta MAIN.CurrentStage

	Okay:

		sta MAIN.Checkpoint

		jmp TITLE.Show


	}

	GameOverEnd:
	.print ("GAME OVER...." + (GameOverEnd - GameOver))
}