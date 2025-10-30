#import "scripts/data/labels.asm"

.namespace MAP {


	  * = $3000 "Level 3 Map Data" 
	
	//* = * "Sector 1"

 	

	NumSectors2:		.byte 22
	Luminances2:		.byte LUMINANCE_7 - 1, LUMINANCE_6 - 1, LUMINANCE_5 - 1, LUMINANCE_5 - 1, LUMINANCE_4 - 1, LUMINANCE_4 - 1
 						.byte LUMINANCE_4 - 1, LUMINANCE_2 - 1, LUMINANCE_3, LUMINANCE_4, LUMINANCE_4, LUMINANCE_4


	LeftLadders2:		.byte 6
	RightLadders2:		.byte 8 + 1
	SectorIDs2:		.byte 0, 1, 1, 1, 1, 1, 1, 2, 3, 4, 3, 4, 4, 4, 3, 5, 5, 6, 6, 6, 6, 6, 7



	//* = * "Sector 1 Data"

	SectorData:		.byte 10, RED + 8, <Sector1 - ($3000 - MapAddress), >Sector1- ($3000 - MapAddress)
					.byte 32, RED + 8, <Sector2 - ($3000 - MapAddress), >Sector2- ($3000 - MapAddress)
					.byte 8,  RED + 8, <Sector3- ($3000 - MapAddress), >Sector3- ($3000 - MapAddress)
					.byte 16, RED + 8, <Sector4- ($3000 - MapAddress), >Sector4- ($3000 - MapAddress)
					.byte 16, RED + 8, <Sector5- ($3000 - MapAddress), >Sector5- ($3000 - MapAddress)
					.byte 16, WHITE + 8, <Sector6- ($3000 - MapAddress), >Sector6- ($3000 - MapAddress)
					.byte 16, RED + 8, <Sector7- ($3000 - MapAddress), >Sector7- ($3000 - MapAddress)
					.byte 48, RED + 8, <Sector8- ($3000 - MapAddress), >Sector8- ($3000 - MapAddress)
					.byte 0

	
	//* = * "Map Data 1"

	SectorMapData:	

		Sector1:	.import binary "assets/Level 3/level_3_sector_1.bin"   
		Sector2:	.import binary "assets/Level 3/level_3_sector_2.bin"   
		Sector3:	.import binary "assets/Level 3/level_3_sector_3.bin"   
		Sector4:	.import binary "assets/Level 3/level_3_sector_4.bin"   
		Sector5:	.import binary "assets/Level 3/level_3_sector_5.bin"   
		Sector6:	.import binary "assets/Level 3/level_3_sector_6.bin"   
		Sector7:	.import binary "assets/Level 3/level_3_sector_7.bin"
		Sector8:	.import binary "assets/Level 3/level_3_sector_8.bin"

	EndLevel:

	.print ("LEVEL 3....." + (EndLevel - NumSectors2))

		* = CHARSET_ADDRESS "Charset Game" 
	Charset:

	.import binary "assets/Level 3/chars.bin" 







}