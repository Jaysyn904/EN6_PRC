#include "qdb_include"

int StartingConditional()
{
int iResult;
int iType;

iResult = FALSE;
iType=GetStepInt("Type");
if (iType==0)
    iResult=TRUE;

return iResult;
}
