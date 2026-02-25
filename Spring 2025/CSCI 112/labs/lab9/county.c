#include "county.h"
#include <string.h>

County add_county(char* name, char* seat, int pop) {
    County c;
    strncpy(c.name, name, sizeof(c.name) - 1);
    c.name[sizeof(c.name) - 1] = '\0';
    strncpy(c.seat, seat, sizeof(c.seat) - 1);
    c.seat[sizeof(c.seat) - 1] = '\0';
    c.pop = pop;
    return c;
}
