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

; Lab 6.2 - Step 9: Initialize registers with locations of Data Memory
init:
			mov.w	#Const0, R5				; initialize first four addresses into R5-R8
			mov.w	#Const1, R6
			mov.w	#Const2, R7
			mov.w	#Const3, R8

main:

; Lab 6.2 - Step 4: Symbolic Mode Addressing
			mov.w	Const0, Var0			; copy the following data into the first three variables
			mov.w 	Const2, Var1
			mov.w	Const4, Var2

; Lab 6.2 - Step 5: Symbolic Mode Addressing
			mov.w	Const4, Var5			; copy the data from step 4 in revers order into the last the variables
			mov.w	Const2, Var6
			mov.w 	Const0, Var7

; Lab 6.2 - Step 6: Compare Symbolic and Register Addressing
			mov.w	Const1, R4				; copy the data into register four
			mov.w	PC, Var3				; move program counter into the forth reserved Var

; Lab 6.2 - Step 7: Immediate & Symbolic Mode Addressing to Clear Information in Data Memory
			mov.w	#0000h, Const0
			mov.w	#0000h, Const2
			mov.w	#0000h, Const4

; Lab 6.2 - Step 10: Indirect Addressing to move data from memory into registers
			mov.w 	@R5, R9					; move contents of first four locations into registers 9-8
			mov.w 	@R6, R10
			mov.w	@R7, R11
			mov.w	@R8, R12

; Lab 6.2 - Step 11: Load R5-R8 with the last four addresses of the memory block
			mov.w	#Const4, R5				; load R5-R8 with last 4 memory addresses
			mov.w 	#Const5, R6
			mov.w	#Const6, R7
			mov.w	#Const7, R8

; Lab 6.2 - Step 12: Load R9-R12 with data from last four locations of memory block
			mov.w 	@R5, R9					; same block of code from step 10
			mov.w 	@R6, R10
			mov.w	@R7, R11
			mov.w	@R8, R12

			jmp		main

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

			.data							; Allocate variables in data memory
			.retain							; Keep these statements even if not used

; Lab 6.2 - Step 3: Initialize and Reserve Locations in data memory
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
            
