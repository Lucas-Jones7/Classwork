#include<stdio.h>

void order(double*, double*);

int main() {
    double num1, num2, num3;
    scanf("%lf%lf%lf", &num1, &num2, &num3);
    printf("Before order: %f %f %f\n", num1, num2, num3);
    order(&num1, &num2);
    order(&num1, &num3);
    order(&num2, &num3);

    printf("After order: %f %f %f\n", num1, num2, num3);
    return 0;
}

void order(double* first, double* second) {
    if(*first > *second) {
        double temp = *first;
        *first = *second;
        *second = temp;
    }
}
