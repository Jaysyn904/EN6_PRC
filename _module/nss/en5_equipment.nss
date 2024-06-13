#include "en5_w_a_check"
#include "prc_x2_itemprop"

#include "en5_misc"

void EquipMob(object oMob);
void EquipWeapon(object oMob);
void EquipArmor(object oMob);
//int GetTwoHanded(string sTag);
int GetEnchantment(int iLevel);
void GetAmmo(object oCreature,string sTag,int iEnchant);
int GetAmmoEnchantBonus(int iEnchant);
void CreateHealingKit(object oTarget, int iItemLevel);
void CreatePotion(object oTarget, int iItemLevel);
void GetScroll(object oChest,int iLevel);

void EquipMob(object oMob)
{
int iLevel;
int iItemLevel;

EquipWeapon(oMob);
EquipArmor(oMob);

//DelayCommand(0.5f,AssignCommand(oMob,ActionEquipMostEffectiveArmor()));

iLevel=GetHitDice(oMob);
iItemLevel=GetItemLevel(iLevel);

if (GetLocalInt(oMob,"Boss") == 1)
    {
    if (GetLevelByClass(CLASS_TYPE_WIZARD,oMob)>0 || GetLevelByClass(CLASS_TYPE_SORCERER,oMob)>0)
        if (Random(10)==0)
            GetScroll(oMob,iLevel);
    } else {
    if (GetLevelByClass(CLASS_TYPE_WIZARD,oMob)>0 || GetLevelByClass(CLASS_TYPE_SORCERER,oMob)>0)
        if (Random(20)==0)
            GetScroll(oMob,iLevel);
    }
}

void EquipWeapon(object oMob)
{
int iLeftHand;
int iTwoWeapons;
int iShield;
int iRandom;
int iEnchant;
int iLevel;
int iChance;
int iTwoHanded;
string sRightHand;
string sLeftHand;
object oItem;
itemproperty ip;

SetLocalInt(oMob,"EN5_Equip",1);
GetWeaponType(oMob);

if (GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oMob) || GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_FIGHTING, oMob))
    iTwoWeapons ++;
if (GetHasFeat(FEAT_AMBIDEXTERITY, oMob))
    iTwoWeapons ++;
if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oMob))
    iShield = 1;

iLeftHand = 0;
if (iShield == 1)
    iLeftHand = 1;

if (iTwoWeapons == 1)
    if (Random(3) == 1)
        iLeftHand = 2;

if (iTwoWeapons == 2)
    iLeftHand = 2;


sRightHand = "en3_" + GetWeaponTag(oMob);
iTwoHanded = GetTwoHanded(sRightHand);

if (iTwoHanded == TRUE)
    iLeftHand = 0;

if (GetLevelByClass(CLASS_TYPE_WIZARD, oMob) >= 1 || GetLevelByClass(CLASS_TYPE_SORCERER, oMob) >= 1 || GetLevelByClass(CLASS_TYPE_MONK, oMob) >= 1)
    iTwoHanded = TRUE;

if (iTwoHanded == FALSE)
    {
    if (iLeftHand == 2)
        {
        sLeftHand = "en3_dagger";
        iRandom=Random(8)+1;
        if (GetCreatureSize(oMob) == CREATURE_SIZE_SMALL || GetCreatureSize(oMob) == CREATURE_SIZE_TINY)
            iRandom = 1;
        switch (iRandom)
            {
            case 1: sLeftHand = "en3_dagger"; break;
            case 2: sLeftHand = "en3_ssword"; break;
            case 3: sLeftHand = "en3_handaxe"; break;
            case 4: sLeftHand = "en3_ssword"; break;
            case 5: sLeftHand = "en3_dagger"; break;
            case 6: sLeftHand = "en3_handaxe"; break;
            case 7: sLeftHand = "en3_mace"; break;
            case 8: sLeftHand = "en3_sickle"; break;
            }
        if (FeatCheck(FEAT_WEAPON_PROFICIENCY_EXOTIC,oMob) && Random(2)>0)
            sLeftHand = "en3_kukri";

        } else {
        if (iLeftHand == 1)
            {
            iRandom=Random(3)+1;
            switch(iRandom)
                {
                case 1: sLeftHand = "en3_sshield"; break;
                case 2: sLeftHand = "en3_lshield"; break;
                case 3: sLeftHand = "en3_tshield"; break;
                }
            }
        }
    }

iEnchant = GetEnchantment(GetHitDice(oMob)-1);
if (iEnchant > 0)
    sRightHand = sRightHand + "1";
