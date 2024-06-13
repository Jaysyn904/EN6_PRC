#include "nw_i0_tool"

int StartingConditional()
{
object oPC;
int iResult;
string sTag;

oPC = GetPCSpeaker();
sTag = GetLocalString(oPC,"QuestItem");

iResult = FALSE;
if (HasItem(oPC,sTag) && GetLocalString(GetPCSpeaker(),"QuestNPC") == GetTag(OBJECT_SELF) && GetLocalInt(GetPCSpeaker(),"QuestResponse") == 2)
    iResult = TRUE;

return iResult;
}
