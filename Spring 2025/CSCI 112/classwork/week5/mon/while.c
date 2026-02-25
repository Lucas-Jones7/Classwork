#include<stdio.h>

int main(){
    printf("Enter a number: ");
    int N;
    scanf("%d", &N);

    int counter = 0;
    while(counter < N){
        //printf("*");
        //counter += 1;
        printf("%d ", ++counter); // combines previous two statements  
    }
    printf("\n");
    return 0;

}
