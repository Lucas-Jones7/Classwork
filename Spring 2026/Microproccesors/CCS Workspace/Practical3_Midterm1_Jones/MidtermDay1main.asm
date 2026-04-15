;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template
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
init:
            ; initialize registers
            mov.w   #0AAAAh, R6
            mov.w   #0001h, R7        ; used for scrolling
            mov.w   #0CCCCh, R8
            mov.w   #0DDDDh, R9

;-------------------------------------------------------------------------------
; LED on P6.6
;-------------------------------------------------------------------------------
            mov.b   #00h, &P6SEL0
            mov.b   #00h, &P6SEL1
            bis.b   #BIT6, &P6DIR
            bic.b   #BIT6, &P6OUT

;-------------------------------------------------------------------------------
; Output nibble (P3.0–P3.3)
;-------------------------------------------------------------------------------
            mov.b   #00h, &P3SEL0
            mov.b   #00h, &P3SEL1
            mov.b   #0Fh, &P3DIR
            bic.b   #0Fh, &P3OUT

;-------------------------------------------------------------------------------
; Switch on P2.3
;-------------------------------------------------------------------------------
            bic.b   #BIT3, &P2SEL0
            bic.b   #BIT3, &P2SEL1
            bic.b   #BIT3, &P2DIR
            bis.b   #BIT3, &P2REN
            bis.b   #BIT3, &P2OUT

;-------------------------------------------------------------------------------
; Input nibble (P5.0–P5.3)
;-------------------------------------------------------------------------------
            mov.b   #00h, &P5SEL0
            mov.b   #00h, &P5SEL1
            mov.b   #00h, &P5DIR
            bis.b   #0Fh, &P5REN
            bic.b   #0Fh, &P5OUT

;-------------------------------------------------------------------------------
; Main Program Flow
;-------------------------------------------------------------------------------
main:
while:
            bic.b   #BIT6, &P6OUT
            bic.b   #0Fh, &P3OUT

            mov.b   &P2IN, R5
            cmp.b   #00h, R5
            jz      EndWhile

            jmp     while

EndWhile:
            bis.b   #BIT6, &P6OUT
            jmp     test

;-------------------------------------------------------------------------------
; TEST LOGIC (REQUIRED FUNCTIONALITY)
;-------------------------------------------------------------------------------
test:
            ; read input nibble
            mov.b   &P5IN, R5
            and.b   #0Fh, R5

            cmp.b   #00h, R5
            jz      case0

            cmp.b   #01h, R5
            jz      case1

            jmp     case2

;-----------------------------------
; 0000 output 1111
case0:
            mov.b   #0Fh, &P3OUT
            jmp     test

;-----------------------------------
; 0001  output lower nibble of R8 (CCCC 1100)
case1:
            mov.b   R8, R6
            and.b   #0Fh, R6
            mov.b   R6, &P3OUT
            jmp     test

;-----------------------------------
; 0010  scrolling LEDs using R7
case2:
            mov.b   R7, R6
            and.b   #0Fh, R6
            mov.b   R6, &P3OUT

            ; rotate left with carry
            rlc.b   R7

            ; keep within lower nibble (extra credit behavior)
            and.b   #0Fh, R7
            jnz     skip_reset
            mov.b   #01h, R7
skip_reset:

            call    #Delay
            jmp     test

;-------------------------------------------------------------------------------
; Delay (1 second)
;-------------------------------------------------------------------------------
Delay:
            mov.w   #005h, R4
Delay_outer:
            mov.w   #0FFFFh, R5
Delay_inner:
            dec.w   R5
            jnz     Delay_inner
            dec.w   R4
            jnz     Delay_outer
            ret

;-------------------------------------------------------------------------------
; Data Section
;-------------------------------------------------------------------------------
            .data
            .retain

Const0:     .word   0xBEEF
Const1:     .word   0xDEAD

Var0:       .word   0
Var1:       .word   0

;-------------------------------------------------------------------------------
; Stack Pointer
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack

;-------------------------------------------------------------------------------
; Reset Vector
;-------------------------------------------------------------------------------
            .sect   ".reset"
            .short  RESET
