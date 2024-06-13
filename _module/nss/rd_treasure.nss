#include "rd_w_a_check"
#include "prc_x2_itemprop"
#include "x2_inc_treasure"
#include "rd_equipment"
#include "x2_inc_compon"

void EquipMob(object oCreature,int iBoss=0,int iAdjust=0);
string GetArmorTag(int iArmor);
string GetWeaponTag(object oCreature);
void EquipItem(int iItemSlot,object oItem, object oCreature);
int GetEnchantment(int iLevel);
void CreateEnchantedItem(object oCreature,string sTag,int iEnchant,int iType, int iPosition = -1,int iBoss=0);
itemproperty zGetItemProperty(int iType=0, int iEnchant=0, int iNoEnchantBonus =0);
void GetMiscMagic(object oCreature, int iDroppable=TRUE);
void GetMagicItem(object oCreature, int iDroppable=TRUE, int iQuest = FALSE, int iForceRandom = 0);
int GetTwoHanded(string sTag);
object GetRandomTreasurePC();
void GetAmmo(object oCreature,string sTag,int iEnchant);
int DamageType();
int GetEnchantBonus(int iEnchant);
int DamageBonus();
itemproperty GetAmmunitionProperty();
int HealSpell();
int CastSpellUses();
int GetEnchantments(object oItem);
itemproperty MiscMagicProperty(int iEnchant);
itemproperty MinorMagicProperty(int iEnchant);
itemproperty ArmorProperty(int iEnchant);
itemproperty WeaponProperty(int iEnchant);
itemproperty RangedWeaponProperty(int iEnchant);
itemproperty MonkWeaponProperty(int iEnchant);
itemproperty CastSpellEffect();
itemproperty CastSpellEffectOnce();
void CreateSpecialPowers(object oPC);
void GetSpecialPowers(object oPC);
void GetSuperPowers(object oPC);
void FireShield(object oTarget);
void CreateSuperPowers(object oPC);
void CreateEvilPowers(object oPC);
void GetEvilPowers(object oPC);
void ItemOfPower(object oPC);
void GetInfiniteSpells(object oPC);
void IE_MagicalRing(object oPC);
void MakeStatue(object oPC);
void GetArtifact(object oCreature);
itemproperty ArtifactProperty();
void GetMinorMagicItem(object oCreature, int iDroppable = TRUE);
int GetNumEnchantments(int iLevel);
void CreateProtectionRing(object oCreature);
void GetEnchantedItem(object oCreature);
void GetEN2Weapon(object oContainer, object oPC);
void GetEN2Armor(object oContainer, object oPC);
void CreateListenRing(object oCreature);
int GetOnHitSpellSubset();
void GetSpecialWeaponBonus(object oPC, object oItem);
int GetWPBDamageType(object oPC);
int GetWPBDamage(object oPC);
itemproperty MiscNegativeProperty(int iType=0);
void GetNegativeItem(object oCreature,int iEquipItem=FALSE);
int OnHitPropSpecial(int iProp);
int OnHitProp();
void ArmorCheck(object oCreature);

void EquipMob(object oCreature,int iBoss=0,int iAdjust=0)
{
int iArmor;
int iLeftHand;
int iTwoWeapons;
int iShield;
int iRandom;
int iEnchant;
int iLevel;
int iChance;
int iTwoHanded;
int iGold;
int iPotion;
int iRightFlag;
string sArmorTag;
string sRightHand;
string sLeftHand;
object oItem;

GetWeaponType(oCreature);
iArmor = ENGetArmorType(oCreature);

iTwoWeapons = 0;
iShield = 0;
iRightFlag = 0;

if (GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature) || GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_FIGHTING, oCreature))
    iTwoWeapons ++;
if (GetHasFeat(FEAT_AMBIDEXTERITY, oCreature))
    iTwoWeapons ++;

//doesn't seem to equip two weapons regardless
//iTwoWeapons = 0;

if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oCreature))
    iShield = 1;

iLeftHand = 0;
if (iShield == 1)
    iLeftHand = 1;

if (iTwoWeapons == 1)
    if (Random(3) == 1)
        iLeftHand = 2;

if (iTwoWeapons == 2)
    iLeftHand = 2;

sArmorTag = GetArmorTag(iArmor);
sRightHand = "en3_" + GetWeaponTag(oCreature);

iTwoHanded = GetTwoHanded(sRightHand);
sLeftHand = "";

//make sure sorcerers and wizards don't get a left hand weapon/shield
if (GetLevelByClass(CLASS_TYPE_WIZARD, oCreature) >= 1 || 
	GetLevelByClass(CLASS_TYPE_SORCERER, oCreature) >= 1 || 
	GetLevelByClass(CLASS_TYPE_BARD, oCreature) >= 1 || 
	GetLevelByClass(CLASS_TYPE_MONK, oCreature) >= 1)
    iTwoHanded = TRUE;


if (iTwoHanded == FALSE)
    {
    if (iLeftHand == 2)
        {
        sLeftHand = "en3_" + GetWeaponTag(oCreature);
        if (Random(4)>0 || GetTwoHanded(sLeftHand))
            {
            iRandom=Random(8)+1;
            switch (iRandom)
                {//kukri
                case 1: sLeftHand = "en3_ssword"; break;
                case 2: sLeftHand = "en3_dagger"; break;
                case 3: sLeftHand = "en3_handaxe"; break;
                case 4: sLeftHand = "en3_ssword"; break;
                case 5: sLeftHand = "en3_dagger"; break;
                case 6: sLeftHand = "en3_handaxe"; break;
                case 7: sLeftHand = "en3_mace"; break;
                case 8: sLeftHand = "en3_sickle"; break;
                }
            if (FeatCheck(FEAT_WEAPON_PROFICIENCY_EXOTIC,oCreature) && Random(3)>0)
                sLeftHand = "en3_kukri";
            }
        } else {
        iRandom=Random(3)+1;
        switch(iRandom)
            {
            case 1: sLeftHand = "en3_sshield"; break;
            case 2: sLeftHand = "en3_lshield"; break;
            case 3: sLeftHand = "en3_tshield"; break;
            }
        }
    }


iLevel = GetLevelByPosition(1,oCreature) +
         GetLevelByPosition(2,oCreature) +
         GetLevelByPosition(3,oCreature);

iLevel = iLevel + iAdjust;


if (iTwoHanded == FALSE && iLeftHand == 2)
    {
    iRightFlag = 1;
    iEnchant = GetEnchantment(iLevel);
    if (iEnchant>0)
        {
        //sRightHand = sRightHand + "1";
        CreateEnchantedItem(oCreature,sRightHand,iEnchant,3,INVENTORY_SLOT_RIGHTHAND,iBoss);
        }
    else
        {
        oItem=CreateItemOnObject(sRightHand,oCreature,1);
        if (GetTag(oItem)=="")
            SendMessageToPC(GetFirstPC(),"Could not create " + sRightHand);
        EquipItem(INVENTORY_SLOT_RIGHTHAND, oItem, oCreature);
        }
    }

if (iTwoHanded == FALSE)  // checking to make sure right hand is one handed
    {
    iTwoHanded = GetTwoHanded(sLeftHand);
    if (iTwoHanded == FALSE) // make sure left hand is one handed
        {
        iEnchant = GetEnchantment(iLevel);
        if (iEnchant>0)
            if (iLeftHand == 2)
                CreateEnchantedItem(oCreature,sLeftHand,iEnchant,3,INVENTORY_SLOT_LEFTHAND,iBoss);
            else
                CreateEnchantedItem(oCreature,sLeftHand,iEnchant,4,INVENTORY_SLOT_LEFTHAND,iBoss);
        else
            {
            oItem=CreateItemOnObject(sLeftHand,oCreature,1);
            EquipItem(INVENTORY_SLOT_LEFTHAND, oItem, oCreature);
            }
        }
    }
//Right Hand
//equip right after left in case its two-handed
if (iRightFlag == 0)
    {
    iEnchant = GetEnchantment(iLevel);
    if (iEnchant>0)
        {
        //sRightHand = sRightHand + "1";
        CreateEnchantedItem(oCreature,sRightHand,iEnchant,3,INVENTORY_SLOT_RIGHTHAND,iBoss);
        }
    else
        {
        oItem=CreateItemOnObject(sRightHand,oCreature,1);
        if (GetTag(oItem)=="")
            SendMessageToPC(GetFirstPC(),"Could not create " + sRightHand);
        EquipItem(INVENTORY_SLOT_RIGHTHAND, oItem, oCreature);
        }
    }

//Armor
iEnchant = GetEnchantment(iLevel);

if (iEnchant>0)
    {
    //sArmorTag = sArmorTag + IntToString(Random(3)+1);
    CreateEnchantedItem(oCreature,sArmorTag,iEnchant,2,INVENTORY_SLOT_CHEST,iBoss);
    }
else
    {
    oItem=CreateItemOnObject(sArmorTag,oCreature,1);
    EquipItem(INVENTORY_SLOT_CHEST, oItem, oCreature);
    }

iLevel = GetLevelByPosition(1,oCreature) +
         GetLevelByPosition(2,oCreature) +
         GetLevelByPosition(3,oCreature);

iChance = iLevel/5 + 1;
iRandom = Random(100)+1;
if (iRandom <= iChance)
    {
    if (iLevel<9)
        {
        if (Random(2)==0)
            GetMinorMagicItem(oCreature);
        else
            GetMagicItem(oCreature);
        } else {
        if (Random(2)==0)
            {
            GetMiscMagic(oCreature);
            if (Random(100)<iChance/2 && iLevel>19)
                GetMagicItem(oCreature);
            } else {
            GetMagicItem(oCreature);
            if (Random(100)<iChance/2 && iLevel>19)
                GetMiscMagic(oCreature);
            }
        }
    }

//Give them some gold to make up for spawning lvl 1
iRandom = Random(100)+1;
if (iRandom <= iLevel)
    {
    iGold = Random(10 * iLevel)+ iLevel;
    GiveGoldToCreature(oCreature,iGold);
    }

if (sRightHand == "en3_hxbow" || sRightHand == "en3_lxbow" || sRightHand == "en3_hxbow1" || sRightHand == "en3_lxbow1" || sRightHand == "en3_hxbow2" || sRightHand == "en3_lxbow2")
    {
    GetAmmo(oCreature,"en3_bolt",iEnchant);
    }

if (sRightHand == "en3_longbow" || sRightHand == "en3_sbow" || sRightHand == "en3_longbow1" || sRightHand == "en3_sbow1" || sRightHand == "en3_longbow2" || sRightHand == "en3_sbow2")
    {
    GetAmmo(oCreature,"en3_arrow",iEnchant);
    }
if (sRightHand == "en3_sling" || sRightHand == "en3_sling1" || sRightHand == "en3_sling2")
    {
    GetAmmo(oCreature,"en3_bullet",iEnchant);
    }

if (iLevel < 10)
    {
    iPotion = iLevel/2+1;
    } else {
    iPotion = iLevel/2+1 + (iLevel-10)/3;
    }
if (Random(100)<iPotion)
    GetPotion(oCreature);

if (iBoss == 0)
   iChance = iLevel/8;
else
   iChance = iLevel/5+1;

iRandom = Random(100)+1;

if (iRandom <= iChance)
    CreateRandomItem(oCreature);

if (Random(15)==0 && (GetLevelByClass(CLASS_TYPE_WIZARD, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_SORCERER, oCreature) >= 1))
    GetScrolls(oCreature);

iRandom = Random(100)+1;
if (iRandom <= (iLevel*3))
    CreateProtectionRing(oCreature);
else if (Random(100)<iLevel/2)
    CreateListenRing(oCreature);

SetLocalObject(oCreature, "LHAND", GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
SetLocalObject(oCreature, "RHAND", GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));

AssignCommand(oCreature,ActionEquipMostEffectiveArmor());
//DelayCommand(3.0,ArmorCheck(oCreature));

}

void ArmorCheck(object oCreature)
{

object oChest = GetItemInSlot(INVENTORY_SLOT_CHEST,oCreature);
if (!GetIsObjectValid(oChest))
    {
    oChest=CreateItemOnObject("Tunic",oCreature);
    SetDroppableFlag(oChest,FALSE);
    AssignCommand(oCreature, ActionEquipItem(oChest, INVENTORY_SLOT_CHEST));
    }
}

