#include "nw_i0_tool"

int StartingConditional()
{
object oPC;
int iResult;
string sTag;

oPC = GetPCSpeaker();
sTag = GetLocalString(oPC,"QuestItem");

iResult = FALSE;
if (HasItem(oPC,sTag))
    iResult = TRUE;

return iResult;
}
