#include "en5_misc"

int StartingConditional()
{
int iResult;
int iQuestType;
int iIndex;
string sTag;
string sWP;
object oWP;
object oMob;

iResult = FALSE;

iQuestType = GetLocalInt(GetPCSpeaker(),"QuestType");

if (iQuestType == 4 || iQuestType == 5)
    iResult = TRUE;

return iResult;
}
