#include<stdio.h>

int main() {
    FILE* fp = fopen("input.txt", "r");
    int num;
    char arr[num];

    while(fscanf(fp, "%d %s", &num, arr)) {
        printf("%d %s\n", num, arr);
    }

    fclose(fp);
    return 0;
}
