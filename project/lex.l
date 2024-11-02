%{
#include "cfg.tab.h"
%}

ident [A-Z][A-Z0-9]*

%%
[1-9][0-9]*|0   return(num);//printf("num         "); ECHO; printf("\n");
false|true      return(boollit);//printf("boollit     "); ECHO; printf("\n");
{ident}         return(ident);//printf("ident       "); ECHO; printf("\n");
\(              return(LP);//printf("LP          "); ECHO; printf("\n");
\)              return(LP);//printf("RP          "); ECHO; printf("\n");
:=              return(ASGN);//printf("ASGN        "); ECHO; printf("\n");
;               return(SC);//printf("SC          "); ECHO; printf("\n");
\*|div|mod      return(OP2);//printf("OP2         "); ECHO; printf("\n");
\+|-            return(OP3);//printf("OP3         "); ECHO; printf("\n");
=|!=|<|>|<=|>=  return(OP3);//printf("OP4         "); ECHO; printf("\n");
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
