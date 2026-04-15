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

; Lab 7.3 - Step 2: Prepare the main.asm file
init:
; Lab 7.3 - Step 3: Initialize Register Values
			mov.w	#0000h, R4				; init the following register values
			mov.w 	#0FFFFh, R5
			mov.w	#0F0F0h, R6
			mov.w	#0BEEFh, R7
			mov.w	#0DEEDh, R8
			mov.w	#0ECEh, R9
			mov.w	#0000h, R10
			mov.w	#1000h, R11

main:
; Lab 7.3 - Step 4: Using Rotate instructions to move the locations of a bit within a word
			clrc
			rla.w	R11						; steps 1-4 rotate bit let arithimetically
			rla.w	R11
			rla.w	R11
			rla.w	R11

			rrc.w	R11						; rotate bit right through carry

			rra.w	R11						; steps 6-8 rotate bit right arithmetically
			rra.w	R11
			rra.w	R11

			rlc.w	R11						; step 9 rotate bit left through carry

			rlc.w	R11						; step 10-12 rotate bits right through carry
			rlc.w	R11
			rlc.w	R11

			rlc.w 	R11						; step 13 rotate bits left through carry

			rra.w	R11						; steps 14 rotate bits right arithmitecally

			rrc.w	R11						; steps 15-18 rotate bits right through carry
			rrc.w	R11
			rrc.w	R11

			rrc.w	R11						; rotate bits right through carry

; Lab 7.3 - Part 5: Take the average of a set of numbers
            mov.w   #0, R12                 ; Initialize R12 for summation
            add.w   #8, R12                 ; R12 = 8
            add.w   #50, R12                ; R12 = 58
            add.w   #78, R12                ; R12 = 136
            add.w   #40, R12                ; R12 = 176


            clrc                            ; Clear carry before rotate
            rrc.w   R12                     ; R12 = 88
            clrc                            ; Clear carry before rotate
            rrc.w   R12                     ; R12 = 44 = 2Ch

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
            
