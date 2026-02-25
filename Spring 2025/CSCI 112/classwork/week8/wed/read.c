#include <stdio.h>

#define NUM_LINES 10
#define MAX_LINE_LENGTH 100

int main(void) {
    char name[20];
    printf("Enter a name: ");
    // TODO: use scanf to read a name
    scanf("%s", name);

    printf("You entered: %s\n", name);

    // TODO: create an array called lines of NUM_LINES length MAX_LINE_LENGTH strings
    char lines[NUM_LINES][MAX_LINE_LENGTH];

    FILE* inp = fopen("/public/classwork/week8/wed/countries.txt", "r");
    for (int i = 0; i < NUM_LINES; i++) {
        // TODO: use fgets to read in a line to i-th slot in lines
        fgets(lines[i], MAX_LINE_LENGTH, inp);
    }

    printf("\n");
    for (int i = 0; i < NUM_LINES; i++) {
        printf("%s", lines[i]);
    }

}
