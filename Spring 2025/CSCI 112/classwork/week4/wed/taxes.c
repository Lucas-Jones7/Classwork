#include<stdio.h>

int main(){
	printf("Please enter your annual income: ");
	double income;
	scanf("%1lf", &income);
	double tax;
	if(income<11600){
		tax = income*0.1;
	}
	else if(income>11600&&income<=47150){
		tax = (income-11600)*0.12+11600*0.1;
	}
	else if(income>47150&&income<=100525){
		tax = (income-47150)*0.22 + (47150-11600)*0.12+11600*0.1;
	}
	else if(income>100525&&income<=191950){
		tax = (income-100525)*0.24 + (100525-47150)*0.22+(47150-11600)*0.12+11600*0.1;
	}
	else if(income>191950&&income<=243725){
		tax = (income-191950)*0.32 + (191950-100525)*0.24 + (100525-47150)*0.22+(47150-11600)*0.12+11600*0.1;
	}
	else if(income>243725 && income <= 609350){
		tax = (income-243725)*0.35 + (243725-191950)*0.32 + (191950-100525)*0.24 + (100525-47150)*0.22+(47150-11600)*0.12+11600*0.1;
	}
	else{
		tax = (income-609350)*0.37 +(609350-243725)*0.35 + (243725-191950)*0.32 + (191950-100525)*0.24 + (100525-47150)*0.22+(47150-11600)*0.12+11600*0.1;
	}


	printf("The tax you need to pay: %f\n", tax);

	return 0;
}
