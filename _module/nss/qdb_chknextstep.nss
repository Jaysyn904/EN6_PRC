#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetStepNumber() == GetQuestInt("Steps") && GetStepNumber()>1)
    iResult=TRUE;

return iResult;
}
