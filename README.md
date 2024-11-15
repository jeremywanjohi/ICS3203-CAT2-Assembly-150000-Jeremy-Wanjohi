# Question 1 Notes

## Overview
This code prompts the user to input a number and determines whether it is positive, negative, or zero. It utilizes specific jump instructions to control the program flow effectively.

## Jump Instructions and Their Impact

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

## Technical Advantages
- **Efficiency:** Using jump instructions reduces the number of comparisons the CPU must perform, leading to faster execution.
- **Structured Flow:** Clearly defined jump paths make the program easier to follow and maintain.

## Conclusion
The strategic use of jump instructions (`je` and `jmp`) in this program ensures efficient and organized handling of different input scenarios, optimizing both performance and readability.
