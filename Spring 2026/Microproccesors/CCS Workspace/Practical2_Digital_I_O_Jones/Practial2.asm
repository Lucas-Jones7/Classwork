;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 7.3, 02/06/2026
;
; Hardware Mapping:
;	- {Green LED}     {Port 6.6}     {Pin 16}
;	- {BLUE LED}      {Port 3.0}     {Pin 47}
;	- {Switch 2}      {Port 2.3}     {Pin 27}
;	- {Switch X}      {Port 5.0}     {Pin 25}
;	- {UCA1CLK}       {   n/a  }     {Pin 25}
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
; Practical 2 - Step 3: Prepare main.asm file
init:
			; init green led
			mov.b	#000h, &P6SEL0			; clear P6SEL0 and P6SEL1
			mov.b	#000h, &P6SEL1
			bis.b	#BIT6, &P6DIR			; set PxDIR.y = 1
			bic.b	#BIT6, &P6OUT			; clear output PxOUT.y = 0

			; init S2
			bic.b	#BIT3, &P2SEL0			; clear P4SEL0 and P4SEL1
			bic.b	#BIT3, &P2SEL1
			bic.b	#BIT3, &P2DIR			; set PxDIR.y = 0 (P2.3 is an input)
			bis.b	#BIT3, &P2REN			; set PxREN.y = 1 (resistor enable)
			bis.b	#BIT3, &P2OUT			; set PxOUT.y = 1 (pull up)

			; init BLUE led to be controlled by P3.0
			bic.b	#BIT0, &P3SEL0			; clear P3SEL0 and P3SEL1
			bic.b	#BIT0, &P3SEL1
			bis.b	#BIT0, &P3DIR			; set P3.0 as an output (=1)
			bic.b	#BIT0, &P3OUT			; clear P3OUT bit 0 - LED of to start

			; init A1CLK feuture
			bic.b	#BIT1, &P4SEL0			; clear P4SEL0 and P4SEL1
			bic.b	#BIT1, &P4SEL1

			; init switch x to be on pin 5.0
			bic.b	#BIT0, &P5SEL0			; set P5.0-P5.3 as inputs with pull donw resistors
			bic.b	#BIT0, &P5SEL1
			bic.b	#BIT0, &P5DIR			; set p5.0 as input
			bis.b	#BIT0, &P5REN			; enable resistor
			bis.b	#BIT0, &P5OUT			; pull down resistor



			bic.b	#LOCKLPM5, &PM5CTL0		; disable high z mode
main:
			mov.b	&P2IN, R5				; perform a read on S2
			bis.b	#BIT6, &P6OUT			; invert the state of the green led
			mov.b	&P2IN, R5				; perform another read on S2
			bic.b	#BIT6, &P6OUT			; invert state of green led so its the same as when init routine was left

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
            
