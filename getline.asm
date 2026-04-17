; Professional comments were omitted. Students should keep professional comments here.
; This version of getline does not use any library functions.

%include "safeguard.inc"
global getline
system_read equ 0     ; 0 is the number of the read function provided by the OS
STDIN equ 0
LF equ 10
NULL equ 0

segment .data
    ; Empty

segment .bss
    one resb 1
    name resb 100

segment .text
getline:
    
    BACKUP          ; Removed the colon here. Semicolons are for comments.

    ; Save the passed in parameters in safe registers
    mov rbx, rdi    ; rbx is the address of the start of the destination string
    mov r15, rsi
    sub r15, 2      ; Added a semicolon before this comment

    ; Set up a counter of incoming bytes
    xor r12, r12

begin_loop:
    ; Block that inputs a single char
    mov rax, system_read
    mov rdi, STDIN
    lea rsi, [one]  ; Copy address of one to rsi
    mov rdx, 1      ; Corrected: Use rdx for the count of bytes to read
    syscall
    ; End of block

    ; Block that copies the inputted byte into the destination array if space is available
    mov al, [one]
    cmp al, LF
    je  readdone
    
    inc r12
    cmp r12, r15
    jge begin_loop  ; If no space, just keep reading until LF is found
    
    mov byte [rbx], al
    inc rbx
    jmp begin_loop

readdone:
    mov byte [rbx], NULL ; Null terminate the string
    
    RESTORE
    ; rax is already set by the caller or can be set to the start of the buffer if needed
    ret