void CreateEnchantedItem(object oCreature,string sTag,int iEnchant,int iType, int iPosition = -1,int iBoss=0)
{
object oItem;
itemproperty iProperty;
itemproperty iProperty2;
int iLevel;
int iIndex;
int iChance;
int iRandom;
int iEnchantments;
int iEnchanted;
int iDmgBonus;
int iDmgType;

if (iBoss>1)
    iBoss = 1;

if (sTag == "en3_monkgloves")
    iPosition = INVENTORY_SLOT_ARMS;

iLevel = GetLevelByPosition(1,oCreature) +
         GetLevelByPosition(2,oCreature) +
         GetLevelByPosition(3,oCreature);

iDmgBonus=0;
iChance = iLevel/4 + iEnchant;
iRandom = Random(100)+1;

iEnchanted = FALSE;
iEnchantments = 0;
if (iRandom <= iChance)
    {
    iEnchanted = TRUE;

    if (iType == 2)
         sTag = sTag + IntToString(Random(3)+2);
    else if (iType == 4)
        sTag = sTag + IntToString(Random(4)+2);
    else
        sTag = sTag + "2";

    iEnchantments = GetNumEnchantments(iLevel);

    } else {
        if (Random(100)<(iBoss*iEnchant))
            {
            sTag = sTag + "2";
            iEnchantments=1;
            iDmgBonus=1;
            } else {
            if (iType == 2 || iType == 4)
                 sTag = sTag + IntToString(Random(2));
            else
                sTag = sTag + "1";
            }
    }


oItem=CreateItemOnObject(sTag,oCreature,1);
if (GetTag(oItem)=="")
    SendMessageToPC(GetFirstPC(),"Could not create " + sTag);
if (iType == 3)
    if (IPGetIsRangedWeapon(oItem))
        {
        iProperty=ItemPropertyAttackBonus(iEnchant);
        IPSafeAddItemProperty(oItem,iProperty);
        iProperty=ItemPropertyMaxRangeStrengthMod(iEnchant);
        }
    else
        {
        if (sTag == "en3_monkgloves1" || sTag == "en3_monkgloves2")
            {
            iProperty=ItemPropertyAttackBonus(iEnchant);
            IPSafeAddItemProperty(oItem,iProperty);
            iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,GetEnchantBonus(iEnchant));
            } else {
            iProperty=ItemPropertyEnhancementBonus(iEnchant);
            }
        if (iDmgBonus==1)
            {
            iDmgType = DamageType();
            if (iEnchant==1)
                iDmgBonus = IP_CONST_DAMAGEBONUS_1;
            else if (iEnchant==2)
                iDmgBonus = IP_CONST_DAMAGEBONUS_1d4;
            else
                iDmgBonus = IP_CONST_DAMAGEBONUS_1d6;

            iProperty2 =ItemPropertyDamageBonus(iDmgType,iDmgBonus);
            IPSafeAddItemProperty(oItem,iProperty2);
            }
        }
else if (iType == 2 || iType == 4)
    iProperty=ItemPropertyACBonus(iEnchant);

IPSafeAddItemProperty(oItem,iProperty);

//If Enchanted then give more stuff here
if (iEnchanted == TRUE)
    {
    //iIndex=0;
    int iInitialEnchantments = IPGetNumberOfItemProperties(oItem);
    while (IPGetNumberOfItemProperties(oItem) < iEnchantments + iInitialEnchantments)
        {
        //iIndex++;
        if (GetTag(oItem) == "en3_monkgloves1" || sTag == "en3_monkgloves2")
            iProperty = MonkWeaponProperty(iEnchant);
        else if (IPGetIsRangedWeapon(oItem))
            iProperty = RangedWeaponProperty(iEnchant);
        else if (iType == 3)
            iProperty = WeaponProperty(iEnchant);
        else
            iProperty = ArmorProperty(iEnchant);
        IPSafeAddItemProperty(oItem,iProperty);
        }
    }

if (iPosition >= 0)
    EquipItem(iPosition, oItem, oCreature);

/*
if (iEnchanted == FALSE)
    if (Random(100)<75)
        SetDroppableFlag(oItem,FALSE);
*/
}

void EquipItem(int iItemSlot,object oItem, object oCreature)
{
object oOldItem;
int iDestroy;

oOldItem = GetItemInSlot(iItemSlot,oCreature);
AssignCommand(oCreature,ActionUnequipItem(oOldItem));

iDestroy = FALSE;

if (iItemSlot == INVENTORY_SLOT_RIGHTHAND && IPGetWeaponEnhancementBonus(oOldItem))
    iDestroy = TRUE;

if (iItemSlot == INVENTORY_SLOT_LEFTHAND && IPGetIsMeleeWeapon(oItem)&& IPGetWeaponEnhancementBonus(oOldItem))
    iDestroy = TRUE;

if (iItemSlot == INVENTORY_SLOT_LEFTHAND && !(IPGetIsMeleeWeapon(oItem)))
    iDestroy = TRUE;

/*
if (iItemSlot == INVENTORY_SLOT_CHEST)
    iDestroy = TRUE;
*/

if (iDestroy == TRUE)
    {
    if (GetEnchantments(oOldItem) < 1)
        {
        //SendMessageToPC(GetFirstPC(),"Destroying " + GetName(oOldItem) + " - " + GetTag(oOldItem));
        DestroyObject(oOldItem,0.1f);
        }
    }
AssignCommand(oCreature, ActionEquipItem(oItem, iItemSlot));

}

string GetArmorTag(int iArmor)
{
int iRandom;
string sArmorTag;

//Get Basic Armor
// 0 = None
// 1 = light
// 2 = medium
// 3 = heavy
// 4 = wizard robes
// 5 == monk robes

switch (iArmor)
    {
    case 1: iRandom=Random(6)+1;
            switch (iRandom)
                {
                case 1: sArmorTag = "en3_padded"; break;
                case 2: case 3: sArmorTag = "en3_leather"; break;
                case 4: case 5: case 6: sArmorTag = "en3_studded"; break;
                }
            break;
    case 2: iRandom=Random(3)+1;
            switch (iRandom)
                {
                case 1: sArmorTag = "en3_scale"; break;
                case 2: case 3: sArmorTag = "en3_chain"; break;
                }
            break;
    case 3: iRandom=Random(6)+1;
            switch (iRandom)
                {
                case 1: sArmorTag = "en3_banded"; break;
                case 2: case 3: sArmorTag = "en3_halfplate"; break;
                case 4: case 5: case 6: sArmorTag = "en3_fullplate"; break;
                }
            break;
    case 4: sArmorTag = "en3_magerobe"; break;
    case 5: sArmorTag = "en3_monkrobe"; break;
    }

return sArmorTag;
}

string GetWeaponTag(object oCreature)
{
int iWeapons;
int iRandom;
string sWeapon;

//add Exotic/Martial weapon to list for weapon variety
if (!(GetIsPC(oCreature)))
    {
    if (FeatCheck(FEAT_WEAPON_PROFICIENCY_EXOTIC,oCreature))
        MakeFeatList(oCreature,GetExoticWeapon(oCreature));

    if (FeatCheck(FEAT_WEAPON_PROFICIENCY_MARTIAL,oCreature))
        MakeFeatList(oCreature,GetMartialWeapon(oCreature));
    }
iWeapons = GetLocalInt(oCreature,"Weapons");
iRandom = Random(iWeapons)+1;

sWeapon = GetLocalString(oCreature,"Weapon" + IntToString(iRandom));

return sWeapon;
}

int GetEnchantment(int iLevel)
{
int iEnchant;
int iEnchantLevel;
int iChance;
int iFlag;
int iRandom;

iEnchant = 0;
iFlag = 0;

iEnchantLevel = iLevel/4;
if (Random(10)==0)
    iEnchantLevel = 1+iLevel/4;

if (iEnchantLevel>20)
    iEnchantLevel =20;

iChance = 10 + (iLevel % 4)/2 + iEnchantLevel*2;
if (iChance > 80)
    iChance = 80;

if (iEnchantLevel > 0)
    {
    while (iFlag == 0)
        {
        iRandom = Random(100)+1;
        if (iRandom<=iChance)
            {
            iEnchant = iEnchantLevel;
            iFlag = 1;
            }
        iEnchantLevel --;
        iChance = iChance + 5;
        if (iEnchantLevel == 0)
            iFlag = 1;
        }
    }

if (iLevel>15 && iEnchant <1)
    iEnchant = 1;

if (iLevel>20 && iEnchant <2)
    iEnchant = 2;

if (iLevel>25 && iEnchant <3)
    iEnchant = 3;

if (iLevel>30 && iEnchant <4)
    iEnchant = 4;

if (iLevel>35 && iEnchant <5)
    iEnchant = 5;

return iEnchant;
}


void GetMiscMagic(object oCreature, int iDroppable = TRUE)
{
string sTag;
object oItem;
itemproperty iProperty;
int iRandom;
int iRandom2;
int iRandom3;
int iPosition;
int iIndex;
int iEnchantments;
int iProperties;
int iMod;
int iLevel;

iMod = 0;
iRandom = Random(15)+1;

switch (iRandom)
    {
    case 1: case 2: sTag = "en3_amulet";
            iPosition = INVENTORY_SLOT_NECK;
            break;
    case 3: case 4: sTag = "en3_ring";
            iPosition = INVENTORY_SLOT_LEFTRING;
            break;
    case 5: case 6: iRandom2 = Random(8)+1;
            sTag = "en3_helm" + IntToString(iRandom2);
            iMod = 1;
            iPosition = INVENTORY_SLOT_HEAD;
            break;
    case 7: case 8: sTag = "en3_belt";
            iPosition = INVENTORY_SLOT_BELT;
            break;
    case 9: case 10: sTag = "en3_boots";
            iPosition = INVENTORY_SLOT_BOOTS;
            break;
    case 11: case 12: sTag = "en3_gloves";
            iPosition = INVENTORY_SLOT_ARMS;
            break;
    case 13: case 14: sTag = "en3_cloak";
            iPosition = INVENTORY_SLOT_CLOAK;
            break;
    case 15: iRandom2 = Random(5)+1;
            switch (iRandom2)
                {
                case 1: sTag = "en3_magestaff";
                        sTag = sTag + IntToString(Random(4)+1);
                        iPosition = -1;
                        break;
                case 2: sTag = "en3_wand";
                        iPosition = -2;
                        break;
                case 3: sTag = "en3_rod";
                        iPosition = -2;
                        break;
                case 4: sTag = "en3_misc";
                        sTag = sTag + IntToString(Random(6)+1);
                        iPosition = -3;
                        break;
                case 5: sTag = "en3_instrument";
                        sTag = sTag + IntToString(Random(3)+1);
                        iPosition = -4;
                        break;
                }
            break;
    }

if (iPosition == -4 && Random(10)==0)
    sTag = "en3_instrument4";

oItem=CreateItemOnObject(sTag,oCreature,1);

iLevel = GetHitDice(oCreature);
iEnchantments = GetNumEnchantments(iLevel);

//acount for usable by properties
if (iPosition == -1)
    iEnchantments = iEnchantments + 3;
if (sTag == "en3_wand")
    iEnchantments = iEnchantments + 5;
if (iPosition == -3)
    iEnchantments = 1;

iIndex = 0;
//SendMessageToPC(GetFirstPC(),"Tag = " + sTag);
//SendMessageToPC(GetFirstPC(),"Enchantments = " + IntToString(iEnchantments));

while (iProperties < iEnchantments + iMod)
    {
    iIndex++;
    if (iPosition >=0)
        {
        iProperty = MiscMagicProperty(0);
        }
    else if (iPosition == -1)
        {
        if (Random(3)==0)
            iProperty = WeaponProperty(0);
        else
            iProperty = CastSpellEffect();
        }
    else if (iPosition == -2)
        {
        iProperty = CastSpellEffect();
        }
    else if (iPosition == -3)
        {
        if (!(sTag == "en3_misc1"))
            iProperty = CastSpellEffectOnce();
        }
    else if (iPosition == -4)
        {
            iProperty = CastSpellEffect();
        }

     IPSafeAddItemProperty(oItem,iProperty);
     iProperties = GetEnchantments(oItem);
//SendMessageToPC(GetFirstPC(),"iProperties = " + IntToString(iProperties) + " Index = " + IntToString(iIndex) );
        if (iIndex > 20)
            {
            if (Random(3)==0)
                {
                iProperty = ItemPropertyDamageReduction(Random(3),Random(3));
                IPSafeAddItemProperty(oItem,iProperty);
                } else {
                iProperty = ItemPropertyACBonus(Random(5)+1);
                IPSafeAddItemProperty(oItem,iProperty);
                }
            iProperties = 99;
            }
    }

if (!(GetIsPC(oCreature)))
    EquipItem(iPosition, oItem, oCreature);

if (iDroppable == FALSE)
    {
    SetDroppableFlag(oItem,FALSE);
    //SendMessageToPC(GetFirstPC(),"Item " + GetName(oItem) + " created on " + GetName(oCreature));
    }

if (sTag == "en3_ring" && Random(10) == 0)
    {
    iProperty = ItemPropertyLight(Random(4),Random(7));
    IPSafeAddItemProperty(oItem,iProperty);
    }

}


void GetMagicItem(object oCreature, int iDroppable=TRUE, int iQuest = FALSE, int iForceRandom=0)
{
int iArmor;
int iRandom;
int iRandom2;
int iShield;
int iEnchant;
int iLevel;
int iEnchantments;
int iIndex;
int iPosition;
int iBuild;
int iPC;
int iProperties;
int iMod;
int iRobe;
string sTag;
itemproperty iProperty;
itemproperty iPropertyTest;
object oItem;
object oPC;

if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oCreature))
    iShield = 1;

iBuild = 0;
iPC = 0;
iRobe = 0;
if (iQuest == TRUE)
    iRandom = Random(4)+1;
else
    iRandom = Random(5)+1;

