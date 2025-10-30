.namespace SCORE {



	SetHigh: {

		lda #3
		sta ZP.HighScore + 1
		sta ZP.HighScore + 2

		lda #0
		sta ZP.HighScore
		sta ZP.HighScore + 3
		sta ZP.HighScore + 4
		sta MAIN.CurrentStage
	
	
	}

	Reset: {

		ldx #4

		Loop:

			sta ZP.Score, x

			dex
			bpl Loop

			rts


	}


	CopyScore: {

		ldx #4

		Loop:

			lda ZP.Score, x
			sta ZP.HighScore, x

			dex
			bpl Loop


		rts
	}

	AddThousands: {

		ldx #2
		jmp Add
	}

	AddHundreds: {


		ldx #3
		//jmp Add
	}

	Add: {

		inc ZP.UpdateScore
		clc
		adc ZP.Score, x

	CheckOverflow:

		cmp #10
		bcc Okay

		inc ZP.Score - 1, x
		sec
		sbc #10

		Okay:

		sta ZP.Score, x

		dex
		bmi Done

		lda ZP.Score, x
		jmp CheckOverflow

	Done:

	

		rts
	}

	CheckHighScore: {

		ldx #0

		Loop:

			lda ZP.Score, x
			cmp ZP.HighScore, x
			bcc NoHigh
			beq Next

			jmp CopyScore

		Next:

			inx
			cpx #4
			bcc Loop

		NoHigh:



		rts
	}


	Display: {

		jsr CheckHighScore

		ldx #4

		Loop:

			lda ZP.Score, x
			clc
			adc #48
			sta SCREEN_RAM + (40 * 2) + 12, x

			lda ZP.HighScore, x
			clc
			adc #48
			sta SCREEN_RAM + (40 * 2) + 21, x

			dex
			bpl Loop

		lda #48
		sta SCREEN_RAM + (40 * 2) + 17
		sta SCREEN_RAM + (40 * 2) + 26

		rts
	}


}