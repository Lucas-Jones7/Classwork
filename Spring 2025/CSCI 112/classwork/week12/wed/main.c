#include <stdio.h>
#include <string.h>
#include "planet.h"
#include "sort.h"

int main() {
    planet_t planets[8] =  {{"Mercury", 4879, 0, 0.25, 1426},
                          {"Venus", 12104.0, 0,.616, 5832},
                          {"Earth", 12756.0, 1, 1.0, 24.0},
                          {"Mars", 6779.0, 2, 1.88, 24.61},
                          {"Jupiter", 142800, 16, 11.9, 9.925},
                          {"Saturn", 120536, 146, 29.4, 10.7},
                          {"Uranus", 50000, 27, 84, 17.23},
                          {"Neptune", 49528, 14, 165, 16.1}
                          };

    // TODO: make an array of 8 pointers to planet_t called planet_ptrs
    planet_t* planet_ptrs[8];
    // TODO: fill it with pointers to the planets in the array planets
    for(int i = 0; i < 8; i++) {
        planet_ptrs[i] = &planets[i];
    }

    printf("The planets are:\n");
    for (int i = 0; i < 8; i++) {
       print_planet(planets[i]); 
    }

    // sorts planet_ptrs by diameter
    sort(planet_ptrs, diamComparator, 8);

    printf("\nSorted by diameter, they are:\n");
    for (int i = 0; i < 8; i++) {
        // TODO: call the function print_planet to print the ith element of planet_ptrs 
        print_planet(*planet_ptrs[i]);
    }

    // sorts planet_ptrs by name
    sort(planet_ptrs, nameComparator, 8);

    printf("\nSorted by name, they are:\n");
    for (int i = 0; i < 8; i++) {
        // TODO: call the function print_planet to print the ith element of planet_ptrs 
        print_planet(*planet_ptrs[i]);    
    }

    return(0);
}
