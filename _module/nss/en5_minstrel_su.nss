#include "en5_specialareas"

int StartingConditional()
{
int iResult;
string sTalk;

iResult = TRUE;

sTalk=GetMinstrelTalk();
SetCustomToken(300,sTalk);

return iResult;
}
