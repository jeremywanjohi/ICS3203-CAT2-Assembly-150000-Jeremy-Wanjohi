section .data
    prompt db "Enter a number: ", 0
    output_format db "%d! = %d", 10, 0
    input_format db "%d", 0

section .bss
    number resd 1
    result resd 1

section .text
    global _start
    extern printf, scanf

_start:
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
    mov eax, [number]

    ; Call factorial subroutine
    call factorial

    ; Print result
    push eax                ; Push factorial result
    push [number]           ; Push the original number
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
    push edx                ; Preserve EDX

    mov ebx, eax            ; Move number to EBX
    mov eax, 1              ; Initialize result to 1
    mov ecx, ebx            ; Set ECX as loop counter

    cmp ebx, 0              ; Handle factorial of 0
    je factorial_end

factorial_loop:
    mul ecx                 ; EAX = EAX * ECX
    loop factorial_loop     ; Decrement ECX and loop if not zero

factorial_end:
    pop edx                 ; Restore EDX
    pop ecx                 ; Restore ECX
    pop ebx                 ; Restore EBX
    ret
