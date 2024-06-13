#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
itemproperty ip;
int iBlessing;
int iDamage;

oPC=GetPCSpeaker();
iBlessing = GetLocalInt(oPC,"DivineBlessing");
if (iBlessing>8)
    iBlessing = 8;

switch (iBlessing)
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
        if (iBlessing>3)
            {
            ip=ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_1D6LIGHT);
            IPSafeAddItemProperty(oItem,ip);
            SetStolenFlag(oItem,TRUE);
            }
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,iDamage);
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
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,iDamage);
        IPSafeAddItemProperty(oItem,ip);
        SetStolenFlag(oItem,TRUE);
        }
    DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_BLESS_WEAPON,oPC)));

    }
}


