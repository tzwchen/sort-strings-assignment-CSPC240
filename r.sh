#!/bin/bash

# Compile assembly files
nasm -f elf64 -o start.o start.asm
nasm -f elf64 -o get_strings.o get_strings.asm
nasm -f elf64 -o getline.o getline.asm
nasm -f elf64 -o sort.o sort.asm

# Compile C++ file
g++ -m64 -c -o show_strings.o sort.cpp

# Link everything
g++ -m64 -o sort_strings start.o get_strings.o getline.o show_strings.o sort.o -fno-pie -no-pie

# Run the program
./sort_strings
