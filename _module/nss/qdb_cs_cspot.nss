#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetStepInt("Type")==1)
    iResult=TRUE;
return iResult;
}
