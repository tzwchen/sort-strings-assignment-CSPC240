#!/bin/bash

# Compile assembly files
nasm -f elf64 -o start.o start.asm
nasm -f elf64 -o get_strings.o get_strings.asm
nasm -f elf64 -o getline.o getline.asm
nasm -f elf64 -o sort.o sort_strings.asm
nasm -f elf64 -o show_strings.o show_strings.asm

# Link everything (without C runtime, using ld directly)
ld -m elf_x86_64 -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o sort_strings \
    /usr/lib/x86_64-linux-gnu/crt1.o \
    /usr/lib/x86_64-linux-gnu/crti.o \
    /usr/lib/gcc/x86_64-linux-gnu/13/crtbegin.o \
    -L/usr/lib/gcc/x86_64-linux-gnu/13 \
    -L/usr/lib/x86_64-linux-gnu \
    -L/lib/x86_64-linux-gnu \
    -L/lib64 \
    start.o get_strings.o getline.o sort.o show_strings.o \
    -lc -lgcc --as-needed -lgcc_s --no-as-needed -lc -lgcc --as-needed -lgcc_s --no-as-needed \
    /usr/lib/gcc/x86_64-linux-gnu/13/crtend.o \
    /usr/lib/x86_64-linux-gnu/crtn.o

# Run the program
./sort_strings
