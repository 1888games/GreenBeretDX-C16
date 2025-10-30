

#import "scripts/data/labels.asm"

.namespace MAP {

	.label GirderColour = LUMINANCE_0 + RED + 8
	.label ForestColour = LUMINANCE_0 + WHITE + 8
	.label TrucksColour = LUMINANCE_0 + GREEN + 8
	.label MissilesColour = LUMINANCE_0 + WHITE + 8

	* = $3000 "Level 1 Map Data"

	NumSectors2:	.byte 13
	Luminances2:		.byte LUMINANCE_7, LUMINANCE_6, LUMINANCE_6, LUMINANCE_5, LUMINANCE_5, LUMINANCE_4
 						.byte LUMINANCE_3, LUMINANCE_0, LUMINANCE_2, LUMINANCE_5, LUMINANCE_5, LUMINANCE_5
	LeftLadders2:	.byte 15
	RightLadders2:	.byte 17 + 1
	SectorIDs2:		.byte 0, 1, 1, 1, 1, 1, 2, 3, 4, 4, 4, 4, 5, 5


	//* = * "Sector 1 Data"

	SectorData:		.byte 23, GirderColour, <Sector1 - ($3000 - MapAddress), >Sector1- ($3000 - MapAddress)
					.byte 16, GirderColour, <Sector2 - ($3000 - MapAddress), >Sector2- ($3000 - MapAddress)
					.byte 24, GirderColour, <Sector3- ($3000 - MapAddress), >Sector3- ($3000 - MapAddress)
					.byte 32, ForestColour, <Sector4- ($3000 - MapAddress), >Sector4- ($3000 - MapAddress)
					.byte 24, TrucksColour, <Sector5- ($3000 - MapAddress), >Sector5- ($3000 - MapAddress)
					.byte 32, MissilesColour, <Sector6- ($3000 - MapAddress), >Sector6- ($3000 - MapAddress)
					.byte 0

	
	//* = * "Map Data 1"

	SectorMapData:	

		Sector1:	.import binary "assets/Level 1/level_1_sector_1.bin"   
		Sector2:	.import binary "assets/Level 1/level_1_sector_2.bin"   
		Sector3:	.import binary "assets/Level 1/level_1_sector_3.bin"   
		Sector4:	.import binary "assets/Level 1/level_1_sector_4.bin"   
		Sector5:	.import binary "assets/Level 1/level_1_sector_5.bin"   
		Sector6:	.import binary "assets/Level 1/level_1_sector_6.bin"  
	
	EndLevel:

	* = CHARSET_ADDRESS "Charset Game" 
	Charset:

	.import binary "assets/Level 1/chars.bin" 

	

	.print ("LEVEL 1....." + (EndLevel - NumSectors2)) 
}