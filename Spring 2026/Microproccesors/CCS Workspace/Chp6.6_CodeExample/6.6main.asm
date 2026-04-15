;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 6.1, 01/26/2026
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

; Indirect AutoIncrement Mode Addressing - Example 6.6
main:
			mov.w	#Block1, R4				; put the value 200h into R6 to be used as address

			mov.w	@R4+, R5				; copy the data at addr held in r4 into R5-R7, then R4+1-->R4
			mov.w	@R4+, R6
			mov.w	@R4+, R7

			mov.b	@R4+, R8				; copy the data at addr held in R4 into R8-R10, then R4+1-->R4
			mov.b	@R4+, R9
			mov.b	@R4+, R10

			jmp		main

;-------------------------------------------------------------------------------
; Memory Alocation
;-------------------------------------------------------------------------------

			.data
			.retain

Block1: 	.short	1122h, 3344h, 5566h, 7788h, 99AAh

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
            
