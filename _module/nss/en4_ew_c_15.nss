#include "nw_i0_tool"

int StartingConditional()
{
int iResult;
string sTag;

iResult = FALSE;
sTag = "en4_lichdust";
if (HasItem(GetPCSpeaker(),sTag))
    iResult = TRUE;

return iResult;
}
