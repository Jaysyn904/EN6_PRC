#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = TRUE;

if (GetResponseInt("Goto")==0)
    iResult=FALSE;
return iResult;
}
