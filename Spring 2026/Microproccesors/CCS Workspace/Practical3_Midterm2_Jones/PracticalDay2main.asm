;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;	Lucas Jones, EELE 371, Practical 3.2, 03/11/2026
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
; Practical 3.2 - Step 2: Create a new CCS project
init:
			; Init registers
			mov.w	#0000h, R4
			mov.w	#0AAAAh, R5
			mov.w	#0BBBBh, R6
			mov.w	#0CCCCh, R7
			mov.w	#61A8h, R8

; Practical 3.2 - Step 3: Digital I/O Interrupts
			; init outputs (led1)
			mov.b	#000h, &P1SEL0			; clear P1SEL0 and P1SEL1
			mov.b	#000h, &P1SEL1
			bis.b	#BIT0, &P1DIR			; set PxDIR.y = 1 (output)
			bic.b	#BIT0, &P1OUT			; clear output PxOUT.y = 0


			; init inputs (S1 & S2)
			; S2
			bic.b	#BIT3, &P2SEL0			; clear P4SEL0 and P4SEL1
			bic.b	#BIT3, &P2SEL1
			bic.b	#BIT3, &P2DIR			; set PxDIR.y = 0 (P2.3 is an input)
			bis.b	#BIT3, &P2REN			; set PxREN.y = 1 (resistor enable)
			bis.b	#BIT3, &P2OUT			; set PxOUT.y = 1 (pull up)

			; S1
			bic.b	#BIT1, &P4SEL0			; clear P4SEL0 and P4SEL1
			bic.b	#BIT1, &P4SEL1
			bic.b	#BIT1, &P4DIR			; set PxDIR.y = 0 (P2.3 is an input)
			bis.b	#BIT1, &P4REN			; set PxREN.y = 1 (resistor enable)
			bis.b	#BIT1, &P4OUT			; set PxOUT.y = 1 (pull up)


			; Port Interrupts
            ; S1 - trigger on H-to-L (press)
            bic.b   #BIT1, &P4IFG           ; clear flag
            bis.b   #BIT1, &P4IES           ; H-to-L edge
            bis.b   #BIT1, &P4IE            ; enable interrupt

            ; S2 - trigger on H-to-L (press)
            bic.b   #BIT3, &P2IFG           ; clear flag
            bis.b   #BIT3, &P2IES           ; H-to-L edge
            bis.b   #BIT3, &P2IE            ; enable interrupt

            bic.w   #LOCKLPM5, &PM5CTL0     ; disable high-Z

; Practical 3.2 - Step 4: Timer Interrupts
			; Init timer
			bis.w	#TBCLR, &TB0CTL			; clear timers and dividers
			bis.w	#TBSSEL__SMCLK, &TB0CTL ; select SMCLK clock source
			bis.w	#MC__UP, &TB0CTL		; choose up counting (compare timer)

			mov.w	R8, &TB0CCR0			; init CCR0 to 25,000d (Count)

			; Timer Interrupts
			bis.w	#CCIE, &TB0CCTL0		; enable compare/capture register
			bis.w	#CCIFG, &TB0CCTL0		; clear interrupt flag


			; Enable Global Interrupts
            nop
            bis.w	#GIE, SR
            nop

main:
			mov.w	#0000h, R5				; re-set R5 to check main loop was entered
     		jmp 	main					; infinite loop of main
     		nop

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------
; service S1 interrupt
SW1_Pressed:
			mov.w	#0000h, R6				; re-set R6 to check ISR is entered
			bic.b   #BIT1, &P4IFG           ; clear flag
			reti							; return to caller


; service S2 interrupt
SW2_Pressed:
			mov.w	#0000h, R7
			bic.b   #BIT3, &P2IFG           ; clear flag
			reti							; return to caller


; service TB0 interrupt
TB0_ISR:
			xor.b	#BIT0, &P1OUT			; toggle led1
			clrc							; divide R7 by 2
			rrc.b	R7
			bic.w	#CCIFG, &TB0CCTL0		; clears flag
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
            
; Practical 3.2 - Step 3: Digital I/O Interupts
			.sect	".int43"				; TimerB0_3 interrupt vector
			.short	TB0_ISR

			.sect	".int24"				; port 2 / SW2 vector
			.short	SW2_Pressed

			.sect	".int22"				; port 4 / SW1 vector
			.short	SW1_Pressed
