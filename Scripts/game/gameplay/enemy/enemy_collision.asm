.namespace ENEMY {

	XAdd:	.byte 1, 1, 1, 1
	XSize:	.byte 2, 3, 4, 2
	
	YAdd:	.byte 1, 0, 2, 0
	YSize:	.byte 3, 3, 3, 1

	CheckPlayerCollision: {

		lda ZP.PlayerCrawling
		asl
		clc
		adc ZP.SpriteCrawling, x
		tay

	NotCrawling:

		lda ZP.SpriteState, x
		and #%11101111
		cmp #STATE_DEAD_RIGHT
		beq Exit

		cmp #STATE_CANNON_DEAD
		beq Exit

		cmp #STATE_WALK_RIGHT
		bne NotDead

		lda ZP.SpriteFrame, x
		bne NotDead

	Exit:

		rts

	NotDead:

	

	SkipY:

		* = *  "Horse"

		lda ZP.SpriteX, x
		sec
		sbc ZP.PlayerX
		clc
		adc XAdd, y
		cmp XSize, y
		bcs Exit

		lda ZP.SpriteY, x
		sec
		sbc ZP.PlayerY
		clc
		adc YAdd, y
		cmp YSize, y
		bcs Exit

		cpx #MAX_SPRITES-1
		bne NotWeapon

	PickupWeapon:

		jsr SPRITE.RestoreChars
		
		lda #$FF
		sta ZP.SpriteX, x

		//dec ZP.EnemyCount

		jsr PLAYER.GainWeapon

		ldx ZP.SpriteID
		rts


	NotWeapon:

		jmp PLAYER.SetDead

	

	}

}