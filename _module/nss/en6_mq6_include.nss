#include "en5_treasure"

void GetMQ6Powers(object oPC);
int GetWPBonusDamage(object oPC);

void GetMQ6Powers(object oPC)
{
string sTag;
int iType;
object oItem;
itemproperty ip;
int iEnchant;
int iBonus;
int iSpellLevel;
int iAlign;
int iAlign2;
int iLevel;
int iRegen;

sTag=GetLocalString(oPC,"QPTag");
iType=GetLocalInt(oPC,"MQ6ItemType");
oItem=GetItemPossessedBy(oPC,sTag);
iAlign=GetLocalInt(oPC,"MQ6Alignment");
iAlign2=GetLocalInt(oPC,"MQ6Alignment2");
iLevel=GetHitDice(oPC);

if (iType<2)
    {
    iEnchant=iLevel/5+1;
    iBonus=iEnchant+3;
    if (iType==0)
        ip=ItemPropertyEnhancementBonus(iEnchant);
    else
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,GetEnchantBonus(iEnchant));
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyAttackBonus(iBonus);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyKeen();
    IPSafeAddItemProperty(oItem,ip);
    if (iLevel>10)
        {
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iLevel>15)
        {
        ip=ItemPropertyHaste();
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iLevel>20)
        {
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iAlign==1)
        {
        iSpellLevel=(iLevel+5)/10+1;
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,iSpellLevel);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,GetWPBonusDamage(oPC));
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyVisualEffect(ITEM_VISUAL_EVIL);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iAlign==2)
        {
        iSpellLevel=(iLevel+5)/10+1;
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_SEARING_LIGHT,iSpellLevel);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,GetWPBonusDamage(oPC));
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyRegeneration(iSpellLevel);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyVisualEffect(ITEM_VISUAL_HOLY);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iAlign==3)
        {
        iSpellLevel=(iLevel+5)/10+1;
        if (iAlign2==0)
            ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,iSpellLevel);
        else
            ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_SEARING_LIGHT,iSpellLevel);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,GetWPBonusDamage(oPC));
        IPSafeAddItemProperty(oItem,ip);
        if (iAlign2>0)
            {
            ip=ItemPropertyRegeneration(iSpellLevel);
            IPSafeAddItemProperty(oItem,ip);
            }
        ip=ItemPropertyVisualEffect(ITEM_VISUAL_SONIC);
        IPSafeAddItemProperty(oItem,ip);
        }
    } else {
    iEnchant=iLevel/5+1;
    iRegen=iLevel/6+1;
    ip=ItemPropertyACBonus(iEnchant);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyRegeneration(iRegen);
    IPSafeAddItemProperty(oItem,ip);
    if (iLevel>10)
        {
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iLevel>15)
        {
        ip=ItemPropertyHaste();
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iLevel>20)
        {
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20);
        IPSafeAddItemProperty(oItem,ip);
        }

        iSpellLevel=1;
        if (iLevel>20)
            iSpellLevel=2;
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_MAGIC_MISSILE,iSpellLevel);
        IPSafeAddItemProperty(oItem,ip);
    }

}

int GetWPBonusDamage(object oPC)
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
else if (iLevel < 25)
    iBonus = IP_CONST_DAMAGEBONUS_1d10;
else if (iLevel < 40)
    iBonus = IP_CONST_DAMAGEBONUS_2d6;
else
    iBonus = IP_CONST_DAMAGEBONUS_2d8;

return iBonus;
}

