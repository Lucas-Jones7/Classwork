#include<stdio.h>

int main(){
    printf("Enter two numbers and compare them: ");
    double a, b;
    scanf("%1f", &a);
    scanf("%1f", &b);

    double bigger = a>b? a:b;
    printf("%6.1f\n", bigger);
    return 0;


}
