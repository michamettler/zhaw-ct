; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- main.s
; --
; -- CT1 P06 "ALU und Sprungbefehle" mit MUL
; --
; -- $Id: main.s 4857 2019-09-10 17:30:17Z akdi $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB

; ------------------------------------------------------------------
; -- Address Defines
; ------------------------------------------------------------------

ADDR_LED_7_0            EQU     0x60000100
ADDR_LED_15_8           EQU     0x60000101
ADDR_LED_31_16          EQU     0x60000102
ADDR_DIP_SWITCH_7_0     EQU     0x60000200
ADDR_DIP_SWITCH_15_8    EQU     0x60000201
ADDR_7_SEG_BIN_DS3_0    EQU     0x60000114
ADDR_BUTTONS            EQU     0x60000210

ADDR_LCD_RED            EQU     0x60000340
ADDR_LCD_GREEN          EQU     0x60000342
ADDR_LCD_BLUE           EQU     0x60000344
LCD_BACKLIGHT_FULL      EQU     0xffff
LCD_BACKLIGHT_OFF       EQU     0x0000

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA myCode, CODE, READONLY

        ENTRY

main    PROC
        export main
            
; STUDENTS: To be programmed

		LDR R3,=0xF0
		
		; BCD tens to R1
		LDR R0, =ADDR_DIP_SWITCH_15_8
		LDRB R1, [R0]
		BICS R1, R1, R3
		
		; BCD ones to R2
		LDR R0, =ADDR_DIP_SWITCH_7_0
		LDRB R2, [R0]
		BICS R2, R2, R3
		
		; Write BCD to LED
		LDR R0, =ADDR_LED_7_0
		LSLS R4, R1, #4
		MOVS R5, R2
		ORRS R5, R5, R4
		STR R5, [R0]
		
		; check if T0 is pressed
		LDR		R0,=ADDR_BUTTONS
		LDR		R6,=0x01
		LDRB	R0,[R0]
		TST		R0, R6		; check if t0 is pressed
		BEQ		mult		; true
		B shift				; false
		
		; -- something else is being executed --
		B main
		
shift
		; multiplication with shift
		MOVS R6, R1
		LSLS R6, R6, #3
		ADDS R6, R6, R1
		ADDS R6, R6, R1
		ADDS R6, R6, R2
		; color red
		LDR R7, =ADDR_LCD_RED
		LDR R0, =0x0000
		STRH R0, [R7, #4]
		LDR R0, =0xffff
		STRH R0, [R7, #0]
		B display
		
mult
		; multiplication with multiplication
		MOVS R6, R1
		MOVS R0, #10
		MULS R6, R0, R6
		ADDS R6, R6, R2
		; color red
		LDR R7, =ADDR_LCD_RED
		LDR R0, =0x0000
		STRH R0, [R7, #0]
		LDR R0, =0xffff
		STRH R0, [R7, #4]
		B display

display
		;write binary to LED
		LDR R0, =ADDR_LED_15_8
		STRB R6, [R0]
		
		; write result to 7 segment
		LDR  R0, =ADDR_7_SEG_BIN_DS3_0
		STRB R6, [R0, #1]  
		STRB R5, [R0, #0]
		B main

; END: To be programmed

        B       main
        ENDP
            
;----------------------------------------------------
; Subroutines
;----------------------------------------------------

;----------------------------------------------------
; pause for disco_lights
pause           PROC
        PUSH    {R0, R1}
        LDR     R1, =1
        LDR     R0, =0x000FFFFF
        
loop        
        SUBS    R0, R0, R1
        BCS     loop
    
        POP     {R0, R1}
        BX      LR
        ALIGN
        ENDP

; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        END
