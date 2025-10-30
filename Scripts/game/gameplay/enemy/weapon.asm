.namespace ENEMY {


	WeaponStateIDs:	.byte 41, 40, 42
	WeaponColours:	.byte YELLOW + 8 + LUMINANCE_5, WHITE + LUMINANCE_7 + 8
					.byte BLUE + LUMINANCE_5 + 8
						

	SpawnWeapon: {

		lda ZP.EnemyCrawling, y
		sta ZP.Temp1

		lda ZP.EnemyY, y
		pha

		lda ZP.EnemyX, y
		pha	

		lda ZP.EnemyType, y
		sec
		sbc #5
		tay
		
		clc
		adc #2
		pha

		lda WeaponStateIDs, y
		pha

		lda WeaponColours, y
		pha

		ldx #MAX_SPRITES - 1
		ldy #ENEMY_WEAPON
	
		jsr Spawn.StoreStuff

		pla
		sta ZP.SpriteColour, x

		pla
		sta ZP.SpriteState, x
		sta ZP.SpriteLastFrameState, x

		pla
		sta ZP.SpriteMasterState, x

		pla
		clc
		adc #1
		sta ZP.SpriteX, x

		pla
		sta ZP.SpriteY, x

		ldy ZP.Temp1
		bne WasCrawling

		clc
		adc #2
		sta ZP.SpriteY, x

	WasCrawling:

		lda #1
		sta ZP.SpriteCrawling, x

		lda #4
		sta ZP.SpriteTime, x
		sta ZP.SpriteOffset, x
		sta ZP.SpriteTimer, x

		jsr SPRITE.CalculatePositionAddresses
		jsr SPRITE.BackupChars




		rts
	}


	Weapon_Update: {

		lda ZP.SpriteOffset, x
		beq NoMove

		dec ZP.SpriteOffset, x

		lda ZP.SpriteX, x
		cmp #37
		bcs NoMove

		inc ZP.SpriteX, x

		inc ZP.SpriteTime, x
		inc ZP.SpriteTime, x


	NoMove:

		rts
	}

}