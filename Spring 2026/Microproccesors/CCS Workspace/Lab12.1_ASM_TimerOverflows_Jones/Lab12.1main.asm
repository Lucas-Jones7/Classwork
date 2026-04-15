;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 12.1, 03/02/2026
; TB0:
;    Dividers: ID=8
;    Equation: 1s = ( (1/32768)*D ) * 2^12   D = 8
; TB1:
;    Dividers: ID=4 TBIDEX=4 Total=16
;    Equation: 2s = ( (1/32768)*D ) * 2^12   D = 16
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
; outputs ----------------------------
			; setup led1
			bis.b	#BIT0, &P1DIR			; led 1 to output p1dir.o=1
			bic.b	#BIT0, &P1OUT 			; clear led 1 to start


			; setup led2
			bis.b	#BIT6, &P6DIR			; led 2 to output p1dir.o=1
			bic.b	#BIT6, &P6OUT 			; clear led 2 to start

			bic.b	#LOCKLPM5, &PM5CTL0		; clear locklpm5 bit

; timers ---------------------------------
            ; setup TB0
            bis.w	#TBCLR, &TB0CTL         ; clear timer and dividers
            bis.w	#TBSSEL__ACLK, &TB0CTL  ; select ALCK clock source
            bis.w 	#MC__CONTINUOUS, &TB0CTL ; continous mode select

            bis.w	#CNTL_1, &TB0CTL		; choose 12-bit counter length
            bis.w	#ID_3, &TB0CTL			; divide by 8
            bis.w	#TBIDEX_0, &TB0EX0  	; divide by 1 (defualt)


			; setup TB1
			bis.w	#TBCLR, &TB1CTL			; clear timers and dividers
			bis.w	#TBSSEL__ACLK, &TB1CTL  ; select ALCK clock source
			bis.w	#MC__CONTINUOUS, &TB1CTL ; continuos mode

			bis.w	#CNTL_1, &TB1CTL		; choose 12-bit count lenght
			bis.w	#ID_2, &TB1CTL			; divide by 4
			bis.w	#TBIDEX_3, &TB1EX0		; divide by 4 (16 total)

; Timer interrupts
			; TB0 interrupt
			bic.w	#TBIFG, &TB0CTL			; clear flag
			bis.w	#TBIE, &TB0CTL			; enable overflow interrupt

			; TB1 interrupt
			bic.w	#TBIFG, &TB1CTL			; clear flag
			bis.w	#TBIE, &TB1CTL			; enable overflow interrupt
			bis.w   #GIE, SR				; enable global interrupts

Main:
			jmp 	Main

; ------------------ END MAIN -----------------------

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
; service TB0
TimerB0_1s:
			xor.b	#BIT0, &P1OUT			; toggle led2
			bic.w	#TBIFG, &TB0CTL			; clear overflow flag
			reti
; -------------------- END TimerB0_1s ------------------

; service TB1
TimerB1_2s:
			xor.b	#BIT6, &P6OUT			; toggle led1
			bic.w	#TBIFG, &TB1CTL			; clear overflow flag
			reti
; -------------------- END TimerB2_2s ------------------

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

; Lab 12.1 - Step 3: Prepare the interrupt vectors
            .sect	".int42"				; TB0 reset vector
            .short	TimerB0_1s

            .sect	".int40"				; TB1 reset vector
            .short	TimerB1_2s
