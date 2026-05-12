;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 6.1, 01/26/2026
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

main:
; Lab 6.1 - Step 3: Immediate Mode Addressing
			mov.w	#4444h, R4				; puts the following values into the following registers
			mov.w	#5555h, R5
			mov.w	#6666h, R6

; Lab 6.1 - Step 4: Immediate Mode Addressing
			mov.w	#0000h, R4				; clears the values of the following registers
			mov.w 	#0000h, R5
			mov.w	#0000h, R6

; Lab 6.1 - Step 5: Immediate Mode Addressing
			mov.b	#77h, R7				; puts the following values into the following registers
			mov.b	#88h, R8
			mov.b	#99h, R9

; Lab 6.1 - Step 7: Register Mode Addressing
			mov.b	R7, R10					; copies the contests of R7-R9 to R10-R12
			mov.b	R8, R11
			mov.b	R9, R12

; Lab 6.1 - Step 8: Register Mode Adressing
			mov.w	SP, R13					; inserts value of stack pointer into R13
			mov.w	PC, R14					; program counter value to R14

; Lab 6.1 - Step - 11: Absolut Mode Addressing
			mov.w   &0x2002, &0x2022
            mov.w   &0x2004, &0x2024
            mov.w   &0x2006, &0x2026
            mov.w   &0x2008, &0x2028
            mov.w   &0x200A, &0x202A

            mov.b   &0x2011, &0x2023
            mov.b   &0x2012, &0x2024
            mov.b   &0x2013, &0x2025
            mov.b   &0x2014, &0x2026
            mov.b   &0x2016, &0x2027

			jmp 	main

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------
; Lab 6.1 - Step 10: Initialize and Reserve locations in data memory
			.data
			.retain

Data: 		.word 	0000h,1111h,2222h,3333h,4444h,5555h,6666h,7777h,8888h,9999h,0AAAAh,0BBBBh,0CCCCh,0DDDDh,0EEEEh,0FFFFh

			.space	32

Byte: 		.byte 	01h,23h,45h,67h,89h,0ABh,0CDh,0EFh

			.space 	8

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
            
