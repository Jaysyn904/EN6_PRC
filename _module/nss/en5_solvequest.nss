#include "nw_i0_tool"

void main()
{
int iResult;
int iQuestType;
int iIndex;
int iStep;
string sTag;
string sWP;
string sQS;
object oWP;
object oMob;
object oPC;
object oQuestNPC;

oPC = GetPCSpeaker();
oQuestNPC=GetObjectByTag(GetLocalString(oPC,"QuestNPC"));
iStep=GetLocalInt(oQuestNPC,"QuestStep");
sQS="QuestStep" + IntToString(iStep);
iQuestType = GetLocalInt(oQuestNPC,sQS + "Type");

if (iQuestType == 1)
    {
    sTag=GetLocalString(oQuestNPC,sQS + "MobTag");
    //SendMessageToPC(GetFirstPC(),"QuestMob=" + sTag);
    oMob = GetObjectByTag(sTag);

    if (GetIsObjectValid(oMob))
        DestroyObject(oMob,0.1);
    }

if (iQuestType==2 || iQuestType == 4 || iQuestType == 7)
    {
    iIndex = 1;
    sTag = GetLocalString(oQuestNPC,"QuestZone") + "_C" + IntToString(GetLocalInt(oQuestNPC,sQS + "CampSpot")) + "_";
    sWP = sTag + IntToString(iIndex);
    oWP = GetObjectByTag(sWP);
    //GetError("Checking " + GetTag(oWP));
    while (GetIsObjectValid(oWP))
        {
        oMob = GetObjectByTag(sWP + "_S");
        //GetError(GetTag(oMob) + "=" + GetName(oMob));
        DestroyObject(oMob,0.1);
        oMob = GetObjectByTag(sWP + "_S");
        iIndex++;
        sWP = sTag + IntToString(iIndex);
        oWP = GetObjectByTag(sWP);
        }
    }

sTag = GetLocalString(oQuestNPC,sQS + "Item");
if (sTag != "")
    if (!HasItem(oPC,sTag))
        CreateItemOnObject(sTag,oPC);

if (iQuestType == 3)
    {
    sTag = GetLocalString(oPC,"QuestTarget");
    AssignCommand(oPC,JumpToLocation(GetLocation(GetObjectByTag(sTag))));
    }
}
