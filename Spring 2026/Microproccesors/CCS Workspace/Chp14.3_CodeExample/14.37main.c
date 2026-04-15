#include <msp430.h> 


int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// put eUSCI_b0 into software reset
	UCB0CTLW0 |= UCSWRST;       // UCSWRST=2 for eUSCI_B0 in SW reset

	// configure eUSCI_B0
	UCB0CTLW0 |= UCSSEL__SMCLK; // choose BRCLK=SMCLK=1MHz
	UCB0BRW = 10;               // Divide BRCLK by 10 for SCL=100kHz

	UCB0CTLW0 |= UCMODE_3;      // put into I2C mode
	UCB0CTLW0 |= UCMST;         // put into master mode
	UCB0CTLW0 |= UCTR;          // put into tx mode
	UCB0I2CSA = 0x0068;         // slave addreess = 0x68

	UCB0CTLW1 |= UCASTP_2;      // auto STOP when UCB0TBCNT reached
	UCB0TBCNT = 0x01;           // send 1 byte of data

	// configure ports
	P1SEL1 &= ~BIT3;            // we want p1.3 = SCL
	P1SEL0 |= BIT3;

	P1SEL1 &= ~BIT2;            // we want p1.2 = SDA
	P1SEL0 |= BIT2;

	PM5CTL0 &= ~LOCKLPM5;       // disable LPM

	// take eUSCI_B0 out of software reset
	UCB0CTLW0 &= ~UCSWRST;      // UCSWRST=1 for eUSCI_B0 in sfotware reset

	// enable interrupts
	UCB0IE |= UCTXIE0;          // enable I2C Tx0 IRQ
	__enable_interrupt();       // enable maskable IRQ's

	int i;
	while(1){
	    UCB0CTLW0 |= UCTXSTT;   // generate start condition
	    for(i=0; i<100; i++){}  // delay loop
	}

	return 0;
}

//----------------------------ISR's------------------------------------
#pragma vector = EUSCI_B0_VECTOR            // this ISR runs when the Tx Buffer is ready for data.
__interrupt void EUSCI_B0_I2C_ISR(void){    // this will occur after the START condition and slave
    UCB0TXBUF = 0xBB;                       // address are sent and the slave sends back an ACK
}
