CC = gcc
CFLAGS = -Wall
LDFLAGS = -lm
OBJS = lab10.o funcs.o

lab10: $(OBJS)
	$(CC) -o lab10 $(OBJS) $(LDFLAGS)

lab10.o: lab10.c lab10.h
	$(CC) -c lab10.c $(CFLAGS)

funcs.o: funcs.c lab10.h
	$(CC) -c funcs.c $(CFLAGS)

clean:
	rm -f lab10 *.o
