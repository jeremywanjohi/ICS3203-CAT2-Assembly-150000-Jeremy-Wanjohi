# Combined Notes for Questions 1, 2, 3 and 4
 
## Question 1 Notes

### Overview

This code prompts the user to input a number and determines whether it is positive, negative, or zero. It utilizes specific jump instructions to control the program flow effectively.

### Jump Instructions and Their Impact

1. **Checking for Negative Numbers:**
   - **Instruction:** The program assesses if the input starts with a `"-"` symbol.
   - **Jump:** If true, it jumps to the `is_negative` function.
   - **Impact:** Ensures negative numbers are processed first, bypassing checks for zero and positive numbers, thereby optimizing the flow.

2. **Checking for Zero:**
   - **Instruction:** The program compares the value of the register `al` with `0`.
   - **Jump:** If equal (`je`), it jumps to the `is_zero` function.
   - **Impact:** Bypasses unnecessary positivity checks, streamlining the decision-making process.

3. **Handling Positive Numbers:**
   - **Jump:** If the number is neither negative nor zero, an unconditional jump (`jmp`) directs the flow to the `display_msg` function.
   - **Impact:** Simplifies the flow by ensuring that once a category is determined, the program proceeds to display the result without evaluating further conditions.

### Technical Advantages

- **Efficiency:** Using jump instructions reduces the number of comparisons the CPU must perform, leading to faster execution.
- **Structured Flow:** Clearly defined jump paths make the program easier to follow and maintain.

### Conclusion

The strategic use of jump instructions (`je` and `jmp`) in this program ensures efficient and organized handling of different input scenarios, optimizing both performance and readability.

---

## Question 2 Notes

### Data Section

- **`prompt`**: Message prompting user input.
- **`input_fmt`**: Format string for `scanf`.
- **`output_fmt`**: Format string for `printf` to display five integers.
- **`array_size`**: Defines the array size as 5.
- **`array`**: Allocates space for 5 integers.

### Text Section

- Declares external functions `printf` and `scanf`.
- Makes the `main` label accessible to the linker.

### Main Function

- Sets the loop counter `ECX` to 0 to start input from the first array element.

#### Input Loop

1. **Compare `ECX`**: Checks if all five elements have been entered.
2. **Read Input**:
   - `LEA`: Calculates the memory address of the array.
   - `PUSH`: Pushes the address of `array[ECX]` and the format string to the stack.
   - `CALL`: Reads integer input from user into the array.
3. **Increment `ECX`**.
4. **Loop**: Continues until `ECX >= array_size`, then jumps to `reverse_array`.

### Array Reversal

- **Indices Initialization**: From beginning to end of array (`EBX` = 0 to `EDX` = 4).

#### Swapping Mechanism

1. **Load Elements**:
   - Loads `array[EBX]` into `ESI`.
   - Loads `array[EDX]` into `EDI`.
2. **Swap Elements**:
   - Stores `EDI` into `array[EBX]`.
   - Stores `ESI` into `array[EDX]`.
3. **Update Indices**:
   - Increments `EBX` by 1.
   - Decrements `EDX` by 1.
4. **Loop**: Stops when `EBX >= EDX`.

### Print Result

- Pushes all 5 array elements to the stack.
- Calls `printf` to display the reversed array.
- Cleans the stack.

### Program Exit

- Sets `EAX` to 0 and exits.

### Challenges with Handling Memory Directly

- **Manual Addressing**: Calculating exact memory addresses requires high precision; incorrect calculations can lead to data corruption.
- **Register Management**: Limited registers must be used efficiently to store temporary values during swaps.
- **Stack Operations**: Properly pushing and popping data for function calls is crucial to maintain stack integrity.
- **Data Size Awareness**: Understanding the size of each data type (e.g., `dword`) is essential for accurate memory allocation and access.

---

## Question 3 Notes

### Register Management

In x86-64, registers are divided into two main categories:

