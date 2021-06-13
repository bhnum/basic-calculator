%option noyywrap
%option nounput
%option noinput

%{
    #include <stdlib.h>
    #include <string.h>
    #include "parser.tab.h"
%}

digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
number {integer}("."{integer})?{exponent}?
whitespace [ \t]+
identifier [_a-zA-Z][_a-zA-Z0-9]*

%%

{number} {
        yylval.fval = strtod(yytext, NULL);
        return NUMBER;
    }

{identifier} {
        // copy yytext, because it gets overwritten each time
        char* name = malloc(strlen(yytext) + 1);
        strcpy(name, yytext);
        yylval.strval = name;
        return ID;
    }

{whitespace} { }

"+"     { return PLUS; }
"-"     { return MINUS; }
"*"     { return TIMES; }
"/"     { return DIVIDE; }
"^"     { return POWER; }
"("     { return LEFTPAREN; }
")"     { return RIGHTPAREN; }
"="     { return EQUAL; }
"\n"    { return END; }

.       { printf("Unexpected input %s\n", yytext); return INVALID; }
