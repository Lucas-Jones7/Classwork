#ifndef LAB10_H
#define LAB10_H

typedef struct {
    char name[50];
    int xp;
    int hp;
} Character;

void fight(Character* a, Character* b);

#endif
