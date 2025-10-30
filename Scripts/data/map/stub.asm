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

   	Entry: 

   		rts