oItem=CreateItemOnObject(sRightHand,oMob,1);
if (iEnchant > 0)
    {
    if (IPGetIsRangedWeapon(oItem))
        ip = ItemPropertyAttackBonus(iEnchant);
    else
        ip = ItemPropertyEnhancementBonus(iEnchant);
    IPSafeAddItemProperty(oItem,ip);
    }

if (!GetIsObjectValid(oItem))
    SendMessageToPC(GetFirstPC(),"Could not create right hand item " + sRightHand + " on " + GetName(oMob));

EquipItem(INVENTORY_SLOT_RIGHTHAND, oItem, oMob);


if (iEnchant>0)
    {
    if (Random(100)>iEnchant+1)
        SetDroppableFlag(oItem,FALSE);
    } else {
    if (Random(100)>9)
        SetDroppableFlag(oItem,FALSE);
    }


if (sRightHand == "en3_hxbow" || sRightHand == "en3_lxbow" || sRightHand == "en3_hxbow1" || sRightHand == "en3_lxbow1" || sRightHand == "en3_hxbow2" || sRightHand == "en3_lxbow2")
    {
    GetAmmo(oMob,"en3_bolt",iEnchant);
    }

if (sRightHand == "en3_longbow" || sRightHand == "en3_sbow" || sRightHand == "en3_longbow1" || sRightHand == "en3_sbow1" || sRightHand == "en3_longbow2" || sRightHand == "en3_sbow2")
    {
    GetAmmo(oMob,"en3_arrow",iEnchant);
    }
if (sRightHand == "en3_sling" || sRightHand == "en3_sling1" || sRightHand == "en3_sling2")
    {
    GetAmmo(oMob,"en3_bullet",iEnchant);
    }


if (iLeftHand > 0)
    {
    iEnchant = GetEnchantment(GetHitDice(oMob)-1);
    if (iLeftHand == 1 && iEnchant == 0)
        sLeftHand = sLeftHand + "_" + IntToString(Random(3)+1);
    if (iEnchant>0)
        sLeftHand = sLeftHand + "1";
    oItem=CreateItemOnObject(sLeftHand,oMob,1);
    if (iEnchant > 0)
        {
        if (IPGetIsRangedWeapon(oItem))
            ip = ItemPropertyAttackBonus(iEnchant);
        else
            if (iLeftHand == 1)
                ip = ItemPropertyACBonus(iEnchant);
            else
                ip = ItemPropertyEnhancementBonus(iEnchant);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (!GetIsObjectValid(oItem))
        SendMessageToPC(GetFirstPC(),"Could not create left hand item " + sLeftHand + " on " + GetName(oMob));
    EquipItem(INVENTORY_SLOT_LEFTHAND, oItem, oMob);
    if (iEnchant>0)
        {
        if (Random(100)>(iEnchant+1) * (GetLocalInt(GetModule(),"MagicLevel")+1))
            SetDroppableFlag(oItem,FALSE);
        } else {
        if (Random(100)>9)
            SetDroppableFlag(oItem,FALSE);
        }
    }

    if (iEnchant>0)
        {
        string sName;
        sName=GetName(oItem);
        if (GetStringLeft(sName,9) == "Enchanted")
            sName=GetStringRight(sName,GetStringLength(sName)-10);
        if (GetStringLeft(sName,7) == "Magical")
            sName=GetStringRight(sName,GetStringLength(sName)-8);
        sName = "+" + IntToString(iEnchant) + " " + sName;
        SetName(oItem,sName);
        }
}

