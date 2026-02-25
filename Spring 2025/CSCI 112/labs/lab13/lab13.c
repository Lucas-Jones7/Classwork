#include <stdio.h>
#include <stdint.h>

void print_binary(uint32_t num) {
    for (int i = 31; i >= 0; i--) {
        printf("%d", (num >> i) & 1);
        if (i % 4 == 0 && i != 0)
            printf(" ");
    }
    printf("\n");
}

void print_hex(uint32_t num) {
    for (int i = 7; i >= 0; i--) {
        printf("%x", (num >> (i * 4)) & 0xF);
        if (i != 0)
            printf("    ");
    }
    printf("\n");
}

uint32_t modify_bit(uint32_t num, int position, int operation) {
    switch (operation) {
        case 1: // set
            return num | (1U << position);
        case 2: // clear
            return num & ~(1U << position);
        case 3: // toggle
            return num ^ (1U << position);
        default:
            return num; // no change
    }
}

void print_number_info(uint32_t num) {
    print_binary(num);
    print_hex(num);
}

int main() {
    uint32_t n1, n2;
    printf("Enter two unsigned integers: ");
    scanf("%u %u", &n1, &n2);

    printf("\nBinary & hex representation:\n");

    printf("Number 1:\n");
    print_number_info(n1);

    printf("Number 2:\n");
    print_number_info(n2);

    // AND
    uint32_t and = n1 & n2;
    printf("\nBitwise AND of Number 1 and Number 2: %u\n", and);
    printf("Binary & hex representation:\n");
    print_number_info(and);

    // OR
    uint32_t or = n1 | n2;
    printf("\nBitwise OR: %u\n", or);
    printf("Binary & hex representation:\n");
    print_number_info(or);

    // XOR
    uint32_t xor = n1 ^ n2;
    printf("\nBitwise XOR: %u\n", xor);
    printf("Binary & hex representation:\n");
    print_number_info(xor);

    // NOT
    uint32_t not1 = ~n1;
    printf("\nBitwise NOT on first number: %u\n", not1);
    printf("Binary & hex representation:\n");
    print_number_info(not1);

    uint32_t not2 = ~n2;
    printf("\nBitwise NOT on second number: %u\n", not2);
    printf("Binary & hex representation:\n");
    print_number_info(not2);

    // Modify bit
    int bit_pos, op;
    printf("\nEnter a bit position to modify: ");
    scanf("%d", &bit_pos);
    printf("Set, clear, or toggle (1/2/3)? ");
    scanf("%d", &op);

    printf("Original number: %u\n", n1);
    print_binary(n1);
    print_hex(n1);

    uint32_t modified = modify_bit(n1, bit_pos, op);
    printf("Modified number: %u\n", modified);
    printf("Binary & hex representation:\n");
    print_binary(modified);
    print_hex(modified);

    return 0;
}

