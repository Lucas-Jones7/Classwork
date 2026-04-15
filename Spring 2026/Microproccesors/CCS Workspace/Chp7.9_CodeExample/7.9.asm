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
			mov.b	#00000001b, R4			; move value to R4
			clrc							; clrc clears the Carry Flag so we have a known starting point for these examples
			rla.b 	R4						; 00000010 Rotate left Arithmetically
			rla.b 	R4						; 00000100
			rla.b 	R4						; 00001000
			rla.b 	R4						; 00010000
			rla.b 	R4						; 00100000
			rla.b 	R4						; 01000000
			rla.b 	R4						; 10000000
			rla.b 	R4						; 00000000
			rla.b 	R4						; 00000000

			mov.b	#10000000b, R5
			clrc
			rra.b	R5						; 11000000 Rotate Right Arithmetically
			rra.b	R5						; 11100000
			rra.b	R5						; 11110000
			rra.b	R5						; 11111000
			rra.b	R5						; 11111100
			rra.b	R5						; 11111110
			rra.b	R5						; 11111111
			rra.b	R5						; 11111111

            jmp		main

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
            