if (iForceRandom > 0)
    iRandom = iForceRandom;

switch (iRandom)
    {
    case 1: GetWeaponType(oCreature);
            sTag = "en3_" + GetWeaponTag(oCreature);
            iBuild = 1;
            break;
    case 2: if (iShield == 1 && Random(2) == 0)
                {
                iRandom2=Random(3)+1;
                switch(iRandom2)
                    {
                    case 1: sTag = "en3_sshield"; break;
                    case 2: sTag = "en3_lshield"; break;
                    case 3: sTag = "en3_tshield"; break;
                    }
                iBuild = 3;
                } else {
                    iBuild = 2;
                    iArmor = ENGetArmorType(oCreature);
                    sTag = GetArmorTag(iArmor);
                }
            break;
    case 3: GetMiscMagic(oCreature);
            break;
    case 4: if (iQuest == TRUE)
                iRandom2 = Random(4)+1;
            else
                iRandom2 = Random(5)+1;

            switch (iRandom2)
                {
                case 1: case 2: DTSGenerateCharSpecificTreasure(oCreature,oCreature);
                        break;
                case 3: case 4: CreateRandomItem(oCreature);
                        break;
                case 5: DTSGenerateTreasureOnContainer (oCreature,oCreature,X2_DTS_CLASS_HIGH,X2_DTS_TYPE_DISP | X2_DTS_TYPE_GOLD);
                        break;
                }
            break;
    case 5: oPC = GetRandomTreasurePC();
            iPC = 1;
            if (Random(3)==0)
            {
            iBuild = 2;
            iArmor = ENGetArmorType(oPC);
            sTag = GetArmorTag(iArmor);
            } else {
            GetWeaponType(oPC);
            sTag = "en3_" + GetWeaponTag(oPC);
            iBuild = 1;
            }
            break;
    }

iLevel = GetLevelByPosition(1,oCreature) +
         GetLevelByPosition(2,oCreature) +
         GetLevelByPosition(3,oCreature);

if (sTag == "en3_magerobe")
    iRobe = 1;

if (iBuild>0)
    {
    iRandom = Random(100)+1 + iLevel/3;

    if (iRandom <=60)
        iEnchant = 1;
    else if (iRandom <=80)
        iEnchant= 2;
    else if (iRandom <=90)
        iEnchant = 3;
    else if (iRandom <=95)
        iEnchant = 4;
    else if (iRandom <=99)
        iEnchant = 5;
    else
        iEnchant = Random(5) + 6;

    if (iLevel > 20)
        if (Random(100) < (iLevel-20))
            iEnchant = iEnchant + Random(10)+1;

    if (iBuild == 1)
        {
        sTag = sTag + "2";
        oItem=CreateItemOnObject(sTag,oCreature,1);
        iPosition = INVENTORY_SLOT_RIGHTHAND;
        if (IPGetIsRangedWeapon(oItem))
            {
            iProperty=ItemPropertyAttackBonus(iEnchant);
            IPSafeAddItemProperty(oItem,iProperty);
            iProperty=ItemPropertyMaxRangeStrengthMod(iEnchant);
            }
        else
            {
            if (sTag == "en3_monkgloves2")
                {
                iProperty=ItemPropertyAttackBonus(iEnchant);
                IPSafeAddItemProperty(oItem,iProperty);
                iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,GetEnchantBonus(iEnchant));
                } else {
                iProperty=ItemPropertyEnhancementBonus(iEnchant);
                }
            }
        }

    if (iBuild == 2)
        {
        sTag = sTag + IntToString(Random(3)+2);
        //if (iRobe == 1 && Random(10)==0)
        //    sTag = "en3_magerobe4";
        oItem=CreateItemOnObject(sTag,oCreature,1);
        iPosition = INVENTORY_SLOT_CHEST;
        iProperty=ItemPropertyACBonus(iEnchant);
        }

    if (iBuild == 3)
        {
        sTag = sTag + IntToString(Random(4)+2);
        oItem=CreateItemOnObject(sTag,oCreature,1);
        iPosition = INVENTORY_SLOT_LEFTHAND;
        iProperty=ItemPropertyACBonus(iEnchant);
        }

    IPSafeAddItemProperty(oItem,iProperty);

    iEnchantments = GetNumEnchantments(iLevel);

    iMod = 1;
    if (GetTag(oItem) == "en3_monkgloves2")
        iMod = 3;
    if (GetTag(oItem) == "en3_magerobe4")
        iMod = 2;
    if (IPGetIsRangedWeapon(oItem))
        iMod = 2;

    iIndex = 0;
//    SendMessageToPC(GetFirstPC(),"Tag = " + sTag);
//    SendMessageToPC(GetFirstPC(),"Enchantments = " + IntToString(iEnchantments));
    while (iProperties < iEnchantments + iMod)
        {
        iIndex++;
        if (iBuild==1)
            {
            if (GetTag(oItem) == "en3_monkgloves2")
                iProperty = MonkWeaponProperty(iEnchant);
            else if (IPGetIsRangedWeapon(oItem))
                iProperty = RangedWeaponProperty(iEnchant);
            else
                iProperty = WeaponProperty(iEnchant);
            }
        else
            {
            iProperty = ArmorProperty(iEnchant);
            }

        //testing for on hit cast spell to make sure two not given to same item.
        iPropertyTest = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_CHAIN_LIGHTNING,20);
        if (GetItemPropertyType(iProperty) == GetItemPropertyType(iPropertyTest))
            {
                if (GetLocalInt(oItem,"OnHit") == 0)
                    {
                    IPSafeAddItemProperty(oItem,iProperty);
                    SetLocalInt(oItem,"OnHit",1);
                    } else {
                    iIndex--;
                    }
            } else {
                IPSafeAddItemProperty(oItem,iProperty);
            }
        iProperties = GetEnchantments(oItem);
//        SendMessageToPC(GetFirstPC(),"iProperties = " + IntToString(iProperties) + " Index = " + IntToString(iIndex) );
        if (iIndex > 20)
            {
            if (iBuild==1)
                {
                iProperty = ItemPropertyDamageBonus(DamageType(),DamageBonus());
                IPSafeAddItemProperty(oItem,iProperty);
                } else {
                iProperty = ItemPropertyDamageReduction(Random(3),Random(3));
                IPSafeAddItemProperty(oItem,iProperty);
                }
            iProperties = 99;
            }
        }

    if (!(GetIsPC(oCreature)))
        if (!(iPC == 1 && iBuild == 2))
            {
            EquipItem(iPosition, oItem, oCreature);
            SetLocalObject(oCreature, "LHAND", GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
            SetLocalObject(oCreature, "RHAND", GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
            }

    if (Random(20) == 0)
        {
        iProperty = ItemPropertyLight(Random(4),Random(7));
        IPSafeAddItemProperty(oItem,iProperty);
        }

    }

    if (iDroppable == FALSE)
        {
        SetDroppableFlag(oItem,FALSE);
        //SendMessageToPC(GetFirstPC(),"Item " + GetName(oItem) + " created on " + GetName(oCreature));
        }

if (sTag == "en3_hxbow1" || sTag == "en3_lxbow1" || sTag == "en3_hxbow2" || sTag == "en3_lxbow2")
    {
    GetAmmo(oCreature,"en3_bolt",iEnchant);
    }

if (sTag == "en3_longbow1" || sTag == "en3_sbow1" || sTag == "en3_longbow2" || sTag == "en3_sbow2")
    {
    GetAmmo(oCreature,"en3_arrow",iEnchant);
    }
if (sTag == "en3_sling1" || sTag == "en3_sling2")
    {
    GetAmmo(oCreature,"en3_bullet",iEnchant);
    }
}


void GetAmmo(object oCreature,string sTag,int iEnchant)
{
object oItem;
itemproperty iProperty;

if (Random(100)<(iEnchant*15))
    {
    sTag=sTag + "1";
    oItem =CreateItemOnObject(sTag,oCreature,99);
    iProperty = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,GetEnchantBonus(iEnchant));
    IPSafeAddItemProperty(oItem,iProperty);
    if (Random(100)<(iEnchant*15))
        {
        iProperty = GetAmmunitionProperty();
        IPSafeAddItemProperty(oItem,iProperty);
        }
    } else {
        oItem =CreateItemOnObject(sTag,oCreature,99);
    }
}

int GetTwoHanded(string sTag)
{
int iTwoHanded;

iTwoHanded = FALSE;

if (sTag == "en3_greataxe")
    iTwoHanded = TRUE;
else if (sTag == "en3_greatsword")
    iTwoHanded = TRUE;
//else if (sTag == "en3_baxe")
//    iTwoHanded = TRUE;
else if (sTag == "en3_spear")
    iTwoHanded = TRUE;
else if (sTag == "en3_staff")
    iTwoHanded = TRUE;
else if (sTag == "en3_halberd")
    iTwoHanded = TRUE;
else if (sTag == "en3_hflail")
    iTwoHanded = TRUE;
else if (sTag == "en3_tblsword")
    iTwoHanded = TRUE;
else if (sTag == "en3_diremace")
    iTwoHanded = TRUE;
else if (sTag == "en3_doubleaxe")
    iTwoHanded = TRUE;
else if (sTag == "en3_hxbow")
    iTwoHanded = TRUE;
else if (sTag == "en3_lxbow")
    iTwoHanded = TRUE;
else if (sTag == "en3_longbow")
    iTwoHanded = TRUE;
else if (sTag == "en3_scythe")
    iTwoHanded = TRUE;
else if (sTag == "en3_sbow")
    iTwoHanded = TRUE;

return iTwoHanded;
}

object GetRandomTreasurePC()
{
int iCount;
int iFlag;
int iIndex;
object oPC;
object oLastPC;

oPC=GetFirstPC();
iCount = 0;
iFlag = 0;

while (iFlag == 0)
    {
    iCount++;
    oLastPC = oPC;
    oPC = GetNextPC();

    if (GetName(oLastPC) == GetName(oPC))
        {
        iFlag = 1;
        }
    if (iCount>65)
        {
        iFlag = 1;
        }
    }
iCount--;
for (iIndex=1; iIndex <= iCount; iIndex++)
    {
    if (iIndex == 1)
        {
        oPC = GetFirstPC();
        } else {
        oPC = GetNextPC();
        }
    }

return oPC;
}

int GetEnchantBonus(int iEnchant)
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

int DamageBonus()
{
int iRandom;
int iBonus;

iRandom = Random(27)+1;
iBonus = IP_CONST_DAMAGEBONUS_1;

switch (iRandom)
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
    case 11: iBonus = IP_CONST_DAMAGEBONUS_1d10; break;
    case 12: iBonus = IP_CONST_DAMAGEBONUS_1d12; break;
    case 13: iBonus = IP_CONST_DAMAGEBONUS_1d4; break;
    case 14: iBonus = IP_CONST_DAMAGEBONUS_1d6; break;
    case 15: iBonus = IP_CONST_DAMAGEBONUS_1d8; break;
    case 16: iBonus = IP_CONST_DAMAGEBONUS_2d10; break;
    case 17: iBonus = IP_CONST_DAMAGEBONUS_2d12; break;
    case 18: iBonus = IP_CONST_DAMAGEBONUS_2d4; break;
    case 19: iBonus = IP_CONST_DAMAGEBONUS_2d6; break;
    case 20: iBonus = IP_CONST_DAMAGEBONUS_2d8; break;
    case 21: iBonus = IP_CONST_DAMAGEBONUS_1d10; break;
    case 22: iBonus = IP_CONST_DAMAGEBONUS_1d12; break;
    case 23: iBonus = IP_CONST_DAMAGEBONUS_1d4; break;
    case 24: iBonus = IP_CONST_DAMAGEBONUS_1d6; break;
    case 25: iBonus = IP_CONST_DAMAGEBONUS_1d8; break;
    case 26: iBonus = IP_CONST_DAMAGEBONUS_2d4; break;
    case 27: iBonus = IP_CONST_DAMAGEBONUS_2d6; break;
    }

return iBonus;
}

int DamageType()
{
int iRandom;
int iType;

iRandom = Random(12)+1;
iType = IP_CONST_DAMAGETYPE_SONIC;

switch (iRandom)
    {
    case 1: iType = IP_CONST_DAMAGETYPE_ACID; break;
    case 2: iType = IP_CONST_DAMAGETYPE_BLUDGEONING; break;
    case 3: iType = IP_CONST_DAMAGETYPE_COLD; break;
    case 4: iType = IP_CONST_DAMAGETYPE_ELECTRICAL; break;
    case 5: iType = IP_CONST_DAMAGETYPE_FIRE; break;
    case 6: iType = IP_CONST_DAMAGETYPE_PIERCING; break;
    case 7: iType = IP_CONST_DAMAGETYPE_SLASHING; break;
    case 8: iType = IP_CONST_DAMAGETYPE_SONIC; break;
    case 9: iType = IP_CONST_DAMAGETYPE_DIVINE; break;
    case 10: iType = IP_CONST_DAMAGETYPE_MAGICAL; break;
    case 11: iType = IP_CONST_DAMAGETYPE_NEGATIVE; break;
    case 12: iType = IP_CONST_DAMAGETYPE_POSITIVE; break;
    }

return iType;
}


