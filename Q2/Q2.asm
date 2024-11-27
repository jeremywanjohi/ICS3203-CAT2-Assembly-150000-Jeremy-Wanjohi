; ===============================================
; Question 2 Notes
; ===============================================

; ### Data Section
; - `prompt`: Message prompting user input.
; - `input_fmt`: Format string for `scanf`.
; - `output_fmt`: Format string for `printf` to display five integers.
; - `array_size`: Defines the array size as 5.
; - `array`: Allocates space for 5 integers.

section .data
    prompt db "Enter an integer: ", 0          ; Prompt string
    input_fmt db "%d", 0                       ; scanf format string
    output_format db "Reversed Array: %d %d %d %d %d", 10, 0 ; printf format string with newline
    array_size equ 5                            ; Array size
    array dd 0, 0, 0, 0, 0                      ; Allocate space for 5 integers

; ===============================================
; ### Text Section
; - Declares external functions `printf` and `scanf`.
; - Makes the `main` label accessible to the linker.
; ===============================================

section .text
    global main
    extern printf, scanf

; ===============================================
; ### Main Function
; - Sets the loop counter `ECX` to 0 to start input from the first array element.
; ===============================================

main:
    ; Initialize loop counter for input (ECX = 0 to 4)
    xor ecx,ecx

; ===============================================
; #### Input Loop
; 1. **Compare `ECX`**: Checks if all five elements have been entered.
; 2. **Read Input**:
;    - `LEA`: Calculates the memory address of the array.
;    - `PUSH`: Pushes the address of `array[ECX]` and the format string to the stack.
;    - `CALL`: Reads integer input from user into the array.
; 3. **Increment `ECX`**.
; 4. **Loop**: Continues until `ECX >= array_size`, then jumps to `reverse_array`.
; ===============================================

input_loop:
    cmp ecx, array_size                        ; Compare loop counter with array size
    jge reverse_array                           ; If ECX >= array_size, jump to reverse_array

    ; Print prompt
    push prompt                                 ; Push address of prompt string
    call printf                                 ; Call printf to display prompt
    add esp, 4
                                      ; Clean up stack (remove prompt address)

    ; Read integer from user
    lea eax, [array + ecx*4]                    ; Load address of array[ECX] into EAX
    push eax                                    ; Push address of array[ECX]
    push input_fmt                              ; Push scanf format string
    call scanf                                  ; Call scanf to read integer
    add esp, 8                                  ; Clean up stack (remove format string and array address)

    inc ecx                                     ; Increment loop counter
    jmp input_loop                              ; Repeat input_loop

; ===============================================
; ### Array Reversal
; - **Indices Initialization**: From beginning to end of array (`EBX` = 0 to `EDX` = 4).
; ===============================================

reverse_array:
    ; Initialize indices for swapping (EBX = 0, EDX = 4)
    mov ebx, 0                                  ; Initialize start index (EBX)
    mov edx, array_size - 1                     ; Initialize end index (EDX)

; ===============================================
; #### Swapping Mechanism
; 1. **Load Elements**:
;    - Loads `array[EBX]` into `ESI`.
;    - Loads `array[EDX]` into `EDI`.
; 2. **Swap Elements**:
;    - Stores `EDI` into `array[EBX]`.
;    - Stores `ESI` into `array[EDX]`.
; 3. **Update Indices**:
;    - Increments `EBX` by 1.
;    - Decrements `EDX` by 1.
; 4. **Loop**: Stops when `EBX >= EDX`.
; ===============================================

reverse_loop:
    cmp ebx, edx                                ; Compare start index with end index
    jge print_result                            ; If EBX >= EDX, jump to print_result

    mov esi, [array + ebx*4]                     ; Load array[EBX] into ESI
    mov edi, [array + edx*4]                     ; Load array[EDX] into EDI
    mov [array + ebx*4], edi                     ; Store EDI into array[EBX]
    mov [array + edx*4], esi                     ; Store ESI into array[EDX]

    inc ebx                                      ; Increment start index
    dec edx                                      ; Decrement end index
    jmp reverse_loop                             ; Repeat reverse_loop

; ===============================================
; ### Print Result
; - Pushes all 5 array elements to the stack.
; - Calls `printf` to display the reversed array.
; - Cleans the stack.
; ===============================================

print_result:
    ; Push array elements in reverse order
    push dword [array]                           ; Push array[0]
    push dword [array + 4]                       ; Push array[1]
    push dword [array + 8]                       ; Push array[2]
    push dword [array + 12]                      ; Push array[3]
    push dword [array + 16]                      ; Push array[4]
    push output_format                           ; Push printf format string
    call printf                                  ; Call printf to display reversed array
    add esp, 24                                  ; Clean up stack (5 integers * 4 bytes + format string)

; ===============================================
; ### Program Exit
; - Sets `EAX` to 0 and exits.
; ===============================================

    mov eax, 0                                   ; Return 0
    ret                                          ; Exit program

section .note.GNU-stack noalloc noexec nowrite progbits

; ===============================================
; ### Challenges with Handling Memory Directly
; - **Manual Addressing**: Calculating exact memory addresses requires high precision; incorrect calculations can lead to data corruption.
; - **Register Management**: Limited registers must be used efficiently to store temporary values during swaps.
; - **Stack Operations**: Properly pushing and popping data for function calls is crucial to maintain stack integrity.
; - **Data Size Awareness**: Understanding the size of each data type (e.g., `dword`) is essential for accurate memory allocation and access.
; ===============================================
