%{
#include "nodes.h"
#include "cfg.tab.h"
%}

ident   [A-Z][A-Z0-9]*
num     [1-9][0-9]*|0
boollit false|true
OP2     \*|div|mod
OP3     \+|-
OP4     =|!=|<|>|<=|>=
%%
{num}           {
                yylval.str = malloc(strlen(yytext));
                strncpy(yylval.str, yytext, strlen(yytext));
                return(num);//printf("num         "); ECHO; printf("\n");
}
{boollit}       {
                yylval.str = malloc(strlen(yytext));
                strncpy(yylval.str, yytext, strlen(yytext));
                return(boollit);//printf("boollit     "); ECHO; printf("\n");
}
{ident}         {
                yylval.str = malloc(strlen(yytext));
                strncpy(yylval.str, yytext, strlen(yytext));
                return(ident);//printf("ident       "); ECHO; printf("\n");
}
\(              return(LP);//printf("LP          "); ECHO; printf("\n");
\)              return(LP);//printf("RP          "); ECHO; printf("\n");
:=              return(ASGN);//printf("ASGN        "); ECHO; printf("\n");
;               return(SC);//printf("SC          "); ECHO; printf("\n");
{OP2}           {
                yylval.str = malloc(strlen(yytext));
                strncpy(yylval.str, yytext, strlen(yytext));
                return(OP2);//printf("OP2         "); ECHO; printf("\n");
}
{OP3}           {
                yylval.str = malloc(strlen(yytext));
                strncpy(yylval.str, yytext, strlen(yytext));
                return(OP3);//printf("OP3         "); ECHO; printf("\n");
}
{OP4}           {
                yylval.str = malloc(strlen(yytext));
                strncpy(yylval.str, yytext, strlen(yytext));
                return(OP4); //printf("OP4         "); ECHO; printf("\n");
}
if              return(IF);//printf("IF          "); ECHO; printf("\n");
then            return(THEN);//printf("THEN        "); ECHO; printf("\n");
else            return(ELSE);//printf("ELSE        "); ECHO; printf("\n");
begin           return(begin);//printf("BEGIN       "); ECHO; printf("\n");
end             return(END);//printf("END         "); ECHO; printf("\n");
while           return(WHILE); //printf("WHILE       "); ECHO; printf("\n");
do              return(DO); //printf("DO          "); ECHO; printf("\n");
program         return(PROGRAM); //printf("PROGRAM     "); ECHO; printf("\n");
var             return(VAR); //printf("VAR         "); ECHO; printf("\n");
as              return(AS); //printf("AS          "); ECHO; printf("\n");
int             return(INT); //printf("INT         "); ECHO; printf("\n");
bool            return(BOOL); //printf("BOOL        "); ECHO; printf("\n");
writeInt        return(WRITEINT); //printf("WRITEINT    "); ECHO; printf("\n");
readInt         return(READINT); //printf("READINT     "); ECHO; printf("\n");
.               /*nothin*/
\n              /*nothin*/
