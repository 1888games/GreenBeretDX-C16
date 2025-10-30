

.namespace ENEMY {

	* = * "Enemy"

	Enemy:

	#import "scripts/game/gameplay/enemy/cannon_fodder.asm"
	#import "scripts/game/gameplay/enemy/gunner.asm"
	#import "scripts/game/gameplay/enemy/cannon.asm"
	#import "scripts/game/gameplay/enemy/kickboxer.asm"
	#import "scripts/game/gameplay/enemy/enemy_collision.asm"
	#import "scripts/game/gameplay/enemy/enemy_spawn.asm"
	#import "scripts/game/gameplay/enemy/mine.asm"
	#import "scripts/game/gameplay/enemy/supply_runner.asm"
	#import "scripts/game/gameplay/enemy/rocket_launcher.asm"
	#import "scripts/game/gameplay/enemy/grenadier.asm"
	#import "scripts/game/gameplay/enemy/crawler.asm"
	#import "scripts/game/gameplay/enemy/weapon.asm"
	#import "scripts/game/gameplay/enemy/enemy_boss.asm"
	#import "scripts/game/gameplay/enemy/dog.asm"
	#import "scripts/game/gameplay/enemy/enemy_config.asm"

	UpdateFunctions_LSB:		.byte <CannonFodder_Update, <Gunner_Update, <Kickboxer_Update, <Cannon_Update, <Mine_Update, <SupplyRunner_Update
								.byte <SupplyRunner_Update, <SupplyRunner_Update, <Weapon_Update, <Crawler_Update, <Dog_Update, <RocketLauncher_Update, <RocketLauncher_Update
								.byte <RocketLauncher_Update

	UpdateFunctions_MSB:		.byte >CannonFodder_Update, >Gunner_Update, >Kickboxer_Update, >Cannon_Update, >Mine_Update, >SupplyRunner_Update
								.byte >SupplyRunner_Update, >SupplyRunner_Update, >Weapon_Update, >Crawler_Update, >Dog_Update, >RocketLauncher_Update, >RocketLauncher_Update
								.byte >RocketLauncher_Update
	
	FrameUpdate: {




		lda ZP.ScrollStopFlag
		bne BossSpawning

		jsr CheckSpecificSpawn

		lda ZP.EnemyCount
		cmp #MAX_ENEMIES - 1
		bcc NormalPlay

		rts

	BossSpawning:

		bpl WaitingForClear

	BossInPlay:

		jmp UpdateBoss
		

	WaitingForClear:

		lda ZP.EnemyCount
		bne Exit

		lda #$FF
		sta ZP.ScrollStopFlag

		lda #60
		sta ZP.LeadSpawnTimer

	InitialiseBoss:

		rts

	NormalPlay:

		jsr CheckLeadSpawn
		jsr CheckGunnerSpawn
		jsr CheckKickboxerSpawn
	
	NoSpawn:

		
	Exit:

		rts
	}





	Update: {

			stx ZP.SpriteID

		CheckActive:

			lda ZP.SpriteX, x
			bmi FrameUpdate.Exit

			lda ZP.JustScrolled
			bpl NoScroll

			dec ZP.SpriteX, x
			bpl CheckEnemyReady

			jmp AI.Delete
			
		NoScroll:

			//lda TED.CURRENT_RASTER_Y
			//cmp #200
			//bcs Okay 

			//cmp #100
			//bcc Okay

			//jmp NoScroll

		Okay:

			jsr SPRITE.RestoreChars



		CheckEnemyReady:

			lda ZP.SpriteCrawling, x
			beq NotDead

			lda ZP.SpriteState, x
			and #%11101111
			cmp #STATE_DEAD_RIGHT
			bne NotDead

			dec ZP.SpriteY, x
			dec ZP.SpriteY, x
			dec ZP.SpriteCrawling, x

		NotDead:

			inc ZP.EnemyCount

			jsr SPRITE.CalculatePositionAddresses
			jsr ENTITY.CheckSurroundings

			lda ZP.SpriteTimer, x
			beq EnemyReady

			dec ZP.SpriteTimer, x
			jmp CheckJumping

		EnemyReady:

			//inc TED.BORDER_COLOR

			jsr ENEMY.AI

			lda ZP.SpriteX, x
			bmi FrameUpdate.Exit

		CheckJumping:

			jsr ACTOR.CheckJump

		DrawSprite:


			//.break

			jsr SPRITE.Draw

			jmp CheckPlayerCollision
			


	}


	


	AI: {

		

		lda ZP.EnemyType - 1, x
		tay

		lda UpdateFunctions_LSB, y
		sta Update + 1

		lda UpdateFunctions_MSB, y
		sta Update + 2

		jsr CheckDead
		bmi SkipUpdate

		Update: jsr $BEEF

	SkipUpdate:

		lda ZP.SpriteX, x
		bmi Delete

		cmp #39
		bcc Okay

	Delete:

		lda ZP.SpriteMasterState, x
		cmp #LEAD_ENEMY_INDICATOR
		bne SetInactive

		dec ZP.LeadEnemyCount
	
	SetInactive:

		lda #$FF
		sta ZP.SpriteX, x

		//dec ZP.EnemyCount

	Okay:

		rts

	
	}

	

	DeadColours:	.byte WHITE + LUMINANCE_7 + 8, RED + LUMINANCE_5 + 8

	// Don't move, using delete function!

	CheckDead: {


		lda ZP.SpriteState, x
		and #%11101111
		cmp #STATE_DEAD_RIGHT
		bne NotDead

	IsDead:

		lda ZP.SpriteState, x
		cmp #STATE_MINE
		bne NotMine

		jmp AI.Delete

	NotMine:

		dec ZP.SpriteTime, x
		bne NotFinished

		lda ZP.EnemyType - 1, x
		cmp #ENEMY_CANNON
		bne NotCannon


		lda #STATE_CANNON_DEAD
		sta ZP.SpriteState, x

		lda #0
		sta ZP.SpriteFrame, x
		rts

	NotCannon:

		lda #255
		sta ZP.SpriteX, x
		rts

	NotFinished:

		lda ZP.SpriteTime, x
		and #%00000001
		tay

		lda DeadColours, y
		sta ZP.SpriteColour, x

		lda #254
		rts
		
	NotDead:

		lda #0
		rts

	}


	CheckLadder: {


		lda ZP.SpriteState, x
		cmp #STATE_CLIMB
		beq Exit

		lda ZP.LadderBelow
		beq NoJoinDown

		lda ZP.PlayerY
		sec
		sbc ZP.SpriteY, x
		bmi Exit
		cmp #3
		bcc Exit

		lda #INPUT.JOY_DOWN
		sta ZP.SpriteJoystick, x

	Exit:

		rts


	NoJoinDown:

		lda ZP.OverLadder
		beq NoClimb

		lda ZP.PlayerY
		sec
		sbc ZP.SpriteY, x
		bcs NoClimb

	GoUp:

		lda #INPUT.JOY_UP
		sta ZP.SpriteJoystick, x
		
	NoClimb:


		rts
	}

	CheckJump: {

		lda ZP.SpriteState, x
		cmp #STATE_WALK_RIGHT
		beq CheckJumpRight

		cmp #STATE_WALK_LEFT
		beq CheckJumpLeft

		rts


	CheckJumpLeft:

		lda ZP.SpriteX, x
		beq Exit

		dey
		lda (ZP.ScreenAddress), y
		cmp MAP.LeftLadders
		bcs DoJump

     Exit:

		rts

	CheckJumpRight:

		iny
		lda (ZP.ScreenAddress), y
		cmp MAP.LeftLadders
		bcc Exit


	DoJump:

		lda ZP.SpriteJoystick, x
		and #INPUT.JOY_UP
		sta ZP.SpriteJoystick, x

		rts
	}

	EnemyEnd:
	.print ("ENEMY......." + (EnemyEnd - Enemy))





}