#### 1. Caller-Saved Registers

- **Registers:** `EAX`, `ECX`, `EDX`
- **Note:** These registers are **not preserved** by the callee. If the caller needs their values after a subroutine call, it must save them before invoking the subroutine.

#### 2. Callee-Saved Registers

- **Registers:** `EBX`
- **Note:** These registers must be **preserved** by the callee if they are used within a subroutine.

---

### In This Program

#### Callee-Saved Register: `EBX`

- **Usage:** Used as a counter in the factorial subroutine.

##### How It's Managed:

**Saving `EBX`**

```assembly
push   ebx       ; Save EBX before using it
```
**Restoring `EBX`**
```assembly
pop    ebx       ; Restore EBX after use
ret              ; Return to caller
```
### Stack Usage
A stack is a structure used to store temporary data such as function parameters, return addresses, and saved registers. It follows a Last-In-First-Out (LIFO) approach.

 ##### Pushing to the Stack

 -   Saves the current value of a register by placing it on top of the stack and moving the stack pointer down.

 ##### Popping from the Stack

 -   Retrieves the last value placed on the stack and stores it back into the specified register and increments the stack pointer.

 ### Example in the Factorial Subroutine

 #### Preserving Registers

 Before using a callee-saved register (`EBX`):
```assembly
push   ebx       ; Save EBX before modifying it
```
 After function operations:
```assembly
pop    ebx       ; Restore EBX after use
ret              ; Return to caller
```
### Importance
#### Maintains Stability:
-  By saving and restoring registers, functions do not unintentionally alter important data, keeping the program's state consistent.
#### Supports Modular Code:
-   Using the stack to save registers allows the subroutine to function without affecting other parts of the program.

---

## Question 4 Notes

### How the Program Determines Actions

#### Sensor Input Reading:

The program reads the sensor value from `SENSOR_PORT` using the `in` instruction. The value is stored in the `AL` register for processing.

#### Threshold Comparisons:

The sensor value in `AL` is compared against two predefined thresholds:

-   High Threshold (80):

    If the sensor value is greater than or equal to 80, the program jumps to the `HIGH_LEVEL` label to execute actions.

-   Moderate Threshold (50):

    If the value is between 50 and 79, the program jumps to the `MODERATE_LEVEL` label.

-   Low Level (below 50):

    If the value is less than 50, the program executes the `LOW_LEVEL` logic.

### Actions Based on Sensor Input

#### High Level (≥ 80):

-   Turn on the motor by setting bit 0 in `MOTOR_PORT`.
-   Trigger the alarm by setting bit 0 in `ALARM_PORT`.

#### Moderate Level (50-79):

-   Stop the motor by clearing bit 0 in `MOTOR_PORT`.

#### Low Level (< 50):

-   Turn off the motor by clearing bit 0 in `MOTOR_PORT`.

### How Ports Are Manipulated

The program uses memory-mapped I/O ports to control the motor and alarm. Specific bits in the ports are manipulated to reflect their state:

#### Motor Control (`MOTOR_PORT`):

-   Turn On the Motor:

    -   Reads the current motor state using `in`.
    -   Sets bit 0 to `1` using the `or` operation.
-   Stop/Turn Off the Motor:

    -   Reads the current motor state.
    -   Clears bit 0 using the `and` operation with the mask `0xFE`.
    -   Writes the updated state back to `MOTOR_PORT`.

#### Alarm Control (`ALARM_PORT`):

-   Trigger the Alarm:

    -   Reads the current alarm state using `in`.
    -   Sets bit 0 to `1` using the `or` operation.
    -   Writes the updated state back to `ALARM_PORT`.

### Conclusion

The program reads the sensor value from `SENSOR_PORT` and uses conditional jumps to determine the appropriate action based on the thresholds. It manipulates specific bits using bitwise operations to control the motor and the alarm, therefore allowing for precise control based on the sensor input.

---
