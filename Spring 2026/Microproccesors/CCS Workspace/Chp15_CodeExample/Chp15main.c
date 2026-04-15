#include <msp430.h> 
unsigned int ADC_Value;

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// configure ports
	P1DIR |= BIT0;              // config led1 as output
	P6DIR |= BIT6;              // config led2 as output
	P1SEL1 |= BIT2;             // configure p1.2 pin for A2
	P1SEL0 |= BIT2;

	PM5CTL0 &= LOCKLPM5;        // turn on GPIO

	// configure ADC
	ADCCTL0 &= ~ADCSHT;         // clear ADCSHT from default of ADCSHT=01
	ADCCTL0 |= ADCSHT_2;        // conversion cycles = 16 (ADCSHT=10)
	ADCCTL0 |= ADCON;           // turn ADC on

	ADCCTL1 |= ADCSSEL_2;       // ADC clock source = SMCLK
	ADCCTL1 |= ADCSHP;          // sample signal source = sampling timer

	ADCCTL2 &= ~ADCRES;         // clear ADCRES from default of ADCRES=01
	ADCCTL2 |= ADCRES_2;        // resolution = 12bit (ADCRES=10)

	ADCMCTL0 |= ADCINCH_2;      // ADC input channel = A2(P1.2)

	while(1)
	{
	    ADCCTL0 |= ADCENC | ADCSC;          // enable and start conversion

	    while((ADC_Value & ADCIFG0) == 0){} // wait for conversion completion
	    ADC_Value = ADCMEM0;                // read ADC result

	    if(ADC_Value > 3613){               // if A2 > 3v
	        P1OUT |= BIT0;                  // led 1 on
	        P6OUT &= BIT6;                  // led 2 off
	    } else {                            // if A2 < 3v
	        P1OUT &= BIT0;                  // led 1 off
	        P6OUT |= BIT6;                  // led 2 on
	    }
	}

	return 0;
}
