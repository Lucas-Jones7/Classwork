#include <string.h>
#include <stdio.h>
#include "planet.h"
#include "sort.h"

int diamComparator(const planet_t* a, const planet_t* b) {
    if (a->diameter < b->diameter) return -1;
    else if (a->diameter > b->diameter) return 1;
    else return 0;
}

int nameComparator(const planet_t* a, const planet_t* b) {
    if (strcmp(a->name, b->name) < 0) return -1;
    else if (strcmp(a->name, b->name) > 0) return 1;
    else return 0;
}

void sort(planet_t* planet_ptrs[], comparator_func comp, int n) {
    int min_idx;
    planet_t* temp;
    // selection sort: walk over the array, find the min, and swap it
    for (int i = 0; i < n; i++) {
        min_idx = get_min_in_range(planet_ptrs, comp, i, n); // find min
        // swap
        temp = planet_ptrs[i];
        planet_ptrs[i] = planet_ptrs[min_idx];
        planet_ptrs[min_idx] = temp;
    }
}

// find the min index in the subset of the array nums between
// index i (inclusive) and n (exclusive)
int get_min_in_range(planet_t* planet_ptrs[], comparator_func comp, int j, int n) { 
    int min_index = j;
    for (int i = j; i < n; i++) {
        if (comp(planet_ptrs[i], planet_ptrs[min_index]) < 0)
            min_index = i;
    }
    return(min_index);
}
