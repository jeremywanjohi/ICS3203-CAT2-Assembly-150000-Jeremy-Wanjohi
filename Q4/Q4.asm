section .data
    HIGH_THRESHOLD  db 80        ; High water level threshold
    MOD_THRESHOLD   db 50        ; Moderate water level threshold

section .bss
    SENSOR_PORT     resb 1       ; Simulated sensor port
    MOTOR_PORT      resb 1       ; Simulated motor port
    ALARM_PORT      resb 1       ; Simulated alarm port


section .text
    global _start

_start:
    call control_program

    ; Exit the program
    mov eax, 1                 
    xor ebx, ebx               
    int 0x80                    


control_program:
    mov al, [SENSOR_PORT]       ; Simulate reading from the sensor port

    cmp al, [HIGH_THRESHOLD]
    jae HIGH_LEVEL              ; If sensor >= HIGH_THRESHOLD, jump to HIGH_LEVEL

    cmp al, [MOD_THRESHOLD]
    jae MODERATE_LEVEL          ; If sensor >= MOD_THRESHOLD, jump to MODERATE_LEVEL

LOW_LEVEL:
    ; Sensor < MOD_THRESHOLD: Turn off motor
    call STOP_MOTOR
    ret

HIGH_LEVEL:
    ; Turn on motor and trigger alarm
    call TURN_ON_MOTOR
    call TRIGGER_ALARM
    ret

MODERATE_LEVEL:
    ; Sensor >= MOD_THRESHOLD and < HIGH_THRESHOLD: Stop motor
    call STOP_MOTOR
    ret

; Subroutine: TURN_ON_MOTOR
TURN_ON_MOTOR:
    mov al, [MOTOR_PORT]        
    or al, 0x01                 ; Set bit 0 to turn on motor
    mov [MOTOR_PORT], al        ; Simulate writing back to motor port
    ret

; Subroutine: STOP_MOTOR
STOP_MOTOR:
    mov al, [MOTOR_PORT]        
    and al, 0xFE                ; Clear bit 0 to stop motor
    mov [MOTOR_PORT], al        ; Simulate writing back to motor port
    ret

; Subroutine: TRIGGER_ALARM
TRIGGER_ALARM:
    mov al, [ALARM_PORT]        
    or al, 0x01                 ; Set bit 0 to trigger alarm
    mov [ALARM_PORT], al        ; Simulate writing back to alarm port
    ret


; ===============================================
; Question 4 Notes
; ===============================================

; ### How the Program Determines Actions

; #### Sensor Input Reading:
; The program reads the sensor value from `SENSOR_PORT` using the `in` instruction.
; The value is stored in the `AL` register for processing.

; #### Threshold Comparisons:
; The sensor value in `AL` is compared against two predefined thresholds:

; - **High Threshold (80):**
;   If the sensor value is greater than or equal to 80, the program jumps to the `HIGH_LEVEL` label to execute actions.

; - **Moderate Threshold (50):**
;   If the value is between 50 and 79, the program jumps to the `MODERATE_LEVEL` label.

; - **Low Level (below 50):**
;   If the value is less than 50, the program executes the `LOW_LEVEL` logic.

; ### Actions Based on Sensor Input

; #### High Level (≥ 80):
; - Turn on the motor by setting bit 0 in `MOTOR_PORT`.
; - Trigger the alarm by setting bit 0 in `ALARM_PORT`.

; #### Moderate Level (50-79):
; - Stop the motor by clearing bit 0 in `MOTOR_PORT`.

; #### Low Level (< 50):
; - Turn off the motor by clearing bit 0 in `MOTOR_PORT`.

; ### How Ports Are Manipulated

; The program uses memory-mapped I/O ports to control the motor and alarm.
; Specific bits in the ports are manipulated to reflect their state:

; #### Motor Control (`MOTOR_PORT`):
; - **Turn On the Motor:**
;   - Reads the current motor state using `in`.
;   - Sets bit 0 to `1` using the `or` operation.
;   - Writes the updated state back to `MOTOR_PORT`.

; - **Stop/Turn Off the Motor:**
;   - Reads the current motor state.
;   - Clears bit 0 using the `and` operation with the mask `0xFE`.
;   - Writes the updated state back to `MOTOR_PORT`.

; #### Alarm Control (`ALARM_PORT`):
; - **Trigger the Alarm:**
;   - Reads the current alarm state using `in`.
;   - Sets bit 0 to `1` using the `or` operation.
;   - Writes the updated state back to `ALARM_PORT`.

; ### Conclusion
; The program reads the sensor value from `SENSOR_PORT` and uses conditional jumps to determine the appropriate action based on the thresholds.
; It manipulates specific bits using bitwise operations to control the motor and the alarm, therefore allowing for precise control based on the sensor input.
