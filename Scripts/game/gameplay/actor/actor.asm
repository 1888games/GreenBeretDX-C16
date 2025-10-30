

.namespace ACTOR {

	* = * "Actor"
	Actor:

	#import "scripts/game/gameplay/actor/actor_right.asm"
	#import "scripts/game/gameplay/actor/actor_left.asm"
	#import "scripts/game/gameplay/actor/actor_jump.asm"
	#import "scripts/game/gameplay/actor/actor_up.asm"
	#import "scripts/game/gameplay/actor/actor_down.asm"
	#import "scripts/game/gameplay/actor/actor_climb.asm"




	Control: {
	
	
		lda ZP.SpriteJoystick, x
		sta ZP.JoyTemp
		and #INPUT.joyRightMask
		bne NotRight

		jsr GoRight
		jmp NotLeft

	NotRight:

		lda ZP.JoyTemp
		and #INPUT.joyLeftMask
		bne NotLeft

		jsr GoLeft

	NotLeft:

		cpx #0
		bne NotFire

		lda ZP.FireFrames
		bpl NotFire

		cmp #$89
		bcc Stab

	Fire:

		lda ZP.PlayerWeapon
		beq Stab

		jsr PLAYER.FireWeapon

		dec ZP.PlayerBullets
		bne StillLoaded

		lda #WEAPON_KNIFE
		sta ZP.PlayerWeapon

	StillLoaded:

		jmp PLAYER.DrawAmmo
		
	Stab:

		jmp PLAYER.StabWeapon
		
	NotFire:

		lda ZP.JoyTemp
		and #INPUT.joyDownMask
		bne NotDown

		jmp GoDown

	NotDown:

		lda ZP.JoyTemp
		and #INPUT.joyUpMask
		bne NotUp
		

		jmp GoUp

	NotUp:
		
			
		jmp CheckReleaseDown
	}




	ActorEnd:
	.print ("ACTOR......." + (ActorEnd - Actor))

}