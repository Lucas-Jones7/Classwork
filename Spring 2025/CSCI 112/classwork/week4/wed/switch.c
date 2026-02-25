#include<stdio.h>

int main(){
	printf("Please enter the serial number: ");
	char ship;
	scanf("%c", &ship);

	switch(ship){
		case 'B':
		case 'b':
			printf("Battleship\n");
			break;
		case 'C':
		case 'c':
			printf("Cruiser\n");
			break;
		case 'D':
		case 'd':
			printf("Destroyer\n");
		case 'F':
		case 'f':
			printf("Frigate\n");
		default:
			printf("Unkown\n");
	}
	return 0;
}
