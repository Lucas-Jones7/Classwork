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
Init:
			; setup led 1
			bis.b	#BIT0, &P1DIR			; set led1 as output
			bis.b	#BIT0, &P1OUT			; set led1 initially
			bic.b	#LOCKLPM5, &PM5CTL0		; clear high z

			; setup timer B0
			bis.w	#TBCLR, &TB0CTL			; clear timer and dividers
			bis.w	#TBSSEL__ACLK, &TB0CTL  ; select ACLK as clock source
			bis.w	#MC__UP, &TB0CTL		; choose up counting

			; setup compare registers
			mov.w	#32768, &TB0CCR0		; init CCR0 to 32768
			mov.w	#1638, &TB0CCR1			; init CCR1 to 1638

			bis.w	#CCIE, &TB0CCTL0		; enable TB0CCR0 interrupt
			bic.w	#CCIFG, &TB0CCTL0		; clear TB0CCR0 flag

			bis.w	#CCIE, &TB0CCTL1		; enable TB0CCR1 interrupt
			bic.w	#CCIFG, &TB0CCTL1		; clear TB0CCR1 flag

			bis.w	#GIE, SR				; enable maskable interrupts (enable global)

Main:
			jmp		Main

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
ISR_TB0_CCR1:
			bic.b	#BIT0, &P1OUT			; drive led1 to a 0 and clear the CCR1 flag
			bic.w	#CCIFG, &TB0CCTL1
			reti

ISR_TB0_CCR0:
			bis.b	#BIT0, &P1OUT			; drive led1 back to 1 and clear CCR0 flag
			bic.w	#CCIFG, &TB0CCTL0
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
            
            ;setup interrupt vectors
            .sect	".int43"
            .short	ISR_TB0_CCR0

            .sect	".int42"
            .short	ISR_TB0_CCR1
