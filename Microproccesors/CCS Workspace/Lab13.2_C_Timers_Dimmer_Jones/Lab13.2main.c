//-----------------------------------------------------
// Lucas Jones, EELE 371, Lab 13.1, 03/23/2026
//-----------------------------------------------------

#include <msp430.h> 

// Constants for pwm
#define PERIOD 999          // CCR0 = 1ms period at 1Mhz
#define DUTY_INIT 250          // 25% duty cycle
#define DUTY_MIN 100          // 10% min .1ms)
#define DUTY_MAX 500          // 50% max (0.5ms)
#define DUTY_STEP 50           // 5% step
volatile int DutyCycle = DUTY_INIT; // isr var starts as starting duty cycle

/**
 * main.c
 */
int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer

// Lab 13.2 - Step 3: create a program that will drive led1 with a pwm signal using timer compares
    // config led1 as output
    P1DIR |= BIT0;              // led1 as output
    P1OUT &= ~BIT0;             // led1 off initially

    // config s1 and s2 with interrupt
    //s1
    P4DIR &= ~BIT1;             // S1 as input
    P4REN |= BIT1;              // Enable resistor on S1
    P4OUT |= BIT1;              // Set as pull-UP
    P4IES |= BIT1;              // interrupt on high to low
    P4IFG &= ~BIT1;            // Clear flag
    P4IE |=  BIT1;            // Enable interrupt

    //s2
    P2DIR &= ~BIT3;             // S2 as input
    P2REN |= BIT3;              // Enable resostor on S2
    P2OUT |= BIT3;              // Set as pull-UP
    P2IES |= BIT3;              // interrupt on high to low
    P2IFG &= ~BIT3;            // Clear flag
    P2IE |=  BIT3;            // Enable interrupt

    // turn of gpio and clear flags
    PM5CTL0 &= ~LOCKLPM5;
    P4IFG &= ~BIT1;
    P2IFG &= ~BIT3;

    // config timer B0 for pwm
    TB0CCR0 = PERIOD;           // set period to 1ms
    TB0CCR1 = DUTY_INIT;        // set inital duty cycle
    TB0CCTL0 = CCIE;            // enable CCR0 interrupt (set led high at start of period)
    TB0CCTL1 = CCIE;            // enable CCR1 interrupt (set led low at end of high time)
    TB0CTL = TBSSEL__SMCLK | MC__UP | TBCLR;

    //enable interrupts
    __enable_interrupt();


    // MAIN LOOP ----------------------------------------
    while(1){

    }
}
//-----------------------------------------------------
// Interrupt Service Routines
//-----------------------------------------------------
// service s1
#pragma vector = PORT4_VECTOR
__interrupt void S1_ISR(void){
    if(P4IFG & BIT1){           // if both are asserted
        DutyCycle += DUTY_STEP; // increase duty cycle
        // upper threshold
        if(DutyCycle > DUTY_MAX){
            DutyCycle = DUTY_MAX;
        }
        P4IFG &= ~BIT1;         // clear p4 interrupt flag
    }
}
// ----------------------- END S1 ISR -------------------------------------

// service s2
#pragma vector = PORT2_VECTOR
__interrupt void S2_ISR(void){
    if(P2IFG & BIT3){           // if both are asserted
        DutyCycle -= DUTY_STEP; // decrease duty cycle
        // lower threshold
        if(DutyCycle < DUTY_MIN){
            DutyCycle = DUTY_MIN;
        }
        P2IFG &= ~BIT3;         // clear p4 interrupt flag
    }
}
// ----------------------- END S2 ISR -------------------------------------

// CCR0 ISR - fires at end of period, set led high
#pragma vector = TIMER0_B0_VECTOR
__interrupt void TB0_CCR0_ISR(void){
    P1OUT |= BIT0;              // LED on (start of new period)
}
// ----------------------- END CCR0 ISR -------------------------------------

// CCR1 ISR - fires at end of high time, set led low
#pragma vector = TIMER0_B1_VECTOR
__interrupt void TB0_CCR1_ISR(void){
    if(TB0IV == TB0IV_TBCCR1){  // confirm CCR1 caused interrupt
        P1OUT &= ~BIT0;         // LED off (end of high time)
        TB0CCR1 = DutyCycle;    // update duty cycle
    }
}
// ----------------------- END CCR1 ISR -------------------------------------