itemproperty GetAmmunitionProperty()
{
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
int iX;
int iY;
int iZ;
itemproperty iProperty;

iRandom = Random(100)+1;

if (iRandom<16)
    {
    iX = DamageType();
    iY = DamageBonus();
    iProperty=ItemPropertyDamageBonus(iX,iY);
    }
else if (iRandom<31)
    {
    iX = Random(8) + 1;
    if (Random(10)==0)
        iX = Random(20) + 1;
    iProperty=ItemPropertyVampiricRegeneration(iX);
    }
else if (iRandom<41)
    {
    iX = Random(22);
    iY = Random(3);
    if (Random(6) == 0)
        iY = Random(7);
    iProperty=ItemPropertyOnHitProps(iX,iY,1);
    }
else if (iRandom<46)
    {
    iX = Random(137);
    iY = Random(16)+5;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else
    {
    iX = DamageType();
    iRandom2 = Random(8)+1;
    iY = DAMAGE_BONUS_1;
    switch (iRandom2)
        {
        case 1: iY=DAMAGE_BONUS_1; break;
        case 2: iY=DAMAGE_BONUS_2; break;
        case 3: iY=DAMAGE_BONUS_3; break;
        case 4: iY=DAMAGE_BONUS_4; break;
        case 5: iY=DAMAGE_BONUS_1d4; break;
        case 6: iY=DAMAGE_BONUS_1d6; break;
        case 7: iY=DAMAGE_BONUS_1d8; break;
        case 8: iY=DAMAGE_BONUS_1d10; break;
        }
    iProperty=ItemPropertyDamageBonus(iX,iY);
    }

return iProperty;
}

//wrapper for property types
itemproperty zGetItemProperty(int iType=0, int iEnchant=0, int iNoEnchantBonus =0)
{
itemproperty iProperty;

if (iType<2)
    iProperty = MiscMagicProperty(iEnchant);
else if (iType==2)
    iProperty = ArmorProperty(iEnchant);
else if (iType == 3 && iNoEnchantBonus == 0)
    iProperty = WeaponProperty(iEnchant);
else
    iProperty = MonkWeaponProperty(iEnchant);

return iProperty;
}

itemproperty WeaponProperty(int iEnchant)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;

iRandom=Random(100)+1;

if (iRandom<5)
    {
    //attack bonus
    iEnchant2 = iEnchant+1+Random(3);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iProperty=ItemPropertyAttackBonus(iEnchant2);
    }
else if (iRandom<7)
    {
    //attack bonus vs Align
    iEnchant2 = iEnchant+1+Random(5);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iRandom2 = Random(5);
    iProperty=ItemPropertyAttackBonusVsAlign(iRandom2,iEnchant2);
    }
else if (iRandom<9)
    {
    //attack bonus vs Race
    iEnchant2 = iEnchant+1+Random(5);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iRandom2 = Random(25);
    iProperty=ItemPropertyAttackBonusVsRace(iRandom2,iEnchant2);
    }
else if (iRandom<11)
    {
    //holy avenger
    iProperty=ItemPropertyHolyAvenger();
    }
else if (iRandom<15)
    {
    //massive crit
    iX = Random(20);
    iProperty=ItemPropertyMassiveCritical(iX);
    }
else if (iRandom<18)
    {
    //vamp 1
    iX = Random(8) + 1;
    iProperty=ItemPropertyVampiricRegeneration(iX);
    }
else if (iRandom<19)
    {
    //vamp 2
    iX = Random(20) + 1;
    iProperty=ItemPropertyVampiricRegeneration(iX);
    }
else if (iRandom<24)
    {
    //keen
    iProperty=ItemPropertyKeen();
    }
else if (iRandom<27)
    {
    //enchant vs Align
    iEnchant2 = iEnchant+1+Random(3);
    iZ = Random(6);
    iProperty=ItemPropertyEnhancementBonusVsAlign(iZ,iEnchant2);
    }
else if (iRandom<30)
    {
    //enchant vs race
    iEnchant2 = iEnchant+1+Random(3);
    iZ = Random(24);
    iProperty=ItemPropertyEnhancementBonusVsRace(iZ,iEnchant2);
    }
else if (iRandom<32)
    {
    //on hit cast spell
    iX = Random(130);
    iY = Random(16)+5;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else if (iRandom<34)
    {
    iX = Random(22);
    iY = Random(7);
    iZ = Random(5);
    if (iZ == IP_CONST_ONHIT_SLAYRACE)
        iZ = Random(24);
    if (iZ == IP_CONST_ONHIT_SLAYALIGNMENTGROUP)
        iZ = Random(5);
    if (iZ == IP_CONST_ONHIT_SLAYALIGNMENT)
        iZ = Random(9);
    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    }
else if (iRandom<39)
    {
    //dmg bonus (any)
    iX = DamageType();
    iY = DamageBonus();
    iProperty=ItemPropertyDamageBonus(iX,iY);
    }
else if (iRandom<41)
    {
    //dmg bonus vs Align
    iX = DamageType();
    iY = DamageBonus();
    iZ = Random(6);
    iProperty=ItemPropertyDamageBonusVsAlign(iZ,iX,iY);
    }
else if (iRandom<43)
    {
    //dmg bonus vs Race
    iX = DamageType();
    iY = DamageBonus();
    iZ = Random(24);
    iProperty=ItemPropertyDamageBonusVsRace(iZ,iX,iY);
    }
else if (iRandom<48)
    {
    //dmg bonus based on iEnchant
    iX = DamageType();
    iRandom2 = Random(5)+ iEnchant;
    iY = IP_CONST_DAMAGEBONUS_1;
    switch (iRandom2)
        {
        case 1: iY=IP_CONST_DAMAGEBONUS_1; break;
        case 2: iY=IP_CONST_DAMAGEBONUS_2; break;
        case 3: iY=IP_CONST_DAMAGEBONUS_4; break;
        case 4: iY=IP_CONST_DAMAGEBONUS_1d4; break;
        case 5: iY=IP_CONST_DAMAGEBONUS_1d6; break;
        case 6: iY=IP_CONST_DAMAGEBONUS_1d8; break;
        case 7: iY=IP_CONST_DAMAGEBONUS_2d4; break;
        case 8: iY=IP_CONST_DAMAGEBONUS_1d10; break;
        case 9: iY=IP_CONST_DAMAGEBONUS_1d12; break;
        case 10: iY=IP_CONST_DAMAGEBONUS_2d6; break;
        case 11: iY=IP_CONST_DAMAGEBONUS_6; break;
        case 12: iY=IP_CONST_DAMAGEBONUS_8; break;
        case 13: iY=IP_CONST_DAMAGEBONUS_2d8; break;
        case 14: iY=IP_CONST_DAMAGEBONUS_2d10; break;
        case 15: iY=IP_CONST_DAMAGEBONUS_2d12; break;
        }
    iProperty=ItemPropertyDamageBonus(iX,iY);
    }
else if (iRandom<49)
    {
    //on hit cast spell
    iX = GetOnHitSpellSubset();
    iY = Random(16)+5;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else if (iRandom<50)
    {
    //on hit cast spell
    iX = Random(130);
    iY = Random(30)+11;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else if (iRandom<51)
    {
    //on hit property
    iX = OnHitProp();
    iY = Random(7);
    iZ = OnHitPropSpecial(iX);
    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    }
else
    iProperty=MiscMagicProperty(iEnchant);

return iProperty;
}

int OnHitProp()
{
int iRandom;
int iReturn;
iReturn =IP_CONST_ONHIT_BLINDNESS;
iRandom = Random(12)+1;

switch (iRandom)
    {
    case 1: iReturn =IP_CONST_ONHIT_BLINDNESS; break;
    case 2: iReturn =IP_CONST_ONHIT_CONFUSION; break;
    case 3: iReturn =IP_CONST_ONHIT_DAZE; break;
    case 4: iReturn =IP_CONST_ONHIT_FEAR; break;
    case 5: iReturn =IP_CONST_ONHIT_HOLD; break;
    case 6: iReturn =IP_CONST_ONHIT_LEVELDRAIN; break;
    case 7: iReturn =IP_CONST_ONHIT_MORDSDISJUNCTION; break;
    case 8: iReturn =IP_CONST_ONHIT_SLEEP; break;
    case 9: iReturn =IP_CONST_ONHIT_SLOW; break;
    case 10: iReturn =IP_CONST_ONHIT_STUN; break;
    case 11: iReturn =IP_CONST_ONHIT_VORPAL; break;
    case 12: iReturn =IP_CONST_ONHIT_WOUNDING; break;
    }

return iReturn;
}

int OnHitPropSpecial(int iProp)
{
int iReturn;

iReturn = 0;

if (iProp == IP_CONST_ONHIT_BLINDNESS)
    iReturn = Random(5);
if (iProp == IP_CONST_ONHIT_CONFUSION)
    iReturn = Random(5);
if (iProp == IP_CONST_ONHIT_DAZE)
    iReturn = Random(5);
if (iProp == IP_CONST_ONHIT_FEAR)
    iReturn = Random(5);
if (iProp == IP_CONST_ONHIT_HOLD)
    iReturn = Random(5);
if (iProp == IP_CONST_ONHIT_SLEEP)
    iReturn = Random(5);
if (iProp == IP_CONST_ONHIT_SLOW)
    iReturn = Random(5);
if (iProp == IP_CONST_ONHIT_STUN)
    iReturn = Random(5);

return iReturn;
}

itemproperty ArmorProperty(int iEnchant)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;

iRandom=Random(100)+1;

if (iRandom<11)
    {
    //AC Bonus vs Alignment/RacialGroup/SpecificAlignment
    iEnchant2=Random(3)+iEnchant+1;

    iRandom2 = Random(5) + 1;
    switch (iRandom2)
        {
        case 1: case 2:
            iRandom3 = Random(5);
            iProperty=ItemPropertyACBonusVsAlign(iRandom3,iEnchant2);
            break;
        case 3: case 4:
            iRandom3 = Random(25);
            iProperty=ItemPropertyACBonusVsRace(iRandom3,iEnchant2);
            break;
        case 5:
            iRandom3 = Random(8);
            iProperty=ItemPropertyACBonusVsSAlign(iRandom3,iEnchant2);
            break;
        }
    }
if (iRandom<13)
    {
    //on hit cast spell
    iX = Random(130);
    iY = Random(16)+5;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else if (iRandom<17)
    {
    //Damage Reduction
    iX=Random(2);
    iY=Random(2);
    iProperty=ItemPropertyDamageReduction(iX,iY);
    }
else if (iRandom<18)
    {
    //on hit cast spell
    iX = Random(130);
    iY = Random(30)+11;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
if (iRandom<19)
    {
    //on hit cast spell
    iX = GetOnHitSpellSubset();
    iY = Random(16)+5;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else
    iProperty=MiscMagicProperty(iEnchant);

return iProperty;
}

itemproperty MiscMagicProperty(int iEnchant)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;


iRandom = Random(100)+1;

if (iRandom<11)
    {
    //AbilityBonus
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+1;
    iProperty = ItemPropertyAbilityBonus(iX,iY);
    }
else if (iRandom<21)
    {
    //AC Bonus
    iEnchant2 = Random(5)+1;
    if (iEnchant >= iEnchant2)
        iEnchant2 = Random(2) + iEnchant + 1;

    iProperty=ItemPropertyACBonus(iEnchant2);
    }
else if (iRandom<24)
    {
    iRandom2=Random(28);
    iEnchant2=Random(9)+2;
    iProperty=ItemPropertySkillBonus(iRandom2,iEnchant2);
    }
else if (iRandom<26)
    {
    //AC Bonus vs Alignment/RacialGroup/SpecificAlignment
    iRandom2 = Random(100);
    if (iRandom2 < 90)
        iEnchant2 = Random(5)+1;
    else if (iRandom2<99)
        iEnchant2 = Random(10)+1;
    else
        iEnchant2 = Random(20)+1;

    if (iEnchant >= iEnchant2)
        iEnchant2 = Random(5) + iEnchant + 1;

    iRandom2 = Random(5) + 1;
    switch (iRandom2)
        {
        case 1: case 2:
            iRandom3 = Random(5);
            iProperty=ItemPropertyACBonusVsAlign(iRandom3,iEnchant2);
            break;
        case 3: case 4:
            iRandom3 = Random(25);
            iProperty=ItemPropertyACBonusVsRace(iRandom3,iEnchant2);
            break;
        case 5:
            iRandom3 = Random(8);
            iProperty=ItemPropertyACBonusVsSAlign(iRandom3,iEnchant2);
            break;
        }
    }
else if (iRandom<36)
    {
    //SavingthrowBonus
    iRandom3 = Random(3);
    iX = Random(5)+1;
    if (Random(10)==0)
        iX = Random(5) + 6;
    iProperty=ItemPropertyBonusSavingThrow(iRandom3,iX);
    }
else if (iRandom<41)
    {
    //SavingthrowBonus vs X
    iRandom3 = Random(14);
    iX = Random(5)+1;
    if (Random(10)==0)
        iX = Random(5) + 6;
    iProperty=ItemPropertyBonusSavingThrowVsX(iRandom3,iX);
    }
else if (iRandom<44)
    {
    //Spell Resist
    iRandom3 = Random(12);
    iProperty=ItemPropertyBonusSpellResistance(iRandom3);
    }
else if (iRandom<47)
    {
    //Bonus Feat
    iRandom3 = Random(27);
    iProperty=ItemPropertyBonusFeat(iRandom3);
    }
else if (iRandom<52)
    {
    //Cast Spell
    iX=Random(365);
    iY=CastSpellUses();
    iProperty=ItemPropertyCastSpell(iX,iY);
    }
else if (iRandom<56)
    {
    //Damage Resistance
    iX=Random(13);
    if (iX == 3)
        iX = 1;
    iY=Random(10);
    iProperty=ItemPropertyDamageResistance(iX,iY);
    }
else if (iRandom<60)
    {
    //Damage Reduction
    iX=Random(2);
    iY=Random(2);
    iProperty=ItemPropertyDamageReduction(iX,iY);
    }
else if (iRandom<63)
    {
    //FreedomOfMovement
    iProperty=ItemPropertyFreeAction();
    }
else if (iRandom<66)
    {
    //Haste
    iProperty=ItemPropertyHaste();
    }
else if (iRandom<68)
    {
    //TrueSeeing
    iProperty=ItemPropertyTrueSeeing();
    }
else if (iRandom<72)
    {
    //Regeneration
    iX=Random(5)+1;
    if (Random(10)==0)
        iX=Random(10)+1;
    iProperty=ItemPropertyRegeneration(iX);
    }
else if (iRandom<77)
    {
    //immune Misc
    iRandom3=Random(10);
    iProperty=ItemPropertyImmunityMisc(iRandom3);
    }
else if (iRandom<78)
    {
    //immune spell by level
    if (Random(10) == 0)
        iRandom3 = Random(3)+1;
    else
        iRandom3 = Random(9)+1;
    iProperty=ItemPropertyImmunityToSpellLevel(iRandom3);
    }
else if (iRandom<79)
    {
    //immune spell school
    iRandom3=Random(8);
    iProperty=ItemPropertySpellImmunitySchool(iRandom3);
    }
else if (iRandom<82)
    {
    //immune Damage
    iX=Random(13);
    if (iX == 3)
        iX = 1;
    iY=Random(7);
    iProperty=ItemPropertyDamageImmunity(iX,iY);
    }
else if (iRandom<86)
    {
    //AbilityBonus 4-6
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+4;
    iProperty = ItemPropertyAbilityBonus(iX,iY);
    }
else if (iRandom<88)
    {
    //AbilityBonus 7-9
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+7;
    iProperty = ItemPropertyAbilityBonus(iX,iY);
    }
else if (iRandom<89)
    {
    //AbilityBonus 10-12
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+10;
    iProperty = ItemPropertyAbilityBonus(iX,iY);
    }
else if (iRandom<91)
    {
    //Cast Spell
    iX=HealSpell();
    iY=CastSpellUses();
    iProperty=ItemPropertyCastSpell(iX,iY);
    }
else if (iRandom<93)
    {
    iX=Random(5);
    iY=Random(5);
    iProperty=ItemPropertyDamageReduction(iX,iY);
    }
else if (iRandom<94)
    {
    iX=Random(10);
    iY=Random(10);
    iProperty=ItemPropertyDamageReduction(iX,iY);
    }
else if (iRandom<95)
    {
    iProperty=ItemPropertyImprovedEvasion();
    }
else if (iRandom<96)
    {
    iX=Random(365);
    iProperty=ItemPropertySpellImmunitySpecific(iX);
    }
else if (iRandom<98)
    {
    iEnchant2 = Random(10)+1;
    if (iEnchant >= iEnchant2)
        iEnchant2 = Random(5) + iEnchant + 1;
    iProperty=ItemPropertyACBonus(iEnchant2);
    }
else if (iRandom<99)
    {
    iEnchant2 = Random(20)+1;
    if (iEnchant >= iEnchant2)
        iEnchant2 = Random(5) + iEnchant + 1;
    if (iEnchant2>20)
        iEnchant2=20;
    iProperty=ItemPropertyACBonus(iEnchant2);
    }
else
    {
    iProperty=ItemPropertyDarkvision();
    }
return iProperty;
}

int HealSpell()
{
int iRandom;
int iSpell;

iSpell=IP_CONST_CASTSPELL_CURE_MINOR_WOUNDS_1;

iRandom = Random(100)+1;

if (iRandom<16)
    iSpell=IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_2;
else if (iRandom<31)
    iSpell=IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_5;
else if (iRandom<41)
    iSpell=IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_10;
else if (iRandom<51)
    iSpell=IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_3;
else if (iRandom<61)
    iSpell=IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_6;
else if (iRandom<71)
    iSpell=IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_10;
else if (iRandom<76)
    iSpell=IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_5;
else if (iRandom<81)
    iSpell=IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_12;
else if (iRandom<86)
    iSpell=IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
else if (iRandom<91)
    iSpell=IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_7;
else if (iRandom<96)
    iSpell=IP_CONST_CASTSPELL_HEAL_11;
else if (iRandom<91)
    iSpell=IP_CONST_CASTSPELL_HEALING_CIRCLE_16;

return iSpell;
}

int CastSpellUses()
{
int iRandom;
int iSpellUse;

iRandom = Random(15)+1;
switch (iRandom)
    {
    case 1: case 2:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE;
        break;
    case 3: case 4:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE;
        break;
    case 5: case 6:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE;
        break;
    case 7:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_4_CHARGES_PER_USE;
        break;
    case 8: case 9:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        break;
    case 10: case 11:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
    case 12: case 13:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
    case 14:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
        break;
    case 15:
        iSpellUse=IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE;
        break;
    }

return iSpellUse;
}

itemproperty MonkWeaponProperty(int iEnchant)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;

iRandom=Random(100)+1;

if (iRandom<6)
    {
    //attack bonus
    iEnchant2 = iEnchant+1+Random(3);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iProperty=ItemPropertyAttackBonus(iEnchant2);
    }
else if (iRandom<8)
    {
    //attack bonus vs Align
    iEnchant2 = iEnchant+1+Random(5);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iRandom2 = Random(5);
    iProperty=ItemPropertyAttackBonusVsAlign(iRandom2,iEnchant2);
    }
else if (iRandom<10)
    {
    //attack bonus vs Race
    iEnchant2 = iEnchant+1+Random(5);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iRandom2 = Random(25);
    iProperty=ItemPropertyAttackBonusVsRace(iRandom2,iEnchant2);
    }
else if (iRandom<15)
    {
    //massive crit
    iX = Random(20);
    iProperty=ItemPropertyMassiveCritical(iX);
    }
else if (iRandom<17)
    {
    //on hit cast spell
    iX = Random(130);
    iY = Random(16)+5;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else if (iRandom<19)
    {
    iX = Random(22);
    iY = Random(7);
    iZ = Random(5);
    if (iZ == IP_CONST_ONHIT_SLAYRACE)
        iZ = Random(24);
    if (iZ == IP_CONST_ONHIT_SLAYALIGNMENTGROUP)
        iZ = Random(5);
    if (iZ == IP_CONST_ONHIT_SLAYALIGNMENT)
        iZ = Random(9);
    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    }
else if (iRandom<24)
    {
    //dmg bonus (any)
    iX = DamageType();
    iY = DamageBonus();
    iProperty=ItemPropertyDamageBonus(iX,iY);
    }
else if (iRandom<28)
    {
    //dmg bonus vs Align
    iX = DamageType();
    iY = DamageBonus();
    iZ = Random(6);
    iProperty=ItemPropertyDamageBonusVsAlign(iZ,iX,iY);
    }
else if (iRandom<32)
    {
    //dmg bonus vs Race
    iX = DamageType();
    iY = DamageBonus();
    iZ = Random(24);
    iProperty=ItemPropertyDamageBonusVsRace(iZ,iX,iY);
    }
else if (iRandom<39)
    {
    //dmg bonus based on iEnchant
    iX = DamageType();
    iRandom2 = Random(5)+ iEnchant;
    iY = IP_CONST_DAMAGEBONUS_1;
    switch (iRandom2)
        {
        case 1: iY=IP_CONST_DAMAGEBONUS_1; break;
        case 2: iY=IP_CONST_DAMAGEBONUS_2; break;
        case 3: iY=IP_CONST_DAMAGEBONUS_4; break;
        case 4: iY=IP_CONST_DAMAGEBONUS_1d4; break;
        case 5: iY=IP_CONST_DAMAGEBONUS_1d6; break;
        case 6: iY=IP_CONST_DAMAGEBONUS_1d8; break;
        case 7: iY=IP_CONST_DAMAGEBONUS_2d4; break;
        case 8: iY=IP_CONST_DAMAGEBONUS_1d10; break;
        case 9: iY=IP_CONST_DAMAGEBONUS_1d12; break;
        case 10: iY=IP_CONST_DAMAGEBONUS_2d6; break;
        case 11: iY=IP_CONST_DAMAGEBONUS_6; break;
        case 12: iY=IP_CONST_DAMAGEBONUS_8; break;
        case 13: iY=IP_CONST_DAMAGEBONUS_2d8; break;
        case 14: iY=IP_CONST_DAMAGEBONUS_2d10; break;
        case 15: iY=IP_CONST_DAMAGEBONUS_2d12; break;
        }
    iProperty=ItemPropertyDamageBonus(iX,iY);
    }
else if (iRandom<40)
    {
    //on hit cast spell
    iX = Random(130);
    iY = Random(30)+11;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else if (iRandom<41)
    {
    //on hit cast spell
    iX = GetOnHitSpellSubset();
    iY = Random(30)+11;
    if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
        iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    }
else if (iRandom<42)
    {
    //on hit property
    iX = OnHitProp();
    iY = Random(7);
    iZ = OnHitPropSpecial(iX);
    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    }
else
    iProperty=MiscMagicProperty(iEnchant);

return iProperty;
}

itemproperty RangedWeaponProperty(int iEnchant)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;

iRandom=Random(100)+1;

if (iRandom<11)
    {
    //attack bonus
    iEnchant2 = iEnchant+1+Random(3);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iProperty=ItemPropertyAttackBonus(iEnchant2);
    }
else if (iRandom<16)
    {
    //attack bonus vs Align
    iEnchant2 = iEnchant+1+Random(5);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iRandom2 = Random(5);
    iProperty=ItemPropertyAttackBonusVsAlign(iRandom2,iEnchant2);
    }
else if (iRandom<21)
    {
    //attack bonus vs Race
    iEnchant2 = iEnchant+1+Random(5);
    if (iEnchant2 > 20)
        iEnchant2 = 20;
    iRandom2 = Random(25);
    iProperty=ItemPropertyAttackBonusVsRace(iRandom2,iEnchant2);
    }
else if (iRandom<26)
    {
    iEnchant2 = iEnchant+1+Random(3);
    ItemPropertyMaxRangeStrengthMod(iEnchant2);
    }
else if (iRandom<31)
    {
    //massive crit
    iX = Random(20);
    iProperty=ItemPropertyMassiveCritical(iX);
    }
else
    iProperty=MiscMagicProperty(iEnchant);

return iProperty;
}

int GetEnchantments(object oItem)
{
int iCount;

iCount = IPGetNumberOfItemProperties(oItem);
/*
itemproperty ip;

ip = GetFirstItemProperty(oItem);
iCount = 0;

while (GetIsItemPropertyValid(ip))
    {
    iCount++;
    ip = GetNextItemProperty(oItem);
}
*/

return iCount;
}

itemproperty CastSpellEffect()
{
int iX;
int iY;
itemproperty iProperty;

iX=Random(365);
iY=CastSpellUses();
iProperty=ItemPropertyCastSpell(iX,iY);

return iProperty;
}

itemproperty CastSpellEffectOnce()
{
int iX;
int iY;
itemproperty iProperty;

iX=Random(365);
iY=CastSpellUses();
iProperty=ItemPropertyCastSpell(iX,IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE);

return iProperty;
}

void CreateSuperPowers(object oPC)
{
DelayCommand(1.0f,GetSuperPowers(oPC));
}

void GetSuperPowers(object oPC)
{
object oItem;
itemproperty ip;
string sTag;
int iEquip;
int iSuperPowers;

oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);

if (!GetIsObjectValid(oItem))
    {
    sTag = "en3_pcskin";
    oItem = CreateItemOnObject(sTag,oPC);
    iEquip=1;
    }

iSuperPowers = GetLocalInt(oPC,"SuperPowers");

if (iSuperPowers == 1)
    {
    ip=ItemPropertyRegeneration(20);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSuperPowers == 2)
    {
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyACBonus(10);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,10);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSuperPowers == 3)
    {
    ip=ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSuperPowers == 4)
    {
    ip=ItemPropertyImmunityToSpellLevel(9);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSuperPowers == 5)
    {
    ip=ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_30_HP);
    IPSafeAddItemProperty(oItem,ip);
    FireShield(oPC);
//    SendMessageToPC(oPC,"Fire On");
    }
else if (iSuperPowers == 6)
    {
    ip=ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,20);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSuperPowers == 7)
    {
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyFreeAction();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyTrueSeeing();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_BLUE);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
    IPSafeAddItemProperty(oItem,ip);
    SetLocalInt(oPC,"ProcChanceBonus",50);
    }
