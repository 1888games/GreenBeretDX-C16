


INPUT: {

	* = * "Input"

	Input:

	.label joyUpMask =  %00000001
	.label joyDownMask = %00000010
	.label joyLeftMask = %00000100
	.label joyRightMask = %00001000
	.label joyFireMask = %01000000

	.label joyUpDownOff = %00000011

	.label JOY_UP =  %11111110
	.label JOY_DOWN = %11111101
	.label JOY_LEFT = %11111011
	.label JOY_RIGHT = %11110111
	.label JOY_FIRE = %10111111

	ReadJoystick: {
		
		lda #$FE
		sta $fd30
		lda #%00000010
		sta $ff08
		lda $ff08
		sta ZP.JOY_READING


		rts


	}

    InputEnd:
	.print ("INPUT......." + (InputEnd - Input))
	

}



