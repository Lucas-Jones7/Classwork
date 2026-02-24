;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 10.1, 02/23/2026
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.

; Lab 10.1 - Step 2: Initialize a block of data memory
			.data
			.retain

DataBlock:
			.word	00000h
			.word	01111h
			.word	02222h
			.word	03333h

			.word	04444h
			.word	05555h
			.word	06666h
			.word	07777h

			.word	08888h
			.word	09999h
			.word	0AAAAh
			.word	0BBBBh

			.word	0CCCCh
			.word	0DDDDh
			.word	0EEEEh
			.word	0FFFFh

			.space	32

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
; Lab 10.1 - Step 3: Initialize I/O and Registers
			; init LED2 (green)
			mov.b	#000h, &P6SEL0			; clear P6SEL0 and P6SEL1
			mov.b	#000h, &P6SEL1
			bis.b	#BIT6, &P6DIR			; set PxDIR.y = 1
			bic.b	#BIT6, &P6OUT			; clear output PxOUT.y = 0

			; Configure LED1 (red)
			mov.b	#000h, &P1SEL0			; clear P1SEL0 and P1SEL1
			mov.b	#000h, &P1SEL1
			bis.b	#BIT0, &P1DIR			; set PxDIR.y = 1
			bic.b	#BIT0, &P1OUT			; clear output PxOUT.y = 0

			mov.w	#16, R4					; loop counter
			mov.w	#2000h, R5				; pointer to start of datablock


Main:
; Lab 10.1 - Step 4: Create a Program Loop that will push DataBlock onto the Stack
			mov.w	#16, R4					; re init
			mov.w	#2000h, R5

PushLoop:
			cmp.w	#0, R4					; check if R4=0
			jeq		EndPushLoop				; if R4=0 exit loop

			push 	@R5						; push word at address in R5 onto stack
			add.w	#2, R5					; move pointer to next word in datablock

			dec		R4						; dec counter
			jmp 	PushLoop

EndPushLoop:

			mov.w	#16, R4					; re init counter
			mov.w	#2000h, R5

; Lab 10.1 - Step 5: Create a Program to pop datblack from the stack
PopLoop:
			cmp.w	#0, R4					; check if R4=0
			jeq		EndPopLoop				; if R4=0 exit loop

			pop 	0(R5)					; pop top of stack into address in R5
			call 	#Add3					; call Add3 subroutine
			add.w	#2, R5					; move pointer to next word

			dec		R4						;dec counter
			jmp 	PopLoop

EndPopLoop:
			jmp		Main

; Lab 10.1 - Step 7: Use a Subroutine to repeat a function
Add3:
			 add.w	#3, 0(R5)				; add 3 to value at address in R5
			 ret							; return to caller

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
            
