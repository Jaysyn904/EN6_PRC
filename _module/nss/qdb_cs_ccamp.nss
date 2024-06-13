#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = TRUE;
if (GetStepInt("Type")==1 || GetStepInt("Type")==3)
    iResult=FALSE;
return iResult;
}
