LEX=flex
YACC=bison -d
CC=gcc
CFLAGS=-Wall -lm

all: calculateur.exe

lex.yy.c: lexerpb.l
	$(LEX) lexerpb.l

parserpb.tab.c parserpb.tab.h: parserpb.y
	$(YACC) parserpb.y

calculateur.exe: lex.yy.c parserpb.tab.c
	$(CC) lex.yy.c parserpb.tab.c -o calculateur.exe $(CFLAGS)

clean:
	rm -f calculateur.exe lex.yy.c parserpb.tab.c parserpb.tab.h

test: calculateur.exe
	./calculateur.exe expb.txt