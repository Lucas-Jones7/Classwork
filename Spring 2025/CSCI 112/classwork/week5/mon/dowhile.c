#include<stdio.h>

int amin() {
    int num;
    printf("Enter a number: ");
    int status;
    do{
        status = scanf("%d", &num);

    }while(status > 0 && (num % 2) != 0);

    printf("%d\n", num);
    return 0;
}
