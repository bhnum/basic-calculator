calc: parser.y scanner.l vartable.h vartable.c mathfunction.h mathfunction.c
	bison -o parser.c parser.y --defines=parser.tab.h
	flex -o scanner.c scanner.l
	gcc scanner.c parser.c vartable.c mathfunction.c -o calc -Wall -lm

clean:
	rm scanner.c parser.tab.h parser.c calc
