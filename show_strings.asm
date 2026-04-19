;****************************************************************************************************************************
; Program name: "Show Strings"
; Purpose: This module displays all strings in the array.
; Copyright (C) 2026 Tristan Chen
; Author information
; Author name: Tristan Chen
; Author email: tchen2006@csu.fullerton.edu
; File information
; File name: show_strings.asm
; Language: X86-64 (64-bit)
; Compile: nasm -f elf64 -o show_strings.o show_strings.asm
;****************************************************************************************************************************

extern printf

global show_strings

segment .data
    newline db "%s", 10, 0

segment .text
show_strings:
    ; rdi = arr (array of pointers to strings)
    ; rsi = count (number of strings)

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

    mov r12, rdi  ; r12 = array
    mov r13, rsi  ; r13 = count
    mov r14, 0    ; r14 = index

loop:
    cmp r14, r13
    jge done

    ; Get string from array
    mov rax, [r12 + r14*8]  ; rax = string pointer

    ; Print it
    mov rdi, newline
    mov rsi, rax
    mov rax, 0
    call printf

    inc r14
    jmp loop

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
