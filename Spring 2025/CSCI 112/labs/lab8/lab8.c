#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_COUNTIES 100

typedef struct {
    char name[100];
    char seat[25];
    int pop;
} County;

County add_county(char* name, char* seat, int pop) {
    County c;
    strncpy(c.name, name, sizeof(c.name) - 1);
    c.name[sizeof(c.name) - 1] = '\0';
    strncpy(c.seat, seat, sizeof(c.seat) - 1);
    c.seat[sizeof(c.seat) - 1] = '\0';
    c.pop = pop;
    return c;
}

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

