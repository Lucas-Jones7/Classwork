#include <stdio.h>

int main(void) {
    // obviously, you can just look these up. but if you do that, you don't get any practice.
    
    // set these values using binary
    // e.g., x = 0b1011 to set x to 11 in decimal
    int x, y, z;
    x = 0b1111;
    y = 0b110;
    z = 0b1000010;

    // set these values using hexadecimal
    // e.g., a = 0xb to set x to 11 in decimal
    int a, b, c;
    a = 0xF;
    b = 0x6;
    c = 0x361CE8C5;
    
    // don't change anything below here, but use these values to know what to set
    // x, y, z, and a, b, c to
    if (x == 15) {
        printf("PASS\n");
    } else {
        printf("x=%d\n", x);
        printf("FAIL\n");
    }
    if (y == 6) {
        printf("PASS\n");
    } else {
        printf("y=%d\n", y);
        printf("FAIL\n");
    }
    if (z == 66) {
        printf("PASS\n");
    } else {
        printf("z=%d\n", z);
        printf("FAIL\n");
    }
    if (a == 15) {
        printf("PASS\n");
    } else {
        printf("a=%d\n", a);
        printf("FAIL\n");
    }
    if (b == 6) {
        printf("PASS\n");
    } else {
        printf("b=%d\n", b);
        printf("FAIL\n");
    }
    // hint: 907864261 is 11 0110 0001 1100 1110 1000 1100 0101 in binary
    if (c == 907864261) {
        printf("PASS\n");
    } else {
        printf("c=%d\n", c);
        printf("FAIL\n");
    }


}
