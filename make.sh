


disk=truea

# check if variable equals "true"
if [ "$disk" = "true" ]; then
    echo "Making files for disk..."
  java -cp /Applications/KickAssembler/KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l1.asm -odir "../../../bin"
  #  ./Assets/exomizer sfx '$3000' bin/level_2.prg -o bin/l2.prg -x "inc \$ff19"

     java -cp /Applications/KickAssembler/KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l2.asm -odir "../../../bin" -noexport
   # ./Assets/exomizer sfx '$3000' bin/level_3.prg -o bin/l3.prg -x "inc \$ff19"

     java -cp /Applications/KickAssembler/KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l3.asm -odir "../../../bin" -noexport
  #  ./Assets/exomizer sfx '$3000' bin/level_4.prg -o bin/l4.prg -x "inc \$ff19"

     java -cp /Applications/KickAssembler/KickAss.jar cml.kickass.KickAssembler Scripts/data/map/l4.asm -odir "../../../bin" -noexport
else
    echo "Skipping disk files"
fi




java -cp /Applications/KickAssembler/KickAss.jar cml.kickass.KickAssembler main.asm -vicesymbols -odir "./bin"
pkill -f xplus4 || false
./Assets/exomizer sfx sys -t 16 -x "inc \$ff19" bin/main.prg -o bin/gb.prg 



if [ "$disk" = "true" ]; then

  java -cp /Applications/KickAssembler/KickAss.jar cml.kickass.KickAssembler Scripts/game/system/create_disk.asm -odir "../../../bin" 
 /Applications/vice/bin/xplus4 -autostart ./bin/gb.d64 -moncommands ./bin/main.vs
else 

/Applications/vice/bin/xplus4 -moncommands ./bin/main.vs -silent -8 ./Assets/disk.d64 bin/gb.prg


fi



