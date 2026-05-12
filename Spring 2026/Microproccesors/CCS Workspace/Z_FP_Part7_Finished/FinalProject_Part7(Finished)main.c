//-----------------------------------------------------
// Lucas Jones, EELE 371, Final Project Part 7, 04/20/2026
//
// Motor: Adafruit 858, 5VDC, 32-step, 1/16 gearing
//
// Steps per full rotation: 32 * 16 = 512 steps
//
// Reverse (SW2) - max speed:
//   Max RPM = 25 RPM @ 5V
//   Min pulse width = (60s/25RPM) / 512 steps = 0.469ms -> use 0.5ms
//   SMCLK / ID__4 / TBIDEX__4 = 62,500 Hz
//   CCR0 = 31 (62,500 * 0.0005 = 31.25 -> 31)
//   Expected time for 1 rotation = 512 * 0.5ms = 256ms
//
// Forward (SW1) - 36 degrees per press:
//   Steps per press = 512 / 10 = 51 steps
//   Target time = 50% of 256ms = 128ms
//   Pulse width = 128ms / 51 = 2.5ms
//   CCR0 = 156 (62,500 * 0.0025 = 156.25 -> 156)
//-----------------------------------------------------

#include <msp430.h>

// global vars
volatile int timerFlag = 0;

char revMsg[] = "Motor reversed 1 rotation.\r\n";
char fwdMsg[] = "Motor advanced 1 step.\r\n";

unsigned int position   = 0;
unsigned int msgLen     = 0;
volatile unsigned int sending = 0;  // 1 = currently sending
char* currentMsg;

// step sequences for CW and CCW rotation
const unsigned char stepCCW[4]  = {BIT0, BIT1, BIT2, BIT3};
const unsigned char stepCW[4] = {BIT3, BIT2, BIT1, BIT0};

//--------------------------- MAIN LOOP ---------------------------------------

