;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 7.3, 02/06/2026
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
; Lab 9.1 - Step 2: Prepare main.asm file

			; Configure LED2
			mov.b	#000h, &P6SEL0			; clear P6SEL0 and P6SEL1
			mov.b	#000h, &P6SEL1
			bis.b	#BIT6, &P6DIR			; set PxDIR.y = 1
			bic.b	#BIT6, &P6OUT			; clear output PxOUT.y = 0

			; Configure LED1
			mov.b	#000h, &P1SEL0			; clear P1SEL0 and P1SEL1
			mov.b	#000h, &P1SEL1
			bis.b	#BIT0, &P1DIR			; set PxDIR.y = 1
			bic.b	#BIT0, &P1OUT			; clear output PxOUT.y = 0

			; Configure S1
			bic.b	#BIT1, &P4SEL0			; clear P4SEL0 and P4SEL1
			bic.b	#BIT1, &P4SEL1
			bic.b	#BIT1, &P4DIR			; set PxDIR.y = O (P4.1 is an input)
			bis.b	#BIT1, &P4REN			; set PxREN.y = 1 (resisttor enable)
			bis.b	#BIT1, &P4OUT			; set PxOUT.y = 1 (pull up)

			; Configure S2
			bic.b	#BIT3, &P2SEL0			; clear P4SEL0 and P4SEL1
			bic.b	#BIT3, &P2SEL1
			bic.b	#BIT3, &P2DIR			; set PxDIR.y = 0 (P2.3 is an input)
			bis.b	#BIT3, &P2REN			; set PxREN.y = 1 (resistor enable)
			bis.b	#BIT3, &P2OUT			; set PxOUT.y = 1 (pull up)

			; Init R4-R6
			mov.w	#0000h, R4				; clear the following registers
			mov.w	#0000h, R5
			mov.w	#0000h, R6

; Lab 9.1 - Step 6 - Update init code
			; Configure 3rd Output
			bic.b	#BIT0, &P3SEL0			; clear P3SEL0 and P3SEL1
			bic.b	#BIT0, &P3SEL1
			bis.b	#BIT0, &P3DIR			; set P3.0 as an output (=1)
			bic.b	#BIT0, &P3OUT			; clear P3OUT bit 0 - LED of to start

			; Configure 3rd Input
			bic.b	#BIT0, &P5SEL0			; clear P5SEL0 and P5SEL1
			bic.b	#BIT0, &P5SEL1
			bic.b	#BIT0, &P5DIR			; set P5DIR to input (=0)
			bis.b	#BIT0, &P5REN			; enables resistor
			bic.b	#BIT0, &P5OUT			; P5OUT = 0 pull down

			; Disable Low Power Mode
			bic.w	#LOCKLPM5, &PM5CTL0

main:
; FOR DEMO put jumper P5.0 to 3.3v   and anode P3.0 to grnd
; Lab 9.1 - Step 7: Update the main code
			bis.b	#BIT0, &P3OUT			; turn on LED

; Lab 9.1 - Step 3: Use Digital Outputs
			bis.b	#BIT6, &P6OUT			; green LED(LED2) on and off
			bic.b	#BIT6, &P6OUT

			bis.b	#BIT0, &P1OUT			; red LED(LED1) on and off
			bic.b	#BIT0, &P1OUT

; Lab 9.1 - Step 4: Use Digital Inputs

			; No Switch Pressed
			mov.b	&P4IN, R4				; Result of S1 in R4
			mov.b	&P2IN, R5				; Result of S2 in R5.
											;    neither is pressed so pull ups set Register values
			mov.b	&P5IN, R6				; R6 = 1(input high) jumper to 3.3v

			; Press S2
			mov.b	&P4IN, R4				; Result of S1 in R4
			mov.b	&P2IN, R5				; Result of S2 in R5. S2 is pressed so R5 goes to 0
			mov.b	&P5IN, R6				; R6 = 0(default low) jumper to ground

			; turn off 3rd output
			bic.b	#BIT0, &P3OUT			; Turn on LED

			; Press S1
			mov.b	&P4IN, R4				; Result of S1 in R4
			mov.b	&P2IN, R5				; Result of S2 in R5. S1 is
											;   pressed so R4 goes to 04h R5 goes to 08h
			mov.b	&P5IN, R6				; R6 = 1(input high) 3.3v

			; Press Both S1 & S2
			mov.b	&P4IN, R4				; Result of S1 in R4
			mov.b	&P2IN, R5				; Result of S2 in R5. Both pressed so R4
											;   goes to 04h R5 goes to 00h
			mov.b	&P5IN, R6				; R6 = 0(defualt low) grnd

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
            
