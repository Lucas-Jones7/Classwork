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
;-------------------------------------------------------------------------------

init:

; Lab 6.3 - Step 4: Immediate Mode to Clear CPU Registers R4-R15
			mov.w	#0000h, R4				; clears the following registers in preperation for demo 1
			mov.w	#0000h, R5
			mov.w	#0000h, R6
			mov.w	#0000h, R7
			mov.w	#0000h, R8
			mov.w	#0000h, R9
			mov.w	#0000h, R10
			mov.w	#0000h, R11
			mov.w	#0000h, R12
			mov.w	#0000h, R13
			mov.w	#0000h, R14
			mov.w	#0000h, R15

main:
; Lab 6.3 Step 5: Load R7 with Starting Address of the Memory Block
			mov.w	#Const5, R7				; move memory address of memory block containg FADE to R7

; Lab 6.3 Step 6: Copy Contents of Memory Block into R8-R13 using Indirect Autoincrement Mode
			mov.w	@R7+, R8				; copy contents in memory to R8-R13
			mov.w 	@R7+, R9
			mov.w 	@R7+, R10
			mov.w	#Const0, R7
			mov.w 	@R7+, R11
			mov.w 	@R7+, R12
			mov.w 	@R7+, R13

; Lab 6.3 Step 8: Initialize Registers for Indexed Addressing
			mov.w	#Const0, R4				; loads following registers with address of DEAD(Const0) and Var
			mov.w	#Var0, R5

; Lab 6.3 - Step 9: Copy Block1 to Block 2 in the Original Order
			mov.w	0(R4), 0(R5)			; loads data held in memory address held in register to memory addres stored in other register
			mov.w	2(R4), 2(R5)
			mov.w	4(R4), 4(R5)
			mov.w	6(R4), 6(R5)

; Lab 6.3 - Step 10: Clear Block2
			mov.w	#0000h, 0(R5) 			; clears block 2 of memory
			mov.w	#0000h, 2(R5)
			mov.w	#0000h, 4(R5)
			mov.w	#0000h, 6(R5)

; Lab 6.3 - Step 11: Copy Block 1 to Block2 in Reverse Order
			mov.w	0(R4), 6(R5)			; same as step 9 just reversed
			mov.w	2(R4), 4(R5)
			mov.w	4(R4), 2(R5)
			mov.w	6(R4), 0(R5)

; Lab 6.3 - Step 12: Clear Block2 Again
			mov.w	#0000h, 0(R5) 			; clears block 2 of memory
			mov.w	#0000h, 2(R5)
			mov.w	#0000h, 4(R5)
			mov.w	#0000h, 6(R5)

			jmp		main

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

			.data
			.retain

; Lab 6.3 - Step 3: Initialize and Reserve Locations in data memory
Const0:		.word	0xDEAD					; init 8 16-bit words
Const1:		.word	0xBEEF
Const2:		.word	0xBABE
Const3:		.word	0xFACE
Const4:		.word	0xDEAF
Const5:		.word	0xFADE
Const6: 	.word   0xDEED
Const7:		.word	0xACED

Var0:		.word	0						; reserves enough memory for 8 16-bit words
Var1:		.word	0
Var2:		.word	0
Var3:		.word	0
Var4:		.word	0
Var5:		.word	0
Var6:		.word	0
Var7:		.word	0
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
            
