.namespace ENEMY {




	CannonSpawn: {

		lda #STATE_CANNON
		sta ZP.SpriteState, x
		sta ZP.SpriteLastFrameState, x
	
		lda #FLOOR_ROW - 2
		sta ZP.SpriteY, x

		lda #96
		sta ZP.SpriteTimer, x

		rts
	}



	Throw_Grenade: {

		lda #WEAPON_GRENADE
		jsr BULLET.Fire

		// x = bullet sprite ID

		ldy ZP.SpriteID

		lda ZP.SpriteState, x
		clc 
		adc #STATE_WALK_LEFT
		sta ZP.SpriteState, x

	FireLeft:

		lda ZP.SpriteX, y
		sta ZP.SpriteX, x
		dec ZP.SpriteX, x

		lda ZP.SpriteY, y
		sta ZP.SpriteY, x
		dec ZP.SpriteY, x

		lda #121
		sta ZP.SpriteVelocity, x
		sta ZP.SpriteOffset, x
		sta ZP.BulletSource - MAX_SPRITES, x

		ldx ZP.SpriteID
		lda #120
		sta ZP.SpriteTimer, x

		rts
	}

	Cannon_Update: {

		lda ZP.SpriteState, x
		cmp #STATE_CANNON_DEAD
		beq Exit

		jmp Throw_Grenade
	
	Exit:

		rts
	}


}