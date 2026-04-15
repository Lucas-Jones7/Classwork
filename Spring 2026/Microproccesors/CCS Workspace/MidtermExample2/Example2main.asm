;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Practical 4 - Midterm 2 Example 2, 03/10/2026
;
; Hardware:
;   LED1 (RED)  - P1.0  - output, driven by TB0 PWM (CCR0/CCR1)
;   S1          - P4.1  - input, active LOW, pull-up (port interrupt)
;   S2          - P2.3  - input, active LOW, pull-up (port interrupt)
;
; Behavior:
;   - LED1 blinks via TB0 up-mode compare interrupts (PWM-style, ~1s period)
;   - S1 press (port interrupt): increases ON-time duty cycle by one step
;     (if already at max, RED flashes briefly to indicate limit)
;   - S2 press (port interrupt): decreases ON-time duty cycle by one step
;     (if already at min, RED flashes briefly to indicate limit)
;
; Timer Setup (TB0, SMCLK @ 1MHz, /64 total, up to CCR0):
;   Period    : CCR0 = 15624  -> 1s
;   ON-time   : CCR1 = duty cycle value
;   Step size : 1562 counts ~= 10% of period
;   Min duty  : 1562  (10%)
;   Max duty  : 14062 (90%)
;
; Register Use:
;   R4  - scratch / DelayOnce counter
;   R6  - current CCR1 value (duty cycle)
;   R7  - step size (1562)
;   R8  - minimum duty cycle (1562)
;   R9  - maximum duty cycle (14062)
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"
            .def    RESET
            .text
            .retain
            .retainrefs

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL

;===============================================================================
; INIT
;===============================================================================
Init:
            ; --- Register initialization ---
            mov.w   #0000h, R4
            mov.w   #7812,  R6              ; starting duty cycle (~50%)
            mov.w   #1562,  R7              ; step size (~10%)
            mov.w   #1562,  R8              ; minimum (10%)
            mov.w   #14062, R9              ; maximum (90%)

            ; --- LED1 (RED) P1.0 output ---
            bis.b   #BIT0, &P1DIR
            bis.b   #BIT0, &P1OUT           ; on to start (CCR0 ISR turns on)

            ; --- S1 on P4.1: active LOW, pull-up ---
            bic.b   #BIT1, &P4DIR
            bis.b   #BIT1, &P4REN
            bis.b   #BIT1, &P4OUT

            ; --- S2 on P2.3: active LOW, pull-up ---
            bic.b   #BIT3, &P2DIR
            bis.b   #BIT3, &P2REN
            bis.b   #BIT3, &P2OUT

            ; --- Port interrupts (H-to-L = press) ---
            bic.b   #BIT1, &P4IFG
            bis.b   #BIT1, &P4IES
            bis.b   #BIT1, &P4IE

            bic.b   #BIT3, &P2IFG
            bis.b   #BIT3, &P2IES
            bis.b   #BIT3, &P2IE

            bic.w   #LOCKLPM5, &PM5CTL0     ; disable high-Z

            ; --- TB0: SMCLK, up mode, /64, CCR0=15624 ---
            mov.w   #15624, &TB0CCR0        ; 1s period
            mov.w   R6, &TB0CCR1            ; initial duty cycle

            bis.w   #TBCLR, &TB0CTL
            bis.w   #TBSSEL__SMCLK, &TB0CTL
            bis.w   #MC__UP, &TB0CTL
            bis.w   #CNTL_0, &TB0CTL        ; 16-bit
            bis.w   #ID_3, &TB0CTL          ; divide by 8
            bis.w   #TBIDEX_7, &TB0EX0      ; divide by 8 (64 total)

            ; --- TB0 compare interrupts ---
            bic.w   #CCIFG, &TB0CCTL0       ; clear flags
            bis.w   #CCIE, &TB0CCTL0        ; CCR0 interrupt on
            bic.w   #CCIFG, &TB0CCTL1
            bis.w   #CCIE, &TB0CCTL1        ; CCR1 interrupt on

            ; --- Global interrupts ---
            nop
            eint
            nop

