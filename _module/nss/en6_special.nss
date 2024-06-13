//#include "prc_x2_itemprop"
#include "prc_x2_itemprop"
#include "prc_inc_spells"

void GetSpecialPowers(object oPC);
void FireShield(object oTarget);
void GetSpecialWeapon(object oPC);
void GetSpecialWeaponBonus(object oPC, object oItem);
int GetWPBDamage(object oPC);
int GetWPBDamageType(object oPC);

void main()
{
GetSpecialPowers(OBJECT_SELF);
}

void GetSpecialPowers(object oPC)
{
object oItem;
itemproperty ip;
string sTag;
int iEquip;
int iSpecialPowers;

oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);

if (!GetIsObjectValid(oItem))
    {
    sTag = "en3_pcskin";
    oItem = CreateItemOnObject(sTag,oPC);
    DelayCommand(0.1,AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CARMOUR)));
    }

iSpecialPowers = GetLocalInt(oPC,"SpecialPowers");

if (iSpecialPowers == 1) // Demonic Powers
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,4);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 2) // Enchanted
    {
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyRegeneration(5);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 3) //Enhanced Strength
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 4) // Fire Shield
    {
    FireShield(oPC);
    }
if (iSpecialPowers == 6) // Super Powers Regeneration
    {
    ip=ItemPropertyRegeneration(10);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 7) // Super Powers Speed
    {
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,10);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 8) // Super Powers Physical Invulnerability
    {
    ip = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_10,IP_CONST_DAMAGESOAK_50_HP);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 9) // Super Powers Magical Invulnerability
    {
    ip = ItemPropertyImmunityToSpellLevel(9);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 10) // Super Powers Strength
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,10);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 11) // GhostlyImage
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,10);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 12) // God-like powers
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,5);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,5);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyRegeneration(5);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_20_HP);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 13) // Strength
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,5);
    IPSafeAddItemProperty(oItem,ip);
    }
if (iSpecialPowers == 14) // Haste
    {
    ip = ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    }

GetSpecialWeapon(oPC);
}

void FireShield(object oTarget)
{

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    int nDuration = PRCGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = PRCGetMetaMagicFeat();

    effect eShield = EffectDamageShield(1, DAMAGE_BONUS_1d4, DAMAGE_TYPE_FIRE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 100);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eFire);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_ELEMENTAL_SHIELD, FALSE));


    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    if (!GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD))
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
}

void GetSpecialWeapon(object oPC)
{
object oItem;

oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK,oPC) > 0)
    oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);

if (GetIsObjectValid(oItem))
    GetSpecialWeaponBonus(oPC,oItem);

oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
if (GetIsObjectValid(oItem))
    GetSpecialWeaponBonus(oPC,oItem);
}

void GetSpecialWeaponBonus(object oPC, object oItem)
{
itemproperty ip;
int iDamageType;
int iFlag;

iFlag = FALSE;

if (IPGetIsMeleeWeapon(oItem) || IPGetIsProjectile(oItem) || (GetBaseItemType(oItem) == BASE_ITEM_GLOVES && GetLevelByClass(CLASS_TYPE_MONK,oPC) > 0))
    {
    if (GetLocalInt(oPC,"WeaponBonus") > 0)
        {
        iDamageType = GetWPBDamageType(oPC);
        ip=ItemPropertyDamageBonus(iDamageType,GetWPBDamage(oPC));
        IPSafeAddItemProperty(oItem,ip,86400.0f);
        iFlag = TRUE;
        }

    if (GetLocalInt(oPC,"SpecialWeapon") == 1)
        {
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,GetHitDice(oPC)/4+1);
        IPSafeAddItemProperty(oItem,ip,86400.0f);
        iFlag = TRUE;
        }

    if (GetLocalInt(oPC,"SpecialWeapon") == 2)
        {
        ip=ItemPropertyVampiricRegeneration(GetHitDice(oPC)/5+1);
        IPSafeAddItemProperty(oItem,ip,86400.0f);
        iFlag = TRUE;
        }
    if (GetLocalInt(oPC,"SpecialWeapon") == 3)
        {
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_LIGHTNING_BOLT,GetHitDice(oPC)/20+1);
        IPSafeAddItemProperty(oItem,ip,86400.0f);
        iFlag = TRUE;
        }
    }

if (iFlag == TRUE)
    SetLocalString(oItem,"PCWielder",GetName(oPC));

}

int GetWPBDamageType(object oPC)
{
int iDamageType;

iDamageType=IP_CONST_DAMAGETYPE_SONIC;

if (GetLocalInt(oPC,"WeaponBonus") == 1)
    iDamageType=IP_CONST_DAMAGETYPE_FIRE;
if (GetLocalInt(oPC,"WeaponBonus") == 2)
    iDamageType=IP_CONST_DAMAGETYPE_ELECTRICAL;
if (GetLocalInt(oPC,"WeaponBonus") == 3)
    iDamageType=IP_CONST_DAMAGETYPE_COLD;
if (GetLocalInt(oPC,"WeaponBonus") == 4)
    iDamageType=IP_CONST_DAMAGETYPE_ACID;

//SendMessageToPC(GetFirstPC(),"Sonic Type = " + IntToString(IP_CONST_DAMAGETYPE_SONIC));
//SendMessageToPC(GetFirstPC(),"DType = " + IntToString(iDamageType));
return iDamageType;
}

int GetWPBDamage(object oPC)
{
int iLevel;
int iBonus;

iLevel = GetHitDice(oPC);

if (iLevel < 3)
    iBonus = IP_CONST_DAMAGEBONUS_1;
else if (iLevel < 6)
    iBonus = IP_CONST_DAMAGEBONUS_1d4;
else if (iLevel < 10)
    iBonus = IP_CONST_DAMAGEBONUS_1d6;
else if (iLevel < 15)
    iBonus = IP_CONST_DAMAGEBONUS_1d8;
else
    iBonus = IP_CONST_DAMAGEBONUS_1d10;

return iBonus;
}

