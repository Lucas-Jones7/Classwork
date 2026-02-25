CC = gcc
CFLAGS = -Wall

all: a.out

a.out: main.o planet.o
	$(CC) main.o planet.o $(CFLAGS) -o a.out

main.o: main.c planet.h
	$(CC) -c main.c $(CFLAGS)

planet.o: planet.c planet.h
	$(CC) -c planet.c $(CFLAGS)

clean:
	rm -f a.out main.o planet.o

run: a.out
	./a.out
