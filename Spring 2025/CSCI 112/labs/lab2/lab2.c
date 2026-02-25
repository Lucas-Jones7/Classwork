#include <stdio.h>

float get_earnings(int day) {
	int hours;
	float wage;

	printf("Enter hours worked on day %d: ", day);
	scanf("%d", &hours);

	printf("Enter hourly wage on day %d: ", day);
	scanf("%f", &wage);

	return hours * wage;
}

void display_totalpay(float total) {
	printf("Your total pay is $%.2f\n", total);
}

int main() {
	float total = get_earnings(1) + get_earnings(2) + get_earnings(3);
	display_totalpay(total);
	return 0;
}
