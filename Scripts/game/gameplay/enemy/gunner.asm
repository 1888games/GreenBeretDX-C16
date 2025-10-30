.namespace ENEMY {


	Gunner_Shoot: {

		lda ZP.SpriteBullets, x
		cmp #2
		beq CanShoot

		lda ZP.SpriteState, x
		and #%00010000
		sta ZP.SpriteState, x


		lda ZP.SpriteMasterState, x
		sta ZP.SpriteFrame, x


		inc ZP.SpriteBullets, x
		rts

	CanShoot:

		lda ZP.SpriteWeapon, x
		jsr BULLET.Fire

		// x = bullet sprite ID

		ldy ZP.SpriteID

		lda ZP.SpriteState, y
		and #%00010000
		pha
		ora ZP.SpriteState, x
		sta ZP.SpriteState, x

		pla
		beq FireRight


	FireLeft:

		lda ZP.SpriteX, y
		sta ZP.SpriteX, x
		dec ZP.SpriteX, x
		jmp Exit

	FireRight:

		lda ZP.SpriteX, y
		clc
		adc #2
		sta ZP.SpriteX, x

	Exit:

		lda ZP.SpriteY, y
		sta ZP.SpriteY, x
		sta ZP.BulletSource - MAX_SPRITES, x
		inc ZP.SpriteY, x

		lda ZP.SpriteState, x
		and #%00001111
		cmp #WEAPON_GRENADE
		bne NotGrenade

		lda #93
		sta ZP.SpriteVelocity, x
		sta ZP.SpriteOffset, x

		dec ZP.SpriteY, x

	NotGrenade:

		ldx ZP.SpriteID

		lda #15
		sta ZP.SpriteTimer, x

		dec ZP.SpriteBullets, x

		rts





	}

	Gunner_Update: {

	NotFast:

		cpx #5
		beq Slow

		cmp #8
		beq Slow

		jmp NotSlow

	Slow:
		
		lda ZP.SpriteTime, x
		eor #%00000001
		sta ZP.SpriteTime, x

	NotSlow:

		lda ZP.SpriteState, x
		and #%11101111

	CheckShooting:
	
		cmp #STATE_KICK_RIGHT
		bne NotShooting

	IsShooting:

		jmp Gunner_Shoot


	NotShooting:

		cmp #STATE_CLIMB
		beq NowControl

	CheckJump:

		lda ZP.OnGround
		beq NotFire

		lda ZP.EnemyType - 1, x
		cmp #ENEMY_GRENADIER
		bne NotGrenade

		jsr MAIN.Random
		cmp #9
		bcs NotFire

		inc ZP.SpriteBullets, x

		jmp Gunner_Shoot.CanShoot

	NotGrenade:

		lda ZP.ScrollStopFlag
		beq NoAdd

		lda #7

	NoAdd:

		clc
		adc MAIN.CurrentStage
		adc #3
		sta ZP.Temp1

		jsr MAIN.Random
		cmp ZP.Temp1
		bcs NotFire

	StartShot:

		lda ZP.SpriteFrame, x
		sta ZP.SpriteMasterState, x

		lda #0
		sta ZP.SpriteFrame, x

		lda ZP.SpriteState, x
		and #%00010000
		clc
		adc #STATE_KICK_RIGHT
		sta ZP.SpriteState, x

		lda #40
		sta ZP.SpriteTimer, x

	Exit:
		rts

	NotFire:

		jsr CheckLadder

	NowControl:
		
		jmp ACTOR.Control

		
	}


	CheckGunnerSpawn: {

		lda ZP.EnemyCount
		cmp #6
		bcs Exit

		ldy #ENEMY_GUNNER

		dec ZP.GunnerSpawnTimer
		beq LeftSide

		dec ZP.GunnerSpawnTimer
		beq RightSide

	Exit:

		rts

	LeftSide:

		jsr Spawn

		lda #1
		sta ZP.SpriteX, x

		lda #INPUT.JOY_RIGHT
		sta ZP.SpriteJoystick, x

		lda #STATE_WALK_RIGHT
		ldy #1
		jmp Either

	RightSide:

		lda MAIN.CurrentStage
		beq NotKickBoxer

		jsr MAIN.Random
		cmp #20
		bcs NotKickBoxer

	IsKickboxer:

		ldy #ENEMY_KICKBOXER

	NotKickBoxer:

		jsr Spawn
	
		lda #37
		sta ZP.SpriteX, x
		tay

		lda #INPUT.JOY_LEFT
		sta ZP.SpriteJoystick, x

		lda #STATE_WALK_LEFT

	Either:	

		sta ZP.SpriteState, x
		sta ZP.SpriteLastFrameState, x

		lda ZP.EnemyType - 1, x
		cmp #ENEMY_KICKBOXER
		beq NoWeapon

		lda #2
		sta ZP.SpriteBullets, x

		lda #WEAPON_GUN
		sta ZP.SpriteWeapon, x


	NoWeapon:

		//jsr CalculateValidY

		jsr GetValidFloors
		jsr GetRandomY

		jsr SPRITE.CalculatePositionAddresses
		jsr SPRITE.BackupChars

		stx ZP.Temp1

		jsr MAIN.Random
		and #%00111111
		clc
		adc #172
		adc ZP.Temp1
		sta ZP.GunnerSpawnTimer

		rts
	}



}