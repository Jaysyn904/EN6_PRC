#include "nw_i0_tool"

void main()
{
object oPC;
string sTag;

oPC = GetPCSpeaker();
sTag = "en6_special_ring";

if (!HasItem(oPC,sTag))
    CreateItemOnObject(sTag,oPC);
}
