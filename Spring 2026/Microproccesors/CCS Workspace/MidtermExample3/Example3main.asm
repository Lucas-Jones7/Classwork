;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Practical 4 - Midterm 2 Example 3, 03/10/2026
;
; Hardware:
;   LED1 (RED)  - P1.0  - output
;   S1          - P4.1  - input, active LOW, pull-up (port interrupt)
;   S2          - P2.3  - input, active LOW, pull-up (port interrupt)
;
; Behavior:
;   - TB0 interrupt fires every ~0.5s, TB1 fires every ~2s
;   - In MODE 0 (default):
;       TB0 (~0.5s) toggles LED1 FAST
;       S1 press switches to MODE 1
;   - In MODE 1:
;       TB1 (~2s)   toggles LED1 SLOW
;       S2 press switches back to MODE 0
;   - Mode flag stored in R5 (0 = fast mode, 1 = slow mode)
;   - Only the active mode's ISR drives the LED; the other ISR is a no-op
;
; Timer Setup:
;   TB0 (ACLK, 12-bit, ID_2 = /4): overflow ~0.5s
;   TB1 (ACLK, 12-bit, ID_3 = /8): overflow ~1s, doubled with TBIDEX_1 (/2) = 2s
;
; Register Use:
;   R4  - scratch / delay counter
;   R5  - mode flag (0 = TB0 drives LED, 1 = TB1 drives LED)
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
            mov.w   #0000h, R4
            mov.w   #0000h, R5              ; start in MODE 0 (fast blink)

            ; --- LED1 (RED) P1.0 output ---
            bis.b   #BIT0, &P1DIR
            bic.b   #BIT0, &P1OUT           ; off to start

            ; --- S1 on P4.1: active LOW, pull-up ---
            bic.b   #BIT1, &P4DIR
            bis.b   #BIT1, &P4REN
            bis.b   #BIT1, &P4OUT

            ; --- S2 on P2.3: active LOW, pull-up ---
            bic.b   #BIT3, &P2DIR
            bis.b   #BIT3, &P2REN
            bis.b   #BIT3, &P2OUT

            ; --- Port interrupts (H-to-L = press for both) ---
            bic.b   #BIT1, &P4IFG
            bis.b   #BIT1, &P4IES
            bis.b   #BIT1, &P4IE

            bic.b   #BIT3, &P2IFG
            bis.b   #BIT3, &P2IES
            bis.b   #BIT3, &P2IE

            bic.w   #LOCKLPM5, &PM5CTL0     ; disable high-Z

            ; --- TB0: ACLK, continuous, 12-bit, /4 (~0.5s overflow) ---
            bis.w   #TBCLR, &TB0CTL
            bis.w   #TBSSEL__ACLK, &TB0CTL
            bis.w   #MC__CONTINUOUS, &TB0CTL
            bis.w   #CNTL_1, &TB0CTL        ; 12-bit counter
            bis.w   #ID_2, &TB0CTL          ; divide by 4
            bis.w   #TBIDEX_0, &TB0EX0      ; divide by 1

            bic.w   #TBIFG, &TB0CTL
            bis.w   #TBIE, &TB0CTL          ; overflow interrupt

            ; --- TB1: ACLK, continuous, 12-bit, /8, TBIDEX /2 = /16 (~2s overflow) ---
            bis.w   #TBCLR, &TB1CTL
            bis.w   #TBSSEL__ACLK, &TB1CTL
            bis.w   #MC__CONTINUOUS, &TB1CTL
            bis.w   #CNTL_1, &TB1CTL        ; 12-bit counter
            bis.w   #ID_3, &TB1CTL          ; divide by 8
            bis.w   #TBIDEX_1, &TB1EX0      ; divide by 2 (16 total)

            bic.w   #TBIFG, &TB1CTL
            bis.w   #TBIE, &TB1CTL          ; overflow interrupt

            ; --- Global interrupts ---
            nop
            eint
            nop

;===============================================================================
; MAIN
;===============================================================================
Main:
            jmp     Main                    ; ISRs handle everything

;===============================================================================
; INTERRUPT SERVICE ROUTINES
;===============================================================================

;-------------------------------------------------------------------------------
; ISR_TB0 - TB0 Overflow (~0.5s)
; Toggles LED1 only when in MODE 0 (R5 = 0)
;-------------------------------------------------------------------------------
ISR_TB0:
            cmp.w   #0000h, R5              ; check mode flag
            jne     TB0_Skip                ; if not mode 0, skip toggle
            xor.b   #BIT0, &P1OUT           ; toggle RED LED (fast)
TB0_Skip:
            bic.w   #TBIFG, &TB0CTL         ; clear overflow flag
            reti
;-------------------------------------------------------------------------------
; END ISR_TB0
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_TB1 - TB1 Overflow (~2s)
; Toggles LED1 only when in MODE 1 (R5 = 1)
;-------------------------------------------------------------------------------
ISR_TB1:
            cmp.w   #0001h, R5              ; check mode flag
            jne     TB1_Skip                ; if not mode 1, skip toggle
            xor.b   #BIT0, &P1OUT           ; toggle RED LED (slow)
TB1_Skip:
            bic.w   #TBIFG, &TB1CTL         ; clear overflow flag
            reti
;-------------------------------------------------------------------------------
; END ISR_TB1
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_S1 - S1 Pressed: switch to MODE 1 (slow blink via TB1)
;-------------------------------------------------------------------------------
ISR_S1:
            mov.w   #0001h, R5              ; set mode flag to 1
            bic.b   #BIT0, &P1OUT           ; ensure LED is off during transition
            bic.b   #BIT1, &P4IFG           ; clear S1 flag
            reti
;-------------------------------------------------------------------------------
; END ISR_S1
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_S2 - S2 Pressed: switch to MODE 0 (fast blink via TB0)
;-------------------------------------------------------------------------------
ISR_S2:
            mov.w   #0000h, R5              ; set mode flag to 0
            bic.b   #BIT0, &P1OUT           ; ensure LED is off during transition
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

            .sect   ".int42"                ; TB0 overflow vector
            .short  ISR_TB0

            .sect   ".int40"                ; TB1 overflow vector
            .short  ISR_TB1

            .sect   ".int24"                ; Port 2 / S2 vector
            .short  ISR_S2

            .sect   ".int22"                ; Port 4 / S1 vector
            .short  ISR_S1