else if (iSuperPowers == 8)
    {
    SetLocalInt(oPC,"ProcChanceBonus",50);
    }

if (iEquip == 1)
    DelayCommand(1.0f, AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_CARMOUR)));

}

void FireShield(object oTarget)
{

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    effect eShield = EffectDamageShield(10, DAMAGE_BONUS_1d10, DAMAGE_TYPE_FIRE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 50);

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

void CreateSpecialPowers(object oPC)
{
//use a delay for PrC
DelayCommand(1.0f,GetSpecialPowers(oPC));
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
    iEquip=1;
    }

iSpecialPowers = GetLocalInt(oPC,"SpecialPowers");
if (iSpecialPowers == 1)
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,4);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyFreeAction();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSpecialPowers == 2)
    {
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEIMMUNITY_50_PERCENT);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSpecialPowers == 3)
    {
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyHaste();
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyRegeneration(4);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyDamageReduction(0,0);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyBonusSpellResistance(0);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSpecialPowers == 4)
    {
    ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyBonusSpellResistance(0);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,1);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,1);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,1);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertySkillBonus(SKILL_HIDE,4);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSpecialPowers == 5)
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,3);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSpecialPowers == 6)
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,3);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSpecialPowers == 7)
    {
    ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,3);
    IPSafeAddItemProperty(oItem,ip);
    }
