#import "scripts/data/labels.asm"

.namespace MAP {


	 * = $3000 "Level 4 Map Data" 
	
	//* = * "Sector 1"

 	

	NumSectors2:		.byte 35
	Luminances2:		.byte LUMINANCE_7, LUMINANCE_6, LUMINANCE_5, LUMINANCE_5, LUMINANCE_4, LUMINANCE_4
 						.byte LUMINANCE_2, LUMINANCE_2, LUMINANCE_2, LUMINANCE_2, LUMINANCE_2, LUMINANCE_2


	LeftLadders2:		.byte 19
	RightLadders2:		.byte 22 + 1
	SectorIDs2:			.byte 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 4, 4, 3, 3, 3, 3, 5
						.byte 6, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8



	//* = * "Sector 1 Data"

	SectorData:		.byte 7, WHITE + 8, <Sector1 - ($3000 - MapAddress), >Sector1- ($3000 - MapAddress)
					.byte 16, WHITE + 8, <Sector2 - ($3000 - MapAddress), >Sector2- ($3000 - MapAddress)
					.byte 24,  WHITE + 8, <Sector3- ($3000 - MapAddress), >Sector3- ($3000 - MapAddress)
					.byte 16, WHITE + 8, <Sector4- ($3000 - MapAddress), >Sector4- ($3000 - MapAddress)
					.byte 32, WHITE + 8, <Sector5- ($3000 - MapAddress), >Sector5- ($3000 - MapAddress)
					.byte 16, WHITE + 8, <Sector6- ($3000 - MapAddress), >Sector6- ($3000 - MapAddress)
					.byte 16, WHITE + 8, <Sector7- ($3000 - MapAddress), >Sector7- ($3000 - MapAddress)
					.byte 16, RED + 8, <Sector8- ($3000 - MapAddress), >Sector8- ($3000 - MapAddress)
					.byte 16, RED + 8, <Sector9- ($3000 - MapAddress), >Sector9- ($3000 - MapAddress)
					.byte 0
					

	
	//* = * "Map Data 1"

	SectorMapData:	

		Sector1:	.import binary "assets/Level 4/sector_1.bin"   
		Sector2:	.import binary "assets/Level 4/sector_2.bin"   
		Sector3:	.import binary "assets/Level 4/sector_3.bin"   
		Sector4:	.import binary "assets/Level 4/sector_4.bin"   
		Sector5:	.import binary "assets/Level 4/sector_5.bin"   
		Sector6:	.import binary "assets/Level 4/sector_6.bin"   
		Sector7:	.import binary "assets/Level 4/sector_7.bin"
		Sector8:	.import binary "assets/Level 4/sector_8.bin"
		Sector9:	.import binary "assets/Level 4/sector_9.bin"

	EndLevel:

	.print ("LEVEL 4....." + (EndLevel - NumSectors2))

		* = CHARSET_ADDRESS "Charset Game" 
	Charset:

	.import binary "assets/Level 4/chars.bin" 







}