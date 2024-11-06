%{
    #include <stdio.h>
    #include <stdlib.h> //for atoi()
    #include "nodes.h"
    int yylex(void);
    int yyerror(char *);
%}

%union {
    char* str;
    node_factor* factor;
    node_term* term;
    node_simple_expression* simpleExpression;
    node_expression* expression;
    node_write_int* writeInt;
    node_while_statement* whileStatement;
    node_else_clause* elseClause;
    node_if_statement* ifStatement;
    node_assignment* assignment;
    node_statement* statement;
    node_statement_sequence* statementSequence;
    node_type* type;
    node_declarations* declarations;
    node_program* program;
};

%token <str> num
%token <str> boollit
%token <str> ident
%token LP
%token RP
%token ASGN 
%token SC 
%token <str> OP2
%token <str> OP3
%token <str> OP4
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

%type<factor> factor
%type<term> term 
%type<simpleExpression> simpleExpression
%type<expression> expression
%type<writeInt> writeInt;
%type<whileStatement> whileStatement;
%type<elseClause> elseClause;
%type<ifStatement> ifStatement;
%type<assignment> assignment;
%type<statement> statement;
%type<statementSequence> statementSequence;
%type<type> type;
%type<declarations> declarations;
%type<program> program;

%start program
%%
program:
    PROGRAM declarations begin statementSequence END { 
        printf("program: PROGRAM delcarations begin statementSequence END\n");
        node_program* ptr = malloc(sizeof(node_program));
        ptr->declarations = $2;
        ptr->statementSequence = $4;
        $$ = ptr;
    }
    ;

declarations:
    /*empty*/ {
        printf("declarations:\n");
        node_declarations* ptr = NULL;
        $$ = ptr;
    }
    | VAR ident AS type SC declarations {
        printf("declarations: VAR ident AS type SC declarations (ident = %s)\n", $2);
        node_declarations* ptr = malloc(sizeof(node_declarations));
        node_ident* ident_ptr = malloc(sizeof(node_ident));
        ident_ptr->ident = $2;
        ptr->ident = ident_ptr;
        ptr->type = $4;
        ptr->declarations = $6;
        $$ = ptr;
    }
    ;

type:
    INT {
        printf("type: INT\n");
        node_type* ptr = malloc(sizeof(node_type));
        //TODO: is this a good way to do this?
        ptr->isINT = 1;
        ptr->isBOOL = 0;
        //TODO: is this a good way to do this?
        $$ = ptr;
    }
    | BOOL {
        printf("type: BOOL\n");
        node_type* ptr = malloc(sizeof(node_type));
        //TODO: is this a good way to do this?
        ptr->isINT = 0;
        ptr->isBOOL = 1;
        //TODO: is this a good way to do this?
        $$ = ptr;
    }
    ;

statementSequence:
    /*empty*/ {
        printf("statementSequence:\n");
        node_statement_sequence* ptr = NULL;
        $$ = ptr;
    }
    | statement SC statementSequence {
        printf("statementSequence: statement SC statementSequence\n");
        node_statement_sequence* ptr = malloc(sizeof(node_statement_sequence));
        ptr->statement = $1;
        ptr->statementSequence = $3;
        $$ = ptr;
    }
    ;

statement:
    assignment {
        printf("statement: assignment\n");
        node_statement* ptr = malloc(sizeof(node_statement));
        ptr->assignment = $1;
        ptr->ifStatement = NULL;
        ptr->whileStatement = NULL;
        ptr->writeInt = NULL;
        $$ = ptr;
    }
    | ifStatement {
        printf("statement: ifStatement\n");
        node_statement* ptr = malloc(sizeof(node_statement));
        ptr->assignment = NULL;
        ptr->ifStatement = $1;
        ptr->whileStatement = NULL;
        ptr->writeInt = NULL;
        $$ = ptr;
    }
    | whileStatement {
        printf("statement: whileStatement\n");
        node_statement* ptr = malloc(sizeof(node_statement));
        ptr->assignment = NULL;
        ptr->ifStatement = NULL;
        ptr->whileStatement = $1;
        ptr->writeInt = NULL;
        $$ = ptr;
    }
    | writeInt {
        printf("statement: writeInt\n");
        node_statement* ptr = malloc(sizeof(node_statement));
        ptr->assignment = NULL;
        ptr->ifStatement = NULL;
        ptr->whileStatement = NULL;
        ptr->writeInt = $1;
        $$ = ptr;
    }
    ;

assignment:
    ident ASGN expression {
        printf("assignment: ident ASGN expression (ident = %s)\n", $1);
        node_assignment* ptr = malloc(sizeof(node_assignment));
        node_ident* ident_ptr = malloc(sizeof(node_ident));
        ident_ptr->ident = $1;
        ptr->ident = ident_ptr;
        ptr->expression = $3;
        $$ = ptr;
    }
    | ident ASGN READINT {
        printf("assignment: ident ASGN READINT (ident = %s)\n", $1);
        printf("assignment: ident ASGN expression (ident = %s)\n", $1);
        node_assignment* ptr = malloc(sizeof(node_assignment));
        node_ident* ident_ptr = malloc(sizeof(node_ident));
        ident_ptr->ident = $1;
        ptr->ident = ident_ptr;
        ptr->expression = NULL;
        $$ = ptr;
    }
    ;

