.namespace PLAYER {

	CheckFireButtonHold: {


			lda ZP.JOY_READING
			and #INPUT.joyFireMask
			bne NotFire

			inc ZP.FireFrames
		Exit:
			rts
			
		NotFire:

			lda ZP.FireFrames
			beq Exit

			clc
			ora #%10000000
			sta ZP.FireFrames

		rts


	}
	
	// a = player bullets

	FireWeapon: {
		
		jsr BULLET.Fire

		// x = bullet sprite ID

		lda ZP.PlayerState
		and #%00010000
		pha
		ora ZP.SpriteState, x
		sta ZP.SpriteState, x

		pla
		beq FireRight


	FireLeft:

		lda ZP.PlayerX
		sta ZP.SpriteX, x
		dec ZP.SpriteX, x
		jmp Exit

	FireRight:

		lda ZP.PlayerX
		clc
		adc #2
		sta ZP.SpriteX, x

	Exit:

		lda ZP.PlayerY
		sta ZP.SpriteY, x

		lda ZP.SpriteState, x
		and #%00001111
		cmp #WEAPON_GRENADE
		bne NotGrenade

		lda #93
		sta ZP.SpriteVelocity, x
		sta ZP.SpriteOffset, x

		dec ZP.SpriteY, x

	NotGrenade:

		lda ZP.PlayerState
		cmp #STATE_CROUCH_RIGHT
		bne IsNotCrouchingRight

		inc ZP.SpriteX, x
		jmp IsCrouching

	IsNotCrouchingRight:

		cmp #STATE_CROUCH_LEFT
		beq IsCrouching
		
		inc ZP.SpriteY, x 

	IsCrouching:

		

		ldx #0
		stx ZP.FireFrames

		rts
		

	}




	StabWeapon: {

		lda #0
		sta ZP.FireFrames

		inc ZP.HurryTimer
	
		lda ZP.PlayerState
		sta ZP.PlayerPreviousState
		cmp #STATE_WALK_RIGHT
		beq StabWalk

		cmp #STATE_WALK_LEFT
		beq StabWalk

		cmp #STATE_CROUCH_RIGHT
		beq StabCrouch

		cmp #STATE_CROUCH_LEFT
		beq StabCrouch

		rts


	StabCrouch:

		clc
		adc #STATE_CROUCH_STAB_RIGHT - STATE_CROUCH_RIGHT
		jmp DoStab

	StabWalk:

		clc
		adc #%00001000

	DoStab:

		pha
		
		lda ZP.PlayerFrame
		cmp #3
		bne NoAdjust

		jsr SCREEN.CheckScrollAdjust

		lda #2
		sta ZP.PlayerFrame

	NoAdjust:

		inc ZP.Stabbing

		lda ZP.PlayerFrame
		sta ZP.PreviousFrame

		lda #0
		sta ZP.PlayerFrame
		jsr FireWeapon

		stx ZP.SpriteID

		pla
		sta ZP.PlayerState

		lda #1
		sta ZP.SpriteTimer, x
		sta ZP.PlayerTimer
		inc ZP.PlayerTimer


		rts
	

	}


}