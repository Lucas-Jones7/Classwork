#include <stdio.h>

int main() {
    int num = 10;
    int* p = &num;
    int** pp = &p;
    int*** ppp = &pp;
    int**** pppp = &ppp;
    printf("%d\n", *p);
    printf("%d\n", **pp);
    printf("%d\n", ***ppp);
    printf("%d\n", ****pppp);
    return 0;
}
