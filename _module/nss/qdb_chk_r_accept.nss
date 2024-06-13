#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = TRUE;

if (GetResponseInt("Accept")==0)
    iResult=FALSE;
return iResult;
}
