	
	//.segmentdef Map [start=$3400]
	//.segmentdef Main

	.var target = "264"
	.var format = "disk"

MAIN: {

	#import "scripts/data/zeropage.asm"

	* = $0A00 "Sprites"

	Sprites:
	.import binary "assets/Sprites/gb_sprites - Chars.bin"
	.print ("SPRITES.....1536")


	#import "scripts/game/system/screen.asm"
	#import "scripts/common/input.asm"

	* = $01b0 "Map Data" virtual
	.fill 2048, 64
	.print ("MAP DATA....2048")

	* = TED.COLOR_RAM "Colour RAM" virtual
	.fill 1024, 64
	.print ("COLOR RAM...1024")

	* = SCREEN_RAM "Screen RAM" virtual
	.fill 1024, 96
	.print ("SCREEN RAM..1024")
	 		
	

	
	
	#import "scripts/data/ted.asm"
	#import "scripts/common/macros.asm"

	* = $1000
	PerformFrameCodeFlag:	.byte 0	
	.print ("FRAME FLAG..1")
 
	.pc = $1001 "Basic Upstart"
 
	Upstart:


			
	// BASIC line: 10 SYS 4109 (SYSS $100D)
	.word upstart_end    // Link to next line
 
	.byte 0             // Line number 0
	CurrentStage:
	.byte 0
	.byte $9e            // SYS token 
	.text "4109"        // Address 4110 ($100E) 

	GameMode:
	.byte 0              // End of line

	upstart_end:
	MapCopied:
	.byte 0              // End of BASIC program
	Checkpoint:
	.byte 0

	UpstartEnd:
	.print ("UPSTART....." + (UpstartEnd - Upstart))
	

	* = * "Main"

	Main:

   	Entry: {

   		
		sei
		sta BANK_IN_RAM

		
		jsr SCORE.SetHigh
		//lda CurrentStage
		//bne SkipMap

		jsr MAP.CopyMapTo200
	SkipMap:
 
		jsr IRQ.SetMainIRQ

		//jmp GAME.NewGamessss
		jmp TITLE.Show

	}



	WaitForIRQ: {

		lda PerformFrameCodeFlag
		beq WaitForIRQ

		dec PerformFrameCodeFlag

		rts
	}

	.label RANDOM_TIMER = $FF00
	.label EOR = $FF1E
 
	Random: {

		lda RANDOM_TIMER
		eor EOR
		rts


	} 
	
	MainEnd:
	.print ("MAIN........" + (MainEnd - Main))
	


}

#import "scripts/game/system/irq.asm"
#import "scripts/game/screens/game.asm"
#import "scripts/game/screens/title.asm"
#import "scripts/game/screens/game_over.asm"
#import "scripts/game/screens/level_complete.asm"
#import "scripts/game/system/mapload.asm"

#import "scripts/game/gameplay/player/player.asm"
#import "scripts/game/gameplay/actor/actor.asm"
#import "scripts/game/gameplay/enemy/enemy.asm"
#import "scripts/game/gameplay/bullet/bullet.asm"	

#import "scripts/game/gameplay/entity.asm"
#import "scripts/game/system/sprites.asm"
#import "scripts/game/system/lives.asm"
#import "scripts/game/system/sound.asm"
#import "scripts/game/system/score.asm"
#import "scripts/data/sprite_data.asm"
#import "scripts/data/mask.asm"

#import "scripts/game/system/disk.asm"


.print "bytes free: " + (($3000 - *))

#import "scripts/data/map/map.asm"



//.disk [filename="GreenBeret.d64", name="GreenBeret", id="2025!" ] 
//{
       // [name="MAIN", type="prg",   segments="Main"                        ],
       // [name="LEVEL1", type="prg",  segments="Map" ],
      
//} 
       

