#include<stdio.h>

int main(){
	printf("read an integer ");
	int x;
	scanf("%d", &x);

	if(x>=0&&x<100){
		printf("A number between 0 and 100!\n");
	}
	else{
		printf("A number smaller than 0 or greater than 100!\n");
	}
}


