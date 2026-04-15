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
			mov.w	#00000000b, R4			; initialize R4

			bis.b	#10000001b, R4			; use bit set to alter R4 in this pattern: 10000001b
			bis.b	#01000010b, R4			; 11000011b
			bis.b	#00100100b, R4			; 11100111b
			bis.b	#00011000b, R4			; 11111111b

			bic.b	#00011000b, R4			; use bit clear to alter R4 in this pattern: 11100111b
			bic.b 	#00100100b, R4			; 11000011b
			bic.b	#01000010b, R4			; 10000001b
            bic.b	#10000001b, R4			; 00000000b

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
            
