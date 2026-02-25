#include <stdio.h>
#define CONSTANT -10

int main() {
	int hours, minutes;
	double time, temp;

	printf("Hours and minutes since power outage? (e.g., 2 30 for 2 hours, 30 minutes) ");
	scanf("%d %d", &hours, &minutes);

	time = hours + (minutes / 60.0);
	temp = ((3 * time * time) / (time + 1)) + CONSTANT;

	printf("Estimated current temperature: %.2f degrees Celsius", temp);
	return(0);
}
