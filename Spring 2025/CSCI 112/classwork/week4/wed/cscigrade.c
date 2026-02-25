#include <stdio.h>

int main(void) {
    char grade;

    printf("Enter the grade you got: ");
    scanf("%c", &grade);

    printf("You had ");
    switch(grade) {
	case 'A':
	case 'a':
		printf("93 or above points in the class.");
		break;
	case 'B':
	case 'b':
		printf("83 or above points in the class.");
		break;
	case 'C':
	case 'c': 
		printf("73 or above points in the class.");
		break;
	case 'D':
	case 'd':
		printf("63 or above points in the class.");
		break;
    	default:
        	printf("an unknown number of points in the class.");
    }

    printf("\n");

    return(0);
}       
