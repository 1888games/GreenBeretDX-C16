

.namespace MAP {

	* = MAP_ADDRESS virtual


	NumSectors: 	.byte 0
	Luminances:		.fill 12, 0
	LeftLadders:	.byte 0
	RightLadders:	.byte 0
	SectorIDs:		

	.import source "scripts/data/map/l1.asm"

	* = $3FE8 "Bullet Chars"

	.import binary "assets/bullet chars.bin" 

	.print ("CHARSET.....2048")

}