#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "team.h"

Person *create_new_person(char *name) {
    Person *new_person = malloc(sizeof(Person));
    if (new_person) {
        strncpy(new_person->name, name, sizeof(new_person->name) - 1);
        new_person->name[sizeof(new_person->name) - 1] = '\0';
        new_person->next = NULL;
    }

    return new_person;
}

void insert_person_at_front(Team *t, Person *p) {
    if (t && p) {
        p->next = t->head;
        t->head = p;
    }
}

void print_team(Team *t) {
    if (!t) return;
    Person *current = t->head;
    while (current) {
        printf("%s->", current->name);
        current = current->next;
    }

    printf("\n");
}

void delete_person_at_front(Team *t) {
    if (t && t->head) {
        Person *temp = t->head;
        t->head = t->head->next;
        free(temp);
    }
}

int is_empty(Team t) {
    return t.head == NULL;
}
