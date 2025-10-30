
.label FLOOR_ROW = 23
.label PLAYER_SPRITE_ID = 0

.label PLAYER_CHAR_START = 183
.label SCROLL_THRESHOLD = 18

.label CLIMB_TIME = 2


.namespace PLAYER {

	* = * "Player"

	Player:

	#import "scripts/game/gameplay/player/player_fire.asm"
	#import "scripts/game/gameplay/player/player_weapon.asm"


	Initialise: {

		lda #FLOOR_ROW - 2
		sta ZP.PlayerY

		lda #5
		sta ZP.PlayerX

		ldx #0
		stx ZP.PlayerOffset
		stx ZP.PlayerFrame
		stx ZP.JustScrolled
		stx ZP.PlayerBullets
		stx ZP.PlayerState
		stx ZP.FireFrames
	
		stx ZP.Stabbing
		stx ZP.PlayerTimer
		stx ZP.PlayerTime
		stx ZP.PlayerCrawling
		stx ZP.OverLadder
		stx ZP.PlayerVelocity
		stx ZP.PlayerWeapon

		//lda #1
		//sta ZP.PlayerBullets

		jsr SPRITE.CalculatePositionAddresses

		jsr SPRITE.BackupChars

		//ldy #WEAPON_FLAME
		//jsr GainWeapon.ByY

		lda #LUMINANCE_5 + GREEN + 8
		sta ZP.PlayerColour



		rts

	}




	FrameUpdate: {


			ldx #0
			stx ZP.JustScrolled
			stx ZP.UpdateScore

		CheckScroll:

			lda ZP.IsDead
			beq NotDead

			jmp DeadUpdate

		NotDead:

			lda ZP.JustScrolled
			bpl Restore

			lda ZP.PlayerY
			cmp #12
			bcs SkipRestorePlayer

		Restore:

			jsr SPRITE.RestoreChars
			jmp SkipAddress

		SkipRestorePlayer:

			jsr SPRITE.CalculatePositionAddresses

		SkipAddress:

			jsr CheckFireButtonHold
			jsr ENTITY.CheckSurroundings

			lda ZP.PlayerTimer
			beq Ready

			dec ZP.PlayerTimer

			lda ZP.OnGround
			bne NoControl

			jsr MoveInAir
			jmp NoControl

		Ready:

			jsr ACTOR.Control

		NoControl:

			jsr ACTOR.CheckJump

			lda ZP.PlayerState
			sta ZP.PlayerLastFrameState

			jmp SPRITE.Draw


	}

	MoveInAir: {

		lda ZP.SpriteJoystick, x
		sta ZP.Temp1
		and #INPUT.joyRightMask
		bne NotRight

		jmp ACTOR.GoRight
	

	NotRight:

		lda ZP.Temp1
		and #INPUT.joyLeftMask
		bne NotLeft

		jmp ACTOR.GoLeft

	NotLeft:

		rts

	}


	DeadUpdate: {

		jsr ENEMY.CheckDead.IsDead

		cmp #255
		bne NotDone

		tax
		txs
		jsr LIVES.Decrease
		jmp GAME.RestartLevel

	NotDone:

		jmp SPRITE.Draw

	}

	

	
	SetDead: {

		
		inc ZP.IsDead

		lda ZP.PlayerState
		and #%00010000
		clc
		adc #STATE_DEAD_RIGHT
		sta ZP.PlayerState


		lda #36
		sta ZP.PlayerTime

		lda #0
		sta ZP.PlayerFrame
		sta ZP.PlayerOffset
		sta ZP.PlayerBullets
		sta ZP.PlayerCrawling
		sta ZP.Stabbing
		

		cpy #0
		beq NotCrawling

		dec ZP.PlayerY
		dec ZP.PlayerY
		inc ZP.PlayerX

	NotCrawling:

		rts


	}

	


	PlayerEnd:
	.print ("PLAYER......" + (PlayerEnd - Player))





	

}