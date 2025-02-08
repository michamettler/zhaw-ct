; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- table.s
; --
; -- CT1 P04 Ein- und Ausgabe von Tabellenwerten
; --
; -- $Id: table.s 800 2014-10-06 13:19:25Z ruan $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB
; ------------------------------------------------------------------
; -- Symbolic Literals
; ------------------------------------------------------------------
ADDR_DIP_SWITCH_7_0         EQU     0x60000200
ADDR_DIP_SWITCH_15_8        EQU     0x60000201
ADDR_DIP_SWITCH_31_24       EQU     0x60000203
ADDR_LED_7_0                EQU     0x60000100
ADDR_LED_15_8               EQU     0x60000101
ADDR_LED_23_16              EQU     0x60000102
ADDR_LED_31_24              EQU     0x60000103
ADDR_SEG7_BIN   			EQU     0x60000114
ADDR_BUTTONS                EQU     0x60000210

BITMASK_KEY_T0              EQU     0x01
BITMASK_LOWER_NIBBLE        EQU     0x0F

; ------------------------------------------------------------------
; -- Variables
; ------------------------------------------------------------------
        AREA MyAsmVar, DATA, READWRITE
; STUDENTS: To be programmed
		
my_array			SPACE	32

; END: To be programmed
        ALIGN

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA myCode, CODE, READONLY

main    PROC
        EXPORT main

readInput
        BL    waitForKey                    ; wait for key to be pressed and released
; STUDENTS: To be programmed

		; read address of input index value & store it in R1
		LDR R0, =ADDR_DIP_SWITCH_15_8
		LDRB R1, [R0]
		; mask upper four bits
		LDR R7, =BITMASK_LOWER_NIBBLE
		ANDS R1, R1, R7
		; write R1 to display leds
		LDR R0, =ADDR_LED_15_8
		STRB R1, [R0]
		
		; read address of input value & store it in R2
		LDR R0, =ADDR_DIP_SWITCH_7_0
		LDRB R2, [R0]
		; write R2 to display leds
		LDR R0, =ADDR_LED_7_0
		STRB R2, [R0]
		
		; store R2 in array at index 1
		LDR R0, =my_array
		LSLS R1, R1, #1
		STRH R2, [R0, R1]
		
		; read address of index value & store it in R3
		LDR R0, =ADDR_DIP_SWITCH_31_24
		LDRB R3, [R0]
		; mask upper four bits
		LDR R7, =BITMASK_LOWER_NIBBLE
		ANDS R3, R3, R7
		; write R1 to display leds
		LDR R0, =ADDR_LED_31_24
		STRB R3, [R0]
		
		; load content from table
		LDR R0, =my_array
		LSLS R4, R3, #1
		LDRH R6, [R0, R4]
		; write table content to display output value (R4)
		LDR R0, =ADDR_LED_23_16
		STRB R6, [R0]
		
		; write table content to segment display
		LSLS R3, R3, #8   ; Verschiebe den Wert in R3 um 4 Bits nach links
		ORRS R3, R3, R6   ; Führe eine ODER-Operation zwischen R3 und R4 durch
		LDR R0, =ADDR_SEG7_BIN
		STRH R3, [R0, #0] ; Write byte of output value to DS1..0.

		
		
; END: To be programmed
        B       readInput
        ALIGN

; ------------------------------------------------------------------
; Subroutines
; ------------------------------------------------------------------

; wait for key to be pressed and released
waitForKey
        PUSH    {R0, R1, R2}
        LDR     R1, =ADDR_BUTTONS           ; laod base address of keys
        LDR     R2, =BITMASK_KEY_T0         ; load key mask T0

waitForPress
        LDRB    R0, [R1]                    ; load key values
        TST     R0, R2                      ; check, if key T0 is pressed
        BEQ     waitForPress

waitForRelease
        LDRB    R0, [R1]                    ; load key values
        TST     R0, R2                      ; check, if key T0 is released
        BNE     waitForRelease
                
        POP     {R0, R1, R2}
        BX      LR
        ALIGN

; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        ENDP
        END
