#include <stdio.h>

int within_x_percent(double ref, double data, double x) {
    double lower_bound = ref - (x / 100.0) * ref;
    double upper_bound = ref + (x / 100.0) * ref;
    return (data >= lower_bound && data <= upper_bound) ? 1 : 0;
}

int main() {
    double observed_bp; 
    double percent = 5.0;
    char choice;

    printf("Observed boiling point (in deg. C)? ");
    if (scanf("%lf", &observed_bp) != 1) {
        printf("Error: bad input\n");
        return 1;
    }

    printf("You entered %.2f\n", observed_bp);

    printf("Custom error percent? n for no (5%% default), y for yes: ");
    scanf(" %c", &choice); 

    if (choice == 'y' || choice == 'Y') {
        printf("Enter error percent: ");
        if (scanf("%lf", &percent) != 1) {
            printf("Error: bad input\n");
            return 1;
        }
        printf("You entered %.2f percent\n", percent);
    } else if (choice != 'n' && choice != 'N') {
        printf("Error: bad input\n");
        return 1;
    }

    char *substance = NULL;

    if (within_x_percent(100.0, observed_bp, percent))
        substance = "water";
    else if (within_x_percent(357.0, observed_bp, percent))
        substance = "mercury";
    else if (within_x_percent(1187.0, observed_bp, percent))
        substance = "copper";
    else if (within_x_percent(2193.0, observed_bp, percent))
        substance = "silver";
    else if (within_x_percent(2660.0, observed_bp, percent))
        substance = "gold";

    if (substance) {
        printf("Substance is %s\n", substance);
    } else {
        printf("Substance unknown\n");
    }

    return 0;
}
