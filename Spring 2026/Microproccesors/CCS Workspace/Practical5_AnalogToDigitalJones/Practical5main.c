//-----------------------------------------------------
// Lucas Jones, EELE 371, Lab 15.1, 03/23/2026
// Question 2:
// 2a: a responsible sampling rate would be anything at least twice as fast as 500Hz,
//     the faster the sampling rate the more accuurate the read
//
// 2b:
// 2c:
// 2d: a limiter/resistor
//
// Question 4:
// 4a: Error in volts ~ 0.05V
//
// 4b:
//
// 4c: Two other options for ADC pins could be P1.1 because its in the A1 channel of the adc
//      and P1.3 because its in channel A3 of the ADC. all of this is in ADCINCH register
//-----------------------------------------------------

#include <msp430.h> 

volatile unsigned int ADCvalue = 0;
#define OFFSET   15
#define LOW_MAX  (1737  - OFFSET)    // 1737 (V=1.4)

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//configure led
	P1DIR |= BIT0;                  // config LED1 as output
	P1OUT &= ~BIT0;                 // LED1 off to start

	// configure P1.2 as ADC input
	P1SEL1 |= BIT2;                 // configure P1.2 to ADC function
	P1SEL0 |= BIT2;

	// turn on GPIO
	PM5CTL0 &= ~LOCKLPM5;          // enable GPIO

	// configure ADC
	ADCCTL0 &= ~ADCSHT;            // clear ADCSHT from default
	ADCCTL0 |= ADCSHT_2;           // conversion cycles = 16
	ADCCTL0 |= ADCON;              // turn ADC on
	ADCCTL1 |= ADCSSEL_2;          // ADC clock source = SMCLK
	ADCCTL1 |= ADCSHP;             // sample signal source = sampling timer
	ADCCTL2 &= ~ADCRES;            // clear ADCRES from default
	ADCCTL2 |= ADCRES_2;           // ADCRES_1 = 10-bit
	ADCMCTL0 |= ADCINCH_2;         // ADC input channel = A2 (P1.2)
	ADCIE |= ADCIE0;               // enable ADC conversion complete IRQ

	__enable_interrupt();

// ----------------- MAIN LOOP ---------------------------------
	while(1)
	{
	    ADCCTL0 |= ADCENC | ADCSC; // enable and start conversion
	    __bis_SR_register(LPM0_bits);

	    // control LEDs based on ADC value
	    if(ADCvalue <= LOW_MAX){
	        // low range: LED1 off
	        P1OUT &= ~BIT0;

	    } else {
	        P1OUT |= BIT0;
	    }
	}

	return 0;
}

//-----------------------------------------------------
// Interrupt Service Routines
//-----------------------------------------------------
#pragma vector = ADC_VECTOR
__interrupt void ADC_ISR(void){
    ADCvalue = ADCMEM0;                     // store ADC result
    __bic_SR_register_on_exit(LPM0_bits);   // wake up main loop
}
