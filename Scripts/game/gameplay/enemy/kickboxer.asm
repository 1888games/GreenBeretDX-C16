.namespace ENEMY {




	.label JUMP_DISTANCE = 11

	Kickboxer_Update: {

		
		lda ZP.PlayerY
		sec
		sbc ZP.SpriteY, x
		clc
		adc #3
		cmp #7
		bcs NoJump

		lda ZP.SpriteState, x
		cmp #STATE_WALK_RIGHT
		beq CheckKickRight

		cmp #STATE_WALK_LEFT
		bne NoJump

	CheckKickLeft:

		lda ZP.SpriteX, x
		sec 
		sbc ZP.PlayerX
		cmp #JUMP_DISTANCE
		bcc DoJump

		jmp CannonFodder_Update.DoneDead

	CheckKickRight:

		lda ZP.PlayerX
		sec
		sbc ZP.SpriteX, x
		cmp #JUMP_DISTANCE
		bcc DoJump

		jmp CannonFodder_Update.DoneDead


	DoJump:

		lda ZP.SpriteState, x
		and #%00010000
		clc
		adc #STATE_KICK_RIGHT
		sta ZP.SpriteState, x

		lda ZP.SpriteJoystick, x
		and #INPUT.JOY_UP
		sta ZP.SpriteJoystick, x

		lda #0
		sta ZP.SpriteFrame, x

	NoJump:

		jsr ACTOR.Control

	Exit:

		rts

	}
}


// Cannon

	// 1st level done

	// 3rd level , 3rd warehouse


// Mines

// 1st Level  - 1st truck, second wheel. 8/10   3 

 
// 2nd level - 2nd door, to right of crawler     1
		// 	- 4th door right x 2

		// 5th door right


		// crates after tank x 3, right 1 of 11


		// final door x 3

// Crawlers

// 1st Level - 2nd girder, right stantion
// 2nd truck, end pointy bit
// 1st Missile, black bit


// 2nd level - right edge of 2nd door



// Launchers (crawl to start)

// 2nd door, door

