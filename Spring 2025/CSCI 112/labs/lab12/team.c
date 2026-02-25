#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "team.h"

void initialize_team(Team *t, int capacity) {
    t->people = calloc(capacity, sizeof(Person *));
    t->capacity = capacity;
    t->size = 0;
}

Person *create_new_person(char *name) {
    Person *new_person = malloc(sizeof *new_person);
    if (new_person != NULL) {
        strncpy(new_person->name, name, sizeof(new_person->name) - 1);
        new_person->name[sizeof(new_person->name) - 1] = '\0';
    }

    return new_person;
}

void insert_person_at_back(Team *t, Person *p) {
    if (t->size >= t->capacity) {
        t->capacity *= 2;
        t->people = realloc(t->people, t->capacity * sizeof *t->people);
    }

    t->people[t->size++] = p;
}

void delete_person_at_back(Team *t) {
    if (t->size == 0) return;
    free(t->people[t->size - 1]);
    t->size--;

    if (t->size <= t->capacity / 2 && t->capacity > 1) {
        int new_capacity = t->capacity / 2;
        if (new_capacity < 1) new_capacity = 1;
        t->people = realloc(t->people, new_capacity * sizeof *t->people);
        t->capacity = new_capacity;
    }
}

void print_team(Team *t) {
    printf("[");
    for (int i = 0; i < t->size; i++) {
        printf("%s", t->people[i]->name);
        if (i < t->size - 1) printf(", ");
    }

    printf("]\n");
    printf("Capacity is %d and current size is %d\n", t->capacity, t->size);
}

void decommission_team(Team *t) {
    for (int i = 0; i < t->size; i++) {
        free(t->people[i]);
    }

    free(t->people);
    t->people = NULL;
    t->size = 0;
    t->capacity = 0;
}
