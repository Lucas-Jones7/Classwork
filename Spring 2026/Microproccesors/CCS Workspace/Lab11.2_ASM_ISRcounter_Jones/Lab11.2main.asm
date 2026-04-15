;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Lab 11.2, 02/27/2026
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"
            
            .def    RESET

            .text
            .retain
            .retainrefs

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL

;-------------------------------------------------------------------------------
; Initialization
;-------------------------------------------------------------------------------
Init:
            bic.w   #LOCKLPM5, &PM5CTL0      ; clear high-Z mode

            mov.w   #0000h, R4
            mov.w   #0000h, R5
            mov.b   #00h, R6                 ; 4-bit counter
            mov.w   #0000h, R7

; LED1 (RED) - P1.0
            bis.b   #BIT0, &P1DIR
            bic.b   #BIT0, &P1OUT

; LED2 (GREEN) - P6.6
            bis.b   #BIT6, &P6DIR
            bic.b   #BIT6, &P6OUT

; P3.0-P3.3 outputs (counter display)
            bis.b   #0Fh, &P3DIR
            bic.b   #0Fh, &P3OUT

; Configure S1 (P4.1)
            bic.b   #BIT1, &P4DIR
            bis.b   #BIT1, &P4REN
            bis.b   #BIT1, &P4OUT

; Configure S2 (P2.3)
            bic.b   #BIT3, &P2DIR
            bis.b   #BIT3, &P2REN
            bis.b   #BIT3, &P2OUT

; Port interrupts
            ; S1 - Low to High
            bic.b   #BIT1, &P4IFG
            bic.b   #BIT1, &P4IES
            bis.b   #BIT1, &P4IE

            ; S2 - Low to High
            bic.b   #BIT3, &P2IFG
            bic.b   #BIT3, &P2IES
            bis.b   #BIT3, &P2IE

            ; Enable global interrupts
            nop
            eint
            nop

;-------------------------------------------------------------------------------
; Main Loop - slow green blink
;-------------------------------------------------------------------------------
Main:

BlinkGreen:
            xor.b   #BIT6, &P6OUT

            mov.w   #0006h, R5

LongDelay:
            call    #DelayOnce
            dec.w   R5
            cmp.w   #0000h, R5
            jne     LongDelay

            jmp     Main

;-------------------------------------------------------------------------------
; DelayOnce Subroutine
;-------------------------------------------------------------------------------
DelayOnce:
            mov.w   #0FFFFh, R4
DelayLoop:
            dec.w   R4
            jnz     DelayLoop
            ret

;===============================================================================
; Interrupt Service Routines
;===============================================================================

; S1Released - increment by 1
S1Released:
            bic.b   #BIT1, &P4IFG

            cmp.b   #0Fh, R6
            jge     S1OverflowBlink

            inc.b   R6
            jmp     S1UpdateP3

S1OverflowBlink:
            bis.b   #BIT0, &P1OUT
            call    #DelayOnce
            call    #DelayOnce
            bic.b   #BIT0, &P1OUT
            jmp     S1Released_End

S1UpdateP3:
            bic.b   #0Fh, &P3OUT
            mov.b   R6, R7
            and.b   #0Fh, R7
            bis.b   R7, &P3OUT

S1Released_End:
            reti

; S2Released - decrement by 2
S2Released:
            bic.b   #BIT3, &P2IFG

            cmp.b   #02h, R6
            jl      S2UnderflowBlink

            sub.b   #02h, R6
            jmp     S2UpdateP3

S2UnderflowBlink:
            bis.b   #BIT0, &P1OUT
            call    #DelayOnce
            call    #DelayOnce
            bic.b   #BIT0, &P1OUT
            jmp     S2Released_End

S2UpdateP3:
            bic.b   #0Fh, &P3OUT
            mov.b   R6, R7
            and.b   #0Fh, R7
            bis.b   R7, &P3OUT

S2Released_End:
            reti

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"
            .short  RESET

            .sect   ".int24"
            .short  S2Released

            .sect   ".int22"
            .short  S1Released
