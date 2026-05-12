;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 7.2, 02/04/2026
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
; Lab 7.2 - Step 3: Initialize Register Values
			mov.w	#0000h, R4				; init the following registers
			mov.w 	#0FFFFh, R5
			mov.w	#0F0F0h, R6
			mov.w	#0BEEFh, R7
			mov.w	#0DEEDh, R8
			mov.w	#0ECEh, R9
			mov.w	#0000h, R10
			mov.w	#1000h, R11


main:
; Lab 7.2 - Step 4: Set or Clear bits within a word using Bit set instruction and a bit mask
			bis.w	#0808h, R4				; R4 = 0808h using bit set
			bis.w	#8001h, R4				; R4 = 8809h

			bic.w	#0420h, R5				; R5 = FBDFh using bit clear
			bic.w 	#8001h, R5				; R5 = 7BDEh

; Lab 7.2 - Step 6: Use the bit test instruction to determine value of a bit
			bit.w	#0001h, R6				; checck if R6.0 is set (its set Z=1)
			bit.w	#8000h, R6				; check if R6.15 is set (its cleared Z=0)
			bit.w	#000Fh, R6				; Check if R6.0-3 are all set (all set Z=1)
			bit.w	#0F000h, R6				; check if R6.12-15 are all set (all cleared Z=0)

; Lab 7.2 - Step 7: Use the compare instruction to check the value of a word
			cmp.w	#0DEEDh, R7				; check if R7 = DEEDh (its not Z=0)
			cmp.w	#0DEEDh, R8				; same for R8 (it is Z=1)
			cmp.w	#0DEEDh, R9				; same for R9 (its not Z=0)

; Lab 7.2 - Step 9: Using the test instruction to determine infomation about a word Z=1 means 0 N=1 means negative
			tst.w	R7						; check if R7 is 0 (its not Z=0)
			tst.w	R10						; check if R10 is 0 (it is Z=1)
			tst.w	R8						; check if R8 is negative (it is N=1)
			tst.w	R9						; check if R9 is negative (its not N=0)

			jmp 	main

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
            
