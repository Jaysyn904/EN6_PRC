#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
itemproperty ip;
int iFavor;
int iDamage;

oPC=GetPCSpeaker();
iFavor = GetLocalInt(oPC,"MagicalFavor");
if (iFavor>8)
    iFavor = 8;

switch (iFavor)
    {
    case 1: iDamage = DAMAGE_BONUS_1; break;
    case 2: iDamage = DAMAGE_BONUS_2; break;
    case 3: iDamage = DAMAGE_BONUS_1d4; break;
    case 4: iDamage = DAMAGE_BONUS_1d6; break;
    case 5: iDamage = DAMAGE_BONUS_1d8; break;
    case 6: iDamage = DAMAGE_BONUS_1d10; break;
    case 7: iDamage = DAMAGE_BONUS_2d6; break;
    case 8: iDamage = DAMAGE_BONUS_2d8; break;
    }

oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
if (!GetIsObjectValid(oItem))
    oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);

if (GetIsObjectValid(oItem))
    {
    if (IPGetIsRangedWeapon(oItem))
        {
        if (iFavor>3)
            {
            ip=ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_1D6LIGHT);
            IPSafeAddItemProperty(oItem,ip);
            SetStolenFlag(oItem,TRUE);
            }
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,iDamage);
        oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
        if (GetIsObjectValid(oItem))
            {
            IPSafeAddItemProperty(oItem,ip);
            SetStolenFlag(oItem,TRUE);
            }
        oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
        if (GetIsObjectValid(oItem))
            {
            IPSafeAddItemProperty(oItem,ip);
            SetStolenFlag(oItem,TRUE);
            }
        oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
        if (GetIsObjectValid(oItem))
            {
            IPSafeAddItemProperty(oItem,ip);
            SetStolenFlag(oItem,TRUE);
            }
        } else {
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,iDamage);
        IPSafeAddItemProperty(oItem,ip);
        SetStolenFlag(oItem,TRUE);
        }
    DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_GREATER_MAGIC_WEAPON,oPC)));

    }
}

