#!/bin/bash

# Compile assembly files
nasm -f elf64 -o start.o start.asm
nasm -f elf64 -o get_strings.o get_strings.asm
nasm -f elf64 -o getline.o getline.asm
nasm -f elf64 -o sort.o sort_strings.asm
nasm -f elf64 -o show_strings.o show_strings.asm

# Link everything with gcc
g++ -m64 -nostartfiles -no-pie -o sort_strings start.o get_strings.o getline.o sort.o show_strings.o -lc

# Run the program
./sort_strings

rm start.o get_strings.o getline.o sort.o show_strings.o sort_strings