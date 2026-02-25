CC = gcc
CFLAGS = -Wall -g
OBJ = main.o team.o
TARGET = lab12

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

main.o: main.c team.h
	$(CC) $(CFLAGS) -c main.c

team.o: team.c team.h
	$(CC) $(CFLAGS) -c team.c

clean:
	rm -f *.o $(TARGET)

