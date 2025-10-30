.namespace DISK {

	*= * "DISK"

	Disk:

	.label SETLFS = $ffba
	.label SETNAM = $ffbd
	.label LOAD   = $ffd5

	.label TAPE   = 1
	.label DISK   = 8

	FNAME:	
	 	.encoding "petscii_upper"
        .text "L2"  

    Routine07D9:	

    	php
    	sei
    	sta $FF3F
    	lda ($AF), y
    	sta $FF3E
    	plp
    	rts

    Vectors:

    	.byte $42, $CE, $0E, $CE, $4C, $F4


	Load: {

		clc
		adc #$31
		sta FNAME + 1 // store requested level number in filename
		sta $FF3E   // turn on kernel ROM



	RestoreKernelValues:

		ldx #5

		Loop2:

			lda Vectors, x
			sta $312, x

			dex
			bpl Loop2	

		inx
		stx $9A

		lda #$10
		sta $08A9

		lda #$3F
		sta $38

		lda #$4A
		sta $032E

		lda #$F0
		sta $032F

		lda #$4B
		sta $0324

		lda #$EC
		sta $0325

		lda #$65
		sta $0326

		lda #$F2
		sta $0327

		//lda #$7A
		//sta $0545

		//lda #$DB
		//sta $0546

		//lda #$40
		//sta $A6
		//sta $94

	
		ldx #11

		Loop:

			lda Routine07D9, x
			sta $07D9, x

			dex
			bpl Loop
		
		.if (format == "disk") {
			ldx #DISK
		
        // You may need to set other TED registers here
		}
	
		
		.if (format == "tape") {

			 //lda #0
    		 //sta $FF81       
             //sta $FF87       
			 ldx #TAPE

		}
		
		lda #1
		ldy #1

		jsr SETLFS

		lda #2         // Filename length
	        ldx #<FNAME     // Filename address low
	        ldy #>FNAME     // Filename address high
	        jsr SETNAM 
			
		lda #0          // 0=load, 1=verify
		//ldx #$00       
        //ldy #$30   


        jsr LOAD

        sta $FF3F    // turn off kernel ROM

         jmp IRQ.SetMainIRQ
     
     
	}


	DiskEnd:
	.print ("DISK........" + (DiskEnd - Disk))


}