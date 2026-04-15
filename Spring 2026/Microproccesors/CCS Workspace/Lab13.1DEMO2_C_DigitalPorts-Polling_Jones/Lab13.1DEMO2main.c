//-----------------------------------------------------
// Lucas Jones, EELE 371, Lab 13.1, 03/23/2026
//-----------------------------------------------------

#include <msp430.h> 


/**
 * main.c
 */

volatile int counter = 0;
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// Lab 13.1 - Step 2: Create a 2-bit Binary counter
	// config led1 and 2 as outputs
	P1DIR |= BIT0;          // led1 as output
    P6DIR |= BIT6;          // led2 as output
    P1OUT &= ~BIT0;         // led1 off initially
    P6OUT &= ~BIT6;         // led2 off initially

    // config s1 and s2 as inputs
    P4DIR &= ~BIT1;         // S1 as input
    P4REN |= BIT1;          // Enable resistor on S1
    P4OUT |= BIT1;          // Set as pull-UP
    P4IES |= BIT1;          // interrupt on high to low

    P2DIR &= ~BIT3;         // S2 as input
    P2REN |= BIT3;          // Enable resostor on S2
    P2OUT |= BIT3;          // Set as pull-UP
    P2IES |= BIT3;          // interrupt on high to low

    // turn of gpio
    PM5CTL0 &= ~LOCKLPM5;
    P4IFG &= ~BIT1;    // clear flasgs
    P2IFG &= ~BIT3;

    // setup IRQ
    P4IFG &= ~BIT1;         // clear port 4.1 interrupt flag
    P4IE |= BIT1;           // enable port 4.1 irq

    P2IFG &= ~BIT3;         // clear port 2.3 flag
    P2IE |= BIT3;           // enable port 2.3 irq

    __enable_interrupt();  //enable maskable IRQ's

	// MAIN Loop
	while(1){

	    // Switch/case to set leds based on value in counter
	    switch(counter){
	        case 0:                     // 00b
	            P1OUT &= ~BIT0;         // led1 off
	            P6OUT &= ~BIT6;         // led2 off
	            break;

	        case 1:                     // 01b
	            P1OUT &= ~BIT0;         // led1 off
	            P6OUT |= BIT6;          // led2 on
	            break;

	        case 2:                     // 10b
	            P1OUT |= BIT0;          // led1 on
	            P6OUT &= ~BIT6;         // led2 off
	            break;

	        case 3:                     // 11b
	            P1OUT |= BIT0;          // led1 on
	            P6OUT |= BIT6;          // led2 on
	            break;

	        default:
	            break;
	    }
	}

	return 0;
}

//-----------------------------------------------------
// Interrupt Service Routines
//-----------------------------------------------------
#pragma vector = PORT4_VECTOR
__interrupt void S1_ISR(void){
// If S1 is pressed, increment counter
    if(P4IFG & BIT1){
        counter++;
        // Prevent over counts
        if(counter > 3){
            counter = 3;
        }
        P4IFG &= ~BIT1;
    }
}

#pragma vector = PORT2_VECTOR
__interrupt void S2_ISR(void){
// If S2 is pressed, decrement counter
    if(P2IFG & BIT3){
        counter--;
        // Prevent under counts
        if(counter < 0){
            counter = 0;
        }
        P2IFG &= ~BIT3;
    }
}
