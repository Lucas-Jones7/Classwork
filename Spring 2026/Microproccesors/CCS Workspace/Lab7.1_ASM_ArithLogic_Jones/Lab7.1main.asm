;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 6.1, 01/28/2026
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
;	Expected Values for step 4:
;		Add1 - 1110, V=0 N=0 Z=0 C=0
;		Add2 - FFFE, V=0 N=1 Z=0 C=1
;		Add3 - AAAA, V=1 N=1 Z=0 C=0
;		Add4 - 1000, V=0 N=0 Z=1 C=1
;
;	Expected Values for step 4:
;		sub1 - 6666, V=1 N=0 Z=0 C=1
;		sub2 - 999A, V=1 N=1 Z=0 C=0
;		sub3 - 0000, V=0 N=0 Z=1 C=1
;		sub4 - DDDD, V=0 N=1 Z=0 C=0
;-------------------------------------------------------------------------------

main:
; Lab 7.1 - Step 4: Perform 16-bit additions
			mov.w	AddendA, R4  			; move value labeled by AddendA into R4
			add.w	AddendB, R4				; add AddendB to the value in R4
			mov.w	R4, SumAB				; move value in R4 to SumAB reserved spot in memory


			mov.w	AddendC, R4
			add.w 	AddendD, R4
			mov.w	R4, SumCD

			mov.w	AddendE, R4
			add.w	AddendF, R4
			mov.w	R4, SumEF

			mov.w	AddendG, R4
			add.w	AddendH, R4
			mov.w 	R4, SumGH

; Lab 7.1 - Step 6: Perform 16-bit subtractions
			mov.w	MinuendA, R5
			sub.w	SubB, R5
			mov.w	R5, DiffAB

			mov.w	MinuendC, R5
			sub.w	SubD, R5
			mov.w	R5, DiffCD

			mov.w	MinuendE, R5
			sub.w	SubF, R5
			mov.w	R5, DiffEF

			mov.w	MinuendG, R5
			sub.w	SubH, R5
			mov.w	R5, DiffGH

; Lab 7.1 - Step 9: Perform 32-bit Arithmetic Operations
			mov.w	#Input1, R4				; addresses
			mov.w	#Input2, R5
			mov.w	#Sum12, R6

			mov.w	0(R4), R8				; low words
			mov.w	0(R5), R9
			add.w	R8, R9
			mov.w 	R9, 0(R6)

			mov.w	2(R4), R10				; high words
			mov.w 	2(R5), R11
			addc.w	R10, R11
			mov.w	R11, 2(R6)

; Lab 7.1 - Step 11: Clear registers R3-R5
			mov.w	#0000h, R3
			mov.w	#0000h, R4				; clears the following registers in preperation for demo 1
			mov.w	#0000h, R5

; Lab 7.1 - Step 12: Clear bits within a word using and operation
			mov.w 	#0FFh, R4				; start = 1111 1111

			and.b	#11111110b, R4			; clear bit 0
			and.b	#01111111b, R4			; clear bit 7
			and.b	#01111110b, R4			; clear two bits

; Lab 7.1 - Step 13: set bits within a word using OR operation
			or.b	#00000001b, R4			; set bit 0
			or.b	#10000000b, R4 			; set bit 7
			or.b	#10000001b, R4			;set reamaining bits

; Lab 7.1 - Step 14: toggling bits within a word using XOR operation
			xor.b	#00001111b, R4			; toggle 0-3
			xor.b 	#00111100b, R4			; toggle 2-5
			xor.b	#11110000b, R4			; toggle 4-7

			jmp		main
                                            
;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

			.data
			.retain

; Lab 7.1 - Step 2 Initialize data and reserve memory locations

AddendA:	.word	05555h 					; initiaize data and reserve memory locations for demo 1
AddendB		.word	0BBBBh
SumAB:		.word	00000h
AddendC:	.word	0FFFFh
AddendD:	.word	0FFFFh
SumCD:		.word	00000h
AddendE:	.word	05555h
AddendF:	.word	05555h
SumEF:		.word 	00000h
AddendG:	.word	00002h
AddendH: 	.word	0FFFEh
SumGH:		.word	00000h

			.space	8

MinuendA: 	.word	0BBBBh
SubB:     	.word	05555h
DiffAB:		.word	00000h
MinuendC:	.word	05555h
SubD:		.word	0BBBBh
DiffCD:		.word	00000h
MinuendE: 	.word	05555h
SubF:     	.word	05555h
DiffEF:		.word	00000h
MinuendG:	.word	02222h
SubH:		.word	04444h
DiffGH:		.word	00000h

			.space 	8

Input1: 	.long 	055555BBBh
Input2:		.long	0BBBBB555h
Sum12: 		.space 	4
Diff12:		.space	4

			.space	16

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
            