else if (iSpecialPowers == 8)
    {
    ip = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22);
    IPSafeAddItemProperty(oItem,ip);
    SetLocalInt(oPC,"ProcChanceBonus",25);
    }

if (iEquip == 1)
    DelayCommand(1.0f, AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_CARMOUR)));
}

void CreateEvilPowers(object oPC)
{
//use a delay for PrC
DelayCommand(1.0f,GetEvilPowers(oPC));
}

void GetEvilPowers(object oPC)
{
object oItem;
itemproperty ip;
string sTag;
int iEquip;
int iEvilPowers;
int iEvilLevel;
effect eConceal;

oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);

if (!GetIsObjectValid(oItem))
    {
    sTag = "en3_pcskin";
    oItem = CreateItemOnObject(sTag,oPC);
    iEquip=1;
    }

iEvilPowers = GetLocalInt(oPC,"EvilPath");
iEvilLevel = GetLocalInt(oPC,"EvilLevel");

//1=Death
//2=Darkness
//3=Demonic

if (iEvilPowers == 1)
    {
    if (iEvilLevel > 0)
        {
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iEvilLevel > 1)
        {
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_10_HP);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iEvilLevel > 2)
        {
        ip=ItemPropertySpellImmunitySchool(IP_CONST_SPELLSCHOOL_NECROMANCY);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEVULNERABILITY_100_PERCENT);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEVULNERABILITY_100_PERCENT);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_20_HP);
        IPSafeAddItemProperty(oItem,ip);
        }
    }
else if (iEvilPowers == 2)
    {
    if (iEvilLevel > 0)
        {
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyHaste();
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyDarkvision();
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEVULNERABILITY_100_PERCENT);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyRegeneration(2);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12);
        IPSafeAddItemProperty(oItem,ip);
        eConceal = EffectConcealment(10);
        }
    if (iEvilLevel > 1)
        {
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,4);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyRegeneration(4);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18);
        IPSafeAddItemProperty(oItem,ip);
        eConceal = EffectConcealment(25);
        }
    if (iEvilLevel > 2)
        {
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,6);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,6);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyRegeneration(6);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22);
        IPSafeAddItemProperty(oItem,ip);
        eConceal = EffectConcealment(50);
        }
    if (iEvilLevel>0)
        {
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eConceal, eDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,9999.0f);
        }
    }
else if (iEvilPowers == 3)
    {
    if (iEvilLevel > 0)
        {
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5);
        IPSafeAddItemProperty(oItem,ip);
        }
    if (iEvilLevel > 1)
        {
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,4);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
        IPSafeAddItemProperty(oItem,ip);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_20);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10);
        IPSafeAddItemProperty(oItem,ip);

        }
    if (iEvilLevel > 2)
        {
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,6);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,6);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
        IPSafeAddItemProperty(oItem,ip);
        ip = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEIMMUNITY_50_PERCENT);
        IPSafeAddItemProperty(oItem,ip);
        }
    }

if (iEquip == 1)
    DelayCommand(1.0f, AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_CARMOUR)));
}


void GetInfiniteSpells(object oPC)
{
object oItem;
int iRandom;
int iIndex;
int iX;
itemproperty iProperty;

oItem=CreateItemOnObject("en4_ibook",oPC);

iRandom = Random(4)+4;
iIndex = 0;

while (iIndex < iRandom)
    {
    iX=Random(365);
    iProperty=ItemPropertyCastSpell(iX,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
    IPSafeAddItemProperty(oItem,iProperty);
    iIndex++;
    }
}

void ItemOfPower(object oPC)
{
string sTag;
itemproperty iProperty;
object oItem;
int iX;
int iDamage;
int iFlag;
int iRandom;

if (GetLevelByClass(CLASS_TYPE_DRUID) >= 1 )
    {
    iFlag = 1;
    sTag = "en4_sov";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC) >= 1 )
    {
    iFlag = 1;
    sTag = "en4_br";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) >= 1 )
    {
    iFlag = 1;
    sTag = "en4_motd";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) >= 1 || GetLevelByClass(CLASS_TYPE_SORCERER, oPC) >= 1)
    {
    iFlag = 1;
    sTag = "en4_soa";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0 && FeatCheck(FEAT_WEAPON_FOCUS_LONG_SWORD,oPC))
    {
    iFlag = 1;
    sTag = "en4_wof";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0 && FeatCheck(FEAT_WEAPON_FOCUS_GREAT_SWORD,oPC))
    {
    iFlag = 1;
    sTag = "en4_botv";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0 && FeatCheck(FEAT_WEAPON_FOCUS_BASTARD_SWORD,oPC))
    {
    iFlag = 1;
    sTag = "en4_sotd";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0 && FeatCheck(FEAT_WEAPON_FOCUS_GREAT_AXE,oPC))
    {
    iFlag = 1;
    sTag = "en4_slasher";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0 && FeatCheck(FEAT_WEAPON_FOCUS_LIGHT_MACE,oPC))
    {
    iFlag = 1;
    sTag = "en4_motd";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0 && FeatCheck(FEAT_WEAPON_FOCUS_RAPIER,oPC))
    {
    iFlag = 1;
    sTag = "en4_br";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0 && FeatCheck(FEAT_WEAPON_FOCUS_SCIMITAR,oPC))
    {
    iFlag = 1;
    sTag = "en4_sov";
    oItem=CreateItemOnObject(sTag,oPC);
    }

if (iFlag == 0)
    {
    GetWeaponType(oPC);
    sTag = "en3_" + GetWeaponTag(oPC) + "2";

    oItem=CreateItemOnObject(sTag,oPC);
    iX=Random(4)+5;
    if(GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        {
        iProperty=ItemPropertyAttackBonus(iX);
        IPSafeAddItemProperty(oItem,iProperty);
        iDamage=IP_CONST_DAMAGEBONUS_1d6;
        switch (iX)
            {
            case 5: case 6: iDamage=IP_CONST_DAMAGEBONUS_1d8; break;
            case 7: iDamage=IP_CONST_DAMAGEBONUS_2d4; break;
            case 8: iDamage=IP_CONST_DAMAGEBONUS_1d10; break;
            case 9: iDamage=IP_CONST_DAMAGEBONUS_1d12; break;
            case 10: iDamage=IP_CONST_DAMAGEBONUS_2d6; break;
            }
        iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,iDamage);
        IPSafeAddItemProperty(oItem,iProperty);
        } else {
        iProperty=ItemPropertyEnhancementBonus(iX);
        IPSafeAddItemProperty(oItem,iProperty);
        }

    if (Random(2)==0)
        {
        iX=Random(21)+10;
        iProperty=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,iX);
        IPSafeAddItemProperty(oItem,iProperty);
        } else {
        iX=Random(11)+10;
        iProperty=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ISAACS_GREATER_MISSILE_STORM,iX);
        IPSafeAddItemProperty(oItem,iProperty);
        iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d4);
        IPSafeAddItemProperty(oItem,iProperty);
        }

    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: if (Random(5)>0)
                    iProperty=ItemPropertyDamageReduction(Random(3)+2,Random(3)+2);
                else
                    iProperty=ItemPropertyDamageReduction(Random(8)+2,Random(3)+2);
                IPSafeAddItemProperty(oItem,iProperty);
                break;
        case 2: if (Random(5)>0)
                    iProperty=ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24);
                else
                    iProperty=ItemPropertyImmunityToSpellLevel(Random(9)+1);
                IPSafeAddItemProperty(oItem,iProperty);
                break;
        case 3: iProperty=ItemPropertyHaste();
                IPSafeAddItemProperty(oItem,iProperty);
                break;
        case 4: iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
                IPSafeAddItemProperty(oItem,iProperty);
                iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
                IPSafeAddItemProperty(oItem,iProperty);
                break;
        }
    }
}

void IE_MagicalRing(object oPC)
{
int iX;
int iRandom;
int iIndex;
itemproperty iProperty;
object oItem;

oItem = CreateItemOnObject("IE_Ring",oPC);

iRandom = Random(4)+1;
iIndex = 0;

if (Random(2)==0)
    {
    iProperty = MiscMagicProperty(0);
    IPSafeAddItemProperty(oItem,iProperty);
    }

while (iIndex < iRandom)
    {
    iX=Random(365);
    iProperty=ItemPropertyCastSpell(iX,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
    IPSafeAddItemProperty(oItem,iProperty);
    iIndex++;
    }

}

void MakeStatue(object oPC)
{
object oItem;
itemproperty ip;
int iSpell;
int iRandom;

oItem = CreateItemOnObject("en3_statue",oPC);

iRandom = Random(10)+1;
switch (iRandom)
    {
    case 1: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_I_5; break;
    case 2: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3; break;
    case 3: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5; break;
    case 4: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IV_7; break;
    case 5: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17; break;
    case 6: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_V_9; break;
    case 7: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VI_11; break;
    case 8: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13; break;
    case 9: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15; break;
    case 10: iSpell = IP_CONST_CASTSPELL_PLANAR_ALLY_15; break;
    case 11: iSpell = IP_CONST_CASTSPELL_PLANAR_BINDING_11; break;
    }

ip=ItemPropertyCastSpell(iSpell,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
IPSafeAddItemProperty(oItem,ip);
}

void GetArtifact(object oCreature)
{
int iRandom;
int iCount;
int iSlot;
string sTag;
itemproperty iProperty;
object oItem;

iRandom=Random(6)+1;
sTag = "en3_artifact" + IntToString(iRandom);
if (GetLocalInt(GetModule(),sTag) == 0)
    {
    SetLocalInt(GetModule(),sTag,1);
    } else {
    iRandom = 0;
    sTag = "en3_artifact0";
    }

switch (iRandom)
    {
    case 0: iSlot = INVENTORY_SLOT_RIGHTRING; break;
    case 1: iSlot = INVENTORY_SLOT_CLOAK; break;
    case 2: iSlot = INVENTORY_SLOT_NECK; break;
    case 3: iSlot = INVENTORY_SLOT_BOOTS; break;
    case 4: iSlot = INVENTORY_SLOT_BELT; break;
    case 5: iSlot = INVENTORY_SLOT_RIGHTRING; break;
    case 6: iSlot = INVENTORY_SLOT_HEAD; break;
    }
oItem=CreateItemOnObject(sTag,oCreature);

iCount=0;
while (iCount < 2)
    {
    iCount++;
    iProperty = ArtifactProperty();
    IPSafeAddItemProperty(oItem,iProperty);
    }

iCount=0;
while (iCount < 3)
    {
    iCount++;
    iProperty = MiscMagicProperty(0);
    IPSafeAddItemProperty(oItem,iProperty);
    }

EquipItem(iSlot, oItem, oCreature);
}

itemproperty ArtifactProperty()
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;


iRandom = Random(100)+1;

if (iRandom<8)
    {
    //Enhanced Strength
    iY = Random(15)+6;
    iProperty = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,iY);
    }
else if (iRandom<15)
    {
    //Enhanced Constitution
    iY = Random(15)+6;
    iProperty = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,iY);
    }
else if (iRandom<29)
    {
    //Dmg Resist
    iX = Random(15)+5;
    iY = Random(5)+3;
    iProperty=ItemPropertyDamageReduction(iX,iY);
    }
