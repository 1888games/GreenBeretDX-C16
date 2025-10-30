.namespace GAME {


	* = * "Game"

	Game:


	NewGame: {

		lda #0
		//sta MAIN.CurrentStage
		sta ZP.LeadEnemyType
		sta ZP.SpawnIndex
		sta ZP.StartSpawnIndex

		//lda #3
		sta MAIN.CurrentStage

		jsr SCORE.Reset

		// fall through

	}

	Show: {


		lda #48
		sta ZP.HudEndLine

		lda #GAME_MODE_PLAY
		sta MAIN.GameMode

		jsr SetupScreen
		jmp Loop

	}


	SetupScreen: {

		jsr SetColoursAndMode

		lda MAIN.MapCopied
		bne SkipCopy

		.if (format == "disk" || format == "tape") {

			sei 
			jsr SCREEN.Clear
			jsr COMPLETE.DrawLoading

			jsr IRQ.BeginIRQCode
			
			lda MAIN.CurrentStage
			jsr DISK.Load

		}

		jsr MAP.CopyMapTo200

	SkipCopy:

		jsr NewLevel
		jsr ShowLevel

		rts
	}

	SetColoursAndMode: {

			lda #%10010000
	        sta TED.SCREEN_CONTROL_2

			lda #LUMINANCE_2 + WHITE
			sta TED.BORDER_COLOR

			lda #LUMINANCE_0 + BLACK 
			sta TED.EXTENDED_BG_COLOR_1

			lda #LUMINANCE_6 + RED
			sta TED.EXTENDED_BG_COLOR_2

			lda #%00110000
			sta TED.VIDEO_ADDRESS

			rts


	}

	AdjustSpawnIndex: {



		ldy ZP.StartSpawnIndex

	CheckSector:

		lda ENEMY.EnemySector, y
		cmp ZP.ScrollSectorNumber
		bcs Okay

		iny
		jmp CheckSector


	Okay:

		sty ZP.SpawnIndex


		rts
	}

	RestartLevel: {


		jsr ShowLevel
		jmp Loop
	}

	ShowLevel: {

		sei 
		
		ldy #0
		sty ZP.EnemyCount
		sty ZP.LeadEnemyCount
		sty ZP.IsDead
		sty ZP.SectorXOffset
		sty ZP.ThisSectorXOffset
		sty ZP.ScrollStopFlag
		sty ZP.HurryTimer

		sty TED.BACKGROUND_COLOR

		jsr SCREEN.Clear
			
		ldx #100

		WaitLoop:
			
			lda TED.CURRENT_RASTER_Y
			cmp #200
			bne WaitLoop

			dex 
			bne WaitLoop

		
		lda MAIN.Checkpoint
		sta ZP.ScrollSectorNumber
		
		//lda ZP.ScrollSectorNumber
		//beq NoReduce

		//dec ZP.ScrollSectorNumber
		//beq NoReduce

		//dec ZP.ScrollSectorNumber
		//beq NoReduce

		//dec ZP.ScrollSectorNumber
		
	NoReduce:

		jsr AdjustSpawnIndex

		jsr SCREEN.DrawFloor


		jsr MAP.FillScreen

		jsr PLAYER.Initialise
		jsr BULLET.Initialise



		//jsr ENEMY.Spawn

		lda #255
		sta ZP.GunnerSpawnTimer
		sta ZP.JOY_READING

		jsr MAIN.Random
		and #%00011111
		clc
		adc #32
		sta ZP.LeadSpawnTimer

		
		jsr DrawHud
		jsr SCORE.Display



		cli

		jmp SOUND.PlaySFX


	}


    .encoding "screencode_upper"
	Hud1:	.text "LIVES 3   SCORE   HI-SCORE   STAGE  1"
	//Hud2:	.text "00000     00000"


	DrawHud: {


		ldx #35
		
		Loop:

			lda Hud1, x
			sta SCREEN_RAM + 42, x

			lda #LUMINANCE_5 + RED
			sta TED.COLOR_RAM + 42, x

			cpx #15
			bcs NoScore

			//lda Hud2, x
			//sta SCREEN_RAM + 92, x

			lda #LUMINANCE_7 + WHITE
			sta TED.COLOR_RAM + 92, x


		NoScore:
	
			dex
			bpl Loop
			

			lda MAIN.CurrentStage
			clc
			adc #49
			sta SCREEN_RAM + 77
						
			jmp LIVES.Decrease.DrawLives

	
	}




	NextLevel: {


		.if (format == "disk" || format == "tape") {

		lda MAIN.CurrentStage
		clc
		adc #1
		and #%00000011
		sta MAIN.CurrentStage

		dec MAIN.MapCopied

		}

		jmp Show

	}

	NewLevel: {

		jsr MAP.CalculateMapAddresses

		jsr ResetFineScroll
		
		lda #0
		sta ZP.ScrollSectorNumber
		sta ZP.SectorXOffset
		sta ZP.ValidFloors + 4

		//lda MAP.NumSectors
		//sec
		//sbc #1
		//lda #0
		sta MAIN.Checkpoint

		ldy MAIN.CurrentStage
		lda ENEMY.SpawnIndexes, y
		sta ZP.StartSpawnIndex

		rts
	}

	ResetFineScroll: {

		lda #7
		sta ZP.FineScroll

		jmp SCREEN.SetFineScroll


	}

	Loop: {

	
		jsr MAIN.WaitForIRQ

	* = * "Berk"

		lda ZP.Score + 1
		sta ZP.TenThousandsMarker

		jsr PLAYER.FrameUpdate
		jsr ENTITY.FrameUpdate
		jsr ENEMY.FrameUpdate

		lda ZP.UpdateScore
		beq Skip

		jsr SCORE.Display

		Skip:

		//lda ZP.EnemyCount
		//bpl Okay

		//lda #0
		//sta ZP.EnemyCount
	Okay:

		lda ZP.TenThousandsMarker
		clc
		adc ZP.Score + 1
		cmp #5
		bne NotLive

		cmp #13
		bne NotLive

		inc ZP.LivesRemaining
		jsr LIVES.Decrease.DrawLives

	NotLive:


		jmp Loop
	}

	GameEnd:
	.print ("GAME........" + (GameEnd - Game))



}