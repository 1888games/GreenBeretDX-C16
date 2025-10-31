@echo off
setlocal

set "disk=true"

if /i "%disk%"=="true" (
    
    java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l1.asm -odir "../../../bin"
    rem assets\exomizer sfx $3000 -Di_load_addr $3E00 bin/level_1.prg -o bin/l1.prg -x "inc \$ff19"

    java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l2.asm -odir "../../../bin"
    rem assets\exomizer sfx $3000 -Di_load_addr $3E00 bin/level_2.prg -o bin/l2.prg -x "inc \$ff19"

    java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l3.asm -odir "../../../bin"
    rem assets\exomizer sfx $3000 -Di_load_addr $3E00 bin/level_3.prg -o bin/l3.prg -x "inc \$ff19"

    java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l4.asm -odir "../../../bin"
   rem assets\exomizer sfx $3000 -Di_load_addr $3E00 bin/level_4.prg -o bin/l4.prg -x "inc \$ff19"

   java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler Scripts/data/map/stub.asm -odir "../../../bin"

   
)


rem Kick assembling
java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler main.asm -vicesymbols -odir bin

rem Launch vice
taskkill /im "xplus4w.exe"
taskkill /im "xplus4.exe"

rem Compress to allow

assets\exomizer sfx sys -t 4 -x "inc $ff19" bin/main.prg -o ./bin/gb.prg >nul 2>&1

if /i "%disk%"=="true" (
       echo "Putting files on disk..."
      java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler Scripts/game/system/create_disk.asm -odir "../../../bin" 
       start "" C:\C64\Tools\Vice\xplus4w.exe -autostart ./bin/gb.d64 -moncommands bin/main.vs
) else (

  echo "Starting VICE from prg..."
 start "" C:\C64\Tools\Vice\xplus4w.exe -moncommands bin/main.vs bin/gb.prg
  rem start "" C:\C64\Tools\Vice\Yape.exe -autostart bin/gb.prg

)



exit /b
