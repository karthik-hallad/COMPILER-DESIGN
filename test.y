%{
    #include <stdio.h>
    #include <stdlib.h>
    extern int yylex();
%}

%token NUM

%%
S : E	{printf("Result = %d\n", $1);}
  ;
  
E : E '+' T	{$$ = $1 + $3;}
  | E '-' T	{$$ = $1 - $3;}
  | T		{$$ = $1;}
  ;

T : T '*' F	{$$ = $1 * $3;}
  | T '/' F	{if ($3 == 0) {printf("Cannot divide by 0\n"); yyerror();} $$ = $1 / $3;}
  | F		{$$ = $1;} //misse
  ;

F : '(' E ')'	{$$ = $2;} //miss
  | '-' F	{$$ = -$2;}
  | NUM	{$$ = $1;}
  ;
%%

int yyerror()
{
    printf("Invalid\n");
    exit(0);
}

int main()
{
    printf("Enter a valid arithmetic expression\n");
    yyparse();
    return 0;
}
