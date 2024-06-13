#include "qdb_include"

int StartingConditional()
{
int iResult;
int iLine;

iResult = FALSE;

if (GetLineNumber()>1)
    {
    iLine=GetLineNumber()+1;
    SetLineNumber(iLine);
    if (GetLine() == "")
        iResult=TRUE;
    iLine=GetLineNumber()-1;
    SetLineNumber(iLine);
    }

return iResult;
}