else if (iRandom<33)
    {
    iRandom3 = Random(7)+1;
    switch (iRandom3)
        {
        case 1: iX = IP_CONST_CASTSPELL_METEOR_SWARM_17; break;
        case 2: iX = IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17; break;
        case 3: iX = IP_CONST_CASTSPELL_SUNBURST_20; break;
        case 4: iX = IP_CONST_CASTSPELL_SHAPECHANGE_17; break;
        case 5: iX = IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15; break;
        case 6: iX = IP_CONST_CASTSPELL_INCENDIARY_CLOUD_15; break;
        case 7: iX = IP_CONST_CASTSPELL_EARTHQUAKE_20; break;
        }
    iProperty=ItemPropertyCastSpell(iX,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
    }
else if (iRandom<43)
    {
    //Spell Resist
    iRandom3 = Random(4);
    switch (iRandom3)
        {
        case 0: iY = IP_CONST_SPELLRESISTANCEBONUS_26; break;
        case 1: iY = IP_CONST_SPELLRESISTANCEBONUS_28; break;
        case 2: iY = IP_CONST_SPELLRESISTANCEBONUS_30; break;
        case 3: iY = IP_CONST_SPELLRESISTANCEBONUS_32; break;
        }
    iProperty=ItemPropertyBonusSpellResistance(iY);
    }
else if (iRandom<57)
    {
    //Regeneration
    iX=Random(15)+6;
    iProperty=ItemPropertyRegeneration(iX);
    }
else if (iRandom<71)
    {
    //immune Misc
    iRandom3 = Random(6)+3;
    iProperty = ItemPropertyImmunityToSpellLevel(iRandom3);
    }
else if (iRandom<85)
    {
    //immune Physical Damage
    iRandom2 = Random(3);
    switch (iRandom2)
        {
        case 0: iX =IP_CONST_DAMAGETYPE_BLUDGEONING; break;
        case 1: iX =IP_CONST_DAMAGETYPE_PIERCING; break;
        case 2: iX =IP_CONST_DAMAGETYPE_SLASHING; break;
        }

    iRandom2 = Random(2);
    if (iRandom2 == 0)
        {
        iY = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;
        }
    else
        {
        iY = IP_CONST_DAMAGEIMMUNITY_100_PERCENT;
        }

    iProperty=ItemPropertyDamageImmunity(iX,iY);
    }
else
    {
    //immune Magical Damage
    //immune Physical Damage

    iRandom2 = Random(5);
    switch (iRandom2)
        {
        case 0: iX =IP_CONST_DAMAGETYPE_ACID;  break;
        case 1: iX =IP_CONST_DAMAGETYPE_COLD;  break;
        case 2: iX =IP_CONST_DAMAGETYPE_ELECTRICAL;  break;
        case 3: iX =IP_CONST_DAMAGETYPE_FIRE;   break;
        case 4: iX =IP_CONST_DAMAGETYPE_SONIC;  break;
        }

    iRandom2 = Random(3);
    if (iRandom2 == 0)
        {
        iY = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;
        }
    else if (iRandom2 == 1)
        {
        iY = IP_CONST_DAMAGEIMMUNITY_75_PERCENT;
        }
    else
        {
        iY = IP_CONST_DAMAGEIMMUNITY_100_PERCENT;
        }

    iProperty=ItemPropertyDamageImmunity(iX,iY);
    }

return iProperty;
}

void GetMinorMagicItem(object oCreature, int iDroppable = TRUE)
{
string sTag;
object oItem;
itemproperty iProperty;
int iRandom;
int iRandom2;
int iRandom3;
int iPosition;
int iIndex;
int iEnchantments;
int iProperties;
int iMod;

iMod = 0;
iRandom = Random(15)+1;

switch (iRandom)
    {
    case 1: case 2: sTag = "en3_amulet";
            iPosition = INVENTORY_SLOT_NECK;
            break;
    case 3: case 4: sTag = "en3_ring";
            iPosition = INVENTORY_SLOT_LEFTRING;
            break;
    case 5: case 6: iRandom2 = Random(8)+1;
            sTag = "en3_helm" + IntToString(iRandom2);
            iMod = 1;
            iPosition = INVENTORY_SLOT_HEAD;
            break;
    case 7: case 8: sTag = "en3_belt";
            iPosition = INVENTORY_SLOT_BELT;
            break;
    case 9: case 10: sTag = "en3_boots";
            iPosition = INVENTORY_SLOT_BOOTS;
            break;
    case 11: case 12: sTag = "en3_gloves";
            iPosition = INVENTORY_SLOT_ARMS;
            break;
    case 13: case 14: sTag = "en3_cloak";
            iPosition = INVENTORY_SLOT_CLOAK;
            break;
    case 15: iRandom2 = Random(5)+1;
            switch (iRandom2)
                {
                case 1: sTag = "en3_magestaff";
                        sTag = sTag + IntToString(Random(4)+1);
                        iPosition = -1;
                        break;
                case 2: sTag = "en3_wand";
                        iPosition = -2;
                        break;
                case 3: sTag = "en3_rod";
                        iPosition = -2;
                        break;
                case 4: sTag = "en3_misc";
                        sTag = sTag + IntToString(Random(6)+1);
                        iPosition = -3;
                        break;
                case 5: sTag = "en3_instrument";
                        sTag = sTag + IntToString(Random(3)+1);
                        iPosition = -4;
                        break;
                }
            break;
    }

if (iPosition == -4 && Random(10)==0)
    sTag = "en3_instrument4";

oItem=CreateItemOnObject(sTag,oCreature,1);

iEnchantments = 1;
iRandom = Random(100)+1;
if (iRandom <=85)
    iEnchantments = 1;
else if (iRandom <=99)
    iEnchantments = 2;
else
    iEnchantments = 3;

//acount for usable by properties
if (iPosition == -1)
    iEnchantments = iEnchantments + 3;
if (sTag == "en3_wand")
    iEnchantments = iEnchantments + 5;
if (iPosition == -3)
    iEnchantments = 1;

iIndex = 0;
//SendMessageToPC(GetFirstPC(),"Tag = " + sTag);
//SendMessageToPC(GetFirstPC(),"Enchantments = " + IntToString(iEnchantments));

while (iProperties < iEnchantments + iMod)
    {
    iIndex++;
    if (iPosition >=0)
        {
        iProperty = MinorMagicProperty(0);
        }
    else if (iPosition == -1)
        {
        if (Random(3)==0)
            iProperty = WeaponProperty(0);
        else
            iProperty = CastSpellEffect();
        }
    else if (iPosition == -2)
        {
        iProperty = CastSpellEffect();
        }
    else if (iPosition == -3)
        {
        if (!(sTag == "en3_misc1"))
            iProperty = CastSpellEffectOnce();
        }
    else if (iPosition == -4)
        {
            iProperty = CastSpellEffect();
        }

     IPSafeAddItemProperty(oItem,iProperty);
     iProperties = GetEnchantments(oItem);
//SendMessageToPC(GetFirstPC(),"iProperties = " + IntToString(iProperties) + " Index = " + IntToString(iIndex) );
        if (iIndex > 20)
            {
            if (Random(3)==0)
                {
                iProperty = ItemPropertyDamageReduction(Random(3),Random(3));
                IPSafeAddItemProperty(oItem,iProperty);
                } else {
                iProperty = ItemPropertyACBonus(Random(5)+1);
                IPSafeAddItemProperty(oItem,iProperty);
                }
            iProperties = 99;
            }
    }

if (!(GetIsPC(oCreature)))
    EquipItem(iPosition, oItem, oCreature);

if (iDroppable == FALSE)
    {
    SetDroppableFlag(oItem,FALSE);
    //SendMessageToPC(GetFirstPC(),"Item " + GetName(oItem) + " created on " + GetName(oCreature));
    }

if (sTag == "en3_ring" && Random(10) == 0)
    {
    iProperty = ItemPropertyLight(Random(4),Random(7));
    IPSafeAddItemProperty(oItem,iProperty);
    }

}

itemproperty MinorMagicProperty(int iEnchant)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;


iRandom = Random(100)+1;

if (iRandom<6)
    {
    iRandom2=Random(28);
    iEnchant2=Random(4)+1;
    iProperty=ItemPropertySkillBonus(iRandom2,iEnchant2);
    }
else if (iRandom<26)
    {
    //AbilityBonus
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+1;
    iProperty = ItemPropertyAbilityBonus(iX,iY);
    }
else if (iRandom<76)
    {
    //AC Bonus
    iEnchant2 = Random(3)+1;
    if (iEnchant >= iEnchant2)
        iEnchant2 = Random(2) + iEnchant + 1;

    iProperty=ItemPropertyACBonus(iEnchant2);
    }

else if (iRandom<91)
    {
    //SavingthrowBonus
    iRandom3 = Random(90);
    iX = Random(3)+1;
    if (Random(10)==0)
        iX = Random(3) + 4;
    iProperty=ItemPropertyBonusSavingThrow(iRandom3,iX);
    }

else if (iRandom<96)
    {
    //Damage Reduction
    iProperty=ItemPropertyDamageReduction(0,0);
    }

else if (iRandom<101)
    {
    //Regeneration
    iX=1;
    if (Random(10)==0)
        iX=2;
    iProperty=ItemPropertyRegeneration(iX);
    }
else
    {
    iProperty=ItemPropertyDarkvision();
    }
return iProperty;
}

int GetNumEnchantments(int iLevel)
{
int iEnchantments;
int iRandom;

iEnchantments = 1;
iRandom = Random(100)+1;

if (iLevel<5)
    {
    if (iRandom <=90)
        iEnchantments = 1;
    else if (iRandom <=99)
        iEnchantments = 2;
    else
        iEnchantments = 3;
    }
else if (iLevel<9)
    {
    if (iRandom <=85)
        iEnchantments = 1;
    else if (iRandom <=95)
        iEnchantments = 2;
    else if (iRandom <=99)
        iEnchantments = 3;
    else
        iEnchantments = 4;
    }
else if (iLevel < 13)
    {
    if (iRandom <=80)
        iEnchantments = 1;
    else if (iRandom <=90)
        iEnchantments = 2;
    else if (iRandom <=95)
        iEnchantments = 3;
    else if (iRandom <=99)
        iEnchantments = 4;
    else
        iEnchantments = 5;
    }
else if (iLevel < 17)
    {
    if (iRandom <=70)
        iEnchantments = 1;
    else if (iRandom <=85)
        iEnchantments = 2;
    else if (iRandom <=92)
        iEnchantments = 3;
    else if (iRandom <=97)
        iEnchantments = 4;
    else if (iRandom <=99)
        iEnchantments = 5;
    else
        iEnchantments = 6;
    }
else
    {
    if (iRandom <=60)
        iEnchantments = 1;
    else if (iRandom <=80)
        iEnchantments = 2;
    else if (iRandom <=90)
        iEnchantments = 3;
    else if (iRandom <=95)
        iEnchantments = 4;
    else if (iRandom <=99)
        iEnchantments = 5;
    else
        iEnchantments = 6;
    }

return iEnchantments;
}

void CreateListenRing(object oCreature)
{
object oItem;
int iBonus;
itemproperty ip;

oItem = CreateItemOnObject("en3_ring",oCreature);

iBonus = Random(20)+1;
ip = ItemPropertySkillBonus(SKILL_LISTEN,iBonus);
IPSafeAddItemProperty(oItem,ip);
SetDroppableFlag(oItem,FALSE);
EquipItem(INVENTORY_SLOT_RIGHTRING, oItem, oCreature);
}

void CreateProtectionRing(object oCreature)
{
object oItem;
int iRange;
int iProtection;
int iBonus;
itemproperty ip;

oItem = CreateItemOnObject("en3_ring",oCreature);

iRange = GetHitDice(oCreature)/10+1;

if (iRange <2)
    iProtection = Random(3)+1;
else if (iRange <3)
    iProtection = Random(4)+2;
else if (iRange <4)
    iProtection = Random(8)+3;
else
    iProtection = Random(10)+5;

ip = ItemPropertyACBonus(iProtection);
IPSafeAddItemProperty(oItem,ip);

if (Random(100)<GetHitDice(oCreature)/2)
    {
    iBonus = Random(20)+1;
    ip = ItemPropertySkillBonus(SKILL_LISTEN,iBonus);
    IPSafeAddItemProperty(oItem,ip);
    }

if (GetHitDice(oCreature)>29 && Random(2)==0)
    {
    ip = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,Random(8)+3);
    IPSafeAddItemProperty(oItem,ip);
    }

SetDroppableFlag(oItem,FALSE);
EquipItem(INVENTORY_SLOT_RIGHTRING, oItem, oCreature);
}

void GetEnchantedItem(object oCreature)
{
int iRandom;
int iRandom2;
int iType;
int iEnchantment;
int iLevel;
int iArmor;
string sTag;
object oItem;
itemproperty ip;

if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oCreature))
    iRandom = Random(3) + 1;
else
    iRandom = Random(2) + 1;

switch (iRandom)
    {
    case 1: GetWeaponType(oCreature);
            sTag = "en3_" + GetWeaponTag(oCreature);
            iType=1;
            break;
    case 2: iRandom2=Random(3)+1;
            switch(iRandom2)
            {
            case 1: sTag = "en3_sshield"; break;
            case 2: sTag = "en3_lshield"; break;
            case 3: sTag = "en3_tshield"; break;
            }
            iType=2;
            break;
    case 3: iArmor = ENGetArmorType(oCreature);
            sTag = GetArmorTag(iArmor);
            iType=2;
            break;
    }

