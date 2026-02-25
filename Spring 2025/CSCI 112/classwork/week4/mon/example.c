#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int main(){
	int x;
	printf("read an integer: ");
	scanf("%d", &x);
	printf("abs (%d)= %d\n", x, abs(x));
	printf("ceil (%d)=%f\n", x, ceil(x));
	printf("sin (%d)=%f\n", x, sin(x));
	printf("log (%d)=%f\n", x, log(x));
	return 0;
}

