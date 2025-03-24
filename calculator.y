%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);

%}

%union {
    double num;
}

%token <num> NUMBER
%type <num> expr

%left '+' '-'
%left '*' '/'
%right '^'

%%

input:
    | input line
;

line:
    '\n'
    | expr '\n'  { printf("= %g\n", $1); }
    | error '\n' { yyerrok; }
;

expr:
      expr '+' expr  { $$ = $1 + $3; }
    | expr '-' expr  { $$ = $1 - $3; }
    | expr '*' expr  { $$ = $1 * $3; }
    | expr '/' expr  {
        if ($3 == 0) {
            fprintf(stderr, "Error: division by zero\n");
            YYERROR;
        } else {
            $$ = $1 / $3;
        }
      }
    | expr '^' expr  { $$ = pow($1, $3); }
    | '(' expr ')'   { $$ = $2; }
    | NUMBER         { $$ = $1; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

