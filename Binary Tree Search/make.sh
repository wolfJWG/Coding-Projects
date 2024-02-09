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
compile treeSearch.c -o treeSearch.asm || abort_build

echo
echo Assemble the ASM code
echo --------------------------
assemble treeSearch.asm -o treeSearch.vbin || abort_build

echo
echo Pack the ROM
echo --------------------------
packrom treeSearch.xml -o treeSearch.v32 || abort_build

echo
echo BUILD SUCCESSFUL
