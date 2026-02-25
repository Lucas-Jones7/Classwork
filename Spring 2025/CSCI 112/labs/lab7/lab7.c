#include <stdio.h>
#include <string.h>

#define MAX_COUNTIES 100
#define MAX_LINE_LENGTH 500

int compareStrings(const char *str1, const char *str2) {
    while (*str1 && *str2 && *str1 == *str2) {
        str1++;
        str2++;
    }
    return *str1 - *str2;
}

void sort(char arr[][MAX_LINE_LENGTH], int size) {
    int min_index;
    char temp[MAX_LINE_LENGTH];

    for (int i = 0; i < size - 1; i++) {
        min_index = i;
        for (int j = i + 1; j < size; j++) {
            if (compareStrings(arr[j], arr[min_index]) < 0) {
                min_index = j;
            }
        }

        if (min_index != i) {
            strcpy(temp, arr[i]);
            strcpy(arr[i], arr[min_index]);
            strcpy(arr[min_index], temp);
        }
    }
}

int main() {
    FILE *inpt = fopen("/public/labs/lab7/counties1.txt", "r");
    if (inpt == NULL) {
        return 1;
    }

    char counties[MAX_COUNTIES][MAX_LINE_LENGTH];
    int count = 0;

    while (count < MAX_COUNTIES && fgets(counties[count], MAX_LINE_LENGTH, inpt)) {
        for (int i = 0; i < MAX_LINE_LENGTH; i++) {
            if (counties[count][i] == '\n') {
                counties[count][i] = '\0';
                break;
            }
        }
        count++;
    }

    fclose(inpt);
    sort(counties, count);

    FILE *outp = fopen("outdata_strings.txt", "w");
    if (outp == NULL) {
        return 1;
    }

    for (int i = 0; i < count; i++) {
        char line[MAX_LINE_LENGTH];
        strcpy(line, counties[i]);

        char *name = strtok(line, "|");
        char *seat = strtok(NULL, "|");
        strtok(NULL, "|");
        strtok(NULL, "|");
        char *population = strtok(NULL, "|");

        if (name && seat && population) {
            fprintf(outp, "%s has population %s and seat %s\n", name, population, seat);
        }
    }

    fclose(outp);
    return 0;
}

