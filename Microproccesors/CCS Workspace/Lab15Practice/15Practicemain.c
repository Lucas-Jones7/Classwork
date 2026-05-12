/*******************************************************************************
 * File:    final_project_part1.c
 * Author:  [Your Name]
 * Date:    [Date]
 * Course:  EELE 371
 *
 * Description:
 *   Reads an analog voltage from an AD2 power supply (simulating a pressure
 *   sensor) and controls the onboard LEDs based on three threshold zones:
 *     - Below 1.0 V  -> Green LED ON  (safe)
 *     - 1.0 V-2.0 V  -> Both LEDs OFF (warning)
 *     - Above 2.0 V  -> Red LED ON    (unsafe)
 *
 * Pin Selection:
 *   ADC input: P1.4 (A4)
 *   Rationale: P1.0-P1.3 are reserved for other project modules (per spec).
 *   P1.4 is an available analog-capable pin on the MSP430FR2355. It is NOT
 *   tied to the onboard LEDs (P1.0 = Red, P6.6 = Green) or other peripherals.
 *   Connect AD2 positive supply (+V) to P1.4; AD2 GND to board GND.
 *   *** DO NOT exceed 3.3 V on this pin ***
 *
 * ADC Configuration:
 *   - 12-bit resolution (highest available) for maximum precision
 *   - VRef = 3.3 V (AVCC)
 *   - Full-scale counts: 2^12 - 1 = 4095
 *
 * Threshold Calculations:
 *   1 V threshold: (1.0 / 3.3) * 4095 = 1240.9  -> use 1241 counts
 *   2 V threshold: (2.0 / 3.3) * 4095 = 2481.8  -> use 2482 counts
 *
 * Maximum Resolution Error:
 *   LSB voltage = 3.3 V / 4095 = 0.000806 V = 0.806 mV per count
 *   Maximum error = +/- 0.5 LSB = +/- 0.403 mV (+/- 0.0004 V)
 *   At the 1 V threshold this is <0.05% error.
 *
 ******************************************************************************/

#include <msp430.h>

/* --- Threshold constants (12-bit ADC, 3.3 V reference) ------------------- */
#define THRESH_LOW   1241       /* ~1.0 V: below this -> Green LED on         */
#define THRESH_HIGH  2482       /* ~2.0 V: above this -> Red LED on           */

/* --- LED pin definitions -------------------------------------------------- */
#define RED_LED    BIT0         /* P1.0 - Red LED                             */
#define GREEN_LED  BIT6         /* P6.6 - Green LED                           */

/*******************************************************************************
 * main
 ******************************************************************************/
int main(void)
{
    /* --- Watchdog timer disable ------------------------------------------ */
    WDTCTL = WDTPW | WDTHOLD;

    /* --- LED GPIO setup --------------------------------------------------- */
    P1DIR  |=  RED_LED;         /* P1.0 output                                */
    P1OUT  &= ~RED_LED;         /* Red LED off initially                      */

    P6DIR  |=  GREEN_LED;       /* P6.6 output                                */
    P6OUT  &= ~GREEN_LED;       /* Green LED off initially                    */

    /* --- ADC pin setup (P1.4 = A4) --------------------------------------- */
    P1SEL0 |=  BIT4;            /* Select analog function on P1.4             */
    P1SEL1 |=  BIT4;

    /* --- Disable GPIO high-impedance mode (required on FR2355) ----------- */
    PM5CTL0 &= ~LOCKLPM5;

    /* --- ADC12_B configuration ------------------------------------------- */
    ADCCTL0  = ADCSHT_2 | ADCON;           /* 16 sample clocks, ADC on       */
    ADCCTL1  = ADCSHP;                     /* Sample-and-hold pulse mode      */
    ADCCTL2  = ADCRES_2;                   /* 12-bit resolution               */
    ADCMCTL0 = ADCINCH_4;                  /* Input channel A4 (P1.4)         */
                                           /* Vref = AVCC (3.3 V) by default  */

    /* --- Main loop -------------------------------------------------------- */
    while (1)
    {
        /* Start a single conversion */
        ADCCTL0 |= ADCENC | ADCSC;

        /* Poll until conversion is complete */
        while (!(ADCIFG & ADCIFG0));

        /* Read result and apply thresholds */
        unsigned int result = ADCMEM0;

        if (result < THRESH_LOW)
        {
            /* Safe zone: below ~1 V -> Green ON, Red OFF */
            P6OUT |=  GREEN_LED;
            P1OUT &= ~RED_LED;
        }
        else if (result > THRESH_HIGH)
        {
            /* Unsafe zone: above ~2 V -> Red ON, Green OFF */
            P1OUT |=  RED_LED;
            P6OUT &= ~GREEN_LED;
        }
        else
        {
            /* Warning zone: between 1 V and 2 V -> both LEDs OFF */
            P1OUT &= ~RED_LED;
            P6OUT &= ~GREEN_LED;
        }

        /* Clear the interrupt flag for the next conversion */
        ADCIFG &= ~ADCIFG0;

    } /* end while(1) */

} /* end main */
