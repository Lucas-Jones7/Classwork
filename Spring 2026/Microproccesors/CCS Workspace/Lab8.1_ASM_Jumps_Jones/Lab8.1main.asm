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
; Lab 8.1 - Step 4: Write code to manipulate Register 4
Main:
			mov.w	#0AAAAh, R4
			jmp		Add5					; jump1 to Add5

SubF:
			sub.w	#0000Fh, R4
			jmp		ToggleAll				; jump3 to ToggleAll

RotateLeft:
			clrc							; clear carry
			rlc.w	R4						; rotate left through carry
			jmp		Done					; jump5 to Done

ToggleAll:
			xor.w	#11111111b, R4			; toggle all bits
			jmp		RotateLeft				; jump4 to RotateLeft

Add5:
			add.w	#00005h, R4
			jmp		SubF					; jump2 to SubF

Done:
			jmp		Main					; Repeat forever
                                            

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
            