int main(void)
{
    int i;             // var for for loops

    WDTCTL = WDTPW | WDTHOLD;      // stop watchdog timer

    // put USCI_A1 into software reset
    UCA1CTLW0 |= UCSWRST;

    // configure USCI_A1
    UCA1CTLW0 |= UCSSEL__SMCLK;    // clock source SMCLK
    UCA1BRW = 17;                   // baud rate settings for 57600
    UCA1MCTLW = 0x4A00;            // settings from baud rate table

    // config P3.0-P3.3 as outputs for stepper coils
    P3DIR |= BIT0 | BIT1 | BIT2 | BIT3;
    P3OUT &= ~(BIT0 | BIT1 | BIT2 | BIT3);     // all coils off to start

    // config S1
    P4DIR &= ~BIT1;             // S1 input
    P4REN |= BIT1;              // enable resistor
    P4OUT |= BIT1;              // pull up
    P4IES |= BIT1;              // falling edge

    // config S2
    P2DIR &= ~BIT3;             // S2 input
    P2REN |= BIT3;              // enable resistor
    P2OUT |= BIT3;              // pull up
    P2IES |= BIT3;              // falling edge

    // config UART pins
    P4SEL1 &= ~(BIT3 | BIT2);  // UART pins
    P4SEL0 |= (BIT3 | BIT2);

    PM5CTL0 &= ~LOCKLPM5;       // enable gpio

    // take USCI_A1 out of software reset
    UCA1CTLW0 &= ~UCSWRST;

    // config timer
    TB0CTL   = TBCLR;               // clear timer and dividers
    TB0CTL  |= TBSSEL__SMCLK;       // clock source SMCLK
    TB0CTL  |= ID__4;               // divide by 4
    TB0EX0   = TBIDEX__4;           // divide by 4 again
    TB0CCR0  = 156;                 // default CCR0 (2.5ms)
    TB0CCTL0 = CCIE;                // enable interrupt

    // config IRQs
    P4IFG &= ~BIT1;                 // clear S1 flag
    P4IE  |=  BIT1;                 // enable S1 interrupt
    P2IFG &= ~BIT3;                 // clear S2 flag
    P2IE  |=  BIT3;                 // enable S2 interrupt

    __enable_interrupt();           // enable maskable interrupts

// ------------------------------ MAIN LOOP ----------------------------------------
    while(1) {

        // S1: forward 36 degrees (51 steps, 2.5ms pulse)
        if((P4IN & BIT1) == 0) {
            for(i = 0; i < 10000; i++){}        // debounce delay
            if((P4IN & BIT1) == 0) {
                while((P4IN & BIT1) == 0){}     // wait for S1 release

                TB0CCR0 = 156;              // 2.5ms pulse width

                for(i = 0; i < 51; i++) {
                    P3OUT = (P3OUT & 0xF0) | stepCW[i % 4];    // apply step
                    timerFlag = 0;
                    TB0CTL |= MC__UP;               // start timer
                    while(timerFlag == 0){}         // wait for pulse period
                    TB0CTL &= ~MC__UP;              // stop timer
                    TB0CTL |= TBCLR;                // clear timer
                }
                P3OUT &= ~(BIT0 | BIT1 | BIT2 | BIT3);     // de-energize coils

                // send UART message
                currentMsg = fwdMsg;
                position   = 0;
                msgLen     = sizeof(fwdMsg) - 1;
                sending    = 1;
                UCA1IE |= UCTXCPTIE;            // enable TX-complete IRQ
                UCA1IFG &= ~UCTXCPTIFG;         // clear TX-complete flag
                UCA1TXBUF = currentMsg[position]; // load first character
                while(sending){}                // wait for message to finish
            }
        }

        // S2: reverse 1 full rotation (512 steps, 2.5ms pulse)
        if((P2IN & BIT3) == 0) {
            for(i = 0; i < 10000; i++){}        // debounce delay
            if((P2IN & BIT3) == 0) {
                while((P2IN & BIT3) == 0){}     // wait for S2 release

                TB0CCR0 = 156;              // 2.5ms pulse width

                for(i = 0; i < 512; i++) {
                    P3OUT = (P3OUT & 0xF0) | stepCCW[i % 4];   // apply step
                    timerFlag = 0;
                    TB0CTL |= MC__UP;               // start timer
                    while(timerFlag == 0){}         // wait for pulse period
                    TB0CTL &= ~MC__UP;              // stop timer
                    TB0CTL |= TBCLR;                // clear timer
                }
                P3OUT &= ~(BIT0 | BIT1 | BIT2 | BIT3);     // de-energize coils

                // send UART message
                currentMsg = revMsg;
                position   = 0;
                msgLen     = sizeof(revMsg) - 1;
                sending    = 1;
                UCA1IE |= UCTXCPTIE;            // enable TX-complete IRQ
                UCA1IFG &= ~UCTXCPTIFG;         // clear TX-complete flag
                UCA1TXBUF = currentMsg[position]; // load first character
                while(sending){}                // wait for message to finish
            }
        }
    }

    return 0;
}

//-----------------------------------------------------
// Interrupt Service Routines
//-----------------------------------------------------
// service UART tx
#pragma vector = USCI_A1_VECTOR
__interrupt void ISR_EUSCI_A1(void)
{
    position++;
    if(position == msgLen)
    {
        UCA1IE &= ~UCTXCPTIE;      // all chars sent, disable TX interrupt
        sending = 0;
    }
    else
    {
        UCA1TXBUF = currentMsg[position];   // load next character
    }
    UCA1IFG &= ~UCTXCPTIFG;        // clear TX-complete flag
}

// ----------------------- END UART ISR -------------------------

// service timer B0
#pragma vector = TIMER0_B0_VECTOR
__interrupt void Timer_B0_ISR(void) {
    timerFlag = 1;
}

// -------------------- END TB0 ISR --------------------------------

// service S1 press
#pragma vector = PORT4_VECTOR
__interrupt void ISR_Port4_S1(void) {
    P4IFG &= ~BIT1;                // clear port flag
}

// ----------------------- END S1 ISR -------------------------

// service S2 press
#pragma vector = PORT2_VECTOR
__interrupt void ISR_Port2_S2(void) {
    P2IFG &= ~BIT3;                // clear port flag
}

// ----------------------- END S2 ISR -------------------------
