#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// Setup Ports
	P1DIR |= BIT0;              // config p1.0 as output
	P1OUT |= BIT0;              // led1=1 to start for PWM
	PM5CTL0 &= ~LOCKLPM5        // turn on gpio

	// Setup timer B0
	TB0CTL |= TBCLR;            // clear timer and dividers
	TB0CTL |= TBSSEL__ACLK;     // clock source to ACLK
	TB0CTL |= MC__UP;           // up counting mode
	TB0CCR0 = 32768;            // ccr0=32,768
	TB0CCR1 = 1638;             // ccr1=1,638

	// Setup timer compare IRQ for CCR0 and CCR1
	TB0CCTL0 &= ~CCIFG;          // clear CCR0 flag
	TBOCCTL0 |= CCIE;            // enavle TB0 CCR0 overflow IRQ
	TB0CCTL1 &= ~CCIFG;          // clear CCR1 flag
	TB0CCTL1 |= CCIE;            // enable tb0 ccr1 overflow IRQ
	__enable_interrupt();        // enable maskable IRQ's


	// main loop
	while(1)
	{

	}

	return 0;
}

//  ISR's
#pragma vector = Timer_B0_Vector
__interrupt void ISR_TB0_CCR0(void)
{
    P1OUT |= BIT0;              //led1=1
    TB0CCTL0 &= ~CCIFG          // clear ccr0 flag
}

#pragma vector = Timer_B1_Vector
__interrupt void ISR_TB1_CCR1(void)
{
    P1OUT &= ~BIT0;             // led1 = 0
    TB0CCTL1 &= ~CCIFG          // clear ccr1 flag
}
