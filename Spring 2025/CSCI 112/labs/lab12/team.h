#ifndef TEAM_H
#define TEAM_H

typedef struct {
    char name[20];
} Person;

typedef struct {
    Person **people;
    int size;
    int capacity;
} Team;

//declarations
void initialize_team(Team *t, int capacity);
Person *create_new_person(char *name);
void insert_person_at_back(Team *t, Person *p);
void delete_person_at_back(Team *t);
void print_team(Team *t);
void decommission_team(Team *t);

#endif
