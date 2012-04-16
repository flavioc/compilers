
all: transpose ger

transpose: transpose.o util.o

ger: ger.o util.o

clean:
	rm -f a.out transpose *.o
