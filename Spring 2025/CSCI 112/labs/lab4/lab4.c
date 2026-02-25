#include<stdio.h>

int main() {
    double temp;
    double sum = 0.0;
    double count = 0.0;
    double hday = 0.0, pday = 0.0, cday = 0.0;

    do {
        printf("Enter a high temp reading (-99 to quit)> ");
        if(scanf("%lf", &temp) != 1){
            printf("Enter a valid input\n");
            return 1;
        }
        if(temp == -99) break;
        if(temp >= 85){
            hday++;
        }else if(temp >= 60){
            pday++;
        }else{
            cday++;
        }

        sum += temp;
        count++;

    } while(temp != -99);
    double avg = sum / count;
    if(count > 0){
        printf("\nH: ");
        for(int i = 0; i < hday; i++){
            printf("*");
        }
        printf("\nP: ");
        for(int i = 0; i < pday; i++){
            printf("*");
        }
        printf("\nC: ");
        for(int i = 0; i < cday; i++){
            printf("*");
        }
        printf("\nAverage temperature: %.1lf\n", avg + 0.05);
    }

    return 0;
}
