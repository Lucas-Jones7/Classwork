#include<stdio.h>

int main(){
	printf("read your rest heart rate: ");
	int rate;
	scanf("%d", &rate);

	if(rate > 75){
		printf("Do more exercises\n");
	}
	else{
		printf("You are in good health\n");
	}

	return 0;
}
