%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);



%}

%union {
    int ival;
    double fval;
    
    
}

%token <ival> ENTIER
%token <fval> FLOTTANT
%token PLUS MOINS MULT DIV
%token PARG PARD 


%left PLUS MOINS
%left MULT DIV
%right UMINUS
%start programme

%%
programme:
        expression
        ;
    
expression:
    expression PLUS terme       { /* Syntaxe correcte */ }
    | expression MOINS terme    { /* Syntaxe correcte */ }
    | terme                     { /* Syntaxe correcte */ }
    ;

terme:
    terme MULT facteur          { /* Syntaxe correcte */ }
    | terme DIV facteur         { /* Syntaxe correcte */ }
    | facteur                   { /* Syntaxe correcte */ }
    ;

facteur:
    nombre                      { /* Syntaxe correcte */ }
    | PARG expression PARD      { /* Syntaxe correcte */ }
    | MOINS facteur %prec UMINUS { /* Syntaxe correcte */ }
   
    ;

nombre:
    ENTIER                      { /* Syntaxe correcte */ }
    | FLOTTANT                  { /* Syntaxe correcte */ }
    ;


%%
int syntax_err = 0;

void yyerror(const char *s) {
    fprintf(stderr, "ERREUR SYNTAXIQUE : %s\n", s);
    syntax_err = 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        // Lecture depuis un fichier
        FILE *fichier = fopen(argv[1], "r");
        if (!fichier) {
            perror("Erreur d'ouverture du fichier");
            return 1;
        }
        yyin = fichier;
        printf("Lecture depuis le fichier : %s\n", argv[1]);
    } else {
        // Lecture depuis stdin
        printf("Entrez une expression arithmétique :\n");
    }

    if (yyparse() == 0 && syntax_err == 0) {
        printf("Analyse lexicale et syntaxique : CORRECTE\n");
        return 0;
    } else {
        printf("Analyse lexicale et syntaxique : ERREUR\n");
        return 2;
    }
}
