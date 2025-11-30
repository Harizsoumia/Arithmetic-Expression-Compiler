%{
#include "parser.tab.h"
#include <stdlib.h>
#include <stdio.h>

extern int yyerror(const char *s);
%}

%option noyywrap

%%

[ \t\n]+              { /* Ignorer les espaces */ }

[0-9]+\.[0-9]+        { yylval.fval = atof(yytext); return FLOTTANT; }
[0-9]+                { yylval.ival = atoi(yytext); return ENTIER; }


"+"                   { return PLUS; }
"-"                   { return MOINS; }
"*"                   { return MULT; }
"/"                   { return DIV; }
"("                   { return PARG; }
")"                   { return PARD; }

.                     { 
                        printf("ERREUR LEXICALE : Caractère non reconnu '%s'\n", yytext); 
                        return yytext[0];
                      }

%%