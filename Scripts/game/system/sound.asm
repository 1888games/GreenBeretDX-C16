.namespace SOUND {

		* = * "Sound"

    Sound:

	.label SET_FREQ = 0
	.label REL_FREG = 128


	// Song = List of patterns
	// Pattern = List of commands

	.label LEN_32 = 3
	.label N01 = LEN_32 - 1
	.label N02 = LEN_32 * 2 -1 
	.label N04 = LEN_32 * 4 - 1 
	.label N08 = LEN_32 * 8 - 1
	.label N12 = LEN_32 * 12 - 1
	.label N06 = LEN_32 * 6 - 1
	.label N16 = LEN_32 * 16 - 1


	SnareData:	.byte N01, N01, N02, N04, N04, N04
				.byte N01, N01, N02, N04, N04, N04
				.byte N01, N01, N02, N04, N04, N02
				.byte N04, N02, N04, N04, N04

				.byte N01, N01, N02, N04, N04, N04
				.byte N01, N01, N02, N04, N04, N04
				.byte N01, N01, N02, N04, N04, N02
				.byte N04, N02, N04, N08, 255




	BassData:

				.byte 196-1, 200-1

				.byte N08, N12, N04, N08, N08, N12
				.byte N04, N08, N08, N12, N04, N08, N08, N12
				.byte N02, N02, N04, N04, N08, N12, N04, N08, N08, N12
				.byte N04, N08, N08, N12, N04, N08, N08, N12
				.byte N02, N02, N04, 255


	Volume0:	.byte 	%11000111, %10011111
	VolumeOn:	.byte 	%00010000,%01000000
	Duration:	.byte   12, 1


	UpdateChannel: {


		lda ZP.SFXChannel1_Duration, x
		bmi Exit
		beq SetVolume0

		dec ZP.SFXChannel1_Duration, x
		jmp CheckTimer
	
	SetVolume0:

		lda TED.SOUND_CONTROL
		and Volume0, x
		sta TED.SOUND_CONTROL

	CheckTimer:

		lda ZP.SFXChannel1_Timer, x
		beq NextNote

		dec ZP.SFXChannel1_Timer, x

	Exit:
		rts

	
	NextNote:

		lda ZP.SFXChannel1_Address, x
		sta Address

		lda ZP.SFXChannel2_Address, x
		sta Address + 1

		ldy ZP.SFXChannel1_Index, x
		//tay

	GetNote:

		lda Duration, x
		sta ZP.SFXChannel1_Duration, x

		lda Address: $BEEF, y
		sta ZP.Temp1
		cmp #255
		beq Loop

		inc ZP.SFXChannel1_Index, x

		sta ZP.SFXChannel1_Timer, x
		cmp ZP.SFXChannel1_Duration, x
		bcs Okay

		sec
		sbc #2
		sta ZP.SFXChannel1_Duration, x

	Okay:

		lda ZP.Temp1
		bmi Exit2

		lda TED.SOUND_CONTROL
		ora VolumeOn, x
		sta TED.SOUND_CONTROL

		cpx #1
		beq Exit2

		lda ZP.Temp1
		cmp #N08
		beq Csharp

		cmp #N02
		bne Exit2

		lda #255
		bne StoreFreq

	Csharp:

		lda #217
	StoreFreq:

		sta TED.CHANNEL_1_FREQ

	Exit2:
		rts

	Loop:

		ldy #0
		sty ZP.SFXChannel1_Index, x
		jmp GetNote


	}


	PlaySFX: {

		lda TED.CHANNEL_2_HI_BITS
		and #%11111100
		sta TED.CHANNEL_1_HI_BITS
		ora #%00000011
		sta TED.CHANNEL_2_HI_BITS

		lda #%00000111
		sta TED.SOUND_CONTROL


		lda #0
		sta ZP.SFXChannel2_Index
		sta ZP.SFXChannel2_Timer
		sta ZP.SFXChannel2_Duration
		sta ZP.SFXChannel1_Duration
		sta ZP.SFXChannel1_Timer
		sta ZP.SFXChannel1_Index

		lda #140
		sta TED.CHANNEL_2_FREQ

		lda #224
		sta TED.CHANNEL_1_FREQ

		lda #<SnareData
		sta ZP.SFXChannel1_Address + 1

		lda #>SnareData
		sta ZP.SFXChannel2_Address + 1


		lda #<BassData
		sta ZP.SFXChannel1_Address

		lda #>BassData
		sta ZP.SFXChannel2_Address

		rts

	
	}


	SoundEnd:
	.print ("SOUND......." + (SoundEnd - Sound))
}