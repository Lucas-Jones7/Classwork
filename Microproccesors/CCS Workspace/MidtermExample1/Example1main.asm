;-------------------------------------------------------------------------------
; Timer Calculations:
; 	* Always solving for N or for dividers(ID/TBIDEX)
;	* ACLK = 32,768hz SMCLK = 1,000,000hz
;	* Overflow timers (N is fixed by counter length so just solve for divider)
;	* Compare timers (pick dividers first, then solve for N = CCR0 then set CCRO to N - 1)
;	* PWM timers (CCR0 = period, CCR1 = on time, 1ms period 10% duty cycle = CCR0=999, CCR1=99
;	* KEY INSIGHT:
;		# In overflow mode you're choosing N by picking counter length then solving for the divider.
;		# Compare/PWM mode you pick divider first, then solve for N and put into CCR0.
;		# pick divider such that (clock frequency)/(dividers) is within 0 to 65,535
;		# for PWM once you have CCR0 CCR1 is just a % of it
;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lucas Jones, EELE 371, Practical 4 - Midterm 2 Example 1, 03/10/2026
;
; Hardware:
;   LED1 (RED)  - P1.0  - output
;   S1          - P4.1  - input, active LOW, pull-up
;   S2          - P2.3  - input, active LOW, pull-up
;
; Behavior:
;   - Main loop: RED LED blinks using TB0 timer overflow interrupt (~1s period)
;   - S1 pressed (port interrupt): doubles the blink rate (halves the divider)
;   - S2 pressed (port interrupt): halves the blink rate (doubles the divider)
;   - TB0 ISR toggles LED1 each overflow
;
; Register Use:
;   R4  - general scratch / DelayOnce counter
;   R5  - current timer divider step (1-3, maps to ID_0/1/2)
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
            mov.w   #0002h, R5              ; start at mid-speed (ID_2 = /4)

            ; --- LED1 (RED) P1.0 output ---
            bis.b   #BIT0, &P1DIR
            bic.b   #BIT0, &P1OUT           ; off to start

            ; --- S1 on P4.1: active LOW, pull-up ---
            bic.b   #BIT1, &P4DIR           ; input
            bis.b   #BIT1, &P4REN           ; resistor enable
            bis.b   #BIT1, &P4OUT           ; pull-up

            ; --- S2 on P2.3: active LOW, pull-up ---
            bic.b   #BIT3, &P2DIR           ; input
            bis.b   #BIT3, &P2REN           ; resistor enable
            bis.b   #BIT3, &P2OUT           ; pull-up

            ; --- Port Interrupts ---
            ; S1 - trigger on H-to-L (press)
            bic.b   #BIT1, &P4IFG           ; clear flag
            bis.b   #BIT1, &P4IES           ; H-to-L edge
            bis.b   #BIT1, &P4IE            ; enable interrupt

            ; S2 - trigger on H-to-L (press)
            bic.b   #BIT3, &P2IFG           ; clear flag
            bis.b   #BIT3, &P2IES           ; H-to-L edge
            bis.b   #BIT3, &P2IE            ; enable interrupt

            bic.w   #LOCKLPM5, &PM5CTL0     ; disable high-Z

            ; --- Timer TB0: ACLK, continuous, 12-bit, ID_2 (/4) ---
            bis.w   #TBCLR, &TB0CTL         ; clear timer and dividers
            bis.w   #TBSSEL__ACLK, &TB0CTL  ; ACLK source
            bis.w   #MC__CONTINUOUS, &TB0CTL
            bis.w   #CNTL_1, &TB0CTL        ; 12-bit counter
            bis.w   #ID_2, &TB0CTL          ; divide by 4 (mid speed)
            bis.w   #TBIDEX_0, &TB0EX0      ; divide by 1

            ; --- TB0 overflow interrupt ---
            bic.w   #TBIFG, &TB0CTL         ; clear flag
            bis.w   #TBIE, &TB0CTL          ; enable overflow interrupt

            ; --- Enable global interrupts ---
            nop
            eint
            nop

;===============================================================================
; MAIN
;===============================================================================
Main:
            jmp     Main                    ; background loop - ISRs do the work

;===============================================================================
; INTERRUPT SERVICE ROUTINES
;===============================================================================

;-------------------------------------------------------------------------------
; ISR_TB0 - Timer B0 Overflow
; Toggles LED1 on each timer overflow (~1s at default settings)
;-------------------------------------------------------------------------------
ISR_TB0:
            xor.b   #BIT0, &P1OUT           ; toggle RED LED
            bic.w   #TBIFG, &TB0CTL         ; clear overflow flag
            reti
;-------------------------------------------------------------------------------
; END ISR_TB0
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_S1 - S1 Pressed (P4.1 H-to-L)
; Increases blink rate by increasing the timer divider step (up to max)
;-------------------------------------------------------------------------------
ISR_S1:
            cmp.w   #0003h, R5              ; check if already at max speed (ID_3)
            jge     S1_AtLimit              ; if at limit, skip

            inc.w   R5                      ; increment speed step

            ; rebuild TB0CTL with new divider
            bis.w   #TBCLR, &TB0CTL         ; clear timer and dividers
            bis.w   #TBSSEL__ACLK, &TB0CTL
            bis.w   #MC__CONTINUOUS, &TB0CTL
            bis.w   #CNTL_1, &TB0CTL
            ; apply new ID based on R5
            call    #ApplyDivider

            bic.w   #TBIFG, &TB0CTL
            bis.w   #TBIE, &TB0CTL
            jmp     S1_Done

S1_AtLimit:
            ; optional: flash to indicate limit reached (no change)
S1_Done:
            bic.b   #BIT1, &P4IFG           ; clear flag
            reti
;-------------------------------------------------------------------------------
; END ISR_S1
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ISR_S2 - S2 Pressed (P2.3 H-to-L)
; Decreases blink rate by decreasing the timer divider step (down to min)
;-------------------------------------------------------------------------------
ISR_S2:
            cmp.w   #0001h, R5              ; check if already at min speed (ID_0)
            jle     S2_AtLimit

            dec.w   R5                      ; decrement speed step

            bis.w   #TBCLR, &TB0CTL
            bis.w   #TBSSEL__ACLK, &TB0CTL
            bis.w   #MC__CONTINUOUS, &TB0CTL
            bis.w   #CNTL_1, &TB0CTL
            call    #ApplyDivider

            bic.w   #TBIFG, &TB0CTL
            bis.w   #TBIE, &TB0CTL
            jmp     S2_Done

S2_AtLimit:
S2_Done:
            bic.b   #BIT3, &P2IFG           ; clear flag
            reti
;-------------------------------------------------------------------------------
; END ISR_S2
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; ApplyDivider - Subroutine
; Applies ID divider bits to TB0CTL based on value in R5 (1=ID_0, 2=ID_1, 3=ID_2)
;-------------------------------------------------------------------------------
ApplyDivider:
            cmp.w   #0001h, R5
            jne     TryTwo
            bis.w   #ID_0, &TB0CTL
            ret
TryTwo:
            cmp.w   #0002h, R5
            jne     TryThree
            bis.w   #ID_1, &TB0CTL
            ret
TryThree:
            bis.w   #ID_2, &TB0CTL
            ret
;-------------------------------------------------------------------------------
; END ApplyDivider
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

            .sect   ".int24"                ; Port 2 / S2 vector
            .short  ISR_S2

            .sect   ".int22"                ; Port 4 / S1 vector
            .short  ISR_S1
