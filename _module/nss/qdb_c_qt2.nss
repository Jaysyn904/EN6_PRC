#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetQuestInt("Type") ==2)
    iResult=TRUE;

return iResult;
}
