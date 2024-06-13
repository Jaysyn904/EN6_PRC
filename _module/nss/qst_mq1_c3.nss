#include "nw_i0_tool"

int StartingConditional()
{
object oPC;
int iResult;
string sTag;

oPC = GetPCSpeaker();
sTag = "en6_mq1item";

iResult = FALSE;
if (HasItem(oPC,sTag))
    iResult = TRUE;

return iResult;
}
