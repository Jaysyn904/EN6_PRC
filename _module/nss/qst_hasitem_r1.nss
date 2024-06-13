#include "nw_i0_tool"
#include "en5_misc"

int StartingConditional()
{
object oPC;
int iResult;
string sTag;

oPC = GetPCSpeaker();
sTag = GetLocalString(oPC,"QuestItem");

//GetError("Tag = "  + sTag + " | QuestNPC = " + GetLocalString(GetPCSpeaker(),"QuestNPC") + " | Response = " + IntToString(GetLocalInt(GetPCSpeaker(),"QuestResponse")));

iResult = FALSE;
if (HasItem(oPC,sTag) && GetLocalString(GetPCSpeaker(),"QuestNPC") == GetTag(OBJECT_SELF) && GetLocalInt(GetPCSpeaker(),"QuestResponse") == 1)
    iResult = TRUE;

return iResult;
}
