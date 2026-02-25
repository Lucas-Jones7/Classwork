#include<stdio.h>

int main(){
	printf("read an integter: ");
	int x;
	scanf("%d", &x);

	if(x==100){
		printf("you guessed correct!\n");
	}
	else{
		printf("you guessed wrong.\n");
	}
}
