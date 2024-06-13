#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
itemproperty ip;
int iBlessing;
int iDamage;

oPC=GetPCSpeaker();
SetLocalInt(oPC,"TempPowers",1);
iDamage = DAMAGE_BONUS_1;

oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
if (!GetIsObjectValid(oItem))
    oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);

if (GetIsObjectValid(oItem))
    {
    if (IPGetIsRangedWeapon(oItem))
        {
        ip=ItemPropertyEnhancementBonus(2);
        oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
        if (GetIsObjectValid(oItem))
            IPSafeAddItemProperty(oItem,ip,4.0*60*60);
        oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
        if (GetIsObjectValid(oItem))
            IPSafeAddItemProperty(oItem,ip,4.0*60*60);
        oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
        if (GetIsObjectValid(oItem))
            IPSafeAddItemProperty(oItem,ip,4.0*60*60);
        } else {
        ip=ItemPropertyEnhancementBonus(2);
        IPSafeAddItemProperty(oItem,ip,4.0*60*60);
        }
    DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_MAGIC_WEAPON,oPC)));
    TakeGoldFromCreature(200,oPC,TRUE);
    }
}


