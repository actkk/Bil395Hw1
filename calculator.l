%{
#include "calculator.tab.h"
#include <stdlib.h>
%}

digits   [0-9]+
float    {digits}"."{digits}

%%
[ \t]+      ;                   
{float}     { yylval.num = atof(yytext); return NUMBER; }
{digits}    { yylval.num = atof(yytext); return NUMBER; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"("         { return '('; }
")"         { return ')'; }
\n          { return '\n'; }
.           { /* Geçersiz karakter */ return yytext[0]; }
%%
int yywrap(void) { return 1; }

