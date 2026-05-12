//-----------------------------------------------------
// Lucas Jones, EELE 371, Lab 14.1, 03/31/2026
//-----------------------------------------------------

#include <msp430.h>

char FirstName[] = "Lucas ";
char FullName[] = "Lucas Jones "; // space at end acts as separator in terminal

unsigned int position;
unsigned int sendingLast = 0; // 0 = send first name, 1 = send last name

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD; // stop watchdog timer

    // put USCI_A1 into software reset
    UCA1CTLW0 |= UCSWRST;

    // configure USCI_A1
    UCA1CTLW0 |= UCSSEL__SMCLK; // clock source = SMCLK
    UCA1BRW = 6;                // baud rate divider for oversampling mode
    UCA1MCTLW = UCOS16 | UCBRF_8 | 0xAA00;  // enable oversampling, and set modulation

    // configure ports
    P4DIR &= ~BIT1;         // S1 input
    P4REN |= BIT1;
    P4OUT |= BIT1;          // pull up
    P4IES |= BIT1;          // falling edge

    P2DIR &= ~BIT3;         // S2 input
    P2REN |= BIT3;
    P2OUT |= BIT3;          // pull up
    P2IES |= BIT3;          // falling edge

    P4SEL1 &= ~(BIT3 | BIT2); // UART pins
    P4SEL0 |= (BIT3 | BIT2);

    P1DIR |= BIT0;          // led1
    P1OUT |= BIT0;          // led1 on to start
    P6DIR |= BIT6;          // led2
    P6OUT &= ~BIT6;         // led2 off to start

    PM5CTL0 &= ~LOCKLPM5;

    // take USCI_A1 out of software reset
    UCA1CTLW0 &= ~UCSWRST;

    // config IRQs
    P4IFG &= ~BIT1;
    P4IE |= BIT1;
    P2IFG &= ~BIT3;
    P2IE |= BIT3;

// Lab 14.1 - Step 9: modify code to use the UART recieve interrupts to modify the stat of the leds
    // enable UART recieve interrupt
    UCA1IE |= UCRXIE;
    UCA1IFG &= ~UCRXIFG;

    __enable_interrupt();

    while (1) {
// Lab 14.1 - Step2: create a program to send 'E' over UART
        //while (!(UCA1IFG & UCTXIFG)); // wait until Tx is ready
        //UCA1TXBUF = 'E';

        //delay between transmissions
        //for(i=0; i<10000; i=i+1){
        return 0;
    }

}

//-----------------------------------------------------
// Interrupt Service Routines
//-----------------------------------------------------
//Lab 14.1 - Step 4: create program to send full name over UART
// service s1 press
#pragma vector = PORT4_VECTOR
__interrupt void ISR_Port4_S1(void)
{
    position = 0;
    sendingLast = 0;

    P1OUT |= BIT0;              // led1 on
    P6OUT &= ~BIT6;             // led2 off

    UCA1IE |= UCTXCPTIE;        // enable TX-complete IRQ
    UCA1IFG &= ~UCTXCPTIFG;     // clear TX-complete flag
    UCA1TXBUF = FirstName[position]; // load first character

    P4IFG &= ~BIT1;             // clear port flag
}
// ----------------------- END S1 ISR -------------------------

// service s2 press
#pragma vector = PORT2_VECTOR
__interrupt void ISR_Port2_S2(void)
{
// last name "Jones" starts at sizeof(FirstName) in FullName
    position = sizeof(FirstName) - 1;
    sendingLast = 1;

    P6OUT |= BIT6; // led2 on
    P1OUT &= ~BIT0; // led1 off

    UCA1IE |= UCTXCPTIE;
    UCA1IFG &= ~UCTXCPTIFG;
    UCA1TXBUF = FullName[position];

    P2IFG &= ~BIT3; // clear port flag
}
// ----------------------- END S2 ISR  ------------------------

// service UART tx and rx
#pragma vector = USCI_A1_VECTOR
__interrupt void ISR_EUSCI_A1(void){
    // tx
    if(UCA1IFG & UCTXCPTIFG){               // fires after char finishes shifting out of buffer
        unsigned int stopIndex;

        if(sendingLast == 0){
            stopIndex = sizeof(FirstName);  //end of first name
        } else {
            stopIndex = sizeof(FullName);   // end of full name
        }

        if(position == stopIndex){
            UCA1IE &= ~UCTXCPTIE;            // all chars sent disable tx interrupt
        } else {   // more chars left
            position++;
            UCA1TXBUF = (sendingLast ==0) ? FirstName[position] : FullName[position];
        }

        UCA1IFG &= ~UCTXCPTIFG;             // clear tx flag
    }

    // rx
    if(UCA1IFG & UCRXIFG){
        char received = UCA1RXBUF;          // reading char from rx buffer

        if(received == '1'){
            P1OUT ^= BIT0;                  // toggle led1
        } else if(received == '2'){
            P6OUT ^= BIT6;                  // toggle led2
        }

        UCA1IFG &= ~UCRXIFG;                // clear rx flag
    }
}

// ------------------ END UART ISR ---------------------------------


