#pragma once

#define true 1
#define false 0

typedef struct node_program node_program;
typedef struct node_declarations node_declarations ;
typedef struct node_type node_type ;
typedef struct node_statement_sequence node_statement_sequence ;
typedef struct node_statement node_statement ;
typedef struct node_assignment node_assignment ;
typedef struct node_if_statement node_if_statement ;
typedef struct node_else_clause node_else_clause ;
typedef struct node_while_statement node_while_statement ;
typedef struct node_write_int node_write_int ;
typedef struct node_expression node_expression ;
typedef struct node_simple_expression node_simple_expression ;
typedef struct node_term node_term ;
typedef struct node_factor node_factor ;
typedef struct node_ident node_ident;
typedef struct node_boollit node_boollit;
typedef struct node_num node_num;
typedef struct node_op2 node_op2;
typedef struct node_op3 node_op3;
typedef struct node_op4 node_op4;

struct node_program {
    node_declarations* declarations;
    node_statement_sequence* statementSequence;
}; 

struct node_declarations {
    node_ident* ident;
    node_type* type; //or just have it here as like char* to either 'INT' or 'BOOL' ????
    node_declarations* declarations;
};

//type 
struct node_type {
    //TODO: idk if there's a better way to do this... I will ask in class
    unsigned char isINT;
    unsigned char isBOOL;
};

struct node_statement_sequence {
    node_statement* statement;
    node_statement_sequence* statementSequence;
};

struct node_statement {
    node_assignment* assignment;
    node_if_statement* ifStatement;
    node_while_statement* whileStatement;
    node_write_int* writeInt;
};

struct node_assignment {
    node_ident* ident;
    node_expression* expression;
};

struct node_if_statement {
    node_expression* expression;
    node_statement_sequence* statementSequence;
    node_else_clause* elseClause;
};

struct node_else_clause {
    node_statement_sequence* statementSequence;
};

struct node_while_statement {
    node_expression* expression;
    node_statement_sequence* statementSequence;
};

struct node_write_int {
    node_expression* expression;
};

struct node_expression {
    node_simple_expression* simpleExpression1;
    node_op4* op4;
    node_simple_expression* simpleExpression2;
};

struct node_simple_expression {
    node_term* term1;
    node_op3* op3;
    node_term* term2;
};

struct node_term {
    node_factor* factor1;
    node_op2* op2;
    node_factor* factor2;
};

struct node_factor {
    node_ident* ident;
    node_num* num;
    node_boollit* boollit;
    node_expression* expression;
};

struct node_ident {
    char* ident;
};

struct node_boollit {
    char* boollit;
};

struct node_num {
    unsigned int num;
};

struct node_op2 {
    char* op2;
};

struct node_op3 {
    char* op3;
};

struct node_op4 {
    char* op4;
};
