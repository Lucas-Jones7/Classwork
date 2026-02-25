#include<stdio.h>

int main() {
    FILE *inp;
    FILE *outp;
    double num;

    inp = fopen("/public/classwork/week7/wed/input.txt", "r");
    if(inp == NULL){
        return 1;
    }

    outp = fopen("output.txt", "w");
    if(outp == NULL){
        fclose(inp);
        return 1;
    }

    for(int i = 0; i < 5; i++){
        if(fscanf(inp, "%lf", &num) != 1) {
            break;
        } else {
            fprintf(outp, "%.2f\n", num);
        }
    }

    fclose(inp);
    fclose(outp);
    
    outp = fopen("output.txt", "r");
    if(outp == NULL){
        return 1;
    }

    while(fscanf(outp, "%lf", &num) != 1) {
        printf("%.2f\n", num);
    }

    fclose(outp);
    return 0;
}
