#include <stdio.h>
#include <string.h>

int main(void) {
    // do not change these variables
    char line[] = "Bozeman,MT,USA";
    char *city, *state, *country;

    // TODO: use strtok to split line by ,
    // assigning "Bozeman" to city, "MT" to state,
    // and "USA" to country
    city = strtok(line, ",");
    state = strtok(NULL, ",");
    country = strtok(NULL, ",");
    
    // do not change this print statement
    printf("%s is in %s, %s\n", city, state, country);
}
