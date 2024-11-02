;* ------------------------------------------------------------------
;* --  _____       ______  _____                                    -
;* -- |_   _|     |  ____|/ ____|                                   -
;* --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
;* --   | | | '_ \|  __|  \___ \   Zurich University of             -
;* --  _| |_| | | | |____ ____) |  Applied Sciences                 -
;* -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
;* ------------------------------------------------------------------
;* --
;* -- Project     : CT1 - Lab 7
;* -- Description : Control structures
;* -- 
;* -- $Id: main.s 3748 2016-10-31 13:26:44Z kesr $
;* ------------------------------------------------------------------


; -------------------------------------------------------------------
; -- Constants
; -------------------------------------------------------------------
    
                AREA myCode, CODE, READONLY
                    
                THUMB
ADDR_LED_15_0           EQU     0x60000100
ADDR_LED_31_16          EQU     0x60000102
ADDR_7_SEG_BIN_DS1_0    EQU     0x60000114
ADDR_DIP_SWITCH_15_0    EQU     0x60000200
ADDR_HEX_SWITCH         EQU     0x60000211

NR_CASES                EQU     0xB

jump_table      ; ordered table containing the labels of all cases
                ; STUDENTS: To be programmed 


                ; END: To be programmed
    

; -------------------------------------------------------------------
; -- Main
; -------------------------------------------------------------------   
                        
main            PROC
                EXPORT main
                
read_dipsw      ; Read operands into R0 and R1 and display on LEDs
                ; STUDENTS: To be programmed

				LDR R7, =ADDR_DIP_SWITCH_15_0
				LDRB R0, [R7, #1]
				LDR R7, =ADDR_LED_15_0
				STRB R0, [R7, #1]
				
				; BCD ones to R2
				LDR R7, =ADDR_DIP_SWITCH_15_0
				LDRB R1, [R7]
				LDR R7, =ADDR_LED_15_0
				STRB R1, [R7]
				
                ; END: To be programmed
                    
read_hexsw      ; Read operation into R2 and display on 7seg.
                ; STUDENTS: To be programmed

				

                ; END: To be programmed
                
case_switch     ; Implement switch statement as shown on lecture slide
                ; STUDENTS: To be programmed


                ; END: To be programmed


; Add the code for the individual cases below
; - operand 1 in R0
; - operand 2 in R1
; - result in R0

case_dark       
                LDR  R0, =0
                B    display_result  

case_add        
                ADDS R0, R0, R1
                B    display_result

; STUDENTS: To be programmed


; END: To be programmed


display_result  ; Display result on LEDs
                ; STUDENTS: To be programmed


                ; END: To be programmed

                B    read_dipsw
                
                ALIGN
                ENDP

; -------------------------------------------------------------------
; -- End of file
; -------------------------------------------------------------------                      
                END

