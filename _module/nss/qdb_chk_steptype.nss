#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = TRUE;

if (GetStepInt("Type")==0)
    iResult=FALSE;

return iResult;
}
