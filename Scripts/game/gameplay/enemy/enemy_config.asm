.namespace ENEMY {

	.label MN = ENEMY_MINE
	.label CN = ENEMY_CANNON
	.label SF = ENEMY_SUPPLY_FLAME
	.label SR = ENEMY_SUPPLY_ROCKET
	.label SG = ENEMY_SUPPLY_GRENADE


	.label KB = ENEMY_KICKBOXER
	.label CF = ENEMY_CANNON_FODDER
	.label RL = ENEMY_ROCKET_LAUNCHER
	.label CR = ENEMY_CRAWLER
	.label DG = ENEMY_DOG
	.label GR = ENEMY_GRENADIER
	.label FL = ENEMY_FLAME_THROWER

	.label FS = 70
	.label DT = 78
	.label FAST_FLAG = FS
	.label DOG_TRAINER = 78
	.label RT = 128

	EnemySector:	

					// LEVEL ONE

					.byte 00, 03, 04, 07, 07, 07, 08, 255			// level 1  0-7

					.byte 00, FS, FS, 00, FS, 00, FS, FS
					.byte 00, FS, 00, 00, FS, FS, 255    // 8-20 level 1 boss enemy speed

					// LEVEL TWO // 23

					.byte 01, 01, 01, 03, 03, 05, 05, 05
					.byte 05, 07  // 32
					.byte 09, 12, 12, 12, 12, 12, 15, 16, 16, 17, 17, 19, 19, 255  //46

					// LEVEL TWO BOSS  // 47

					.byte 00, FS, 00, 00
					.byte 00, FS, 00, 00
					.byte 00, FS, 00, 00
					.byte 00, FS, 00, 00
					.byte 00, FS, 00, 00
					.byte 00, FS, 00, 00, 255 // 71


					// LEVEL 3   // 72
					
					.byte 01, 01, 01, 01, 01, 02, 02, 03, 03, 03, 04, 04, 04  // 84
					.byte 05, 05, 05, 06, 06  // 89
					.byte 07, 08, 09, 09, 10, 13, 15, 16, 17, 17, 17, 18, 18, 255 // 103

					.byte 00, FS, 00, 00
					.byte 00, 00, 00, FS
					.byte 00, FS, 00, 00
					.byte FS, 00, 00, 00, 255 // 120


					// LEVEL 4

					.byte 00, 00, 01, 01, 01, 02, 02, 03, 04, 04, 05, 05
					.byte 06, 07, 08, 08, 08, 10, 10, 10, 10, 10
					.byte 11, 11, 12, 12, 13, 13, 14, 14, 15, 16, 17

					

					.byte 21, 21, 21, 22, 23, 23, 23, 24, 25, 25
					.byte 25, 26, 27, 27, 28, 28, 29, 30
					

					.byte 255

					.byte 00, 00, 00, FS, 00, 00

					.byte 255




	EnemyOffset:	.byte 07, 01, 09, 04, 08, 12, 05, 255       // level 1 x offset
					.byte 20, 25, 15, 12, 70
					.byte 25, 20, 10, 25, 75
					.byte 15, 30, 25, 20, 255   // level 1 boss timers


					// LEVEL TWO

					.byte 02, 07, 12, 08, 12, 06, 07, 08
					.byte 11, 07
					.byte 04, 00, 04, 08, 20, 28, 08, 08, 12, 00, 05, 11, 15, 255   ////2

					// LEVEL TWO BOSS

					.byte RT + 4, RT + 20, RT + 25, RT + 90
					.byte 4, 25, 20, 90
					
					.byte RT + 4, RT + 20, RT + 25, RT + 90
					.byte 4, 25, 20, 90

					.byte RT + 4, RT + 20, RT + 25, RT + 90
					.byte 4, 25, 20, 90

					.byte 255
					


					// LEVEL THREE


					.byte 02, 03, 25, 27, 31, 12, 21, 02, 21, 28, 10, 17, 21  // 84
					.byte 19, 25, 29, 20, 27  // 89
					.byte 04, 07, 00, 11, 12, 07, 04, 08, 04, 07, 08, 05, 07, 255 // 

					.byte RT + 4, RT + 20, RT + 25, RT + 120
					.byte 4, 25, 20, 120
					
					.byte RT + 4, RT + 20, RT + 25, RT + 120
					.byte 4, 25, 20, 120
					.byte 255

					// LEVEL FOUR


					.byte 00, 02, 03, 04, 08, 00, 03, 08, 03, 04, 00, 03    // 12
					.byte 02, 04, 02, 05, 09, 00, 03, 06, 11, 15  // 10

					.byte 09, 14, 00, 04, 06, 10, 00, 11, 05, 07, 04  // 11


					.byte 07, 13, 15, 05, 01, 05, 15, 12, 01, 04    // 10

					.byte 15, 04, 01, 09, 03, 09, 03, 04   // 08

					.byte 255  // 01

					.byte RT + 90, 80, RT + 100, 95, RT + 80, 100 // 6

					.byte 255 // 1



	EnemyType:		.byte SF + (7 << 4), SF + (1 << 4), CN, MN, MN, MN, SF + (7 << 4), 255  // level 1
					.byte CF, KB, CF, CF, CF, CF, KB, CF, CF, CF, CF, CF, KB, CF, 255   // level 1 boss

					// Level TWO

					
					.byte RL + (13 << 4), MN,  SR + (7 << 4), CR + (13 << 4), RL + (13 << 4), CR + (13 << 4), MN, RL + (1 << 4), MN,  SR + (1 << 4)
					
					.byte RL + (1 << 4), MN, MN, MN, RL + (1 << 4), SR + (1 << 4), RL + (13 << 4), MN, MN, MN, CN
					.byte CR + (13 << 4), CR + (13 << 4), 255  // level 2	

					// LEVEL TWO BOSS

					.byte DG, CF, DG, DG
					.byte DG, CF, DG, DG
					.byte DG, CF, DG, DG
					.byte DG, CF, DG, DG
					.byte DG, CF, DG, DG
					.byte DG, CF, DG, DG, 255  

					// LEVEL 3


					.byte CN, SG + (9 << 4), CN, MN, MN, SG + (9 << 4), CR + (13 << 4), CN, CR + (13 << 4), MN, CN, SG + (9<<4), CR + (13 << 4)
					.byte SF + (9<<4), CN, CN, MN, RL + (4 << 4)
					.byte MN, RL + (4 << 4), MN, MN, GR + (4 << 4), MN, MN, RL + (7<<4), CR + (7<<4), CR + (7<<4), MN, SF + (7<<4), MN, 255  // level 3



					.byte GR, CF, CF, CF
					.byte CF, GR, CF, KB
					.byte CF, CF, CF, GR
					.byte CF, KB, CF, GR
					.byte 255  



					.byte RL + (7 << 4), CR + (13 << 4), MN, SG + (1 << 4),  CR + (13 << 4), MN, MN, CR + (13 << 4), SG + (1 << 4), MN, MN, MN  // 12

					.byte CR + (13 << 4), RL + (1 << 4), SG + (7 << 4), RL + (1 << 4), CN, KB, KB, KB, GR + (7 << 4), GR + (7 << 4)  // 10

					.byte RL + (13 << 4),  GR + (7 << 4), GR + (7 << 4), SF + (7 << 4),  GR + (7 << 4), RL + (13 << 4), MN, MN, MN, MN, GR + (7 << 4) // 1


					.byte MN, CN, MN, CN, SF + (13 << 4), CN, MN, MN, CN, MN  // 10


					.byte RL + (8 << 4), SG + (13 << 4), CN, CN, CR + (13 << 4), CN,  CR + (13 << 4), CN  // 08
					//.byte CN, MN, MN

					.byte 255	 // 01	

					.byte FL, FL, FL, FL, FL, FL // 06

					.byte 255		// 01


	//EnemySector:	.byte 01, 07, 07, 255, 06, 255
	//EnemyOffset:	.byte 01, 07, 11, 18, 255
	//EnemyType:		.byte ENEMY_MINE, ENEMY_MINE, ENEMY_MINE, ENEMY_MINE, 255

	SpawnIndexes:	.byte 0, 23, 72, 121



					//.byte 00, 00, 01, 01, 01, 02, 02, 03, 04, 04, 05, 05
					//.byte 06, 07, 08, 08, 08, 10, 10, 10, 10, 10
					//.byte 11, 11, 12, 12, 13, 13, 14, 14, 15, 16, 17

					//.byte 21, 21, 21, 22, 23, 23, 23, 24, 25, 25
					//.byte 25, 26, 27, 27, 28, 28, 29, 30
					

					//.byte 255

					//.byte 00, 00, 00, FS, 00, 00

					//.byte 255
}

					//.byte 00, 02, 03, 04, 08, 00, 03, 08, 03, 04, 00, 03  // 12
					//.byte 02, 04, 02, 05, 09, 00, 03, 06, 11, 15  //  10

					//.byte 09, 14, 00, 04, 06, 10, 00, 11, 05, 07

					//.byte 04  // 153

					//.byte 07, 13, 15, 05, 01, 05, 15, 12, 01, 04




					//.byte 15, 04, 01, 09, 03, 09, 03, 04  // 8

					//.byte 255

					//.byte RT + 90, 80, RT + 100, 95, RT + 80, 100

					//.byte 255
