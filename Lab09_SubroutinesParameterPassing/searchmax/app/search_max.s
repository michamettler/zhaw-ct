;* ------------------------------------------------------------------
;* --  _____       ______  _____                                    -
;* -- |_   _|     |  ____|/ ____|                                   -
;* --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
;* --   | | | '_ \|  __|  \___ \   Zurich University of             -
;* --  _| |_| | | | |____ ____) |  Applied Sciences                 -
;* -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
;* ------------------------------------------------------------------
;* --
;* -- Project     : CT1 - Lab 10
;* -- Description : Search Max
;* -- 
;* -- $Id: search_max.s 879 2014-10-24 09:00:00Z muln $
;* ------------------------------------------------------------------


; -------------------------------------------------------------------
; -- Constants
; -------------------------------------------------------------------
                AREA myCode, CODE, READONLY
                THUMB
                    
; STUDENTS: To be programmed




; END: To be programmed
; -------------------------------------------------------------------                    
; Searchmax
; - tableaddress in R0
; - table length in R1
; - result returned in R0
; -------------------------------------------------------------------   
search_max      PROC
                EXPORT search_max

                ; STUDENTS: To be programmed
				
				PUSH {R4-R7, LR}
				MOV R4, R0			; R4 table address
				MOV R5, R1			; R5 table length
				
				;setup for max search				
				LDR R0, =0x80000000	; default return
				LDR R1, =0 			; i
				
				CMP	R5, #0			; check if table is empty
				BNE search
				BEQ end

search
				LSLS R3, R1, #2		; index increase: i * 4 = R3
				LDR R2,[R4, R3]		; next value: R2
				
				CMP  R2, R0			; compare max (R0) with next value (R2)				
				BLE	increment		; increment
				MOVS R0, R2			; new

increment
				ADDS R1, #1
				CMP R1, R5			; check if finished
				BLT	search

end
				POP	{R4-R7, PC}


                ; END: To be programmed
                ALIGN
                ENDP
; -------------------------------------------------------------------
; -- End of file
; -------------------------------------------------------------------                      
                END

