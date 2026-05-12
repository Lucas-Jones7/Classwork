//-----------------------------------------------------
// Lucas Jones, EELE 371, Lab 14.3, 04/6/2026
//-----------------------------------------------------

#include <msp430.h> 

// global vars (RAN at 10:59:20 April 6th, 2026)
#define START_REG 0x03          // start register
#define SEC 0x20                // seconds 0-59
#define MIN 0x59                // mins 0-59
#define HOUR 0x10               // hours 0-23
#define DAY 0x06                // days 1-31
#define WEEKDAY 0x01            // day of week 0-6, 0=sun
#define MONTH 0x04              // months 1-12
#define YEAR 0x26               // year

//packet array
unsigned char packet[8] = {START_REG, SEC, MIN, HOUR, DAY, WEEKDAY, MONTH, YEAR};
int txIndex= 0;                 // index to track which byte is being transmitted

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// put eUSCI_B0 into software reset
	UCB0CTLW0 |= UCSWRST;

	// config eUSCI_B0
	UCB0CTLW0 |= UCSSEL__SMCLK; // clock source = SMCLK
	UCB0BRW = 10;               // divide by 10 for SCL = 100kHz

	UCB0CTLW0 |= UCMODE_3;      // put into I2C mode
	UCB0CTLW0 |= UCMST;         // put into master mode
	UCB0I2CSA = 0x0068;         // slave address = 0x68 for RTC

	UCB0TBCNT = 0x08;           // send 8 bytes of data
	UCB0CTLW1 |= UCASTP_2;      // auto stop when UCB0TBCNT reached

	// config ports for I2c
	// SCL
	P1SEL1 &= ~BIT3;
	P1SEL0 |= BIT3;             // p1.3 = UCB0SCL

	// SDA
	P1SEL1 &= ~BIT2;
	P1SEL0 |= BIT2;             // p1.2 = UCB0SDA

	PM5CTL0 &= ~LOCKLPM5;       // disable LPM lock

	// take out of SW reset
	UCB0CTLW0 &= ~UCSWRST;

	// enable interrupts
	UCB0IE |= UCTXIE0;          // enable I2C tx IRQQ
	__enable_interrupt();       // enable maskable IRQs

// ------------------------ MAIN LOOP ---------------------------
	while(1){
	    txIndex = 0;            // reset packet index before each transmission

	    UCB0CTLW0 |= UCTR;      // put into tx mode
	    UCB0CTLW0 |= UCTXSTT;   // generate start condition

	    while((UCB0IFG & UCSTPIFG) == 0){} // wait for stop condition
	    UCB0IFG &= ~UCSTPIFG;   // clear stop flag

	    // delay before repeating
	    volatile int i;
	    for(i=0; i<30000; i++){}
	}

	return 0;
}

//-----------------------------------------------------
// Interrupt Service ROutines
//-----------------------------------------------------

#pragma vector = EUSCI_B0_VECTOR
__interrupt void EUSCI_B0_ISR(void){
    UCB0TXBUF = packet[txIndex];
    txIndex++;
}
// ------------------ END ISRs---------------------------------
