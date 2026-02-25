#include<stdio.h>
 
#define max 100
  
void printArray(double arr[], int size){
    for(int i = 0; i < size; i++) {
        printf("%.2f", arr[i]);
        if(i < size - 1) {
            printf(" ");
        }
    }
    printf("\n");
}
 
void sort(double arr[], int size) {
    int min_index, i, j;
    for(i = 0; i < size - 1; i++) {
        min_index = i;
        for(j = i + 1; j < size; j++){
            if(arr[j] < arr[min_index]) {
                min_index = j;
            }
        }
        double temp = arr[i];
        arr[i] = arr[min_index];
        arr[min_index] = temp;
 
        printArray(arr, size);
    }
}
 
 
int main() {
    FILE *inpt;
    FILE *outp;
 
    inpt = fopen("/public/labs/lab6/numbers.txt", "r");
        if(inpt == NULL) {
            return 1;
        }
 
    double nums[max];
    int count = 0;
    while(count < max && fscanf(inpt, "%lf", &nums[count]) == 1) {
        count++;
    }
 
    fclose(inpt);
    printf("Before sorting, arr of numbers is\n");
    printArray(nums, count);
 
    printf("Now performing selection sort:\n");
    sort(nums, count);
 
    outp = fopen("outdata.txt", "w");
        if(outp == NULL) {
            return 1;
        }

    for(int i = 0; i < count; i++){
        fprintf(outp, "%.2f\n", nums[i]);
    }
 
    fclose(outp);
    return 0;

}
