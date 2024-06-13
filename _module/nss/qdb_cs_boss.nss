#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = TRUE;
if (GetStepInt("Type")==1 || GetStepInt("Type")==3)
    iResult=FALSE;

if (GetStepInt("Ambush")==1)
    iResult=TRUE;

return iResult;
}
