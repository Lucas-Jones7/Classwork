lab9: lab9.o sort.o county.o utils.o
	gcc -o lab9 lab9.o sort.o county.o utils.o

lab9.o: lab9.c county.h sort.h utils.h
	gcc -c lab9.c

sort.o: sort.c sort.h
	gcc -c sort.c

county.o: county.c county.h
	gcc -c county.c

utils.o: utils.c utils.h county.h
	gcc -c utils.c

clean:
	rm -f lab9 *.o
