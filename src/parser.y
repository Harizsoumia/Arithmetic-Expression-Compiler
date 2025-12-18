%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylineno;
extern char *yytext;
extern FILE *yyin;

/* Declaration de yylex */
int yylex(void);

void yyerror(const char *s){
    fprintf(stderr, "Syntax error at line %d: %s\n", yylineno, yytext ? yytext : "end of line");
}
%}

/* Definition de la structure AVANT %union */
%code requires {
    typedef struct {
        double values[100];
        int len;
    } liste_args_t;
}

%code {
    /* Declarations de fonctions */
    double somme(liste_args_t args);
    double produit(liste_args_t args);
    double moyenne(liste_args_t args);
    double variance(liste_args_t args);
}

%union {
    double dval;
    liste_args_t args;
}

%token <dval> ENTIER FLOTTANT
%token PLUS MOINS MULT DIV
%token PARG PARD VIRG
%token SOMME PRODUIT MOYENNE VARIANCE

%type <dval> expression terme facteur nombre
%type <args> liste_args

%left PLUS MOINS
%left MULT DIV
%right UMINUS

%%

programme:
    /* vide */
    | programme ligne
;

ligne:
    expression '\n' { printf("Result = %lf\n", $1); }
    | '\n'          { /* empty line */ }
;

expression:
      expression PLUS terme       { $$ = $1 + $3; }
    | expression MOINS terme      { $$ = $1 - $3; }
    | terme                        { $$ = $1; }
;

terme:
      terme MULT facteur          { $$ = $1 * $3; }
    | terme DIV facteur           { 
          if ($3 == 0) {
              fprintf(stderr, "ERROR: Division by zero at line %d\n", yylineno);
              $$ = 0;
          } else {
              $$ = $1 / $3;
          }
      }
    | facteur                     { $$ = $1; }
;

facteur:
      nombre                       { $$ = $1; }
    | PARG expression PARD         { $$ = $2; }
    | MOINS facteur %prec UMINUS   { $$ = -$2; }
    | SOMME PARG liste_args PARD   { $$ = somme($3); }
    | PRODUIT PARG liste_args PARD { $$ = produit($3); }
    | MOYENNE PARG liste_args PARD { $$ = moyenne($3); }
    | VARIANCE PARG liste_args PARD { $$ = variance($3); }
;

nombre:
      ENTIER   { $$ = $1; }
    | FLOTTANT { $$ = $1; }
;

liste_args:
      expression             { $$.values[0]=$1; $$.len=1; }
    | liste_args VIRG expression { $1.values[$1.len]=$3; $1.len++; $$=$1; }
;

%%

double somme(liste_args_t args) {
    double s = 0;
    for(int i=0; i<args.len; i++) s += args.values[i];
    return s;
}

double produit(liste_args_t args) {
    double p = 1;
    for(int i=0; i<args.len; i++) p *= args.values[i];
    return p;
}

double moyenne(liste_args_t args) {
    return somme(args)/args.len;
}

double variance(liste_args_t args) {
    double m = moyenne(args);
    double v = 0;
    int i;
    for(i=0; i<args.len; i++) v += (args.values[i]-m)*(args.values[i]-m);
    return v/args.len;
}

int main(int argc, char **argv) {
    if(argc>1) {
        yyin = fopen(argv[1],"r");
        if(!yyin) { perror("Error opening file"); return 1; }
    }
    else yyin=stdin;
    
    int result = yyparse();
    
    if(argc>1) fclose(yyin);
    
    if(result == 0) {
        printf("\nAnalysis complete: SUCCESS\n");
    } else {
        printf("\nAnalysis complete: FAILED\n");
    }
    
    return result;
}