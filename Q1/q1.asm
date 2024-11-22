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
    mov rax, 1; syscall number for write
    mov rdi, 1 ; file descriptor 1 is stdout
    mov rsi, prompt
    mov rdx, 21 ; number of bytes to write
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
; ===============================================
; Question 1 Notes
; ===============================================

; Overview:
; This code prompts the user to input a number and determines whether
; it is positive, negative, or zero. It utilizes specific jump instructions
; to control the program flow effectively.

; ===============================================
; Jump Instructions and Their Impact
; ===============================================

; 1. Checking for Negative Numbers:
; - Instruction: The program assesses if the input starts with a "-" symbol.
; - Jump: If true, it jumps to the is_negative function.
; - Impact: Ensures negative numbers are processed first, bypassing checks
;   for zero and positive numbers, thereby optimizing the flow.

; 2. Checking for Zero:
; - Instruction: The program compares the value of the register AL with 0.
; - Jump: If equal (je), it jumps to the is_zero function.
; - Impact: Bypasses unnecessary positivity checks, streamlining the 
;   decision-making process.

; 3. Handling Positive Numbers:
; - Jump: If the number is neither negative nor zero, an unconditional jump
;   (jmp) directs the flow to the display_msg function.
; - Impact: Simplifies the flow by ensuring that once a category is
;   determined, the program proceeds to display the result without
;   evaluating further conditions.

; ===============================================
; Technical Advantages
; ===============================================

; - Efficiency: Using jump instructions reduces the number of comparisons
;   the CPU must perform, leading to faster execution.

; - Structured Flow: Clearly defined jump paths make the program easier
;   to follow and maintain.

; ===============================================
; Conclusion
; ===============================================

; The strategic use of jump instructions (je and jmp) in this program
; ensures efficient and organized handling of different input scenarios,
; optimizing both performance and readability.
