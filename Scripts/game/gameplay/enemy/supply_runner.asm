.namespace ENEMY {


	SpawnSupplyRunner: {


		lda ZP.ScrollSectorNumber
		sta MAIN.Checkpoint
		beq NoDecrease

		dec MAIN.Checkpoint
		
	NoDecrease:

		lda #WEAPON_HOLDER_FLAG
		sta ZP.SpriteOffset, x

		lda #2
		sta ZP.SpriteTime, x

	CrouchingEnemy:

		lda #STATE_CROUCH_LEFT	
		sta ZP.SpriteState, x
		sta ZP.SpriteLastFrameState, x
	
		lda ZP.Temp3
		and #%11110000
		lsr
		lsr
		lsr
		lsr
		clc
		adc #10
		sta ZP.SpriteY, x

		lda #1
		sta ZP.SpriteTimer, x
		sta ZP.SpriteCrawling, x


		rts
	}


	CheckTriggered: {

	
		clc
		adc #9
		sta ZP.Temp1

		lda ZP.SpriteX, x
		sec 
		sbc ZP.PlayerX
		cmp ZP.Temp1
		bcs Exit

		cmp #2
		bcc Trigger

		jsr MAIN.Random
		cmp #50
		bcs Exit

	Trigger:

		lda #INPUT.JOY_LEFT
		sta ZP.SpriteJoystick, x

		lda #STATE_WALK_LEFT
		sta ZP.SpriteState, x

		dec ZP.SpriteY, x
		dec ZP.SpriteY, x
		dec ZP.SpriteCrawling, x
	
	Exit:

		rts





	}

	SupplyRunner_Update: {
		
		lda ZP.SpriteState, x
		cmp #STATE_CROUCH_LEFT
		bne NoLongerCrouching

	IsCrouching:

		lda MAIN.CurrentStage

		jmp CheckTriggered

		
	NoLongerCrouching:

		lda ZP.SpriteTime, x
		cmp #2
		beq MakeOne

		lda #2
		jmp StoreTime


	MakeOne:

		lda #1

	StoreTime:

		sta ZP.SpriteTime, x

		jsr CheckLadder
		jsr ACTOR.Control

	Exit:


		rts
	}
}