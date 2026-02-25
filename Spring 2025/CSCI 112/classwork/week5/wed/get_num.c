#include <stdio.h>

int main() {
    double num;
    int valid_input;

    do {
        printf("Enter a number outside of 0 and 100: (decimals okay): ");
        valid_input = scanf("%lf", &num);

        if (valid_input != 1) {
            printf("You didn't enter a number\n");
            return 1;
        }

    } while (num >= 0 && num <= 100);

    printf("You entered %.2f\n", num);
    return 0;
}

