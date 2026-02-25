#ifndef SORT_H
#define SORT_H

#include "planet.h"

typedef int (*comparator_func)(const planet_t *, const planet_t *);

void sort(planet_t* planet_ptrs[], comparator_func comp, int n);

int diamComparator(const planet_t* a, const planet_t* b);

int nameComparator(const planet_t* a, const planet_t* b);

int get_min_in_range(planet_t* planet_ptrs[], comparator_func comp, int j, int n);

#endif
