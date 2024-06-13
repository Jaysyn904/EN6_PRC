#include "nw_i0_tool"

int StartingConditional()
{
int iResult;
string sTag;

iResult = FALSE;
sTag = "NW_IT_MSMLMISC17";
if (HasItem(GetPCSpeaker(),sTag))
    iResult = TRUE;

return iResult;
}
