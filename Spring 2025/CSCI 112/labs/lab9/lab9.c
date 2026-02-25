#include <stdio.h>
#include <stdlib.h>
#include "county.h"
#include "sort.h"
#include "utils.h"

#define MAX_COUNTIES 100

int main() {
    FILE *file = fopen("/public/labs/lab8/counties1.txt", "r");
    if (!file) {
        printf("Error opening file.\n");
        return 1;
    }

    County counties[MAX_COUNTIES];
    int count = 0;
    char line[200], name[100], seat[25], pop_str[20];
    
    while (fgets(line, sizeof(line), file) && count < MAX_COUNTIES) {
        if (sscanf(line, "%99[^,],%24[^,],%19s", name, seat, pop_str) == 3) {
            int pop;
            sscanf(pop_str, "%d", &pop);
            counties[count++] = add_county(name, seat, pop);
        }
    }
    fclose(file);

    printf("~~~Welcome to the county database!\n");
    while (1) {
        printf("~~~To search for a county by seat, press 1.\n");
        printf("~~~To search for counties within a population range, press 2.\n");
        printf("~~~To exit, press any other key.\n");

        int choice;
        if (scanf("%d", &choice) != 1) break;

        if (choice == 1) search_by_seat(counties, count);
        else if (choice == 2) search_by_population(counties, count);
        else break;
    }

    return 0;
}

