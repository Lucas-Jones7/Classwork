;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 12.2, 03/02/2026
; Equations:
;   TB0: D1=8 D2=8 N=(1m/64)=15625
;   TB1: D1=8 D2=8 N=31250
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
; Lab 12.1 - Step 2: Prepare the main.sam file
Init:
; output LEDs----------------------------
			; setup led1
			bis.b	#BIT0, &P1DIR			; led 1 to output p1dir.o=1
			bic.b	#BIT0, &P1OUT 			; clear led 1 to start


			; setup led2
			bis.b	#BIT6, &P6DIR			; led 2 to output p1dir.o=1
			bic.b	#BIT6, &P6OUT 			; clear led 2 to start

			bic.b	#LOCKLPM5, &PM5CTL0		; clear locklpm5 bit

; timers ---------------------------------------
			mov.w	#15625, &TB0CCR0		; init TB0CCR0=15625
			mov.w	#31250, &TB1CCR0		; init TB1CCR0=31250

			; setup TB0 1s
			bis.w	#TBCLR, &TB0CTL			; clear timer and dividers
			bis.w	#TBSSEL__SMCLK, &TB0CTL ; choose SMCLK timer source
			bis.w	#MC__UP, &TB0CTL		; choose up counting mode
			bis.w	#CNTL_0, &TB0CTL		; 16-bit count length
			bis.w	#ID_3, &TB0CTL			; divide by 8
			bis.w	#TBIDEX_7, &TB0EX0		; divide by 8  (64 total)

			; setup TB1 2s
			bis.w	#TBCLR, &TB1CTL			; clear timer and dividers
			bis.w	#TBSSEL__SMCLK, &TB1CTL ; choose SMCLK timer source
			bis.w	#MC__UP, &TB1CTL		; choose up counting mode
			bis.w	#CNTL_0, &TB1CTL		; 16-bit count length
			bis.w	#ID_3, &TB1CTL			; divide by 8
			bis.w	#TBIDEX_7, &TB1EX0		; divide by 8  (64 total)

; interrupts -----------------------------------
			; TB0
			bic.w	#CCIFG, &TB0CCTL0
			bis.w	#CCIE, &TB0CCTL0

			; TB1
			bic.w	#CCIFG, &TB1CCTL0
			bis.w	#CCIE, &TB1CCTL0
			bis.w	#GIE, SR

Main:
			jmp 	Main

; ---------------------- END MAIN -----------------------

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
; service TB0
TimerB0_1s:
			xor.b	#BIT0, &P1OUT			; toggle led2
			bic.w	#CCIFG, &TB0CCTL0			; clear overflow flag
			reti
; -------------------- END TimerB0_1s ------------------


; service TB1
TimerB1_2s:
			xor.b	#BIT6, &P6OUT			; toggle led1
			bic.w	#CCIFG, &TB1CCTL0		; clear overflow flag
			reti
; -------------------- END TimerB1_2s ------------------


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

; Lab 12.2 - Step 3: Prepare the Interrupt vectors
			.sect	".int43"				; TB0 reset vector
			.short	TimerB0_1s

			.sect	".int41"				; TB1 reset vector
			.short	TimerB1_2s
