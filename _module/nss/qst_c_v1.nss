#include "en5_misc"

int StartingConditional()
{
int iResult;

//GetError("QuestVariance=" + IntToString(GetLocalInt(GetPCSpeaker(),"QuestVariance")));

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"QuestVariance")==1)
    iResult = TRUE;

return iResult;
}
