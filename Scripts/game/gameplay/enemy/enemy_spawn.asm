.namespace ENEMY {


	//EnemyColours:		.byte LUMINANCE_2 + YELLOW + 8, LUMINANCE_5 + BLUE + 8
						//.byte LUMINANCE_5 + YELLOW + 8, LUMINANCE_2 + YELLOW + 8
						//.byte LUMINANCE_5 + PURPLE + 8, LUMINANCE_2 + BLUE + 8


		EnemyColours:	.byte LUMINANCE_2 + YELLOW + 8, LUMINANCE_4 + RED+ 8        // cannon, gunner
						.byte LUMINANCE_6 + YELLOW + 8, LUMINANCE_2 + YELLOW + 8    // kick, cannon
						.byte LUMINANCE_5 + PURPLE + 8, LUMINANCE_1 + BLUE + 8       // mine, supply flame
						.byte LUMINANCE_1 + BLUE + 8, LUMINANCE_1 + BLUE + 8      // supply rocket, supply grenade
						.byte LUMINANCE_5 + WHITE + 8, LUMINANCE_1 + CYAN + 8       // weapon, crawler
						.byte LUMINANCE_6 + YELLOW + 8                            // dog
						.byte LUMINANCE_4 + PURPLE + 8, LUMINANCE_4 + CYAN + 8   //  rocket, grenade
						.byte LUMINANCE_3 + CYAN + 8
						



	

	Spawn: {

		// y = EnemyType


		lda EnemyColours, y
		pha

		ldx #1

		Loop:

			lda ZP.SpriteX, x
			bmi Found

			inx
			cpx #MAX_SPRITES - 1
			bcc Loop

			pla
			rts

		Found:

			pla 

		StoreStuff:

			sta ZP.SpriteColour, x

			tya
			sta ZP.EnemyType - 1, x

			lda #0
			sta ZP.SpriteFrame, x
			sta ZP.SpriteBullets, x
			sta ZP.SpriteTimer, x
			sta ZP.SpriteVelocity, x
			sta ZP.SpriteCrawling, x
			sta ZP.SpriteMasterState, x
			sta ZP.SpriteTime, x
			sta ZP.SpriteOffset, x
			sta ZP.SpriteWeapon, x
			//sta ZP.SpriteJoystick, x
		//	dec ZP.SpriteJoystick, x

			//inc ZP.EnemyCount


		Exit:	

		rts
	}

	HurryTimers:	.byte 60, 45, 30, 25

	CheckKickboxerSpawn: {

		ldy MAIN.CurrentStage

		lda ZP.HurryTimer
		cmp HurryTimers, y
		bcc NotKickboxer

	Spawn:
		
		ldy #ENEMY_KICKBOXER
		jsr CheckGunnerSpawn.RightSide

		lda #0
		sta ZP.SpriteBullets, x
		sta ZP.HurryTimer

	NotKickboxer:

		rts
	}


	CheckSpecificSpawn: {

		ldy ZP.SpawnIndex
		lda EnemySector, y
		bpl Okay

	Exit2:

		rts

	Okay:

		cmp ZP.ScrollSectorNumber
		bne Exit2

		lda EnemyOffset, y
		cmp ZP.SectorXOffset
		bne Exit2

	Force:

		inc ZP.SpawnIndex

		lda ZP.EnemyCount
		cmp #MAX_SPRITES - 1
		bcs Exit2

		lda EnemyType, y
		sta ZP.Temp3
		and #%00001111
		tay

		cpy #ENEMY_KICKBOXER
		bne NotKickboxer

		jmp CheckKickboxerSpawn.Spawn

	NotKickboxer:

		jsr Spawn

		lda #37
		sta ZP.SpriteX, x

		lda #$FF
		sta ZP.SpriteJoystick, x

		cpy #ENEMY_CANNON
		bne NotCannon

	IsCannon:

		jsr CannonSpawn
		jmp FinishSpawn

	NotCannon:

		cpy #ENEMY_MINE
		bne NotMine

	IsMine:

		jsr MineSpawn
		jmp FinishSpawn

	NotMine:

		cpy #ENEMY_SUPPLY_FLAME
		bcc NotSupply

		cpy #ENEMY_SUPPLY_GRENADE + 1
		bcs NotSupply

	IsSupply:

		jsr SpawnSupplyRunner
		jmp FinishSpawn

	NotSupply:

		cpy #ENEMY_ROCKET_LAUNCHER
		bne NotRocket

	IsRocket:

		jsr SpawnRocketLauncher
		jmp FinishSpawn

	NotRocket:	

		cpy #ENEMY_CRAWLER
		bne NotCrawler

		jsr SpawnCrawler
		jmp FinishSpawn

	NotCrawler:

		cpy #ENEMY_GRENADIER
		bne NotGrenadier

		jsr SpawnGrenadier
		jmp FinishSpawn

	NotGrenadier:

		cpy #ENEMY_DOG
		bne NotDog

		jsr SpawnDog
		jmp FinishSpawn

	NotDog:

	FinishSpawn:

		lda MAIN.CurrentStage
		cmp #3
		bne NotForce

		ldy ZP.SpawnIndex
		dey
		cpy SpawnIndexes + 3
		bne NotForce

		lda #32
		sta ZP.SpriteX, x

	NotForce:

		jsr SPRITE.CalculatePositionAddresses
		jsr SPRITE.BackupChars

	Exit:



		rts
	}

	FloorY:	.byte 09, 12, 15, 17, 21
	NearestValidFloor:	 .byte 00, 00, 00, 00, 00, 01, 01, 01, 02, 02, 03, 03, 03, 03, 04, 04, 04 

	GetValidFloors: {

		lda SCREEN_RAM + ([12] * 40), y
		sta ZP.ValidFloors

		lda SCREEN_RAM + ([15] * 40), y
		sta ZP.ValidFloors + 1

		lda SCREEN_RAM + ([18] * 40), y
		sta ZP.ValidFloors + 2

		lda SCREEN_RAM + ([20] * 40), y
		sta ZP.ValidFloors + 3


		rts
	}

	GetRandomY: {


		jsr MAIN.Random
		cmp #100
		bcc UseGround

		ldy #0

		Loop:

			lda ZP.ValidFloors, y
			cmp MAP.LeftLadders
			bcs NotValid

			jsr MAIN.Random
			cmp #140
			bcc NotValid

			lda FloorY, y
			bne Exit

		NotValid:

			iny
			cpy #5
			bcc Loop


	UseGround:

		lda FloorY + 4

	Exit:

		sta ZP.SpriteY, x
		rts



	}

	GetNearestY: {


		ldy ZP.PlayerY


		lda NearestValidFloor - 7, y
		tay

		Loop:

			lda ZP.ValidFloors, y
			cmp MAP.LeftLadders
			bcs NotValid

			lda FloorY, y
			sta ZP.SpriteY, x
			rts

		NotValid:

			iny
			jmp Loop



	}						
		

	LevelAmount:	.byte 40, 35, 30, 25		

	CheckLeadSpawn: {

		CheckLeadEnemies:

			lda ZP.EnemyCount
			cmp #MAX_SPRITES - 2
			bcs Exit

			lda ZP.LeadSpawnTimer
			bmi NoneToSpawn

			beq ReadyToSpawn
			dec ZP.LeadSpawnTimer
		Exit:
			rts

		NoneToSpawn:

			lda ZP.LeadEnemyCount
			bne DoneLead

			jsr MAIN.Random
			and #%00011111
			ldy MAIN.CurrentStage
			clc
			adc LevelAmount, y
			jmp SaveLeadSpawn
		
		ReadyToSpawn:

			ldy ZP.LeadEnemyType
			jsr Spawn

			lda #37
			sta ZP.SpriteX, x

			lda #80
			sta ZP.SpriteMasterState, x

			ldy #38
			jsr GetValidFloors
			jsr GetNearestY
			//jsr CalculateValidY

			lda #INPUT.JOY_LEFT
			sta ZP.SpriteJoystick, x

			lda #STATE_WALK_LEFT
			sta ZP.SpriteState, x

			jsr SPRITE.CalculatePositionAddresses
			jsr SPRITE.BackupChars

			inc ZP.LeadEnemyCount

			lda ZP.LeadEnemyCount
			cmp #3
			bcc SetupLeadSpawn

		StopSpawning:

			jsr MAIN.Random
			ldy MAIN.CurrentStage
			cmp KickChance, y
			bcs NoKick


			jsr CheckKickboxerSpawn.Spawn

		NoKick:


			lda #255
			sta ZP.LeadSpawnTimer

			rts

		SetupLeadSpawn:

			jsr MAIN.Random
			and #%0000111
		SaveLeadSpawn:
			clc
			adc #10
			sta ZP.LeadSpawnTimer

		DoneLead:


		rts
	}

	KickChance:	.byte 0, 4, 8, 12
}