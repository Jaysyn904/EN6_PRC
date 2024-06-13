#include "nw_i0_tool"
//#include "en5_misc"
int StartingConditional()
{
object oPC;
int iResult;
int iQuestType;
string sTag;

oPC = GetPCSpeaker();
sTag = GetLocalString(oPC,"QuestItem");
iQuestType = GetLocalInt(GetPCSpeaker(),"QuestType");
//GetError("Item=" + GetLocalString(oPC,"QuestItem") + " | Type = " + IntToString(GetLocalInt(GetPCSpeaker(),"QuestType")));
iResult = FALSE;
if (HasItem(oPC,sTag) && GetLocalString(GetPCSpeaker(),"QuestNPC") == GetTag(OBJECT_SELF) && iQuestType == 4)
    iResult = TRUE;

return iResult;
}


