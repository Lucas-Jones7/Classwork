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
			bis.b	#BIT0, &P1DIR			; setup LED1 to be an output
			bic.b	#BIT0, &P1OUT			; clear LED1 initial

			; setup S1 as a port interrupt
			bic.b	#BIT1, &P4DIR			; set port direction to input
			bic.b	#BIT1, &P4REN			; enable pull-up/down resistros
			bic.b	#BIT1, &P4OUT			; configure resistor as pull-up
			bic.b	#BIT1, &P4IES			; set IRQ sensitivity to High-to-Low

			bic.b	#LOCKLPM5, &PM5CTL0		; clear LOCKLMP5 bit

			bic.b	#BIT1, &P4IFG			; clear interrupt flag
			bic.b	#BIT1, &P4IE			; assert local enable
			bis.w	#GIE, SR				; assert global enable

main:
			jmp 	main

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
ISR_S1:
			xor.b	#BIT0, &P1OUT			; toggle LED1
			bic.b	#BIT1, &P4IFG			; clear P4IFG.1 flag
			reti							; return to main program

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
            
            .sect	".int22"				; initialize the vector table for port 4
            .short	ISR_S1
