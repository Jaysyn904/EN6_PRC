#include "nw_i0_tool"

int StartingConditional()
{
object oPC;
int iResult;
int iResponse;
string sTag;

oPC = GetPCSpeaker();
sTag = GetLocalString(oPC,"QuestItem");
iResponse = GetLocalInt(oPC,"QuestResponse");

iResult = FALSE;
if (HasItem(oPC,sTag) && GetLocalString(GetPCSpeaker(),"QuestNPC") == GetTag(OBJECT_SELF) && iResponse == 1)
    iResult = TRUE;

return iResult;
}
