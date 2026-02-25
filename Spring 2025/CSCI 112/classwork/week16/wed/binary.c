#include <stdio.h>

// Function to print a number in binary
void print_binary(unsigned int num) {
    // TODO: implement this function so that it prints all 32 bits
    // separate each group of 4 bits with a space
    for ( int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        printf("%d", bit);

        if (i % 4 == 0 && i != 0) {
            printf(" ");
        }
    }
    printf("\n");
}

int main(void) {
    // should print 0000 0000 0000 0000 0000 0000 0011 0010 
    print_binary(50);
   // should print 0000 0000 0000 0011 1001 0111 1010 1000 
    print_binary(235432);
    // should print 0000 0001 0011 0001 0000 1111 0110 0111
    print_binary(19992423);
}
