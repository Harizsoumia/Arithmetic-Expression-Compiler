LEX=flex
YACC=bison -d
CC=gcc
CFLAGS=-Wall -lm

all: calculateur.exe

lex.yy.c: lexer.l
	$(LEX) lexer.l

parser.tab.c parser.tab.h: parser.y
	$(YACC) parser.y

calculateur.exe: lex.yy.c parser.tab.c
	$(CC) lex.yy.c parser.tab.c -o calculateur.exe $(CFLAGS)

clean:
	rm -f calculateur.exe lex.yy.c parser.tab.c parser.tab.h
