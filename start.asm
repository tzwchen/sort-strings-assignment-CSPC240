;****************************************************************************************************************************
; Program name: "String Sorting"
; Purpose: This is the driver module for sorting strings.
; Copyright (C) 2026 Tristan Chen
; Author information
; Author name: Tristan Chen
; Author email: tchen2006@csu.fullerton.edu
; File information
; File name: start.asm
; Language: X86-64 (64-bit)
; Compile: nasm -f elf64 -o start.o start.asm
; Link: g++ -m64 -o sort_strings start.o get_strings.o getline.o show_strings.o sort.o -fno-pie -no-pie
;****************************************************************************************************************************

extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern get_strings
extern show_strings
extern sort_strings

global _start

segment .data
    welcome db "Welcome to String Sorting by Tristan Chen", 10, 0
    name_prompt db "Please enter your name: ", 0
    enjoy db "We hope you enjoy using our software %s.", 10, 0
    input_prompt db "Please enter string data. After the last input press enter and control+D", 10, 0
    thank_you db "Thank you for your input.", 10, 0
    count_msg db "There are %ld strings are now stored in the array.", 10, 0
    before_sort db "Here are the data in the array", 10, 0
    after_sort db "The array has been sorted. Here are the sorted data.", 10, 0
    goodbye db "The program will end now. Good-bye %s.", 10, 0
    zero_msg db "A zero will be sent to the operating system. Bye", 10, 0

segment .bss
    name resb 256
    string_array resq 10  ; Array of 10 pointers to strings

segment .text
_start:
    ; Backup registers
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

    ;Display welcome message
    mov rax, 0
    mov rdi, welcome
    call printf

    ;Prompt for name
    mov rax, 0
    mov rdi, name_prompt
    call printf

    ; Read name
    mov rax, 0
    mov rdi, name
    mov rsi, 256
    mov rdx, [stdin]  ;stdin extern
    call fgets

    ;Remove newline
    mov rdi, name
    call strlen
    cmp rax, 0
    je skip
    dec rax
    mov byte [name + rax], 0

skip:

    ;Display enjoy message
    mov rax, 0
    mov rdi, enjoy
    mov rsi, name
    call printf

    ;Display input prompt
    mov rax, 0
    mov rdi, input_prompt
    call printf

    ;Call get_strings
    mov rax, 0
    mov rdi, string_array
    call get_strings
    mov r12, rax 

    ;Display thank you
    mov rax, 0
    mov rdi, thank_you
    call printf

    ;Display count
    mov rax, 0
    mov rdi, count_msg
    mov rsi, r12
    call printf

    ;Display before sort
    mov rax, 0
    mov rdi, before_sort
    call printf

    ;Call show_strings
    mov rax, 0
    mov rdi, string_array
    mov rsi, r12
    call show_strings

    ;Call sort_strings
    mov rax, 0
    mov rdi, string_array
    mov rsi, r12
    call sort_strings

    ;Display after sort
    mov rax, 0
    mov rdi, after_sort
    call printf

    ;Call show_strings again
    mov rax, 0
    mov rdi, string_array
    mov rsi, r12
    call show_strings

    ;Display goodbye
    mov rax, 0
    mov rdi, goodbye
    mov rsi, name
    call printf

    ;Display zero message
    mov rax, 0
    mov rdi, zero_msg
    call printf

    ;Restore registers
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

    ;Exit with 0
    mov rax, 60
    mov rdi, 0
    syscall