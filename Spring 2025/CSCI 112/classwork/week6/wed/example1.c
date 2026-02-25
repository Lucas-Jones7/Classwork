#include<stdio.h>

int main() {
    double arr[10];

    printf("%ld\n", sizeof(arr));
    printf("%ld\n", sizeof(arr[0]));
    for(int i = 0; i < 10; i++) {
        arr[i] = i * i;
    }

    printf("print out all the numbers!\n");
    
    int j;
    while(j < 10) {
        printf("%f\n", arr[j]);
        j++;
    }
    
    double sum = 0;
    for(int i=0;i<1;i++){
        sum += arr[i];
    }
    printf("%f\n", sum);
    return 0;
}
