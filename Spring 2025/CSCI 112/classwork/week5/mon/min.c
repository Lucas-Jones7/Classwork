#include<stdio.h>

int main() {
    char ch, ch1;
    printf("Enter two characters: ");
    scanf(" %c %c", &ch, &ch1);

    char min = (ch < ch1) ? ch : ch1;

    printf("Min is %c\n", min);
    return 0;
}
