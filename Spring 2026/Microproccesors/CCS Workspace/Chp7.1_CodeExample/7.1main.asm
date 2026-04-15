;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
main:
			mov.w	#371, R4				; copy following values to registers R4-R5
			mov.w	#465, R5
			add.w	R4, R5					; Add the values held in R4 and R5

			mov.w	#0FFFEh, R6				; copy value to register R6
			add.w	#1h, R6					; add value to value held in register R6

			mov.w	#0FFFFh, R7				; copy value to register R7
			add.w	#1h, R7					; add #1h to value in R7

			mov.b	#255, R8				; copy following values to R8-R9
			mov.b	#1, R9
			add.b	R8, R9					; adds the values held in R8-R9

			mov.b	#-1, R10				; copy value to R10
			add.b	#1, R10					; add #1 to value in R10

			mov.b	#127, R11				; copy to R11
			add.b 	#127, R11				; add #127 to value in R11

			jmp 	main
                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
