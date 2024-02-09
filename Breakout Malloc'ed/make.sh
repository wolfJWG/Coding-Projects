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
compile breakout.c -o breakout.asm || abort_build

echo
echo Assemble the ASM code
echo --------------------------
assemble breakout.asm -o breakout.vbin || abort_build


echo
echo Convert the PNG textures
echo --------------------------
png2vircon BreakoutTextures.png -o BreakoutTextures.vtex || abort_build


echo
echo Pack the ROM
echo --------------------------
packrom breakout.xml -o breakout.v32 || abort_build

echo
echo BUILD SUCCESSFUL
