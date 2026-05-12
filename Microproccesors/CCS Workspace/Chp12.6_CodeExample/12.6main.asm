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
; setup led1
			bis.b	#BIT0, &P1DIR			; led 1 to output p1dir.o=1
			bic.b	#BIT0, &P1OUT 			; clear led 1 to start
			bic.b	#LOCKLPM5, &PM5CTL0		; clear locklpm5 bit

; setupu timer B0
			bis.w	#TBCLR, &TB0CTL         ; clear timer & dividers (TBCLR=1)
			bis.w	#TBSSEL__ACLK, &TB0CTL   ; select ACLK as timer source (TBSSEL=01)
			bis.w	#MC__CONTINUOUS, &TBOCTL ; choose continuous counting (MC=10)
			bis.w	#TBIE, &TB0CTL			; enable overflow interrupt (TBIE=1)
			bic.w	#TBIFG, &TB0CTL			; clear interrupt flag (TBIFG=0)
			bis.w	#GIE, SR				; enable maskable interrupts (GIE=1)

main:
			jmp 	main

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
ISR_TB0_Overflow:
			xor.b	#BIT0, &P1OUT   		; the ISR toggles led1 and clear the TBIFG flag
			bic.w	#TBIFG, &TB0CTL
			reti


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
            
            .sect	".int42"				; Timer B0 interrupt vector
            .short	ISR_TB0_Overflow

