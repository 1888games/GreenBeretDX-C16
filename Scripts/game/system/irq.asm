
IRQ: {

	*= * "IRQ"

	.label HudIRQLine = 0
	.label HudEndLine = 48
	.label MainIRQLine =190

	.label ResetBorderIRQLine = 0
	.label MultiplexerIRQLine = 20


	IRQ:


	* = * "BeginIRQ"
	HudBeginIRQ: {

		pha

		jsr BeginIRQCode

		:RestoreA()

	}


	DummyIRQ: {

		asl TED.INTERRUPT_FLAGS
		rti

	}

	
	BeginIRQCode: {

		lda #BLACK
		sta TED.BACKGROUND_COLOR

		lda #<HudEndIRQ
		sta TED.INTERRUPT_VECTOR

		lda #>HudEndIRQ
		sta TED.INTERRUPT_VECTOR + 1

		lda ZP.HudEndLine
		sta TED.RASTER_Y

		lda #%11000100   
		sta TED.SND_1_CHAR_ROM_RAM     // Bit 2 = 0 (RAM)

		lda #%11010001   
		sta TED.CHARSET_ADDRESS 

		lda #%10010000
    	sta $FF07

    	rts

	}

	* = * "MainIRQ"

	SetMainIRQ: {

		lda #<MainIRQ
		sta TED.INTERRUPT_VECTOR

		lda #>MainIRQ
		sta TED.INTERRUPT_VECTOR + 1

		lda #MainIRQLine
		sta TED.RASTER_Y

		rts


	}



  * = * "HudEndIRQ"
	HudEndIRQ: {


		pha

		jsr SetMainIRQ


		lda #%11000000   
		sta TED.SND_1_CHAR_ROM_RAM     // Bit 2 = 0 (RAM)

		lda #%00111000      // $38
		sta TED.CHARSET_ADDRESS 

		lda ZP.StageBackgroundColour
		sta TED.BACKGROUND_COLOR


		lda $FF07
   		ora ZP.FineScroll
    	sta $FF07

    	

		:RestoreA()

	

	}

	* = * "MainIRQ"
	MainIRQ: {

			pha

			lda ZP.JOY_READING
			//and #%00000001
			//sta ZP.Temp1

			jsr INPUT.ReadJoystick

			tya
			pha
			txa
			pha

			ldx #0
			jsr SOUND.UpdateChannel

			ldx #1
			jsr SOUND.UpdateChannel

			pla
			tax
			pla
			tay

		CheckFrame:

			lda ZP.FrameSwitch
			eor #%00000001
			sta ZP.FrameSwitch
			bne SkipFrame

			inc MAIN.PerformFrameCodeFlag
			inc ZP.Counter
			//jmp DoneIRQ

		SkipFrame:

			//lda ZP.JOY_READING
			//ora ZP.Temp1
			//sta ZP.JOY_READING

		DoneIRQ:

			lda #<HudBeginIRQ
			sta TED.INTERRUPT_VECTOR

			lda #>HudBeginIRQ
			sta TED.INTERRUPT_VECTOR + 1

			lda #HudIRQLine
			sta TED.RASTER_Y


			// lda ZP.PlayerFrame
			// clc
			// adc #48
			// sta SCREEN_RAM + 5


			// lda ZP.FineScroll
			// clc
			// adc #48
			// sta SCREEN_RAM + 6

			// lda #RED
			// sta TED.COLOR_RAM + 5
			// sta TED.COLOR_RAM + 6
			//lda #%11000100   
			//sta TED.SND_1_CHAR_ROM_RAM     // Bit 2 = 0 (RAM)


			:RestoreA()

	

	}

	

	IRQEnd:
	.print ("IRQ........." + (IRQEnd - IRQ))



}