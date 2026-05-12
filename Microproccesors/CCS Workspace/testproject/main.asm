;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 12.4, 03/05/2026
;
; Register Definitions:
; R4 - DelayOnce counter
; R6 - PWM time period (t)
; R7 - PWM duty cycle (delta-t)
; R8 - Minimum duty cycle allowed
; R9 - Maximum duty cycle allowed
; R10 - Duty cycle step size
;
;
; Calculations:
;	Period(R6): 0.001s = (1/1mill) * N, N = 1000, TB0CCR0 = N - 1 = 999
;	On-Time(R7): 0.0001s = (1/1mill) * N, N = 100, TB0CCR1 = N - 1 = 99
;	Step Size(R10): 0.025 * 0.001s = (1/1mill) * N, N = 25
;	Min(R8): 10% = N = 100 - 1 = 99
;	Max(R9): 50% = N = 500 - 1 = 499
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
; Lab 12.4 - Step 2: Prepare the main.asm file
Init:
			; init registers R4-R10
			mov.w	#0, R4					; delay once counter
			mov.w	#999, R6				; T | period counts (1ms)
			mov.w	#99, R7					; delta t | 10% 0.1ms
			mov.w	#99, R8					; min duty cycle (10%)
			mov.w	#499, R9				; max duty cycle (50%)
			mov.w	#25, R10				; step size (2.5%)

; ---------------------- END REGISTERS ---------------------

			; init leds as outputs
			bis.b	#BIT0, &P1DIR
			bis.b	#BIT0, &P1OUT
			bis.b	#BIT6, &P6DIR
			bic.b	#BIT6, &P6OUT

; ---------------------------- END OUTPUTS -------------------------

			; init switches
			; sw1
			bic.b	#BIT1, &P4DIR			; set p4.1 input
			bis.b	#BIT1, &P4REN			; enable resistors
			bis.b	#BIT1, &P4OUT			; pull up
			bis.b	#BIT1, &P4IES			; interrupt on high to low
			bic.b	#BIT1, &P4IFG			; clear flag
			bis.b	#BIT1, &P4IE			; enable interrupt

			; sw2
			bic.b	#BIT3, &P2DIR			; set p2.3 input
			bis.b	#BIT3, &P2REN			; enable resistors
			bis.b	#BIT3, &P2OUT			; pull up
			bis.b	#BIT3, &P2IES			; interrupt on high to low
			bic.b	#BIT3, &P2IFG			; clear flag
			bis.b	#BIT3, &P2IE			; enable interrupt

; ---------------------------- END SWITCHES ------------------------

			; init timers
			bis.w	#TBCLR, &TB0CTL			; clear timers and dividers
			bis.w	#TBSSEL__SMCLK, &TB0CTL ; choose SMCLK clock source
			bis.w	#MC__UP, &TB0CTL		; up counting mode
			bis.w	#ID__1, &TB0CTL			; divide by 1
			bis.w	#TBIDEX__1, &TB0EX0     ; divide by 1

			mov.w	R6, &TB0CCR0			; load period (T)
			mov.w	R7, &TB0CCR1			; load duty cycle (delta-t)

; ------------------------- END TIMERS ----------------------------

			; timer interrupts
			bis.w	#CCIE, &TB0CCTL0		; enable CCR0 interrupt
			bic.w	#CCIFG,	&TB0CCTL0		; clear flag
			bis.w	#CCIE, &TB0CCTL1		; enable CCR1 interrupt
			bic.w	#CCIFG, &TB0CCTL1		; clear flag

			bic.b	#LOCKLPM5, &PM5CTL0		; disable high z

			nop
			bis.w	#GIE, SR				; enable global interrupts
			nop

Main:
			jmp		Main

;-------------------------------------------------------------------------------
; Delay Subroutine
;-------------------------------------------------------------------------------
DelayOnce:
			mov.w	#0FFFFh, R4

DelayLoop:
			dec.w	R4
			jnz		DelayLoop
			ret

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
; Lab 12.4 - Step 4: modify program from 12.3 to meet requirements for lab 12.4
; service TB0 CCR0
ISR_TB0_CCR0:
			bis.b	#BIT0, &P1OUT			; led1 on
			bic.w	#CCIFG, &TB0CCTL0		; clear flag
			reti

; service TB0 CCR1
ISR_TB0_CCR1:
			bic.b	#BIT0, &P1OUT			; led1 off
			bic.w	#CCIFG, &TB0CCTL1		; clear flag
			reti

; ------------------------- END TB0 service ---------------------------------
; service sw1 - increase duty cycle
ISR_SW1:
			push	R15					; save R15
			mov.w	R7, R15				; copy duty cycle
			add.w	R10, R15			; R15 = R7 + step
			cmp.w	R9, R15				; R15 - R9 (unsigned)
			jhs		SW1_AtLimit			; if R15 >= R9, at limit

			add.w	R10, R7				; R7 += step
			mov.w	R7, &TB0CCR1		; update timer
			jmp		SW1_Done

SW1_AtLimit:
			bis.b	#BIT6, &P6OUT		; led2 on
			bic.b	#BIT6, &P6OUT		; led2 off

SW1_Done:
			pop		R15					; restore R15
			bic.b	#BIT1, &P4IFG		; clear sw1 flag
			reti

; -------------------------- END SW1 service --------------------------------
; service sw2 - decrease duty cycle
ISR_SW2:
			push	R15					; save R15
			mov.w	R7, R15				; copy duty cycle
			sub.w	R10, R15			; R15 = R7 - step
			cmp.w	R8, R15				; R15 - R8 (unsigned)
			jlo		SW2_AtLimit			; if R15 < R8, at limit

			sub.w	R10, R7				; R7 -= step
			mov.w	R7, &TB0CCR1		; update timer
			jmp		SW2_Done

SW2_AtLimit:
			bis.b	#BIT6, &P6OUT		; led2 on
			bic.b	#BIT6, &P6OUT		; led2 off

SW2_Done:
			pop		R15					; restore R15
			bic.b	#BIT3, &P2IFG		; clear sw2 flag
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

; Lab 12.4 - Step 3: Prepare the interrupt vectors
			.sect	".int43"				; TB0CCR0 vector
			.short	ISR_TB0_CCR0

			.sect	".int42"				; TB0CCR1 vector
			.short	ISR_TB0_CCR1

			.sect	".int24"				; port 2 / SW2 vector
			.short	ISR_SW2

			.sect	".int22"				; port 4 / SW1 vector
			.short	ISR_SW1
