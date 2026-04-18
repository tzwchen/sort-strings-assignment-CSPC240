;****************************************************************************************************************************
; Program name: "Get Strings"
; Purpose: This module gets strings from user input and stores them in an array.
; Copyright (C) 2026 Tristan Chen
; Author information
; Author name: Tristan Chen
; Author email: tchen2006@csu.fullerton.edu
; File information
; File name: get_strings.asm
; Language: X86-64 (64-bit)
; Compile: nasm -f elf64 -o get_strings.o get_strings.asm
;****************************************************************************************************************************

extern getline
extern malloc
extern strcpy
extern strlen

global get_strings

segment .data
    ; No data

segment .bss
    buffer resb 256  ; Temporary buffer for getline

segment .text
get_strings:
    ; rdi = address of string_array (array of qwords)

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

    mov r12, rdi 
    mov r13, 0    

loop:
    ;Call getline
    mov rax, 0
    mov rdi, buffer
    mov rsi, 256
    call getline
    cmp rax, 0
    je done  ;If getline returns 0, EOF

    ;Get length
    mov rdi, buffer
    call strlen
    add rax, 1  ;+1 for null terminator

    ;Allocate memory for the string
    mov rdi, rax
    call malloc
    mov r14, rax  ;r14 = new string pointer

    ;Copy the string
    mov rdi, r14
    mov rsi, buffer
    call strcpy

    ;Remove trailing newline
    mov rdi, r14
    call strlen
    cmp rax, 0
    je no_nl
    dec rax
    cmp byte [r14 + rax], 10  ; LF
    jne no_nl
    mov byte [r14 + rax], 0

no_nl:

    ;Store in array
    mov [r12 + r13*8], r14
    inc r13
    cmp r13, 10
    jl loop

done:
    mov rax, r13  ;return count

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