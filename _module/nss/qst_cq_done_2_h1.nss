#include "nw_i0_tool"
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

if (iQuestType == 2 || iQuestType == 7)
    {
    iResult = TRUE;
    iIndex = 1;
    sTag = GetLocalString(GetPCSpeaker(),"QuestMobZone") + "_" + GetLocalString(GetPCSpeaker(),"QuestCamp") + "_";
    sWP = sTag + IntToString(iIndex);
    oWP = GetObjectByTag(sWP);
    //GetError("Checking " + GetTag(oWP));
    while (GetIsObjectValid(oWP))
        {
        oMob = GetObjectByTag(sWP + "_S");
        //GetError(GetTag(oMob) + "=" + GetName(oMob));
        if (GetIsObjectValid(oMob))
            iResult = FALSE;
        iIndex++;
        sWP = sTag + IntToString(iIndex);
        oWP = GetObjectByTag(sWP);
        }

    if (GetLocalInt(GetPCSpeaker(),"QuestHideItem") == 1 && !HasItem(GetPCSpeaker(),GetLocalString(GetPCSpeaker(),"QuestItem")))
        iResult=FALSE;
    if (GetLocalInt(GetPCSpeaker(),"QuestHideItem") == 0)
        iResult=FALSE;
    }
return iResult;
}
