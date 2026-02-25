#include<stdio.h>

#define rows 3
#define cols 5

int main() {
    int nums[rows][cols];
    int row, col, value;

    for(row = 0; row < rows; row++) {
        for(col = 0; col < cols; col++) {
            scanf("%d", &value);
            nums[row][col] = value;
        }
    }

    for(row = 0; row < rows; row++){
        int sum = 0;
       for(col = 0; col < cols; col++) {
            sum += nums[row][col];
        } 
    printf("Row %d has total %d.\n", row, sum);
    }

    return 0;
}
