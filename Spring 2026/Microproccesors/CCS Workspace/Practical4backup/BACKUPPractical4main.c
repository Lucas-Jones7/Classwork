//-----------------------------------------------------
// Lucas Jones, EELE 371, Practical 4, 03/27/2026
//-----------------------------------------------------
#include <msp430.h> 


int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
// Practical 4: Create a program to toggle led1 upon a button press on s1

//------------------------- INIT -------------------------------------------
	// config leds as outputs
	P1DIR |= BIT0;          // led1 as output
	P6DIR |= BIT6;          // led2 as output
	P1OUT &= ~BIT0;         // led1 off initially
	P6OUT &= ~BIT6;         // led2 off initially

	// config sw1 as an input
	P4DIR &= ~BIT1;         // S1 as input
	P4REN |= BIT1;          // Enable resistor on S1
	P4OUT |= BIT1;          // Set as pull-UP
	P4IES |= BIT1;          // interrupt on high to low

	// clear flags and GPIO
	PM5CTL0 &= ~LOCKLPM5;   // turn of gpio
	P4IFG &= ~BIT1;         // clear P4.1 interrupt flag

	// setup IRQ
	P4IFG &= ~BIT1;         // clear port 4.1 interrupt flag
	P4IE |= BIT1;           // enable port 4.1 irq
	__enable_interrupt();   // enable maskable IRQ's

//--------------------- MAIN LOOP ------------------------------------------------------

	while(1){

	}


	return 0;
}


//-----------------------------------------------------
// Interrupt Service Routines
//-----------------------------------------------------
#pragma vector = PORT4_VECTOR
__interrupt void S1_ISR(void){
// If S1 is pressed, flash both leds simultaneously
    P1OUT |= BIT0;      // led1 on
    P6OUT |= BIT6;      // led2 on
    //0.5s delay
    for(i=0; i<0x7FFF; i=i+1){
    }
    P1OUT &= ~BIT0;     // led1 off
    P6OUT &= ~BIT6;     // led2 off
    //0.5s delay
    for(i=0; i<0x7FFF; i=i+1){
    }
    P4IFG &= ~BIT1;
}




