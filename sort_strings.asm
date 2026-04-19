;****************************************************************************************************************************
; Program name: "Sort Strings"
; Purpose: This module sorts the array of strings using bubble sort.
; Copyright (C) 2026 Tristan Chen
; Author information
; Author name: Tristan Chen
; Author email: tchen2006@csu.fullerton.edu
; File information
; File name: sort_strings.asm
; Language: X86-64 (64-bit)
; Compile: nasm -f elf64 -o sort.o sort_strings.asm
;****************************************************************************************************************************

global sort_strings

segment .data
  

segment .bss
 

segment .text
sort_strings:
    ;rdi = arr, rsi = count

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
    mov r13, rsi 
    cmp r13, 1
    jle done

    ; Bubble sort
    mov r14, 0  

outer_loop:
    mov r15, 0  
    mov rcx, r13
    sub rcx, r14
    dec rcx  
inner_loop:
    cmp r15, rcx
    jge inner_done

    ;comp arr[j] and arr[j+1]
    mov rdi, [r12 + r15*8]
    mov rsi, [r12 + r15*8 + 8]
    call compare_strings
    ;rax = -1 if rdi < rsi, 0 equal, 1 if rdi > rsi
    cmp rax, 1
    jne no_swap

    mov rdx, [r12 + r15*8]
    mov rbx, [r12 + r15*8 + 8]
    mov [r12 + r15*8], rbx
    mov [r12 + r15*8 + 8], rdx

no_swap:
    inc r15
    jmp inner_loop

inner_done:
    inc r14
    mov rax, r13
    sub rax, 1
    cmp r14, rax
    jl outer_loop

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

compare_strings:
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

loop_cmp:
    mov al, [rdi]
    mov bl, [rsi]
    cmp al, bl
    jl less
    jg greater
    cmp al, 0
    je equal
    inc rdi
    inc rsi
    jmp loop_cmp

less:
    mov rax, -1
    jmp cmp_done

greater:
    mov rax, 1
    jmp cmp_done

equal:
    mov rax, 0

cmp_done:
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