;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Practical 1, 02/04/2026
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
; Practical 1 - Step 4: Enter Move Instructions to Show Understanding of Addresssing Modes
			mov.w	#2000h, R4				; put the value 2000h into R4 Using Immediate for src and Register mode for dst
			mov.w	R4, R5					; copy contents of R4 to R5 using Register Mode
			mov.w	#Var1, R6				; Init R6 to the address of Var1 Using Immediate mode with addrlabel and register mode



main:
; Practical 1 - Step 4: Enter Move Instructions to Show Understanding of Addresssing Modes
			mov.w	&2000h, R7				; copy contents at address 2000h into R7 using absolute and register mode
			mov.w	Con2, R8				; copy contents at label Con2 to R8 using symbolic and register mode
			mov.w	@R4, R9					; copy contents located at address held in R4 to R9 using Indirect register and register mode
			mov.w	@R5+, R10				; copy data at addr held in R5 into R10, then increment address by 2 using autoincrement and register mode
			mov.w	@R5+, R11				; same as above just starting at a different address increment
			mov.w	2(R4), 4(R6)			; copy conw into the 3rd word of Var1 block usring R4 and R5 indexed mode addressing

			jmp 	main

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

; Practical 1 - Step 3: Prepare main.asm file and Data Allocation
			.data
			.retain

Con1:		.short	0ACEDh
Con2:		.short	0BEEFh

Var1:		.space	28

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
            
