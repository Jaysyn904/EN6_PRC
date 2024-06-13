int PhantomDmgType();

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "x2_inc_switches"
#include "prc_x2_itemprop"
void main()
{
    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");

    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    /*  Fix for the new golems to reduce their number of attacks */

    int nNumber = GetLocalInt(OBJECT_SELF,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber >0 )
    {
        SetBaseAttackBonus(nNumber);
    }

object oItem;
object oOldItem;
int iType;
itemproperty iProperty;

oOldItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
AssignCommand(OBJECT_SELF,ActionUnequipItem(oOldItem));
DestroyObject(oOldItem);

oItem=CreateItemOnObject("en3_lsword",OBJECT_SELF,1);
iProperty=ItemPropertyEnhancementBonus(5);
IPSafeAddItemProperty(oItem,iProperty);
iType = PhantomDmgType();
if (iType>=0)
    iProperty=ItemPropertyDamageBonus(iType,IP_CONST_DAMAGEBONUS_1d10);
else
    iProperty=ItemPropertyVampiricRegeneration(5);
IPSafeAddItemProperty(oItem,iProperty);

//INVENTORY_SLOT_RIGHTHAND

AssignCommand(OBJECT_SELF, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
SetDroppableFlag(oItem,FALSE);

    // Execute default OnSpawn script.
    ExecuteScript("nw_c2_default9", OBJECT_SELF);


    //Post Spawn event requeste
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }

}

int PhantomDmgType()
{
int iRandom;
int iType;

iRandom = Random(6)+1;
iType = IP_CONST_DAMAGETYPE_SONIC;

switch (iRandom)
    {
    case 1: iType = IP_CONST_DAMAGETYPE_ACID; break;
    case 2: iType = IP_CONST_DAMAGETYPE_COLD; break;
    case 3: iType = IP_CONST_DAMAGETYPE_ELECTRICAL; break;
    case 4: iType = IP_CONST_DAMAGETYPE_FIRE; break;
    case 5: iType = IP_CONST_DAMAGETYPE_SONIC; break;
    case 6: iType = -1; break;
    }

return iType;
}
