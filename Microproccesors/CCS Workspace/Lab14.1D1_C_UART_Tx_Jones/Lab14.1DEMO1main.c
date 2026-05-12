#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// configure UART pins
	// p4.3 = UCA1TXD, p4.2 = UCA1RXD
	P4SEL0 |= (BIT3 | BIT2);
	P4SEL1 &= ~(BIT3 | BIT2);

	PM5CTL0 &= ~LOCKLPM5;       // disable gpio

	// configure eUSCI_A1 for UART
	UCA1CTLW0 |= UCSWRST;       // put into software reset mode
	UCA1CTLW0 |= UCSSEL__SMCLK;  // use SMCLK clock source

	UCA1BRW = 6;                // UCBRx = 6 (oversampling)
	// enable oversampling  mode, UCBRF = 8, UCBRSx = 0AA
	UCA1MCTLW = UCOS16 | UCBRF_8 | 0xAA00;

	UCA1CTLW0 &= ~UCSWRST;      // take out of softare reset mode


// -------------------- MAIN LOOP --------------------------------
	int i;
	while(1){
	    while (!(UCA1IFG & UCTXIFG)); // wait until Tx is ready
	    UCA1TXBUF = 'E';

	    //delay between transmissions
	    for(i=0; i<10000; i=i+1){

	    }


	}
	return 0;
}
