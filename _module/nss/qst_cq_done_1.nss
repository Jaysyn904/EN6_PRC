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

//SendMessageToPC(GetFirstPC(),"QuestType=" + IntToString(iQuestType));
if (iQuestType == 1 || iQuestType == 6)
    {
    iResult = TRUE;
    sTag = GetLocalString(GetPCSpeaker(),"QuestMob");
    //SendMessageToPC(GetFirstPC(),"QuestMob=" + sTag);
    oMob = GetObjectByTag(sTag);

    if (GetIsObjectValid(oMob))
        iResult = FALSE;
    }

return iResult;
}
