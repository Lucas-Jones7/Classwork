a.out: main.o planet.o sort.o
	gcc main.o planet.o sort.o -Wall

main.o: main.c planet.h sort.h
	gcc -c main.c -Wall

sort.o: sort.c planet.h sort.h
	gcc -c sort.c -Wall

planet.o: planet.c planet.h
	gcc -c planet.c -Wall

clean:
	rm *.o a.out
