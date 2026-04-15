//-----------------------------------------------------
// Lucas Jones, EELE 371, Lab 13.1, 03/23/2026
//-----------------------------------------------------

#include <msp430.h> 


/**
 * main.c
 */
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

    P2DIR &= ~BIT3;         // S2 as input
    P2REN |= BIT3;          // Enable resostor on S2
    P2OUT |= BIT3;          // Set as pull-UP

    // turn of gpio
    PM5CTL0 &= ~LOCKLPM5;

	// config variables
	int counter=0;                // create variable counter
	int i;
	int S1;
	int S2;

	// MAIN Loop
	while(1){
	    // If S1 is pressed, increment counter
	    S1 = P4IN;               // read p4 to S1 var
	    S1 &= BIT1;              // clears bits in S1except bit 1
	    if(S1 == 0){
	        counter++;
	        // Prevent over counts
	        if(counter > 3){
	            counter = 3;
	        }

	        //0.5s delay
	        for(i=0; i<0x7FFF; i++){
	        }
	    }

	    // If S2 is pressed, decrement counter
	    S2 = P2IN;               // read p4 to S1 var
	    S2 &= BIT3;              // clears bits in S1except bit 1
	    if(S2 == 0){
	        counter--;

	        // Prevent under counts
	        if(counter < 0){
	            counter = 0;
	        }

	        //1s delay
	        for(i=0; i<0xFFFF; i++){
	        }
	    }

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
