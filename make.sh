#!/bin/bash

# define an abort function to call on error
abort_build()
{
    echo
    echo BUILD FAILED
    exit 1
}

# create obj and bin folders if non exiting, since
# the development tools will not create them themselves
#mkdir -p obj
#mkdir -p bin

echo
echo Compile the C code
echo --------------------------
compile freecell.c -o freecell.asm || abort_build

echo
echo Assemble the ASM code
echo --------------------------
assemble freecell.asm -o freecell.vbin || abort_build


echo
echo Convert the PNG textures
echo --------------------------
png2vircon 52CardsV2.png -o 52CardsV2.vtex || abort_build


echo
echo Pack the ROM
echo --------------------------
packrom freecell.xml -o freecell.v32 || abort_build

echo
echo BUILD SUCCESSFUL
