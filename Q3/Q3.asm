section .data
    prompt db "Enter a number: ", 0
    output_format db "%d! = %d", 10, 0
    input_format db "%d", 0

section .bss
    number resd 1

section .text
    global main
    extern printf, scanf

main:
    ; Print prompt
    push prompt
    call printf
    add esp, 4

    ; Read number from user
    push number
    push input_format
    call scanf
    add esp, 8

    ; Load the input number into EAX
    mov eax, dword [number]

    ; Call factorial subroutine
    call factorial

    ; Print result
    push eax                ; Push factorial result
    push dword [number]           ; Push the original number
    push output_format
    call printf
    add esp, 12

    ; Exit program
    mov eax, 1              ; syscall number for exit
    xor ebx, ebx            ; exit code 0
    int 0x80

factorial:
    push ebx                ; Preserve EBX
    push ecx                ; Preserve ECX

    mov ebx, eax            ; Move input number to EBX
    mov eax, 1              ; Initialize result (EAX = 1)

    cmp ebx, 0              ; Handle factorial of 0
    je factorial_end

factorial_loop:
    mul ebx                 ; Multiply EAX by EBX
    dec ebx                 ; Decrement EBX
    jnz factorial_loop      ; Repeat if EBX != 0

factorial_end:
    pop ecx                 ; Restore ECX
    pop ebx                 ; Restore EBX
    ret


; ===============================================
; Question 3 Notes
; ===============================================

; ### Register Management
; In x86-32, registers are divided into two main categories:

; #### 1. Caller-Saved Registers
; - **Registers:** `EAX`, `ECX`, `EDX`
; - **Note:** These registers are **not preserved** by the callee. If the caller needs their values after a subroutine call, it must save them before invoking the subroutine.

; #### 2. Callee-Saved Registers
; - **Registers:** `EBX`
; - **Note:** These registers must be **preserved** by the callee if they are used within a subroutine.

; ### In This Program

; #### Callee-Saved Register: `EBX`
; - **Usage:** Used as a counter in the factorial subroutine.

; ##### How It's Managed:
; **Saving `EBX`**
; ```assembly
; push   ebx       ; Save EBX before using it
; ```

; **Restoring `EBX`**
; ```assembly
; pop    ebx       ; Restore EBX after use
; ret              ; Return to caller
; ```

; ### Stack Usage
; A stack is a structure used to store temporary data such as function parameters, return addresses, and saved registers. It follows a **Last-In-First-Out (LIFO)** approach.

; ##### Pushing to the Stack
; - Saves the current value of a register by placing it on top of the stack and moving the stack pointer down.

; ##### Popping from the Stack
; - Retrieves the last value placed on the stack and stores it back into the specified register, incrementing the stack pointer.

; ### Example in the Factorial Subroutine

; #### Preserving Registers
; **Before using a callee-saved register (`EBX`):**
; ```assembly
; push   ebx       ; Save EBX before modifying it
; ```

; **After function operations:**
; ```assembly
; pop    ebx       ; Restore EBX after use
; ret              ; Return to caller
; ```
