;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 8.1, 02/12/2026
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
; Lab 8.1 - Step 8: Zero-based (equality) Jumps
Init:
			; Configure P5
			mov.b	#00h, &P5SEL0
			mov.b	#00h, &P5SEL1
			mov.b	#00h, &P5DIR
			bis.b	#0Fh, &P5REN
			bic.b	#0Fh, &P5OUT

			; Configure LEDs
			bis.b	#BIT0, &P1DIR			; red
			bic.b	#BIT0, &P1OUT
			bis.b	#BIT6, &P6DIR			; green
			bic.b	#BIT6, &P6OUT

			; Disable high-z
			bic.w	#LOCKLPM5, &PM5CTL0

Main:




Done:
			mov.b	&P5IN, R5				; move input to R5
			and.b	#0Fh, R5				; move #0Fh to R5

			cmp.b	#00h, R5				; Compare R5 to 00h
			jz		SolidGreen				; If R5=0 Z = 1
			jnz     SolidRed				; If R5 != 0 Z = 0


;-------------------------------------------------------------------------------
; Blinky LED Subroutines here (DEMO 2)
;-------------------------------------------------------------------------------
; Lab 8.1 - Step 8: Zero-based (equality) Jumps
SolidGreen:
			bic.b	#BIT0, &P1OUT			; red off
			bis.b	#BIT6, &P6OUT			; green on
			jmp		Done

SolidRed:
			bis.b	#BIT0, &P1OUT			; red on
			bic.b	#BIT6, &P6OUT			; green off

;----------------------
; Lab 8.1 - Step 9 - Overflow-based (inequality) jumps
			mov.b	#04h, R5
       		cmp.b	#04h, R5				; compare P5 value to 4
       		jge		SlowBlink				; If R5 >= 4 go slow
       		jl		FastBlink				; If R5 < 4 go fast

SlowBlink:
			bis.b	#BIT6, &P6OUT			; green on
			mov.w	#0FFFFh, R6

SlowDelayOn:
			dec.w	R6
			jnz		SlowDelayOn				; jump back if Z = 0
			bic.b	#BIT6, &P6OUT			; green off

			mov.w	#0FFFFh, R6

SlowDelayOff:
			dec.w	R6
			jnz		SlowDelayOff			; jump back if Z = 0
			jmp		Done

FastBlink:
			bis.b	#BIT6, &P6OUT			; green on
			mov.w	#01111h, R6

; Lab 9.1 - Step 10: More zero based jumps
FastDelayOn:
			dec.w	R6
			tst.w	R6
			jn		ContinueOn				; jump if N = 1
			jmp		FastDelayOn

ContinueOn:
			bic.b	#BIT6, &P6OUT			; green off
			mov.w	#01111h, R6

FastDelayOff:
			dec.w	R6
			tst.w	R6
			jn		ContinueOff				; jump if N = 1
			jmp		FastDelayOff

ContinueOff:
			jmp		Done
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
            
