#include "qst_include"

int StartingConditional()
{
int iResult;
string sText;

iResult = FALSE;

SetCustomToken(100,GetOverallBossName());
sText=GetLocalString(OBJECT_SELF,"Tie-In");
SetCustomToken(101,sText);

return iResult;
}
