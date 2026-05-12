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

; Indexed Mode Addressing - Example 6.7
main:
			mov.w	#Block1, R4				; put value 200h into R4 to be used as address

			mov.w 	0(R4), 8(R4)			; copy 1st word in Block1 into 1st word of block 2
			mov.w	2(R4), 10(R4)			; 2nd in block1 to 2nd in block 2
			mov.w	4(R4), 12(R4)			; 3rd in block1 to 3rd in block2
			mov.w	6(R4), 14(R4)			; 4th in block1 to 4th in block 2

			jmp		main

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

			.data
			.retain

Block1: 	.short	0AAAAh, 0BBBBh, 0CCCC, 0DDDDh
Block2:		.space	8

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
            
