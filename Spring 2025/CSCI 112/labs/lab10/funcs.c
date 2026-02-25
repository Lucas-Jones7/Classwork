#include<stdio.h>
#include<string.h>
#include<math.h>
#include"lab10.h"

void fight(Character* a, Character* b) {
    printf("### LET'S FIGHT ###\n");
    printf("%s (%d XP, %d HP) vs. %s (%d XP, %d HP)\n", a->name, a->xp, a->hp, b->name, b->xp, b->hp);

    if(a->xp == b->xp) {
        printf("It's a tie!\n\n");
        printf("Result is:\n");
        printf("%s (%d XP, %d HP)\n", a->name, a->xp, a->hp);
        printf("%s (%d XP, %d HP)\n", b->name, b->xp, b->hp);
        return;
    }

    Character *winner, *loser;
    if(a->xp > b->xp) {
        winner = a;
        loser = b;
    }else {
        winner = b;
        loser = a;
    }

    int damage = winner->xp - loser->xp;
    loser->hp -= damage;

    printf("%s deals %d damage to %s\n", winner->name, damage, loser->name);

    winner->xp = (int) round(winner->xp + log10(winner->xp));
    loser->xp = (int) round(loser->xp * 1.5);

    if(loser->hp <= 0) {
        loser->hp = 0;
        strcat(loser->name, " (deceased)");
    }

    printf("\nResult is:\n");
    printf("%s (%d XP, %d HP)\n", a->name, a->xp, a->hp);
    printf("%s (%d XP, %d HP)\n", b->name, b->xp, b->hp);
}
