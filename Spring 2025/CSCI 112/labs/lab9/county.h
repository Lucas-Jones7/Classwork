#ifndef county_h
#define county_h

typedef struct {
    char name[100];
    char seat[25];
    int pop;
} County;

County add_county(char* name, char* seat, int pop);

#endif
