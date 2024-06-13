#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetResponseInt("Goto")==0)
    iResult=TRUE;
return iResult;
}