void EquipArmor(object oMob)
{
int iArmor;
int iEnchant;
string sArmorTag;
object oItem;
itemproperty ip;

SetLocalInt(oMob,"Armor",1);

iEnchant = 0;
iArmor = ENGetArmorType(oMob);
if (iArmor == 3 && GetHitDice(oMob)<4)
    iArmor=2;
if (iArmor == 3 && GetHitDice(oMob)<6 && Random(2)==0)
    iArmor=2;
sArmorTag = GetArmorTag(iArmor);
iEnchant = GetEnchantment(GetHitDice(oMob)-1);

if (iEnchant > 0)
    sArmorTag = sArmorTag + IntToString(Random(2));
else if (Random(2)>0)
    sArmorTag = sArmorTag + "_" + IntToString(Random(2)+1);

oItem=CreateItemOnObject(sArmorTag,oMob,1);
if (!GetIsObjectValid(oItem))
    SendMessageToPC(GetFirstPC(),"Could not create armor " + sArmorTag + " on " + GetName(oMob));

if (iEnchant > 0)
    {
    ip = ItemPropertyACBonus(iEnchant);
    IPSafeAddItemProperty(oItem,ip);
    }

EquipItem(INVENTORY_SLOT_CHEST, oItem, oMob);

SetLocalString(oMob,"EN6_ARMOR",GetTag(oItem));

if (iEnchant>0)
    {
    if (Random(100)>iEnchant+1)
        SetDroppableFlag(oItem,FALSE);
    } else {
    if (Random(100)>4)
        SetDroppableFlag(oItem,FALSE);
    }

if (iArmor < 4 && Random(100) < iArmor * 25)
    {
    iEnchant = GetEnchantment(GetHitDice(oMob)-1);
    sArmorTag = "en3_helm_" + IntToString(Random(10)+1);
    oItem=CreateItemOnObject(sArmorTag,oMob,1);
    SetDroppableFlag(oItem,FALSE);
    SetLocalInt(oItem,"EN5_EQUIP",INVENTORY_SLOT_HEAD);
    if (iEnchant > 0)
        {
        ip = ItemPropertyACBonus(iEnchant);
        IPSafeAddItemProperty(oItem,ip);
        }
    EquipItem(INVENTORY_SLOT_HEAD, oItem, oMob);
    }

}


int GetEnchantment(int iLevel)
{
int iChance;
int iEnchant;
int iRandom;

iEnchant = 0;
iChance = 2 * iLevel;

if (GetLocalInt(GetModule(),"MagicLevel")==1)
    iChance=iChance + iChance/10;
if (GetLocalInt(GetModule(),"MagicLevel")==2)
    if (iLevel>5)
        iChance=iChance+2;
    iChance=iChance + iChance/5;
if (GetLocalInt(GetModule(),"MagicLevel")==3)
    iChance=iChance+3;
    iChance=iChance + iChance/3;

while (iChance > 0)
    {
    iRandom = Random(100);
    if (iRandom<iChance && iRandom < 90)
        iEnchant++;
    if (iChance < 41)
        iChance = iChance - 5;
    if (iChance > 40 && iChance < 48)
        iChance = iChance - 7;
    if (iChance > 47)
        iChance = iChance - 10;
    }

return iEnchant;
}

void GetAmmo(object oCreature,string sTag,int iEnchant)
{
object oItem;
itemproperty iProperty;

if (iEnchant>1)
    {
    sTag=sTag + "1";
    oItem =CreateItemOnObject(sTag,oCreature,99);
    iProperty = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,GetAmmoEnchantBonus(Random(iEnchant)+1));
    IPSafeAddItemProperty(oItem,iProperty);
    } else {
        oItem =CreateItemOnObject(sTag,oCreature,99);
    }
}

int GetAmmoEnchantBonus(int iEnchant)
{
int iBonus;

iBonus = IP_CONST_DAMAGEBONUS_1;

if (iEnchant > 10)
    iBonus = IP_CONST_DAMAGEBONUS_2d10;

switch (iEnchant)
    {
    case 1: iBonus = IP_CONST_DAMAGEBONUS_1; break;
    case 2: iBonus = IP_CONST_DAMAGEBONUS_2; break;
    case 3: iBonus = IP_CONST_DAMAGEBONUS_3; break;
    case 4: iBonus = IP_CONST_DAMAGEBONUS_4; break;
    case 5: iBonus = IP_CONST_DAMAGEBONUS_5; break;
    case 6: iBonus = IP_CONST_DAMAGEBONUS_6; break;
    case 7: iBonus = IP_CONST_DAMAGEBONUS_7; break;
    case 8: iBonus = IP_CONST_DAMAGEBONUS_8; break;
    case 9: iBonus = IP_CONST_DAMAGEBONUS_9; break;
    case 10: iBonus = IP_CONST_DAMAGEBONUS_10; break;
    }

return iBonus;
}

void GetScroll(object oChest,int iLevel)
{
string sRes;
int iScroll;
int iScrollLevel;
int iMaxScrollLevel;
object oItem;

iMaxScrollLevel =  iLevel/2+1;

//sRes = "nw_it_sparscr216";

while (!GetIsObjectValid(oItem))
    {
    iScrollLevel = Random(iMaxScrollLevel)+1;
    if (iScrollLevel > 9)
        iScrollLevel=9;

    iScroll = Random(21)+1;
    if (iScroll < 10)
        sRes = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + "0" + IntToString(iScroll);
    else
        sRes = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + IntToString(iScroll);
    oItem =CreateItemOnObject(sRes, oChest, 1);
    }

}




