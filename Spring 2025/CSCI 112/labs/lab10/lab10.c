#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"lab10.h"

int main(int argc, char *argv[]) {
    if(argc != 7) {
        printf("Usage: %s name1 xp1 hp1 name2 xp2 hp2\n", argv[0]);
        return -1;
    }

    Character c1, c2;

    strncpy(c1.name, argv[1], 49);
    c1.name[49] = '\0';
    c1.xp = atoi(argv[2]);
    c1.hp = atoi(argv[3]);

    strncpy(c2.name, argv[4], 49);
    c2.name[49] = '\0';
    c2.xp = atoi(argv[5]);
    c2.hp = atoi(argv[6]);

    fight(&c1, &c2);

    return 0;
}