ifStatement:
    IF expression THEN statementSequence elseClause END {
        printf("ifStatement: IF expression THEN statmentSequence elseClause END\n");
        node_if_statement* ptr = malloc(sizeof(node_if_statement));
        ptr->expression = $2;
        ptr->statementSequence = $4;
        ptr->elseClause = $5;
        $$ = ptr;
    }
    ;

elseClause:
    /*empty*/ {
        printf("elseClause:\n");
        node_else_clause* ptr = NULL;
        $$ = ptr;
    }
    | ELSE statementSequence {
        printf("elseClause: ELSE statementSequence\n");
        node_else_clause* ptr = malloc(sizeof(node_else_clause));
        ptr->statementSequence = $2; 
        $$ = ptr;
    }
    ;

whileStatement:
    WHILE expression DO statementSequence END {
        printf("whileStatement: WHILE expression DO statementSequence END\n");
        node_while_statement* ptr = malloc(sizeof(node_while_statement));
        ptr->expression = $2;
        ptr->statementSequence = $4; 
        $$ = ptr;
    }
    ;

writeInt:
    WRITEINT expression {
        printf("writeInt: expression\n");
        node_write_int* ptr = malloc(sizeof(node_write_int));
        ptr->expression = $2;
        $$ = ptr;
    }
    ;

expression:
    simpleExpression {
        printf("expression: simpleExpression\n");
        node_expression* ptr = malloc(sizeof(node_expression));
        ptr->simpleExpression1 = $1;
        ptr->simpleExpression2 = NULL;
        ptr->op4 = NULL;
        $$ = ptr;
    }
    | simpleExpression OP4 simpleExpression {
        printf("expression: ");
        node_expression* ptr = malloc(sizeof(node_expression));
        node_op4* op4_ptr = malloc(sizeof(node_op4));
        op4_ptr->op4 = $2;
        ptr->simpleExpression1 = $1;
        ptr->simpleExpression2 = $3;
        ptr->op4 = op4_ptr;
        printf("simpleExpression %s simpleExpression\n", op4_ptr->op4);
        $$ = ptr;
    }
    ;

simpleExpression:
    term OP3 term {
        printf("simple expression: ");
        node_simple_expression* ptr = malloc(sizeof(node_simple_expression));
        node_op3* op3_ptr = malloc(sizeof(node_op3));
        op3_ptr->op3 = $2;
        ptr->term1 = $1;
        ptr->term2 = $3;
        ptr->op3 = op3_ptr;
        printf("term %s term\n", op3_ptr->op3);
        $$ = ptr;
    }
    | term {
        printf("simple expression: term\n");
        node_simple_expression* ptr = malloc(sizeof(node_simple_expression));
        ptr->term1 = $1;
        ptr->term2 = NULL;
        ptr->op3 = NULL;
        $$ = ptr;
    }
    ;

term:
    factor OP2 factor {
        printf("term: ");
        node_term* ptr = malloc(sizeof(node_term));
        node_op2* op2_ptr = malloc(sizeof(node_op2));
        op2_ptr->op2 = $2;
        ptr->factor1 = $1;
        ptr->factor2 = $3;
        ptr->op2 = op2_ptr;
        printf("factor %s factor\n", op2_ptr->op2);
        $$ = ptr;
    }
    | factor {
        printf("term: factor\n");
        node_term* ptr = malloc(sizeof(node_term));
        ptr->factor1 = $1;
        ptr->factor2 = NULL;
        ptr->op2 = NULL;
        $$ = ptr;
    }
    ;

factor:
    ident {
        printf("factor:");
        node_factor* ptr = malloc(sizeof(node_factor));
        node_ident* ident_ptr = malloc(sizeof(node_ident));
        ident_ptr->ident = $1;
        ptr->ident = ident_ptr;
        printf("\tident   = %s\n", ident_ptr->ident);
        ptr->num = NULL;
        ptr->boollit = NULL;
        ptr->expression = NULL;
        $$ = ptr;
    
    }
    | num { 
        printf("factor:"); 
        node_factor* ptr = malloc(sizeof(node_factor));
        node_num* num_ptr = malloc(sizeof(node_num));
        num_ptr->num = atoi($1);
        ptr->num = num_ptr;
        printf("\tnum     = %u\n", num_ptr->num);
        ptr->ident = NULL;
        ptr->boollit = NULL;
        ptr->expression = NULL;
        $$ = ptr;
    }
    | boollit { 
        printf("factor:"); 
        node_factor* ptr = malloc(sizeof(node_factor));
        node_boollit* bool_ptr = malloc(sizeof(node_boollit));
        bool_ptr->boollit = $1;
        ptr->boollit = bool_ptr;
        printf("\tboollit = %s\n", bool_ptr->boollit);
        ptr->ident = NULL;
        ptr->num = NULL;
        ptr->expression = NULL;
        $$ = ptr;
    }
    | LP expression RP {
        printf("factor: ( expression )"); 
        node_factor* ptr = malloc(sizeof(node_factor));
        ptr->expression = $2;
        ptr->ident = NULL;
        ptr->num = NULL;
        ptr->boollit = NULL;
        $$ = ptr;
    }
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
