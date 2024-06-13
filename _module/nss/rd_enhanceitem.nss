#include "prc_x2_itemprop"
#include "nw_i0_tool"

void UseComponent(string sItemTag);
string AddEffectToItem(object oPC, object oItem, string sTag,itemproperty ip, int iGold);

void UseComponent(string sItemTag)
{
int iFlag;
int iGoldCost;
int iItemPosition;
int iRandom;
int iX;
int iY;
string sTag;
string sMessage;
object oPC;
object oItem;
itemproperty ip;

iFlag = 0;
sMessage = "";

oPC = GetPCSpeaker();

sTag = "NW_IT_MSMLMISC19";

if (sItemTag == sTag)
    {
    iFlag = 1;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    oItem = GetItemInSlot(iItemPosition,oPC);
    iGoldCost = 100;
    ip = ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_GREEN);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);

    }

sTag = "en4_mheart";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;
    oItem = GetItemInSlot(iItemPosition,oPC);
    iX = IPGetWeaponEnhancementBonus(oItem);
    iGoldCost = 25000;
    if (iX<3)
        {
        ip = ItemPropertyEnhancementBonus(3);
        sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
        }
    else if (iX==3)
        {
        ip = ItemPropertyEnhancementBonus(4);
        sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
        }
    else
        sMessage = "Weapon too strong for effect to be added.";
    }

sTag = "en4_mheart";
if (sItemTag == sTag && GetLevelByClass(CLASS_TYPE_MONK,oPC)>0)
    {
    iFlag = 1;
    iGoldCost = 5000;
    iItemPosition = INVENTORY_SLOT_ARMS;
    oItem = GetItemInSlot(iItemPosition,oPC);
    ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d8);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_ostinger";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;
    oItem = GetItemInSlot(iItemPosition,oPC);
    iX = IPGetWeaponEnhancementBonus(oItem);
    iGoldCost = 2000 * iX;
    if (iX<4)
        {
        ip = ItemPropertyEnhancementBonus(iX+1);
        sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
        }
    else
        sMessage = "Weapon too strong for effect to be added.";
    }

sTag = "en4_ostinger";
if (sItemTag == sTag && GetLevelByClass(CLASS_TYPE_MONK,oPC)>0)
    {
    iFlag = 1;
    iGoldCost = 3000;
    iItemPosition = INVENTORY_SLOT_ARMS;
    oItem = GetItemInSlot(iItemPosition,oPC);
    ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d4);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_bargskin";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;
    oItem = GetItemInSlot(iItemPosition,oPC);
    iX = IPGetWeaponEnhancementBonus(oItem);
    iGoldCost = 1000 * (iX+1);
    if (iX<2)
        {
        ip = ItemPropertyEnhancementBonus(iX+1);
        sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
        }
    else
        sMessage = "Weapon too strong for effect to be added.";

    }

sTag = "en4_bargskin";
if (sItemTag == sTag && GetLevelByClass(CLASS_TYPE_MONK,oPC)>0)
    {
    iFlag = 1;
    iGoldCost = 1000;
    iItemPosition = INVENTORY_SLOT_ARMS;
    oItem = GetItemInSlot(iItemPosition,oPC);
    ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_2);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }


sTag = "en4_licheye";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 50000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;
    oItem = GetItemInSlot(iItemPosition,oPC);
    ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,5);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_licheye";
if (sItemTag == sTag && GetLevelByClass(CLASS_TYPE_MONK,oPC)>0)
    {
    iFlag = 1;
    iGoldCost = 50000;
    iItemPosition = INVENTORY_SLOT_ARMS;
    oItem = GetItemInSlot(iItemPosition,oPC);
    ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,5);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_lichdust";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;
    oItem = GetItemInSlot(iItemPosition,oPC);
    iX = IPGetWeaponEnhancementBonus(oItem);
    iGoldCost = 50000;
    if (iX<4)
        {
        ip = ItemPropertyEnhancementBonus(4);
        sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
        }
    else if (iX==4)
        {
        ip = ItemPropertyEnhancementBonus(5);
        sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
        }
    else
        sMessage = "Weapon too strong for effect to be added.";
    }

