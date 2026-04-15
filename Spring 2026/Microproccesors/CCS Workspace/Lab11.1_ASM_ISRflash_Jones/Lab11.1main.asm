;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 11.1, 02/25/2026
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
; Lab 11.1 - Step 2: Prepare the main.asm file
Init:
			mov.w	#0000h, R4				; clear the following registers for later use
			mov.w	#0000h, R5
			mov.w	#0000h, R6
			mov.w	#0000h, R7

			; configure led1
			bic.b	#BIT0, &P1DIR			; clear first
			bis.b	#BIT0, &P1DIR			; set P1.0 as output
			bic.b	#BIT0, &P1OUT			; LED1 off to start

			; configure led2
			bic.b	#BIT6, &P6DIR			; clear first
			bis.b	#BIT6, &P6DIR			; set P1.0 as output
			bic.b	#BIT6, &P6OUT			; LED1 off to start

			; configure S1
            bic.b   #BIT1, &P4DIR       	; P4.1 = input
            bis.b   #BIT1, &P4REN       	; enable pull resistor
            bis.b   #BIT1, &P4OUT       	; pull-up

            ; configure S2
            bic.b   #BIT3, &P2DIR       	; P2.3 = input
            bis.b   #BIT3, &P2REN       	; enable pull resistor
            bis.b   #BIT3, &P2OUT       	; pull-up

			; Port Interupts
            ; S1 on P4.1 – trigger High-to-Low (press)
            bic.b   #BIT1, &P4IFG       	; clear P4.1 interrupt flag
            bis.b   #BIT1, &P4IES       	; H-to-L edge select
            bis.b   #BIT1, &P4IE        	; enable P4.1 interrupt

            ; S2 on P2.3 – trigger Low-to-High (release)
            bic.b   #BIT3, &P2IFG       	; clear P2.3 interrupt flag
            bic.b   #BIT3, &P2IES       	; L-to-H edge select (0 = rising)
            bis.b   #BIT3, &P2IE        	; enable P2.3 interrupt

            bic.w   #LOCKLPM5, &PM5CTL0 	; clear high z mode

            ; Enable Global Interrupts
            nop
            eint
            nop

Main:

BlinkRed:
            xor.b   #BIT0, &P1OUT       ; toggle RED LED

            mov.w   #0x0006, R5         ; 6 repetitions

LongDelay:
            call    #DelayOnce          ; call full FFFFh delay
            dec.w   R5
            cmp.w   #0x0000, R5
            jne     LongDelay           ; if R5=0 exit loop
; ------------------------------ END BlinkRed --------------------------------

			jmp		Main

; --------------------------------- END MAIN ----------------------------------

;-------------------------------------------------------------------------------
; DelayOnce Subroutine
;-------------------------------------------------------------------------------
DelayOnce:
            mov.w   #0xFFFF, R4         ; load max count
DelayLoop:
            dec.w   R4
            jnz     DelayLoop           ; loop until 0
            ret
;---------- End DelayOnce -------------------------------------------------------


;------------------------------------------------------------------------------
; Interrupt Service Routines
;------------------------------------------------------------------------------

; Service S1
Switch1Triggered:
            xor.b   #BIT6, &P6OUT       ; toggle green LED
            bic.b   #BIT1, &P4IFG       ; clear P4.1 interrupt flag
            reti
;------------------------- END Switch1Triggered -------------------------------

; Service S2
Switch2Released:
            mov.w   R5, R6              ; save R5 to R6
            mov.w   #0x0005, R5         ; blink green LED 5 times
BlinkGreen:
            bis.b   #BIT6, &P6OUT       ; green on
            call    #DelayOnce
            call    #DelayOnce
            call    #DelayOnce
            bic.b   #BIT6, &P6OUT       ; green off
            call    #DelayOnce
            call    #DelayOnce
            call    #DelayOnce
            dec.w   R5
            jnz     BlinkGreen

            bic.b   #BIT6, &P6OUT       ; ensure green is off
            mov.w   R6, R5              ; restore R5
			bic.b   #BIT3, &P2IFG       ; clear P2.3 interrupt flag
            reti
;---------- END Switch2Released -------------------------------------------------


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
            
            .sect	".int24"				; port 2 interupt vector
            .short	Switch2Released

            .sect	".int22"				; port 4 interupt vector
            .short	Switch1Triggered



