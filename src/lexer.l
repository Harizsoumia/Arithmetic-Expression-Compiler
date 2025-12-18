%{
#include "parser.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%option nounput
%option noinput
%option noyywrap
%option yylineno
%%

[ \t]+                { /* ignore spaces and tabs */ }
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
.                     { printf("LEXICAL ERROR: Unrecognized character '%s'\n", yytext); return yytext[0]; }

%%