sTag = "en4_lichdust";
if (sItemTag == sTag && GetLevelByClass(CLASS_TYPE_MONK,oPC)>0)
    {
    iFlag = 1;
    iGoldCost = 15000;
    iItemPosition = INVENTORY_SLOT_ARMS;
    oItem = GetItemInSlot(iItemPosition,oPC);
    ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d10);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_demonhide";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 15000;
    iItemPosition = INVENTORY_SLOT_CHEST;
    ip = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "NW_IT_MSMLMISC14";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 500;
    iItemPosition = INVENTORY_SLOT_HEAD;
    ip = ItemPropertyACBonus(1);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "NW_IT_MSMLMISC09";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 8000;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    ip = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "NW_IT_MSMLMISC10";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 1000;
    iItemPosition = INVENTORY_SLOT_BELT;
    ip = ItemPropertyACBonus(2);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_salskin";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 10000;
    iItemPosition = INVENTORY_SLOT_LEFTHAND;
    ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_rscale";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 20000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;
    ip = ItemPropertyKeen();
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_bbvsack";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 3000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;
    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_BLINDNESS,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_igtongue";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 500;
    iItemPosition = INVENTORY_SLOT_BOOTS;
    ip = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEIMMUNITY_50_PERCENT);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_wessence";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 15000;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_ceye";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 5000;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    ip=ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,Random(2)+1);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_ftooth";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 500;
    iItemPosition = INVENTORY_SLOT_NECK;
    ip = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "NW_IT_MSMLMISC06";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 5000;
    iItemPosition = INVENTORY_SLOT_NECK;
    ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,4);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "NW_IT_MSMLMISC17";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 25000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: iX = IP_CONST_DAMAGETYPE_ACID; break;
        case 2: iX = IP_CONST_DAMAGETYPE_COLD; break;
        case 3: iX = IP_CONST_DAMAGETYPE_ELECTRICAL; break;
        case 4: iX = IP_CONST_DAMAGETYPE_FIRE; break;
        }

    ip = ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_1d4);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_beye";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 50000;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    iRandom = Random(10)+1;
    switch (iRandom)
        {
        case 1: ip = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20); break;
        case 2: ip = ItemPropertyFreeAction(); break;
        case 3: ip = ItemPropertyHaste(); break;
        case 4: ip = ItemPropertyRegeneration(Random(4)+2); break;
        case 5: ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR); break;
        case 6: ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS); break;
        case 7: ip = ItemPropertyImmunityToSpellLevel(Random(3)+1); break;
        case 8: ip = ItemPropertyCastSpell(IP_CONST_CASTSPELL_FLESH_TO_STONE_5,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY); break;
        case 9: ip = ItemPropertyCastSpell(IP_CONST_CASTSPELL_STONESKIN_7,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY); break;
        case 10: ip = ItemPropertyCastSpell(IP_CONST_CASTSPELL_PRISMATIC_SPRAY_13,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY); break;
        }
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_mskull";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 1500;
    iItemPosition = INVENTORY_SLOT_HEAD;
    ip = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_seye";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 1000;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_mfstalk";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 50000;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }
sTag = "en4_gheart";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 50000;
    iItemPosition = INVENTORY_SLOT_RIGHTRING;
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
    oItem = GetItemInSlot(iItemPosition,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en3_igeye";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 10000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    iX = IP_CONST_DAMAGETYPE_COLD;
    iY = IP_CONST_DAMAGEBONUS_2;

    ip = ItemPropertyDamageBonus(iX,iY);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_lichskull";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 50000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    iX = IP_CONST_DAMAGETYPE_MAGICAL;
    iY = IP_CONST_DAMAGEBONUS_1d6;

    ip = ItemPropertyDamageBonus(iX,iY);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_cubeooze";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 25000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    iX = IP_CONST_DAMAGETYPE_ACID;
    iY = IP_CONST_DAMAGEBONUS_1d4;

    ip = ItemPropertyDamageBonus(iX,iY);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_ghair";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 5000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    iX = IP_CONST_DAMAGETYPE_MAGICAL;
    iY = IP_CONST_DAMAGEBONUS_1d4;

    ip = ItemPropertyDamageBonus(iX,iY);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_cfeather";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 25000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL,IP_CONST_ONHIT_SAVEDC_14);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_nheart";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 25000;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    ip = ItemPropertyVampiricRegeneration(5);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

sTag = "en4_mspike";
if (sItemTag == sTag)
    {
    iFlag = 1;
    iGoldCost = 2500;
    iItemPosition = INVENTORY_SLOT_RIGHTHAND;

    ip = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10);
    oItem = GetItemInSlot(iItemPosition,oPC);
    if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    sMessage = sMessage + AddEffectToItem(oPC,oItem,sTag,ip,iGoldCost);
    }

if (iFlag == 0)
    sMessage = "You have no items found that I could use.";

SpeakString(sMessage);
}

string AddEffectToItem(object oPC, object oItem, string sTag,itemproperty ip, int iGoldCost)
{
int iGold;
string sMessage;
object oItemToTake;

iGold = GetGold(oPC);

if (GetIsObjectValid(oItem))
    {
    if (iGoldCost <= iGold)
        {
        TakeGoldFromCreature(iGoldCost,oPC);
        oItemToTake = GetItemPossessedBy(oPC, sTag);
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);

        IPSafeAddItemProperty(oItem,ip);
        sMessage = "Effect added to " + GetName(oItem) + ".  ";
        } else {
        sMessage = "It will take " + IntToString(iGoldCost) + " gold to use the " + GetName(GetItemPossessedBy(oPC, sTag)) + ".  ";
        }
    } else {
        sMessage = "You lack the right item for the " + GetName(GetItemPossessedBy(oPC, sTag)) + ".  ";
    }

return sMessage;
}
