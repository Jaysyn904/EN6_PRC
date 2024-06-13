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

if (iQuestType == 6 || iQuestType == 7)
    if (GetLocalInt(GetPCSpeaker(),"QuestHideItem") == 0)
        iResult = TRUE;

return iResult;
}
