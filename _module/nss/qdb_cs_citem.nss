#include "qdb_include"

int StartingConditional()
{
int iResult;

iResult = TRUE;
if (GetStepString("Item")=="")
    iResult=FALSE;
return iResult;
}