;===============================================================================
; MAIN
;===============================================================================
Main:
            jmp     Main

;===============================================================================
; INTERRUPT SERVICE ROUTINES
;===============================================================================

;-------------------------------------------------------------------------------
; ISR_TB0_CCR0 - Timer B0 CCR0 (end of period)
; Turns LED1 ON at the start of each new period
;-------------------------------------------------------------------------------
ISR_TB0_CCR0:
            bis.b   #BIT0, &P1OUT           ; LED on (start of period)
            bic.w   #CCIFG, &TB0CCTL0       ; clear CCR0 flag
            reti
;-------------------------------------------------------------------------------
; END ISR_TB0_CCR0
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_TB0_CCR1 - Timer B0 CCR1 (end of ON time)
; Turns LED1 OFF after duty cycle expires
;-------------------------------------------------------------------------------
ISR_TB0_CCR1:
            bic.b   #BIT0, &P1OUT           ; LED off (end of on-time)
            bic.w   #CCIFG, &TB0CCTL1       ; clear CCR1 flag
            reti
;-------------------------------------------------------------------------------
; END ISR_TB0_CCR1
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_S1 - S1 Pressed: increase duty cycle by one step
; If at maximum, briefly flash to indicate limit
;-------------------------------------------------------------------------------
ISR_S1:
            push    R15
            mov.w   R6, R15
            add.w   R7, R15                 ; proposed new duty = R6 + step

            cmp.w   R9, R15                 ; compare to max
            jhs     S1_AtMax                ; if >= max, at limit

            add.w   R7, R6                  ; update duty cycle register
            mov.w   R6, &TB0CCR1            ; write to timer
            jmp     S1_Done

S1_AtMax:
            ; flash to indicate limit
            bic.b   #BIT0, &P1OUT
            call    #DelayOnce
            bis.b   #BIT0, &P1OUT

S1_Done:
            pop     R15
            bic.b   #BIT1, &P4IFG           ; clear S1 flag
            reti
;-------------------------------------------------------------------------------
; END ISR_S1
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_S2 - S2 Pressed: decrease duty cycle by one step
; If at minimum, briefly flash to indicate limit
;-------------------------------------------------------------------------------
ISR_S2:
            push    R15
            mov.w   R6, R15
            sub.w   R7, R15                 ; proposed new duty = R6 - step

            cmp.w   R8, R15                 ; compare to min
            jlo     S2_AtMin                ; if < min, at limit

            sub.w   R7, R6                  ; update duty cycle register
            mov.w   R6, &TB0CCR1            ; write to timer
            jmp     S2_Done

S2_AtMin:
            ; flash to indicate limit
            bic.b   #BIT0, &P1OUT
            call    #DelayOnce
            bis.b   #BIT0, &P1OUT

S2_Done:
            pop     R15
            bic.b   #BIT3, &P2IFG           ; clear S2 flag
            reti
;-------------------------------------------------------------------------------
; END ISR_S2
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; DelayOnce - Subroutine
; Busy-wait delay loop (~65ms at 1MHz)
;-------------------------------------------------------------------------------
DelayOnce:
            mov.w   #0FFFFh, R4
DelayLoop:
            dec.w   R4
            jnz     DelayLoop
            ret
;-------------------------------------------------------------------------------
; END DelayOnce
;-------------------------------------------------------------------------------

;===============================================================================
; Stack Pointer
;===============================================================================
            .global __STACK_END
            .sect   .stack

;===============================================================================
; Interrupt Vectors
;===============================================================================
            .sect   ".reset"
            .short  RESET

            .sect   ".int43"                ; TB0 CCR0 vector
            .short  ISR_TB0_CCR0

            .sect   ".int42"                ; TB0 CCR1 vector
            .short  ISR_TB0_CCR1

            .sect   ".int24"                ; Port 2 / S2 vector
            .short  ISR_S2

            .sect   ".int22"                ; Port 4 / S1 vector
            .short  ISR_S1
