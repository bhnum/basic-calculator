%{
    #include <math.h>
    #include <stdio.h>
    #include "vartable.h"
    #include "mathfunction.h"

    void yyerror (char const *s);
    extern int yylex (void);
%}

%union {
    double fval;
    char* strval;
}

// tokens
%token PLUS MINUS TIMES DIVIDE POWER RIGHTPAREN LEFTPAREN EQUAL END INVALID
%token <fval> NUMBER
%token <strval> ID

// precedences
%start Input
%left PLUS MINUS
%left TIMES DIVIDE
%left Negative
%right POWER

%type <fval> Expression

%%

Input: /* empty line */
    | Input Statement
    ;

Statement: ID EQUAL Expression END /* assignment */ {
            if ($3 != $3) // chack if result is NaN
                printf("Error in calculation\n"); 
            else
                setvar($1, $3);
            
            // prevent memory leak
            free($1);
        }
    | Expression END {
            if ($1 != $1) // chack if result is NaN
                printf("Error in calculation\n");
            else
                printf("%f\n", $1);
        }
    | error END  /* error recovery */ { yyerrok; }
    | END;

Expression: NUMBER { $$ = $1; }
    | ID LEFTPAREN Expression RIGHTPAREN {
            // function call
            if (!evaluate_function($1, $3, &$$))
            {
                printf("Function %s does not exist!\n", $1);
                $$ = NAN;
            }

            // prevent memory leak
            free($1);
        }
    | ID {
            // variable
            if (!getvar($1, &$$))
            {
                printf("Variable %s was not declared!\n", $1);
                $$ = NAN;
            }

            // prevent memory leak
            free($1);
        }
    | Expression PLUS Expression { $$ = $1 + $3; }
    | Expression MINUS Expression { $$ = $1 - $3; }
    | Expression TIMES Expression { $$ = $1 * $3; }
    | Expression DIVIDE Expression {
            if ($3 != 0)
                $$ = $1 / $3;
            else {
                printf("Cannot divide by zero!\n");
                $$ = NAN;
            }
        }
    | MINUS Expression %prec Negative { $$ = -$2; }
    | Expression POWER Expression { $$ = pow($1, $3); }
    | LEFTPAREN Expression RIGHTPAREN { $$ = $2; }
    ;

%%

void yyerror(char const* str)
{
    printf("Error: %s\n", str);
}

int main()
{
    // add common math constants such as pi and e to the variable list
    setvar("pi", M_PI);
    setvar("e", M_E);
    setvar("inf", INFINITY);

    // start parsing
    yyparse();
    return 0;
}
