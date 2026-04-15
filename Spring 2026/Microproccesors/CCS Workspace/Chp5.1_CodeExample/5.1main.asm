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
init:
			bic.w	#0001h, &PM5CTL0		; disable gpio power on default high z mode
			bis.b	#01h, &P1DIR			; set p1 as output

main:
			xor.b	#01h, &P1OUT			; toggle led1

			; 1s delay loop
			mov.w	#005h, R4				; put big number into R4
Delay:
			mov.w	#0FFFFh, R5 			; put big number into R4

DelayLoop:
			dec.w	R5						; decrement R4
			jnz 	DelayLoop				; loop until R5 is 0
			dec.w	R4
			jnz		Delay					; repeat main loop foreever
                                            
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
            
