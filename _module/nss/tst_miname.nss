
#include "en5_treasure"

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

sTag=GetLocalString(oPC,"QPTag");
iType=GetLocalInt(oPC,"MQ6ItemType");
oItem=GetItemPossessedBy(oPC,sTag);
iAlign=GetLocalInt(oPC,"MQ6Alignment");
iAlign2=GetLocalInt(oPC,"MQ6Alignment2");
iLevel=GetHitDice(oPC);

iEnchant=iLevel/5+1;
ip=ItemPropertyACBonus(iEnchant);
IPSafeAddItemProperty(oItem,ip);
ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP);
IPSafeAddItemProperty(oItem,ip);

        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
        IPSafeAddItemProperty(oItem,ip);

        ip=ItemPropertyHaste();
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_10_HP);
        IPSafeAddItemProperty(oItem,ip);

        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_10_HP);
        IPSafeAddItemProperty(oItem,ip);

        iSpellLevel=1;
        if (iLevel>20)
            iSpellLevel=2;
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_MAGIC_MISSILE,iSpellLevel);
        IPSafeAddItemProperty(oItem,ip);
}
void main()
{
string sTag;
int iType;
object oItem;
string sName;
object oPC;
int iValue;

oPC=GetPCSpeaker();
CreateItemOnObject("en6_mq6robes",oPC);
SetLocalString(oPC,"QPTag","en6_mq6robes");
SetLocalInt(oPC,"MQ6ItemType",2);
sTag=GetLocalString(oPC,"QPTag");
iType=GetLocalInt(oPC,"MQ6ItemType");
oItem=GetItemPossessedBy(oPC,sTag);

sName=GetName(oItem);
if (iType<2)
    {
    if (GetStringLeft(sName,7) == "Special")
        sName=GetStringRight(sName,GetStringLength(sName)-8);
    }
sName = sName + " of Narsis";
SetName(oItem,sName);
//SetLocalInt(oPC,"MQ6ItemMade",1);

if (GetGoodEvilValue(oPC) <35)
    iValue=1;
else if (GetGoodEvilValue(oPC) >65)
    iValue=2;
else
    iValue=3;

SetLocalInt(oPC,"MQ6Alignment",iValue);
SetLocalInt(oPC,"MQ6Alignment2",Random(2));

GetMQ6Powers(oPC);
}



/*
#include "en5_treasure"

void main()
{
int iX;
iX=Random(3);

if (iX==0)
    GetRandomMagic(GetPCSpeaker(),Random(6)+1);
else if (iX==1)
    GetRandomMagic(GetPCSpeaker(),Random(6)+1,1);
else
    GetRandomMagic(GetPCSpeaker(),Random(6)+1,3);
}
*/
