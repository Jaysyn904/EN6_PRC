#include "en5_misc"
#include "nw_i0_tool"

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

if (iQuestType == 1 || iQuestType == 6)
    {
    iResult = TRUE;
    sTag = GetLocalString(GetPCSpeaker(),"QuestMob");
    //SendMessageToPC(GetFirstPC(),"QuestMob=" + sTag);
    oMob = GetObjectByTag(sTag);

    if (GetIsObjectValid(oMob))
        iResult = FALSE;

    if (GetLocalInt(GetPCSpeaker(),"QuestHideItem") == 1 && !HasItem(GetPCSpeaker(),GetLocalString(GetPCSpeaker(),"QuestItem")))
        iResult=FALSE;
    if (GetLocalInt(GetPCSpeaker(),"QuestHideItem") == 0)
        iResult=FALSE;
    }

return iResult;
}
