.namespace COMPLETE {


	* = * "Complete"


	LevelComplete:


	Show: {

		jsr TITLE.SetMode

		jsr DrawText

		cli

		jmp Loop
	}




 	.encoding "screencode_upper"

 	Row0:	.text "RESCUE THE CAPTIVES"
	Row1:	.text "     WELL DONE!    "
	Row2:	.text "  TARGET OVERCOME  "

	Row3:	.text " STAGE 2 -  HARBOR "
	Row3a:	.text " STAGE 3 -  BRIDGE "
	Row3b:	.text " STAGE 4 -  PRISON "
	Row3c:	.text " MISSION COMPLETED "
	Row3d: 	.text "LOADING..."


	.label NameRow = 4
	.label KonamiRow = 6
	.label ArlaRow = 7
	.label FireRow = 9
	.label CharStart = 10


	DrawLoading: {

		
		 	ldx #9
		
		 Loop:

			lda Row3d, x
		 	sta SCREEN_RAM + (FireRow * 40) +  CharStart + 4, x

		 	dex
		 	bpl Loop
	
		 	rts


	}

	DrawText: {

		ldx #18
		
		Loop:

			lda Row0, x
			sta SCREEN_RAM + (NameRow * 40) + CharStart, x

			lda Row1, x
			sta SCREEN_RAM + (KonamiRow * 40) +  CharStart, x

			lda Row2, x
			sta SCREEN_RAM + (ArlaRow * 40) +  CharStart, x

			lda MAIN.CurrentStage
			beq First

			cmp #1
			beq Second

			cmp #2
			beq Third

			lda Row3c, x
			jmp Store

		Third:

			lda Row3b, x
			jmp Store

		Second:

			lda Row3a, x
			jmp Store

		First:

			lda Row3, x
		Store:
			sta SCREEN_RAM + (FireRow * 40) +  CharStart, x


			lda #CYAN + LUMINANCE_3
			sta TED.COLOR_RAM + (NameRow * 40) +  CharStart, x

			lda #YELLOW + LUMINANCE_3
			sta TED.COLOR_RAM + (KonamiRow * 40) +  CharStart, x
			sta TED.COLOR_RAM + (ArlaRow * 40) +  CharStart, x

			lda #WHITE + LUMINANCE_7
			sta TED.COLOR_RAM + (FireRow * 40) +  CharStart, x

			dex
			bpl Loop
			

		rts
	}



	CanFire: {

		lda ZP.PlayerY
		beq CanFire

		dec ZP.PlayerY
		jmp NoFire

	CanFire:

		lda ZP.JOY_READING
		and #INPUT.joyFireMask
		bne NoFire

		clc
		rts

	 NoFire:

	 	sec
	 	rts

	}



	Loop: {


		jsr MAIN.WaitForIRQ

		jsr CanFire
		bcs Loop

		sei

		jmp GAME.NextLevel


	}

	LevelCompleteEnd:
	.print ("COMPLETE....." + (LevelCompleteEnd - LevelComplete))


}