//-----------------------------------------------------
// Lucas Jones, EELE 371, Lab 14.3 Demo 2, 04/6/2026
//-----------------------------------------------------
#include <msp430.h>

unsigned char Data_In = 0;
int buttonPressed = 0;

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer

    // put eUSCI_B0 into software reset
    UCB0CTLW0 |= UCSWRST;
    // config eUSCI_B0
    UCB0CTLW0 |= UCSSEL__SMCLK; // clock source = SMCLK
    UCB0BRW = 10;                // divide by 10 for SCL = 100kHz
    UCB0CTLW0 |= UCMODE_3;      // put into I2C mode
    UCB0CTLW0 |= UCMST;         // put into master mode
    UCB0I2CSA = 0x0068;          // slave address = 0x68
    UCB0TBCNT = 0x01;            // send 1 byte of data
    UCB0CTLW1 |= UCASTP_2;      // auto STOP after 1 byte
    // config ports as I2C
    P1SEL1 &= ~BIT3;
    P1SEL0 |= BIT3;              // P1.3 = UCB0SCL
    P1SEL1 &= ~BIT2;
    P1SEL0 |= BIT2;              // P1.2 = UCB0SDA

    // config S1 button (P4.1)
    P4DIR &= ~BIT1;              // P4.1 as input
    P4REN |= BIT1;               // enable pull resistor
    P4OUT |= BIT1;               // pull-up
    P4IES |= BIT1;               // high-to-low edge
    P4IFG &= ~BIT1;              // clear flag
    P4IE  |= BIT1;               // enable interrupt

    PM5CTL0 &= ~LOCKLPM5;        // disable LPM lock
    UCB0CTLW0 &= ~UCSWRST;      // take eUSCI_B0 out of SW reset

    // enable interrupts
    UCB0IE |= UCTXIE0;           // enable I2C Tx IRQ
    UCB0IE |= UCRXIE0;           // enable I2C Rx IRQ
    __enable_interrupt();        // enable maskable IRQs

    while(1){
        if(buttonPressed){
            buttonPressed = 0;

            // Transmit register address with write message
            UCB0CTLW0 |= UCTR;       // put into Tx mode
            UCB0CTLW0 |= UCTXSTT;    // generate START condition
            while((UCB0IFG & UCSTPIFG) == 0){} // wait for STOP
            UCB0IFG &= ~UCSTPIFG;    // clear STOP flag

            // Receive data from Rx
            UCB0CTLW0 &= ~UCTR;      // put into Rx mode
            UCB0CTLW0 |= UCTXSTT;    // generate START condition
            while((UCB0IFG & UCSTPIFG) == 0){} // wait for STOP
            UCB0IFG &= ~UCSTPIFG;    // clear STOP flag
        }
    }
    return 0;
}

//-----------------------------------------------------
// Interrupt Service Routines
//-----------------------------------------------------
#pragma vector = EUSCI_B0_VECTOR
__interrupt void EUSCI_B0_ISR(void){
    switch(UCB0IV){
        case 0x16:                // ID 16: RXIFG0
            Data_In = UCB0RXBUF;  // retrieve data
            break;
        case 0x18:                // ID 18: TXIFG0
            UCB0TXBUF = 0x03;     // send register address
            break;
        default:
            break;
    }
}

#pragma vector = PORT4_VECTOR
__interrupt void PORT4_ISR(void){
    P4IFG &= ~BIT1;              // clear S1 flag
    buttonPressed = 1;           // set flag for main loop
}
// ------------------ END ISRs ---------------------------------
