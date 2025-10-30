.namespace BULLET {



	WeaponSpeed:		.byte 1, 0, 1, 1

	Move: {

		CheckType:

			lda ZP.SpriteState, x
			and #%00001111
			bne NotKnife

		IsKnife:

			lda ZP.PlayerPreviousState
			sta ZP.PlayerState
			
			lda ZP.PreviousFrame
			sta ZP.PlayerFrame

			dec ZP.Stabbing

			jmp CancelBullet

		NotKnife:

			cmp #WEAPON_GRENADE
			bne NotGrenade


		IsGrenade:

			jsr DoGrenadeArc
			jmp NotGrenade

		Exit:

			rts

		NotGrenade:

			lda ZP.SpriteState, x
			and #%00010000
			beq GoRight

		GoLeft:

	
			lda ZP.SpriteX, x
			sec
			sbc ZP.BulletXSpeed - MAX_SPRITES, x
			bpl NoWrapRight

			jmp CancelBullet

		GoRight:

			lda ZP.SpriteX, x
			clc
			adc ZP.BulletXSpeed - MAX_SPRITES, x
			cmp #40
			bcc NoWrapRight

			jmp CancelBullet


		NoWrapRight:

			sta ZP.SpriteX, x

			lda ZP.BulletSource - MAX_SPRITES, x
			beq PlayerFired

			lda #1
			jmp StoreTime

		PlayerFired:

			lda ZP.SpriteState, x
			and #%00001111
			tay
			lda WeaponSpeed - 1, y
		StoreTime:
			sta ZP.SpriteTimer, x

			rts
	}



	DoGrenadeArc: {

		lda ZP.BulletXSpeed - MAX_SPRITES, x
		eor #%00000001
		sta ZP.BulletXSpeed - MAX_SPRITES, x

		lda ZP.SpriteVelocity, x
		bne NotDelete

		lda ZP.BulletSource - MAX_SPRITES, x
		beq PlayerFired

		jmp GrenadeCollisionPlayer

	PlayerFired:

		jmp GrenadeCollisionEnemies

	NotDelete:

		bpl GoingUp
		jmp CanFall

		//lda ZP.SpriteY, x
		//cmp #FLOOR_ROW + 1
		//bcc CanFall

	Landed:

		lda #0
		sta ZP.SpriteVelocity, x
		rts

	CanFall:

		lda ZP.SpriteVelocity, x
		eor #$FF
		clc
		adc #1
		sta ZP.Temp1

		lda ZP.SpriteOffset, x
		sec
		sbc ZP.Temp1
		sta ZP.SpriteOffset, x
		bcs CheckGravity

		lda ZP.SpriteY, x
		cmp #23
		bcs Landed

		clc
		adc #2
		sta ZP.SpriteY, x
		cmp #24
		bcc CheckGravity

		lda #23
		sta ZP.SpriteY, x

	CheckGravity:

		lda ZP.SpriteVelocity, x
		cmp #145
		bcc NoJump

		jmp DoGravity

	GoingUp:	

		lda ZP.SpriteOffset, x
		clc 
		adc ZP.SpriteVelocity, x
		sta ZP.SpriteOffset, x
		bcc DoGravity

		dec ZP.SpriteY, x
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