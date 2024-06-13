#include "x2_inc_switches"

void main()
{
int nEvent;
object oItem;
object oPC;

nEvent = GetUserDefinedItemEventNumber();

if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    oPC   = GetItemActivator();
    if (GetIsPC(oPC))
        {
        oItem = GetItemActivated();
        if (GetTag(oItem) == "en5_info")
            {
            DelayCommand(0.1f,AssignCommand(oPC,ActionStartConversation(oPC,"cnv_en5_info",TRUE,FALSE)));
            }
        }
    }

}
