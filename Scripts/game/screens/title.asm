.namespace TITLE {


	* = * "Title"

	.label LIVES = 5

	Title:

	SetMode: {

		lda #GAME_MODE_TITLE
		sta MAIN.GameMode

		lda #93
		sta ZP.HudEndLine
		sta ZP.PlayerY

		lda #LIVES + 48
		sta ZP.LivesRemaining

		rts

	}


	Show: {

		jsr SetMode

		jsr GAME.SetupScreen
		jsr TitleText
		jsr SCORE.Display
		
		lda #SCROLL_THRESHOLD
		sta ZP.PlayerX
		

		jmp Loop
	}

 	.encoding "screencode_upper"
	Tit1:	.text "GREEN BERET C16"
	Tit2:	.text "(C) KONAMI 1985"
	Tit3:	.text " ARLASOFT  2025"
	Tit4:	.text "  PRESS  FIRE  "

	.label NameRow = 4
	.label KonamiRow = 6
	.label ArlaRow = 7
	.label FireRow = 9
	.label CharStart = 12

	TitleText: {

		ldx #14
		
		

		Loop:

			lda Tit1, x
			sta SCREEN_RAM + (NameRow * 40) + CharStart, x

			lda Tit2, x
			sta SCREEN_RAM + (KonamiRow * 40) +  CharStart, x

			lda Tit3, x
			sta SCREEN_RAM + (ArlaRow * 40) +  CharStart, x

			lda Tit4, x
			sta SCREEN_RAM + (FireRow * 40) +  CharStart, x


			lda #YELLOW + LUMINANCE_2
			sta TED.COLOR_RAM + (NameRow * 40) +  CharStart, x

			lda #WHITE + LUMINANCE_7
			sta TED.COLOR_RAM + (KonamiRow * 40) +  CharStart, x
			sta TED.COLOR_RAM + (ArlaRow * 40) +  CharStart, x
			sta TED.COLOR_RAM + (FireRow * 40) +  CharStart, x

			stx ZP.ScrollStopFlag
			dex

			bpl Loop



		rts
	}


	Loop: {

		jsr MAIN.WaitForIRQ

		ldx #0
		jsr ACTOR.AdvanceFrame

		jsr SCREEN.Scroll

		jsr COMPLETE.CanFire
		bcs Loop

		sei

		jmp GAME.NewGame

	}


	TitleEnd:
	.print ("TITLE......." + (TitleEnd - Title))
}