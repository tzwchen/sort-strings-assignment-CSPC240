;****************************************************************************************************************************
; Program name: "Get Line"
; Purpose: This module gets a line from stdin and stores it in the buffer.
; Copyright (C) 2026 Tristan Chen
; Author information
; Author name: Tristan Chen
; Author email: tchen2006@csu.fullerton.edu
; File information
; File name: getline.asm
; Language: X86-64 (64-bit)
; Compile: nasm -f elf64 -o getline.o getline.asm
;****************************************************************************************************************************

extern fgets
extern stdin

global getline

segment .data
    ; No data

segment .bss
    ; No bss

segment .text
getline:
    ; rdi = buffer, rsi = max_len
    ; Returns 1 if line read, 0 if EOF

    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15

    ; Call fgets
    mov rdx, [stdin]
    call fgets
    cmp rax, 0
    je eof

    mov rax, 1
    jmp done

eof:
    mov rax, 0

done:
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
    ret