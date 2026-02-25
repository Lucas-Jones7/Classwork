#include<stdio.h>

int main() {
    int data, sum, input_status;

    printf("Enter a number: ");
    input_status = scanf("%d", &data);
    sum = 0;
    while(input_status != EOF) {
        sum += data;
        scanf("%d", &data);
    } 

    printf("sum=%d\n", sum);
    return 0;
}
