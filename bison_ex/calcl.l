/******************  calc1.l   *******************************/
%{
 
#include <stdio.h>
#include "calcl.tab.h"
int c;
extern int yylval;
%}
%%
" "       ;
[a-z]     {
            c = yytext[0];
            yylval = c - 'a';
            return(LETTER);
          }
[0-9]     {
            c = yytext[0];
            yylval = c - '0';
            return(DIGIT);
          }
[^a-z0-9\b]    {
                 c = yytext[0];
                 return(c);
               }
%%


/****************  to run this ********************
  **********   run the ./a.out 
  *********  then type any expression like 4 + 5
   **********   or 7 - 2  

***  etc etc   */

