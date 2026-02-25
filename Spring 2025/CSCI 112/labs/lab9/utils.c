#include "utils.h"
#include <stdio.h>
#include <string.h>

void search_by_seat(County counties[], int count) {
    char search_seat[25];
    printf("Enter a county seat to search for: ");
    scanf("%24s", search_seat);
    for (int i = 0; i < count; i++) {
        if (strcasecmp(counties[i].seat, search_seat) == 0) { // Case-insensitive comparison
            printf("%s County has seat %s\n", counties[i].name, counties[i].seat);
            return;
        }
    }
}

void search_by_population(County counties[], int count) {
    int lower, upper;
    printf("Enter an upper bound for the population (inclusive): ");
    scanf("%d", &upper);
    printf("Enter a lower bound for the population (inclusive): ");
    scanf("%d", &lower);

    printf("The counties with populations between %d and %d are:\n", lower, upper);
    for (int i = 0; i < count; i++) {
        if (counties[i].pop >= lower && counties[i].pop <= upper) {
            printf("%s County, pop. %d\n", counties[i].name, counties[i].pop);
        }
    }
}
