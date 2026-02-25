#include <stdio.h>
int main(){
	printf("Please read a char");
	char ch;
	scanf("%c", &ch);

	printf("Please read an int");
	int num;
	scanf("%d", &num);

	printf("Please read a double");
	double fl_num;
	scanf("%1f", &fl_num);

	printf("%c %d %1f\n", &ch, &num, &fl_num);

	return 0;
}

