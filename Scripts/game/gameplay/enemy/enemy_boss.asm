.namespace ENEMY {

	UpdateBoss: {


		lda ZP.LeadSpawnTimer
		beq Ready

		dec ZP.LeadSpawnTimer

	Exit:

		rts

	Ready:

		* = * "Boss Update"

		sta ZP.Temp2  // Going Left

		ldy ZP.SpawnIndex
		
		lda EnemyOffset, y
		cmp #255
		beq LevelComplete
		bpl GoingLeft

		inc ZP.Temp2
		and #%01111111

	GoingLeft:

		sta ZP.LeadSpawnTimer

		jsr MAIN.Random
		and #%00000111
		clc
		adc ZP.LeadSpawnTimer
		sta ZP.LeadSpawnTimer

		lda EnemySector, y
		pha

		lda EnemyType, y
		tay

		jsr Spawn

		lda #FLOOR_ROW - 2
		sta ZP.SpriteY, x

		lda ZP.Temp2
		beq DoLeft

		lda #1
		sta ZP.SpriteX, x

		lda #INPUT.JOY_RIGHT
		sta ZP.SpriteJoystick, x

		lda #STATE_WALK_RIGHT
		sta ZP.SpriteState, x
		jmp Done


	DoLeft:

		lda #37
		sta ZP.SpriteX, x

		lda #INPUT.JOY_LEFT
		sta ZP.SpriteJoystick, x

		lda #STATE_WALK_LEFT
		sta ZP.SpriteState, x

	Done:

		lda ZP.EnemyType-1, x
		cmp #ENEMY_DOG
		bne NotDog

		jsr SpawnDog
		jmp NotGrenadier

	NotDog:

		cmp #ENEMY_GRENADIER
		bne NotGrenadier

		jsr SpawnBossGrenadier

	NotGrenadier:

		cmp #ENEMY_FLAME_THROWER
		bne NotFlameThrower

		jsr SpawnFlameThrower

	NotFlameThrower:

		jsr SPRITE.CalculatePositionAddresses
		jsr SPRITE.BackupChars

		pla
		sta ZP.SpriteOffset, x


	SetTime:

		inc ZP.SpawnIndex
		ldy ZP.SpawnIndex
		lda EnemyOffset, y
		cmp #255
		beq LevelComplete

		rts

	LevelComplete:

		lda ZP.EnemyCount
		bne NotYet

		sei
		ldx #$F6
		txs

		jmp COMPLETE.Show

	NotYet:

		lda #50
		sta ZP.LeadSpawnTimer


		rts
	}


}