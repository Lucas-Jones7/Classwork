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
; Practical 3.1 - Step 2: Create new CSS project
init:
			; initialize register values
			mov.w	#0AAAAh, R6
			mov.w	#0001h, R7
			mov.w	#0CCCCh, R8
			mov.w	#0DDDDh, R9

; Practical 3.1 - Step 4: Basic Digital I/O
			; initialize led2 as output (P6)
			mov.b	#000h, &P6SEL0			; clear P6SEL0 and P6SEL1
			mov.b	#000h, &P6SEL1
			bis.b	#BIT6, &P6DIR			; set PxDIR.y = 1 (output)
			bic.b	#BIT6, &P6OUT			; clear output PxOUT.y = 0

			; initialize one additional 4 bit nibble of your choosing as outputs
			mov.b	#00h, &P3SEL0			; set P3.0-P3.3 as inputs with pull donw resistors
			mov.b	#00h, &P3SEL1			; clear P4SEL0 and SEL1
			mov.b	#01h, &P3DIR			; set P5dir.y = 1 (output)
			bic.b	#0Fh, &P3OUT			; clear output

			;initialize swith2 as a input with a pull up resistor (P2)
			bic.b	#BIT3, &P2SEL0			; clear P4SEL0 and P4SEL1
			bic.b	#BIT3, &P2SEL1
			bic.b	#BIT3, &P2DIR			; set PxDIR.y = 0 (P2.3 is an input)
			bis.b	#BIT3, &P2REN			; set PxREN.y = 1 (resistor enable)
			bis.b	#BIT3, &P2OUT			; set PxOUT.y = 1 (pull up)

			; initialize one additional 4-bit nibble of your choosing as inputs (P5)
			mov.b	#00h, &P5SEL0			; set P5.0-P5.3 as inputs with pull donw resistors
			mov.b	#00h, &P5SEL1
			mov.b	#00h, &P5DIR
			bis.b	#0Fh, &P5REN
			bic.b	#0Fh, &P5OUT

verify:
			bis.b	#BIT6, &P6OUT			; sets led high
			bic.b	#BIT6, &P6OUT			; set led2 low

			; may be an issue here with next 2 lines
			bis.b	#0Fh, &P3OUT			; set additional output nibble to 0Fh
			bis.b	#00h, &P3OUT			; set additional output nibble to 00h

			mov.b	&P2IN, R6				; read s2 to r6 (not pressed)
			mov.b	&P2IN, R6				; same as above but pressed

			mov.b	&P5IN, R7				; read additional input nibble to R7 (jumper connected to 2nd pin)
			mov.b	&P5IN, R7				; same as above (jumper connected to 4th pin)

main:
; Practical 3.1 - Step 5: Basic Program Flow
while:
			bic.b	#BIT6, &P6OUT			; led2 off
			mov.b	&P2IN, R5
			cmp.b	#00h, R5				; is s2 to 1
			jz		EndWhile  					; if not equal exit loop

			jmp		while

EndWhile:
			bis.b	#BIT6, &P6OUT			; led2 on
			jmp		test					; move on to test routine

test:


;-------------------------------------------------------------------------------
; 1s Delay Loop
;-------------------------------------------------------------------------------
			mov.w	#005h, R4				; put big number into R4
Delay:
			mov.w	#0FFFFh, R5 			; put big number into R4

DelayLoop:
			dec.w	R5						; decrement R4
			jnz 	DelayLoop				; loop until R5 is 0
			dec.w	R4
			jnz		Delay					; repeat main loop foreever

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------
; Practical 3.1 - Step 3: Data Allocation
			.data
			.retain

Const0:		.word	0xBEEF					; init 8 16-bit words
Const1:		.word	0xDEAD

Var0:		.word	0						; reserves enough memory for 8 16-bit words
Var1:		.word	0

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
            
