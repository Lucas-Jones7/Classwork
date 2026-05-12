;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 12.3, 03/05/2026
; Calculations:
;	TB0:
;		1s Period: 1s = (1/25000) * N , N = 25000, TB0CCR0 = N - 1 = 24999
;		10% duty cycle: 0.1s = (1/25000) * N, N = 2500, TB0CCR1 = N -1 = 2499
;
;	TB1:
;		1s Period: 1s = (1/25000) * N, N= 25000, TB1CCR0 = N - 1 = 24999
;		90% duty cycle:	0.9s = (1/25000) * N, TB1CCR1 = N - 1 = 22499
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
; Lab 12.3 - Step 2: Prepare the main.asm file
Init:
			; init led1 and 2 as outputs
			bis.b	#BIT0, &P1DIR
			bis.b	#BIT0, &P1OUT			; on to start
			bis.b	#BIT6, &P6DIR
			bis.b	#BIT6, &P6OUT			; aslo on

; ------------------ END OUTPUTS --------------------------

			; init timers
			; TB0
			bis.w	#TBCLR, &TB0CTL			; clear timers and dividers
			bis.w	#TBSSEL__SMCLK, &TB0CTL ; choose SMCLK clock source
			bis.w	#MC__UP, &TB0CTL		; up counting mode
			bis.w	#ID_3, &TB0CTL			; divide by 8
			bis.w	#TBIDEX__5, &TB0EX0     ; divide by 5 (40 total)
			mov.w	#24999, &TB0CCR0		; init CCR0 to counts - 1 (1s)
			mov.w	#2499, &TB0CCR1			; init CCR2 to counts - 1 (10%)

			;TB1
			bis.w	#TBCLR, &TB1CTL			; clear timers and dividers
			bis.w	#TBSSEL__SMCLK, &TB1CTL ; choose SMCLK source
			bis.w	#MC__UP, &TB1CTL		; up counting mode
			bis.w	#ID_3, &TB1CTL			; divide by 8
			bis.w	#TBIDEX__5, &TB1EX0     ; divide by 5 (40 total)
			mov.w	#24999, &TB1CCR0		; init CCR0 to counts - 1 (1s)
			mov.w	#22499, &TB1CCR1		; init CCR2 to counts - 1 (10%)

; ------------------- END TIMERS ------------------------------


			; timer interrupts
			; TB0
			bis.w	#CCIE, &TB0CCTL0		; enable CCR0 interrupt
			bic.w	#CCIFG, &TB0CCTL0		; clear CCR0 flag
			bis.w	#CCIE, &TB0CCTL1		; enable CCR1 interrupt
			bic.w	#CCIFG, &TB0CCTL1		; clear CCR1 flag

			; TB1
			bis.w	#CCIE, &TB1CCTL0		; enable CCR0 interrupt
			bic.w	#CCIFG, &TB1CCTL0		; clear CCR0 flag
			bis.w	#CCIE, &TB1CCTL1		; enable CCR1 interrupt
			bic.w	#CCIFG, &TB1CCTL1		; clear CCR1 flag


			bis.w	#GIE, SR				; enable global interrupts

; ------------------- END INTERRUPTS ------------------------------


Main:
			jmp		Main

; --------------------------------END MAIN------------------

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
; Lab 12.3 - Step 4: Create a program to flash led1 according to instructions
; service TB0 CCR0
TimerB0_EndLow:
			bis.b	#BIT0, &P1OUT			; led1 on
			bic.w	#CCIFG, &TB0CCTL0		; clear CCR0 flag
			reti

; service TB0 CCR1
TimerB0_EndHigh:
			bic.b	#BIT0, &P1OUT			; led 1 off
			bic.w	#CCIFG, &TB0CCTL1		; clear CCR1 flag
			reti

; --------------------------- END Service TB0 interrupts ----------------------

; Lab 12.3 - Step 6: Create a program that will flash led2 according to lab instructions
; service TB1 CCR0
TimerB1_EndLow:
			bis.b	#BIT6, &P6OUT			; led 2 on
			bic.w	#CCIFG, &TB1CCTL0		; clear CCR0 flag
			reti

; service TB1 CCR1
TimerB1_EndHigh:
			bic.b	#BIT6, &P6OUT			; led 2 off
			bic.w	#CCIFG, &TB1CCTL1		; clear CCR1 flag
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

; Lab 12.3 - Step 3: Prepare the Interrupt Vectors for Demo 1
			.sect	".int43"				; TB0CCR0 CCIFG0 vector
			.short	TimerB0_EndLow

			.sect	".int42"				; TB0CCR1, TB0IFG vector
			.short	TimerB0_EndHigh

			.sect	".int41"				; TB1CCR0 CCIFG0 vector
			.short	TimerB1_EndLow

			.sect	".int40"				; TB1CCR1 CCIFG vector
			.short 	TimerB1_EndHigh
