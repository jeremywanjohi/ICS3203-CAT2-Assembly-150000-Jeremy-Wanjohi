section .data
    prompt db "Enter a number:(0-9) ", 0
    positiveMsg db 'POSITIVE', 10
    negativeMsg db 'NEGATIVE', 10
    zeroMsg db 'ZERO', 10


section .bss
    numInput resb 1


section .text
    global _start

_start:
    ; write prompt to stdout
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, 21
    syscall

    ; read number from stdin
    mov rax, 0
    mov rdi, 0
    mov rsi, numInput
    mov rdx, 1
    syscall

    ;check if the number is negative
    mov al,[numInput]
    cmp al, '-'
    je is_negative

    ; convert number to integer
    mov al,[numInput]
    sub al, '0'
    cmp al, 0
    je  is_zero
    ; check if number is positive, negative or zero
    mov rsi, positiveMsg
    mov rdx, 9
    jmp display_msg

    

is_negative:
    ; write negative message to stdout
    mov rsi,negativeMsg
    mov rdx, 8
    jmp display_msg

is_positive:
    ; write negative message to stdout
    mov rsi,positiveMsg
    mov rdx, 8
    jmp display_msg

is_zero:
    mov rsi, zeroMsg     
    mov rdx, 8

display_msg:
    mov rax, 1
    mov rdi, 1
    syscall

    ; exit program
    mov rax, 60
    xor rdi, rdi
    syscall
