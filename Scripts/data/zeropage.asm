*=$02 "Temp vars zero page" virtual

.label MAX_ENEMIES = 9
.label MAX_SPRITES = MAX_ENEMIES + 1
.label MAX_BULLETS = 6

ZP: {

	ScreenAddress:			.word 0
	FrameSwitch:			  .byte 0
	ColourAddress:			.word 0
	SourceAddress:			.word 0


	HudEndLine:					   .byte 0
	Colour:					    .byte 0
	Frame:					    .byte 0
	SpriteID:				    .byte 0
  Cooldown:           .byte 0
  Stabbing:           .byte 0
  PreviousFrame:      .byte 0

  
  SFXChannel1_Address: .word 0
  SFXChannel2_Address: .word 0

  SFXChannel1_Index:   .byte 0
  SFXChannel2_Index:   .byte 0
  SFXChannel1_Timer:   .byte 0
  SFXChannel2_Timer:   .byte 0
  SFXChannel1_Duration:   .byte 0
  SFXChannel2_Duration:   .byte 0



	JoyTemp:              .byte 0
  HurryTimer:           .byte 0
	JustScrolled:			.byte 0
  
  LivesRemaining:   .byte 0
  Temp3:   .byte 0

* = * "Fire Frames" virtual
	FireFrames:				.byte 0


* = * "Joystick" virtual




* = * "ZP Map Data" virtual

	ScreenColumnsDrawn:		.byte 0

	SectorXOffset:			.byte 0
	CurrentSectorLength:	.byte 0
	CurrentSectorTruncate: .byte 0
	CurrentSectorDrawn:		 .byte 0
	RowsDrawn:				     .byte 0

* = * "Fine Scroll" virtual

	FineScroll:				    .byte 0

	ThisSectorXOffset:		.byte 0

	ScrollSectorNumber:		.byte 0
	ScrollSectorLength:		.byte 0


	SectorDataAddress:		.word 0
	SectorMapAddress:		  .word 0
	SpriteCharAddress:		.word 0
	SpriteDataAddress:		.word 0



   * = * "ZP Sprite Data" virtual

    SpriteX:				
    PlayerX:				.byte 0
    EnemyX:					.fill MAX_ENEMIES, 0
    BulletX:				.fill MAX_BULLETS, 0

    SpriteY:
    PlayerY:				.byte 0
    EnemyY:					.fill MAX_ENEMIES, 0
    BulletY:				.fill MAX_BULLETS, 0


    SpriteState:			
    PlayerState:			.byte 0
    EnemyState:				.fill MAX_ENEMIES, 0
    BulletState:			.fill MAX_BULLETS, 0


   * = * "SpriteStoredChars" virtual
    SpriteStoredChars:      .fill MAX_SPRITES * 6, 0
    SpriteStoredColours:    .fill MAX_SPRITES * 6, 0


   * = * "BulletChars" virtual
    BulletStoredChars:      .fill MAX_BULLETS, 0
    BulletStoredColours:    .fill MAX_BULLETS, 0





    * = * "SpriteFrame" virtual
    SpriteFrame:    
    PlayerFrame:            .byte 0
    EnemyFrame:             .fill MAX_ENEMIES, 0


 
    * = * "SpriteTimer" virtual
    SpriteTimer:			
    PlayerTimer:			.byte 0
    EnemyTimer:				.fill MAX_ENEMIES, 0
    BulletTimer:	   		.fill MAX_BULLETS, 0


       * = $100 "SpriteTime" virtual
    SpriteTime:				
    PlayerTime:				.byte 0
    EnemyTime:				.fill MAX_ENEMIES, 0


      * = * "SpriteColour" virtual
    SpriteColour:
    PlayerColour:			.byte 0
    EnemyColour:			.fill MAX_ENEMIES, 0
    BulletColour:     .fill MAX_BULLETS, 0

      * = * "SpriteOffset" virtual
    SpriteOffset:           
    PlayerOffset:           .byte 0
    EnemyOffset:            .fill MAX_ENEMIES, 0
    BulletOffset:           .fill MAX_BULLETS, 0

    *  = * "SpriteMasterState" virtual
    SpriteMasterState:     
    PlayerMasterState:      .byte 0
    EnemyMasterState:       .fill MAX_ENEMIES, 0

  * = * "SpritePreviousState" virtual
    SpritePreviousState:    
    PlayerPreviousState:    .byte 0
    EnemyPreviousState:     .fill MAX_ENEMIES, 0


    * = * "SpriteLastFrameState" virtual
    SpriteLastFrameState:    
    PlayerLastFrameState:    .byte 0
    EnemyLastFrameState:     .fill MAX_ENEMIES, 0

    * = * "SpriteCrawling" virtual
    SpriteCrawling:
    PlayerCrawling:       .byte 0
    EnemyCrawling:      .fill MAX_ENEMIES, 0

    * = * "SpriteJoystick" virtual


    SpriteJoystick:
    JOY_READING:         .byte 0
    EnemyJoystick:       .fill MAX_ENEMIES, 0


    * = * "EnemyType" virtual
    EnemyType:              .fill MAX_ENEMIES, 0




  * = * "SpriteBullets" virtual
    SpriteBullets:			
    PlayerBullets:			.byte 0
    EnemyBullets:			.fill MAX_ENEMIES, 0
    BulletXSpeed:     .fill MAX_BULLETS, 0

    SpriteWeapon:
    PlayerWeapon:			.byte 0
    EnemyWeapon:			.fill MAX_ENEMIES, 0
    BulletSource:     .fill MAX_BULLETS, 0

  * = * "SpriteVelocity" virtual
    SpriteVelocity:      
    PlayerVelocity:      .byte 0
    EnemyVelocity:     .fill MAX_ENEMIES, 0
    BulletVelocity:   .fill MAX_BULLETS, 0


    Counter:        .byte 0
    Temp1:          .byte 0
    Temp2:          .byte 0
    CurrentSectorNumber:  .byte 0
    CurrentSectorID:    .byte 0
    OverLadder: .byte 0
    OnGround: .byte 0
    IsDead:   .byte 0
    LadderBelow:        .byte 0
    CurrentStage:       .byte 0
    StageBackgroundColour: .byte 0


    EnemyCount:         .byte 0
    LeadEnemyCount:     .byte 0
    LeadSpawnTimer:     .byte 0
    LeadEnemyType:      .byte 0
    GunnerSpawnTimer:   .byte 0

    Score:      .fill 5, 0
    HighScore:  .fill 5, 0
    UpdateScore:        .byte 0
 

* = * "Spawn Index" virtual
    SpawnIndex:         .byte 0
    StartSpawnIndex:    .byte 0
    ScrollStopFlag:     .byte 0
    NumSectors:         .byte 0
    ValidFloors:        .fill 5, 0
    TenThousandsMarker:  .byte 0

  
	* = * "End of ZP" virtual

  .print ("ZP & P1.....512")



}



