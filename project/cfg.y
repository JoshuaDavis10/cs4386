%{
    #include <stdio.h>
    #include "nodes.h"
    int yylex(void);
    int yyerror(char *);
%}


%token num
%token boollit
%token ident
%token LP
%token RP
%token ASGN 
%token SC 
%token OP2
%token OP3
%token OP4
%token IF
%token THEN 
%token ELSE 
%token begin 
%token END
%token WHILE
%token DO
%token PROGRAM
%token VAR
%token AS
%token INT
%token BOOL
%token WRITEINT
%token READINT

%start program
%%
program:
    PROGRAM declarations begin statementSequence END 
    ;

declarations:
    /*empty*/
    | VAR ident AS type SC declarations
    ;

type:
    INT
    | BOOL
    ;

statementSequence:
    /*empty*/
    | statement SC statementSequence
    ;

statement:
    assignment
    | ifStatement
    | whileStatement
    | writeInt
    ;

assignment:
    ident ASGN expression
    | ident ASGN READINT
    ;

ifStatement:
    IF expression THEN statementSequence elseClause END
    ;

elseClause:
    /*empty*/
    | ELSE statementSequence
    ;

whileStatement:
    WHILE expression DO statementSequence END
    ;

writeInt:
    WRITEINT expression
    ;

expression:
    simpleExpression
    | simpleExpression OP4 simpleExpression
    ;

simpleExpression:
    term OP3 term
    | term
    ;

term:
    factor OP2 factor
    | factor
    ;

factor:
    ident 
    | num
    | boollit
    | LP expression RP
    ;
%%
int yyerror(char *s) {
  printf("yyerror : %s\n",s);
}
int main(void) {
  yyparse();
   printf("SUCCESS\n");
}
int yywrap() {
}
