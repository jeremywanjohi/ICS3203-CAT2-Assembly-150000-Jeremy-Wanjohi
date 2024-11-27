# Overview for Tasks 1, 2, 3 and 4

## **Commands for Running Task 1-4**

## **Task 1: Number Sign Detection**
1. **Assemble the `.asm` file into an object file:**
   ```bash
   nasm -f elf32 -o Q1.o Q1.asm
   ```
2.**Link the object file to create an executable:**
   ```bash
   ld -m elf_i386 Q1.o -o Q1
   ```

3.**Run The Program**
   ```bash
   ./Q1
   ```
   
## **Task 2: Array Reversal**
1. **Assemble the `.asm` file into an object file:**
   ```bash
   nasm -f elf32 -o Q2.o Q2.asm
   ```
2.**Link the object file to create an executable:**
   ```bash
   gcc -m32 -no-pie Q2.o -o Q2
   ```
3.**Run The Program**
   ```bash
   /./Q2
   ```

## **Task 3: Factorial Calculation**
1. **Assemble the `.asm` file into an object file:**
   ```bash
   nasm -f elf32 -o Q3.o Q3.asm
   ```
2.**Link the object file to create an executable:**
   ```bash
   gcc -m32 -no-pie Q3.o -o Q3
   ```

3.**Run The Program**
   ```bash
   ./Q3
   ```

## **Task 4: Sensor-Controlled Motor and Alarm**
1. **Assemble the `.asm` file into an object file:**
   ```bash
   nasm -f elf32 -o Q4.o Q4.asm
   ```
2.**Link the object file to create an executable:**
   ```bash
   ld -m elf_i386 Q4.o -o Q4
   ```

3.**Run The Program**
   ```bash
   ./Q4
   ```

**⚠️ NOTE:**  
**See the `.asm` file for detailed explanations, comments, and implementation details.**


## Task 1 

### Overview

This code prompts the user to input a number and determines whether it is positive, negative, or zero. It utilizes specific jump instructions to control the program flow effectively.

### Insights and Challenges
- **Understanding Jump Logic:** Being able to differentiate between conditional (`je`) and unconditional (`jmp`) jumps was crucial for controlling the program flow effectively.
- **Handling Edge Cases:** Ensuring that zero is correctly identified requires accurate comparison checks.
- **Optimizing Flow:** I designed the jump paths to prioritize negative numbers, which helped in reducing unnecessary checks, enhancing efficiency.



### Conclusion

The strategic use of jump instructions (`je` and `jmp`) in this program ensures efficient and organized handling of different input scenarios, optimizing both performance and readability.

---

## Task 2 

### Overview
The aim of this task was to implement an assembly program that accepts an array of five integers from the user, reverses the array in place without using additional memory, and then outputs the reversed array. 


### Insights and Challenges
- **Efficient Looping:** Implementing loops to handle array input and reversal without additional memory was challenging.
- **Memory Management:** Directly manipulating memory addresses required careful calculation to ensure correct mapping of data.
- **Register Utilization:** Limited registers meant I had to efficiently manage register usage, especially during the operation of swapping array values.
- **Stack Integrity:** Ensuring that the stack remains balanced after multiple push and pop operations was critical to prevent any errors during runtime.

---

## Task 3 

### Overview
This Tasks goal was to implement a function based program that calculates the factorial of a user defined number.

### Insights and Challenges
 **A Lot of Functions:** I had to declare numerous functions, which made my code more prone to errors.However, it was necessary to ensure modularity of the code.
- **Introduction to `printf` and `scanf`:** Implementing these two functions was difficult at first, but I eventually got the hang of it and understood their usage.
- **Stack Usage:** I learned how stacks work in assembly language, with the `ESP` register handling stack pointers and that each argument (e.g., `prompt`) once popped, the stack pointer would increment.
- **Preserving Registers:** I learned that by using a stack, you can preserve registers, especially when they are at risk of being interfered with by another function. To implement this, I used `push` instructions to save the state before performing calculations and `pop` instructions to restore the state afterward.

---

## Task 4

### Overview

The program reads the sensor value from `SENSOR_PORT` and uses conditional jumps to determine the appropriate action based on the thresholds. It manipulates specific bits using bitwise operations to control the motor and the alarm, therefore allowing for precise control based on the sensor input.

### Insights and Challenges
- **Memory-Mapped I/O Handling:** Managing and manipulating specific bits within I/O ports required me to have a clear understanding of bitwise operations.
- **Conditional Logic Implementation:** Designing the conditional jumps to accurately reflect the sensor thresholds was important to ensure that the program ran smoothly.
- **Ensuring Port Integrity:** Safely reading from and writing to I/O ports without causing unintended side effects was quite a challenge.
- **Accurate Threshold Markers:** I had to clearly define the boundaries under which it would jump to a specific function (e.g., Turn on Motor).


---