sTag = sTag + "1";

iLevel = GetHitDice(oCreature);
iEnchantment = iLevel/5+1;

if (iType == 1)
    ip=ItemPropertyEnhancementBonus(iEnchantment);
else
    ip=ItemPropertyACBonus(iEnchantment);

oItem=CreateItemOnObject(sTag,oCreature);
IPSafeAddItemProperty(oItem,ip);
}

void GetEN2Weapon(object oContainer, object oPC)
{
string sTag;
int iRandom;
object oItem;
itemproperty ip;

GetWeaponType(oPC);
sTag = "en2_" + GetWeaponTag(oPC);

iRandom = Random(5)+1;

if (iRandom >1 && GetHitDice(oPC) < 5)
    iRandom = 2;
else if (iRandom >2 && GetHitDice(oPC) < 8)
    iRandom = 3;
else if (iRandom >3 && GetHitDice(oPC) < 11)
    iRandom = 4;

sTag = sTag + IntToString(iRandom);

oItem = CreateItemOnObject(sTag,oContainer);
if (!GetIsObjectValid(oItem))
    {
    sTag = "en3_" + GetWeaponTag(oPC) + "2";
    oItem = CreateItemOnObject(sTag,oContainer);
    ip = ItemPropertyEnhancementBonus(iRandom+1);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6);
    IPSafeAddItemProperty(oItem,ip);
    }
}

void GetEN2Armor(object oContainer, object oPC)
{
string sTag;
int iRandom;
object oItem;
itemproperty ip;

sTag = GetArmorTag(ENGetArmorType(oPC));
sTag = GetSubString(sTag,4,GetStringLength(sTag)-4);
sTag = "en2_" + sTag;

iRandom = Random(5)+1;

if (iRandom >1 && GetHitDice(oPC) < 5)
    iRandom = 1;
else if (iRandom >2 && GetHitDice(oPC) < 8)
    iRandom = 2;
else if (iRandom >3 && GetHitDice(oPC) < 11)
    iRandom = 3;

sTag = sTag + IntToString(iRandom);
SendMessageToPC(oPC,sTag);
oItem = CreateItemOnObject(sTag,oContainer);
if (!GetIsObjectValid(oItem))
    {
    sTag = GetArmorTag(ENGetArmorType(oPC)) + IntToString(Random(2)+2);
    oItem = CreateItemOnObject(sTag,oContainer);
    ip = ItemPropertyACBonus(iRandom+1);
    IPSafeAddItemProperty(oItem,ip);
    ip = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
    IPSafeAddItemProperty(oItem,ip);
    }
SendMessageToPC(oPC,sTag);
}

int GetOnHitSpellSubset()
{
int iRandom;
int iSpell;

iRandom = Random(10)+1;
iSpell = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
switch (iRandom)
    {
    case 1: iSpell = IP_CONST_ONHIT_CASTSPELL_CALL_LIGHTNING; break;
    case 2: iSpell = IP_CONST_ONHIT_CASTSPELL_DAZE; break;
    case 3: iSpell = IP_CONST_ONHIT_CASTSPELL_FIREBALL; break;
    case 4: iSpell = IP_CONST_ONHIT_CASTSPELL_FLAME_LASH; break;
    case 5: iSpell = IP_CONST_ONHIT_CASTSPELL_FLAME_STRIKE; break;
    case 6: iSpell = IP_CONST_ONHIT_CASTSPELL_ICE_STORM; break;
    case 7: iSpell = IP_CONST_ONHIT_CASTSPELL_ISAACS_LESSER_MISSILE_STORM; break;
    case 8: iSpell = IP_CONST_ONHIT_CASTSPELL_ISAACS_GREATER_MISSILE_STORM; break;
    case 9: iSpell = IP_CONST_ONHIT_CASTSPELL_LIGHTNING_BOLT; break;
    case 10: iSpell = IP_CONST_ONHIT_CASTSPELL_MAGIC_MISSILE; break;
    case 11: iSpell = IP_CONST_ONHIT_CASTSPELL_ONHIT_DARKFIRE; break;
    case 12: iSpell = IP_CONST_ONHIT_CASTSPELL_ONHIT_FIREDAMAGE; break;
    case 13: iSpell = IP_CONST_ONHIT_CASTSPELL_ONHITFLAMINGSKIN; break;
    case 14: iSpell = IP_CONST_ONHIT_CASTSPELL_SOUND_BURST; break;
    case 15: iSpell = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH; break;
    case 16: iSpell = IP_CONST_ONHIT_CASTSPELL_WOUNDING_WHISPERS; break;
    case 17: iSpell = IP_CONST_ONHIT_CASTSPELL_INFESTATION_OF_MAGGOTS; break;
    case 18: iSpell = IP_CONST_ONHIT_CASTSPELL_GEDLEES_ELECTRIC_LOOP; break;
    case 19: iSpell = IP_CONST_ONHIT_CASTSPELL_FREEZE; break;
    case 20: iSpell = IP_CONST_ONHIT_CASTSPELL_CONFUSION; break;
    case 21: iSpell = IP_CONST_ONHIT_CASTSPELL_ACID_SPLASH; break;
    case 22: iSpell = IP_CONST_ONHIT_CASTSPELL_CONTAGION; break;
    }
return iSpell;
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

    if (GetLocalInt(oPC,"SuperPowers") == 8)
        {
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,GetHitDice(oPC));
        IPSafeAddItemProperty(oItem,ip,86400.0f);
        iFlag = TRUE;
        }

    if (GetLocalInt(oPC,"EvilPath")>0)
        {
        if (GetLocalInt(oPC,"EvilPath") == 1 && GetLocalInt(oPC,"EvilLevel") > 2)
            {
            ip=ItemPropertyVampiricRegeneration(10);
            IPSafeAddItemProperty(oItem,ip,86400.0f);
            iFlag = TRUE;
            }
        if (GetLocalInt(oPC,"EvilPath") == 2 && GetLocalInt(oPC,"EvilLevel") > 1)
            {
            //OnHitProps don't seem to work as temp prop
            //ip=ItemPropertyOnHitProps(IP_CONST_ONHIT_BLINDNESS,IP_CONST_ONHIT_SAVEDC_20);
            ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DARKNESS,10);
            IPSafeAddItemProperty(oItem,ip,86400.0f);
            iFlag = TRUE;
            }
        if (GetLocalInt(oPC,"EvilPath") == 3 && GetLocalInt(oPC,"EvilLevel") > 2)
            {
            ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_FIREBALL,20);
            IPSafeAddItemProperty(oItem,ip,86400.0f);
            iFlag = TRUE;
            }
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

itemproperty MiscNegativeProperty(int iType=0)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;

if (iType == 0)
    iRandom = Random(80)+1;
else
    iRandom = Random(120)+1;

//debugline
//SendMessageToPC(GetFirstPC(),"iRandom=" + IntToString(iRandom));

if (iRandom<6)
    {
    iRandom2=Random(28);
    iEnchant2=Random(10)+1;
    iProperty = ItemPropertyDecreaseSkill(iRandom2,iEnchant2);
    }
else if (iRandom<26)
    {
    iRandom2=Random(6);
    iEnchant2=Random(10)+1;
    iProperty = ItemPropertyDecreaseAbility(iRandom2,iEnchant2);
    }
else if (iRandom<46)
    {
    iRandom2=Random(5);
    iEnchant2=Random(5)+1;
    iProperty = ItemPropertyDecreaseAC(iRandom2,iEnchant2);
    }
else if (iRandom<66)
    {
    iRandom2=Random(12);
    iEnchant2=Random(7);
    iProperty = ItemPropertyDamageVulnerability(iRandom2,iEnchant2);
    }
else if (iRandom<81)
    {
    iRandom2=Random(3);
    iEnchant2=Random(10)+1;
    iProperty = ItemPropertyReducedSavingThrow(iRandom2,iEnchant2);
    }
else if (iRandom<101)
    {
    iRandom2=Random(5)+1;
    iProperty = ItemPropertyAttackPenalty(iRandom2);
    }
else if (iRandom<121)
    {
    iRandom2=Random(5)+1;
    iProperty = ItemPropertyDamagePenalty(iRandom2);
    }

return iProperty;
}



void GetNegativeItem(object oCreature,int iEquipItem=FALSE)
{
string sTag;
object oItem;
object oPC;
itemproperty ip;
int iRandom;
int iType;
int iPosition;
int iItemType;
int iArtifact;
int iPositive;
int iNegative;
int iCount;
int iEnchant;
int iEnchantments;

iType = 0;
if (Random(10)==0)
    iType = 1;

if (iType == 0)
    {
    iRandom = Random(12)+1;
    switch (iRandom)
        {
        case 1: case 2: sTag = "en3_amulet";
                iPosition = INVENTORY_SLOT_NECK;
                break;
        case 3: case 4: sTag = "en3_ring";
                iPosition = INVENTORY_SLOT_LEFTRING;
                break;
        case 5: case 6: sTag = "en3_belt";
                iPosition = INVENTORY_SLOT_BELT;
                break;
        case 7: case 8: sTag = "en3_boots";
                iPosition = INVENTORY_SLOT_BOOTS;
                break;
        case 9: case 10: sTag = "en3_gloves";
                iPosition = INVENTORY_SLOT_ARMS;
                break;
        case 11: case 12: sTag = "en3_cloak";
                iPosition = INVENTORY_SLOT_CLOAK;
                break;
        }
    } else {
        oPC = GetRandomTreasurePC();
        GetWeaponType(oPC);
        sTag = "en3_" + GetWeaponTag(oPC);
    }

if (iType == 0)
    oItem=CreateItemOnObject(sTag,oCreature,1);
else
    oItem=CreateItemOnObject(sTag + "2",oCreature,1);

iRandom = Random(100)+1;

if (iRandom < 2)
    {
    iArtifact=1;
    iNegative=1;
    iPositive=0;
    }
else if (iRandom < 3)
    {
    iArtifact=1;
    iNegative=2;
    iPositive=Random(2)+1;
    }
else if (iRandom < 4)
    {
    iArtifact=2;
    iNegative=4;
    iPositive=Random(2);
    }
else if (iRandom < 60)
    {
    iArtifact=0;
    iNegative=1;
    iPositive=1;
    }
else if (iRandom < 85)
    {
    iArtifact=0;
    iNegative=1;
    iPositive=2;
    }
else if (iRandom < 99)
    {
    iArtifact=0;
    iNegative=2;
    iPositive=Random(2)+2;
    }
else
    {
    iArtifact=0;
    iNegative=2;
    iPositive=4;
    }

iItemType=0;
iEnchant = Random(5)+1;

//debugline
//SendMessageToPC(oCreature,GetName(oItem) + " (" + sTag + ") : Artifact = " + IntToString(iArtifact) + " : Positive = " + IntToString(iPositive) + " : Negative = " + IntToString(iNegative));

if (IPGetIsMeleeWeapon(oItem))
    {
    iItemType=1;
    iPositive--;
    ip=ItemPropertyEnhancementBonus(iEnchant);
    IPSafeAddItemProperty(oItem,ip);
    }
if (IPGetIsRangedWeapon(oItem))
    {
    iItemType=2;
    iPositive--;
    ip=ItemPropertyAttackBonus(iEnchant);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyMaxRangeStrengthMod(iEnchant);
    IPSafeAddItemProperty(oItem,ip);
    }
if (GetBaseItemType(oItem) == BASE_ITEM_GLOVES && iType == 1)
    {
    iItemType=3;
    iPositive--;
    ip=ItemPropertyAttackBonus(iEnchant);
    IPSafeAddItemProperty(oItem,ip);
    ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,GetEnchantBonus(iEnchant));
    IPSafeAddItemProperty(oItem,ip);
    }

if (iPositive>0)
    {
    iCount = 0;
    while (iCount < iPositive)
        {
        iEnchantments = GetEnchantments(oItem);
        if (iItemType == 1)
            ip = WeaponProperty(iEnchant);
        else if (iItemType == 2)
            ip = RangedWeaponProperty(iEnchant);
        else if (iItemType == 3)
            ip = MonkWeaponProperty(iEnchant);
        else
            ip = MiscMagicProperty(iEnchant);
        IPSafeAddItemProperty(oItem,ip);
        if (GetEnchantments(oItem)>iEnchantments)
            iCount++;
        }
    }

if (iNegative>0)
    {
    iCount = 0;
    while (iCount < iNegative)
        {
        iEnchantments = GetEnchantments(oItem);
        ip = MiscNegativeProperty(iType);
        IPSafeAddItemProperty(oItem,ip);
        if (GetEnchantments(oItem)>iEnchantments)
            iCount++;
        }
    }

if (iArtifact>0)
    {
    iCount = 0;
    while (iCount < iArtifact)
        {
        iEnchantments = GetEnchantments(oItem);
        ip = ArtifactProperty();
        IPSafeAddItemProperty(oItem,ip);
        if (GetEnchantments(oItem)>iEnchantments)
            iCount++;
        }
    }

}

