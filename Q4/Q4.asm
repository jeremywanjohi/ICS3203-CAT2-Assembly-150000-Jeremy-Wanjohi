section .data
    SENSOR_PORT     equ 0x1000      ; Address of sensor input port
    MOTOR_PORT      equ 0x2000      ; Address of motor control port
    ALARM_PORT      equ 0x3000      ; Address of alarm control port

    HIGH_THRESHOLD  db 80           ; High water level threshold
    MOD_THRESHOLD   db 50           ; Moderate water level threshold

section .text
    global _start

_start:
    ; Call the control subroutine
    call control_program

    ; Exit the program
    mov eax, 1                  ; syscall number for exit
    xor ebx, ebx                ; exit code 0
    int 0x80                    ; make syscall

; Subroutine: control_program
; Reads sensor value and performs control actions
control_program:
    mov dx, SENSOR_PORT         ; Load sensor port address into DX
    in al, dx                   ; Read byte from port into AL

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
; Sets bit 0 of MOTOR_PORT to turn on the motor
TURN_ON_MOTOR:
    mov dx, MOTOR_PORT
    in al, dx                   ; Read current motor state
    or al, 0x01                 ; Set bit 0 to turn on motor
    out dx, al                  ; Write back to motor port
    ret

; Subroutine: STOP_MOTOR
; Clears bit 0 of MOTOR_PORT to stop the motor
STOP_MOTOR:
    mov dx, MOTOR_PORT
    in al, dx                   ; Read current motor state
    and al, 0xFE                ; Clear bit 0 to stop motor
    out dx, al                  ; Write back to motor port
    ret

; Subroutine: TRIGGER_ALARM
; Sets bit 0 of ALARM_PORT to trigger the alarm
TRIGGER_ALARM:
    mov dx, ALARM_PORT
    in al, dx                   ; Read current alarm state
    or al, 0x01                 ; Set bit 0 to trigger alarm
    out dx, al                  ; Write back to alarm port
    ret
