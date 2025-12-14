%{
#include "parserpb.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%option nounput
%option noinput

%option noyywrap
%%

[ \t]+                { /* ignorer les espaces et tabulations */ }
\n                    { return '\n'; }
[0-9]+\.[0-9]+        { yylval.dval = atof(yytext); return FLOTTANT; }
[0-9]+                { yylval.dval = atof(yytext); return ENTIER; }
"+"                   { return PLUS; }
"-"                   { return MOINS; }
"*"                   { return MULT; }
"/"                   { return DIV; }
"("                   { return PARG; }
")"                   { return PARD; }
","                   { return VIRG; }
"SOMME"               { return SOMME; }
"PRODUIT"             { return PRODUIT; }
"MOYENNE"             { return MOYENNE; }
"VARIANCE"            { return VARIANCE; }
.                     { printf("ERREUR LEXICALE : Caractère non reconnu '%s'\n", yytext); return yytext[0]; }

%%



