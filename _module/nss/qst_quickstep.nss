#include "nw_i0_tool"

void main()
{
object oPC;
string sQuestCode;
string sTag;

oPC=GetPCSpeaker();
sTag=GetLocalString(oPC,"QuestItem");
sQuestCode=GetLocalString(oPC,"QuestScript");

if (GetLocalInt(oPC,"QuestHideItem") == 1 && HasItem(oPC,sTag))
    {
    object oItemToTake = GetItemPossessedBy(oPC, sTag);
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    }
ExecuteScript(sQuestCode,OBJECT_SELF);

}
