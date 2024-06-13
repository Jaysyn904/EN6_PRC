#include "x2_inc_switches"
void main()
{
int nEvent =GetUserDefinedItemEventNumber();
object oItem = GetItemActivated();
object oPC   = GetItemActivator();

if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
 {
    SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
    int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
    if (nRet == X2_EXECUTE_SCRIPT_END)
    {
       return;
    }
}

}


