.namespace ACTOR {

	MakeWalk: {


		lda ZP.SpriteState, x
		and #%00010000
		sta ZP.SpriteState, x

		rts

	}

	CheckJump: {

		lda ZP.SpriteState, x
		and #%11101111
		cmp #STATE_DEAD_RIGHT
		beq NoJump

		lda ZP.SpriteVelocity, x
		beq NoJump
		bpl GoingUp

	GoingDown:

		lda ZP.OnGround
		beq CanFall

	Landed:

		lda #0
		sta ZP.SpriteVelocity, x

		lda ZP.SpriteJoystick, x
		ora #INPUT.joyUpDownOff
		sta ZP.SpriteJoystick, x

		jmp MakeWalk

	Exit:
		
		rts

	CanFall:

		lda ZP.SpriteVelocity, x
		cmp #145
		bcc Landed
		eor #$FF
		clc
		adc #1
		sta ZP.Temp1


		lda ZP.SpriteOffset, x
		sec
		sbc ZP.Temp1
		sta ZP.SpriteOffset, x
		bcs DoGravity

		inc ZP.SpriteY, x
		jmp DoGravity

	GoingUp:	

		lda ZP.SpriteOffset, x
		clc 
		adc ZP.SpriteVelocity, x
		sta ZP.SpriteOffset, x
		bcc DoGravity

		dec ZP.SpriteY, x

	DoGravity:

		lda ZP.SpriteVelocity, x
		sec
		sbc #GRAVITY
		sta ZP.SpriteVelocity, x
		bcs NoJump

		lda #40
		sta ZP.SpriteOffset, x
		

	NoJump:

		rts

	}
}