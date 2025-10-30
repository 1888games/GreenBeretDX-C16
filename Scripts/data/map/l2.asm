#import "scripts/data/labels.asm"

.namespace MAP {

	.label SeaColour = LUMINANCE_0 + BLUE + 8

	 * = $3000 "Level 2 Map Data" 
	
	//* = * "Sector 1"

 	

	NumSectors2:		.byte 23
	Luminances2:		.byte LUMINANCE_6 - 1, LUMINANCE_6 - 1, LUMINANCE_5 -1 , LUMINANCE_5 - 1, LUMINANCE_4 - 1, LUMINANCE_2
 						.byte LUMINANCE_2, LUMINANCE_2, LUMINANCE_3, LUMINANCE_3, LUMINANCE_3, LUMINANCE_3
	LeftLadders2:		.byte 12
	RightLadders2:		.byte 13 + 1
	SectorIDs2:		.byte 0, 1, 2, 1, 2, 1, 2, 1, 2, 1, 3, 3, 4, 6, 3, 4, 6, 3, 2, 1, 3, 3, 3, 5



	SectorData:		.byte 3, SeaColour, <Sector1 - ($3000 - MapAddress), >Sector1- ($3000 - MapAddress)
					.byte 28, SeaColour, <Sector2 - ($3000 - MapAddress), >Sector2- ($3000 - MapAddress)
					.byte 4, SeaColour, <Sector3- ($3000 - MapAddress), >Sector3- ($3000 - MapAddress)
					.byte 16, SeaColour, <Sector4- ($3000 - MapAddress), >Sector4- ($3000 - MapAddress)
					.byte 32, SeaColour, <Sector5- ($3000 - MapAddress), >Sector5- ($3000 - MapAddress)
					.byte 48, SeaColour, <Sector6- ($3000 - MapAddress), >Sector6- ($3000 - MapAddress)
					.byte 16, SeaColour, <Sector7- ($3000 - MapAddress), >Sector7- ($3000 - MapAddress)
					.byte 0




		

	
	//* = * "Map Data 1"

	SectorMapData:	

		Sector1:	.import binary "assets/Level 2/level_2_sector_1.bin"   
		Sector2:	.import binary "assets/Level 2/level_2_sector_2.bin"   
		Sector3:	.import binary "assets/Level 2/level_2_sector_3.bin"   
		Sector4:	.import binary "assets/Level 2/level_2_sector_4.bin"   
		Sector5:	.import binary "assets/Level 2/level_2_sector_5.bin"   
		Sector6:	.import binary "assets/Level 2/level_2_sector_6.bin"   
		Sector7:	.import binary "assets/Level 2/level_2_sector_7.bin"

	EndLevel:

	.print ("LEVEL 2....." + (EndLevel - NumSectors2))

	.print (EndLevel)

		* = CHARSET_ADDRESS "Charset Game" 
	Charset:

	.import binary "assets/Level 2/chars.bin" 





}