#include "sort.h"
#include <string.h>

void sort(County counties[], int count) {
    for (int i = 0; i < count - 1; i++) {
        for (int j = i + 1; j < count; j++) {
            if (strcmp(counties[i].name, counties[j].name) > 0) {
                County temp = counties[i];
                counties[i] = counties[j];
                counties[j] = temp;
            }
        }
    }
}
