section .data
    prompt db "Enter an integer: ", 0;prompt string
    input_forms db "%d", 0 ;scanf format string
    ouuput_format db "Reversed Array %d %d %d %d %d", 0 ;printf format string
    array_size equ 5 ;array size
    array db 0, 0, 0, 0, 0 ;array

section .text
    global _main
    extern printf, scanf

_main:
    ;initialize loop counter for input(ECX =0 to 4)
    mov ecx, 0

input_loop:
    cmp ecx, array_size ;compare loop counter with array size   
    jge reverse_array ;if loop counter >= array size, jump to reverse_array

    ;print prompt
    push prompt
    call printf;print prompt
    add esp, 4;clean up stack

    ;read integer from user
    lea eax, [array + ecx*4];load address of array[ecx] into eax
    push eax;push address of array[ecx]
    push input_format;push scanf format string
    call scanf;read integer from user
    add esp, 8;clean up stack

    inc ecx;increment loop counter
    jmp input_loop;repeat input_loop

reverse_array:
    ;initialize indices for swapping (ECX = 0, EDX = 4)
    mov ecx, 0;initialize index i
    mov edx, array_size - 1;initialize index j

reverse_loop:
    cmp ebx,edx; compare start index with end index
    jge print_result ;if start index >= end index, jump to print_result

    mov esi , [array + ebx*4];load array[Start] into esi
    mov edi , [array + edx*4];load array[End] into edi
    mov [array + ebx*4], edi;store array[End] into array[Start]
    mov[array + edx*4], esi;store array[Start] into array[End]

    inc ebx;increment start index
    dec edx;decrement end index
    jmp reverse_loop;repeat reverse_loop


print_result:
    ;push array elements in reverse order
    push dword [array]
    push dword [array + 4]
    push dword [array + 8]
    push dword [array + 12]
    push dword [array + 16]
    push ouput_format;push printf format string
    call printf;print reversed array
    add esp, 24;clean up stack

    ;exit program
    mov eax, 0;return 0
    ret