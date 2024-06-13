#include "en5_misc"
#include "en5_w_a_check"
#include "en5_weapons"
#include "prc_x2_itemprop"

void GetMagicItem(object oCreature, int iItemLevel=0, int iSpecificItemType=0, object oPC=OBJECT_SELF);
string GetArms(object oPC,int iItemLevel=1);
string GetBelt(object oPC,int iItemLevel=1);
string GetBoots(object oPC,int iItemLevel=1);
string GetCloak(object oPC,int iItemLevel=1);
string GetNeck(object oPC,int iItemLevel=1);
string GetRing(object oPC,int iItemLevel=1);
string GetHead(object oPC,int iItemLevel=1);
string GetArmor(object oPC,int iItemLevel=1);
string GetLightArmor(object oPC,int iItemLevel=1);
string GetMediumArmor(object oPC,int iItemLevel=1);
string GetHeavyArmor(object oPC,int iItemLevel=1);
string GetMonkArmor(object oPC,int iItemLevel=1);
string GetRobes(object oPC,int iItemLevel=1);
string GetShield(object oPC,int iItemLevel=1);
string GetMiscMagic(object oPC,int iItemLevel=1);
void GetRandomMagic(object oCreature,int iItemLevel=1, int iType=0,object oPC=OBJECT_SELF);
int GetEnchantBonus(int iEnchant);
itemproperty WeaponProperty(int iEnchant, object oItem);
itemproperty ArmorProperty(int iEnchant, object oItem);
itemproperty MiscProperty(int iEnchant, object oItem);
int DamageType();
int DamageBonus();
int CastSpellUses();
itemproperty GetCastSpell(int iItemLevel);
int GetUnlimitedEnchantBonus(int iEnchant);
int CheckPossibleBrawler(object oPC);
void SetDBName(object oItem,int iX);
void SetPostName(object oItem,string sName);
void SetPreName(object oItem,string sName,string sAltName);
string Trim(string sString);
itemproperty ArtifactProperty();
void GetArtifact(object oCreature);
string SetTagName(string sItemName);

void GetMagicItem(object oCreature, int iItemLevel=0, int iSpecificItemType=0, object oPC=OBJECT_SELF)
{
object oItem;
int iSlot;
int iRandom;
int iRandom2;
int iLevel;
string sTag;

if (!(GetObjectType(oPC) == OBJECT_TYPE_CREATURE))
    if (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE)
        oPC=oCreature;
    else
        oPC = GetRandomPC();

if (iItemLevel==0)
    {
    iLevel = GetHitDice(oPC);
    iItemLevel = GetItemLevel(iLevel);
    }

iRandom=Random(50);
if (iRandom == 0)
    iItemLevel--;
if (iRandom == 1)
    iItemLevel++;

if (iItemLevel<1)
    iItemLevel==1;

if (iItemLevel>6)
    iItemLevel==6;

iRandom = Random(5)+1;

if (iSpecificItemType>0)
    iRandom = iSpecificItemType;

int iArcanePlus	= GetLevelByClass(CLASS_TYPE_WIZARD, oPC)
				+ GetLevelByClass(CLASS_TYPE_SORCERER, oPC)
				+ GetLevelByClass(CLASS_TYPE_DRAGONFIRE_ADEPT, oPC)
				+ GetLevelByClass(CLASS_TYPE_DRAGON_SHAMAN, oPC)			
				+ GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oPC)
				+ GetLevelByClass(CLASS_TYPE_BEGUILER, oPC)
				+ GetLevelByClass(CLASS_TYPE_SHADOWCASTER, oPC)
				+ GetLevelByClass(CLASS_TYPE_WARMAGE, oPC)
				+ GetLevelByClass(CLASS_TYPE_BINDER, oPC)
				+ GetLevelByClass(CLASS_TYPE_BARD, oPC)
				+ GetLevelByClass(CLASS_TYPE_TRUENAMER, oPC)			
				+ GetLevelByClass(CLASS_TYPE_WARLOCK, oPC);	
			
switch (iRandom)
    {
    case 1: sTag="WEAPON"; break;
    case 2: sTag="ARMOR"; break;
    case 3: case 4: sTag="RANDOM"; break;
    case 5: iRandom2=Random(12)+1;
            switch (iRandom2)
                {
                case 1: case 2: sTag=GetMagicWeapon(oPC,iItemLevel); iSlot=INVENTORY_SLOT_RIGHTHAND; break;
                case 3: case 4: sTag=GetArmor(oPC,iItemLevel); iSlot=INVENTORY_SLOT_CHEST; break;
                case 5: sTag=GetArms(oPC,iItemLevel); iSlot=INVENTORY_SLOT_ARMS; break;
                case 6: sTag=GetBelt(oPC,iItemLevel); iSlot=INVENTORY_SLOT_BELT; break;
                case 7: sTag=GetBoots(oPC,iItemLevel); iSlot=INVENTORY_SLOT_BOOTS; break;
                case 8: sTag=GetCloak(oPC,iItemLevel); iSlot=INVENTORY_SLOT_CLOAK; break;
                case 9: sTag=GetNeck(oPC,iItemLevel); iSlot=INVENTORY_SLOT_NECK; break;
                case 10: sTag=GetRing(oPC,iItemLevel); iSlot=INVENTORY_SLOT_LEFTRING; break;
                case 11: sTag=GetHead(oPC,iItemLevel); iSlot=INVENTORY_SLOT_HEAD; break;
                case 12:
                    if (iArcanePlus > 0)
                        {
                        sTag=GetMiscMagic(oPC,iItemLevel);
                        } else {
                        if (Random(2) == 0)
                            sTag=GetMiscMagic(oPC,iItemLevel);
                        else
                            sTag=GetMagicWeapon(oPC,iItemLevel);
                        }
                    break;
                }
    }

if (sTag == "RANDOM")
    GetRandomMagic(oCreature,iItemLevel,0,oPC);
else if (sTag == "WEAPON")
    GetRandomMagic(oCreature,iItemLevel,1,oPC);
else if (sTag == "ARMOR")
    GetRandomMagic(oCreature,iItemLevel,3,oPC);
else
    {
    oItem=CreateItemOnObject(sTag,oCreature);

    if (iSlot==INVENTORY_SLOT_RIGHTHAND && CheckPossibleBrawler(oPC))
        {
        itemproperty ip;
        ip=ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK);
        IPRemoveMatchingItemProperties(oItem,GetItemPropertyType(ip),DURATION_TYPE_PERMANENT,GetItemPropertySubType(ip));
        }

    if (GetObjectType(oCreature)==OBJECT_TYPE_CREATURE && !GetIsPC(oPC))
        {
        EquipItem(iSlot, oItem, oPC);
        }
    }
//DelayCommand(0.1,SendMessageToPC(GetFirstPC(),"Level=" + IntToString(iItemLevel) + " | Item = " + sTag));

}

int CheckPossibleBrawler(object oPC)
{
int iResult;

iResult=FALSE;

if (FeatCheck(FEAT_IMPROVED_UNARMED_STRIKE, oPC) || GetLevelByClass(CLASS_TYPE_MONK, oPC) < 1)
    iResult=TRUE;

return iResult;
}

string GetArms(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MBRACER002"; break;
        case 2: sTag="NW_IT_MBRACER001"; break;
        case 3: sTag="X0_IT_MBRACER001"; break;
        case 4: sTag="NW_IT_MBRACER012"; break;
        case 5: sTag="x2_nash_glove"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MBRACER007"; break;
        case 2: sTag="NW_IT_MBRACER003"; break;
        case 3: sTag="NW_IT_MBRACER011"; break;
        case 4: sTag="NW_IT_MBRACER013"; break;
        case 5: sTag="X0_IT_MGLOVE007"; break;
        }
    }

if (iItemLevel == 3)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MBRACER008"; break;
        case 2: sTag="NW_IT_MBRACER004"; break;
        case 3: sTag="X0_IT_MGLOVE006"; break;
        case 4: sTag="NW_IT_MGLOVE001"; break;
        }
    }

if (iItemLevel == 4)
    {
    iRandom = Random(2)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MBRACER009"; break;
        case 2: sTag="NW_IT_MBRACER005"; break;
        }
    }

if (iItemLevel == 5)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MBRACER010"; break;
        case 2: sTag="NW_IT_MBRACER006"; break;
        case 3: sTag="X0_IT_MBRACER002"; break;
        case 4: sTag="X0_IT_MGLOVE005"; break;
        }
    }

if (iItemLevel == 6)
    {
    iRandom = Random(1)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_IT_MBRACER001"; break;
        }
    }

return sTag;
}

string GetBelt(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mbelt011"; break;
        case 2: sTag="nw_it_mbelt010"; break;
        case 3: sTag="nw_it_mbelt009"; break;
        case 4: sTag="X0_IT_MBELT002"; break;
        }
    }

if (iItemLevel == 2)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mbelt018"; break;
        case 2: sTag="NW_ITEM_000"; break;
        case 3: sTag="nw_it_mbelt015"; break;
        case 4: sTag="NW_IT_MBELT004"; break;
        case 5: sTag="NW_IT_MBELT005"; break;
        }
    }

if (iItemLevel == 3)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mbelt019"; break;
        case 2: sTag="X0_IT_MBELT001"; break;
        case 3: sTag="NW_IT_MBELT002"; break;
        case 4: sTag="nw_it_mbelt016"; break;
        case 5: sTag="x2_belt_001"; break;
        }
    }

if (iItemLevel == 4)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mbelt020"; break;
        case 2: sTag="NW_IT_MBELT007"; break;
        case 3: sTag="NW_IT_MBELT003"; break;
        case 4: sTag="NW_IT_MBELT001"; break;
        case 5: sTag="nw_it_mbelt017"; break;
        case 6: sTag="X0_IT_MBELT006"; break;
        case 7: sTag="X0_IT_MBELT005"; break;
        case 8: sTag="X0_IT_MBELT003"; break;
        }
    }

if (iItemLevel == 5)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mbelt021"; break;
        case 2: sTag="NW_IT_MBELT008"; break;
        case 3: sTag="nw_it_mbelt014"; break;
        case 4: sTag="nw_it_mbelt013"; break;
        case 5: sTag="nw_it_mbelt012"; break;
        }
    }

if (iItemLevel == 6)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_IT_MBELT003"; break;
        case 2: sTag="X2_IT_MBELT001"; break;
        case 3: sTag="X2_IT_MBELT002"; break;
        }
    }
return sTag;
}

string GetBoots(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mboots010"; break;
        case 2: sTag="NW_IT_MBOOTS001"; break;
        case 3: sTag="NW_IT_MBOOTS018"; break;
        case 4: sTag="X0_IT_MBOOTS001"; break;
        case 5: sTag="X0_IT_MBOOTS002"; break;
        case 6: sTag="en5_boots_1_1"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mboots011"; break;
        case 2: sTag="NW_IT_MBOOTS006"; break;
        case 3: sTag="NW_IT_MBOOTS019"; break;
        case 4: sTag="X0_IT_MBOOTS003"; break;
        case 5: sTag="en5_boots_2_1"; break;

        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mboots012"; break;
        case 2: sTag="NW_IT_MBOOTS015"; break;
        case 3: sTag="NW_IT_MBOOTS007"; break;
        case 4: sTag="NW_IT_MBOOTS020"; break;
        case 5: sTag="NW_IT_MBOOTS003"; break;
        case 6: sTag="NW_IT_MBOOTS004"; break;
        case 7: sTag="X0_IT_MBOOTS004"; break;
        case 8: sTag="x2_nash_boot"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mboots013"; break;
        case 2: sTag="NW_IT_MBOOTS016"; break;
        case 3: sTag="NW_IT_MBOOTS005"; break;
        case 4: sTag="NW_IT_MBOOTS008"; break;
        case 5: sTag="NW_IT_MBOOTS021"; break;
        case 6: sTag="en5_boots_4_1"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_it_mboots014"; break;
        case 2: sTag="NW_IT_MBOOTS017"; break;
        case 3: sTag="NW_IT_MBOOTS009"; break;
        case 4: sTag="X1_IT_MBOOTS001"; break;
        case 5: sTag="NW_IT_MBOOTS022"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(2)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_IT_MBOOTS003"; break;
        case 2: sTag="X2_IT_MBOOTS006"; break;
        }
    }

return sTag;
}

string GetCloak(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL055"; break;
        case 2: sTag="nw_maarcl098"; break;
        case 3: sTag="nw_maarcl097"; break;
        case 4: sTag="nw_maarcl096"; break;
        case 5: sTag="nw_maarcl099"; break;
        case 6: sTag="X0_MAARCL025"; break;
        case 7: sTag="NW_MAARCL031"; break;
        case 8: sTag="en5_cloak3"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL088"; break;
        case 2: sTag="NW_MAARCL104"; break;
        case 3: sTag="X0_MAARCL030"; break;
        case 4: sTag="NW_MAARCL057"; break;
        case 5: sTag="NW_MAARCL030"; break;
        case 6: sTag="X2_IT_DROWCL001"; break;
        case 7: sTag="NW_MAARCL092"; break;
        case 8: sTag="X1_IT_MCLOAK001"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(11)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL089"; break;
        case 2: sTag="NW_MAARCL105"; break;
        case 3: sTag="X0_MAARCL038"; break;
        case 4: sTag="X0_MAARCL039"; break;
        case 5: sTag="X0_MAARCL040"; break;
        case 6: sTag="NW_MAARCL056"; break;
        case 7: sTag="X0_MAARCL027"; break;
        case 8: sTag="X0_MAARCL031"; break;
        case 9: sTag="X0_MAARCL034"; break;
        case 10: sTag="x2_nash_cloak"; break;
        case 11: sTag="NW_MAARCL093"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(11)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL090"; break;
        case 2: sTag="NW_MAARCL106"; break;
        case 3: sTag="X0_MAARCL028"; break;
        case 4: sTag="nw_maarcl102"; break;
        case 5: sTag="nw_maarcl101"; break;
        case 6: sTag="nw_maarcl100"; break;
        case 7: sTag="nw_maarcl103"; break;
        case 8: sTag="NW_MAARCL094"; break;
        case 9: sTag="X0_MAARCL035"; break;
        case 10: sTag="en5_cloak1"; break;
        case 11: sTag="en5_cloak2"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL091"; break;
        case 2: sTag="X2_IT_MCLOAK004"; break;
        case 3: sTag="X0_MAARCL032"; break;
        case 4: sTag="X0_MAARCL033"; break;
        case 5: sTag="X0_MAARCL029"; break;
        case 6: sTag="NW_MAARCL095"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_IT_MCLOAK006"; break;
        case 2: sTag="X2_IT_MCLOAK005"; break;
        case 3: sTag="X2_IT_MCLOAK002"; break;
        case 4: sTag="X2_IT_MCLOAK003"; break;
        case 5: sTag="X2_IT_MCLOAK008"; break;
        }
    }
return sTag;
}

string GetNeck(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MNECK001"; break;
        case 2: sTag="nw_it_mneck024"; break;
        case 3: sTag="X0_IT_MNECK005"; break;
        case 4: sTag="NW_IT_MNECK023"; break;
        case 5: sTag="NW_IT_MNECK007"; break;
        case 6: sTag="NW_IT_MNECK006"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(15)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MNECK012"; break;
        case 2: sTag="nw_it_mneck032"; break;
        case 3: sTag="nw_it_mneck030"; break;
        case 4: sTag="nw_it_mneck031"; break;
        case 5: sTag="nw_it_mneck029"; break;
        case 6: sTag="NW_IT_MNECK005"; break;
        case 7: sTag="X0_IT_MNECK006"; break;
        case 8: sTag="NW_IT_MNECK034"; break;
        case 9: sTag="X0_IT_MNECK001"; break;
        case 10: sTag="nw_it_mneck025"; break;
        case 11: sTag="NW_IT_MNECK035"; break;
        case 12: sTag="NW_IT_MNECK033"; break;
        case 13: sTag="X0_IT_MNECK004"; break;
        case 14: sTag="NW_IT_MNECK008"; break;
        case 15: sTag="NW_IT_MNECK016"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MNECK013"; break;
        case 2: sTag="NW_IT_MNECK036"; break;
        case 3: sTag="nw_it_mneck026"; break;
        case 4: sTag="X0_IT_MNECK002"; break;
        case 5: sTag="NW_IT_MNECK003"; break;
        case 6: sTag="NW_IT_MNECK009"; break;
        case 7: sTag="NW_IT_MNECK017"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(10)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MNECK014"; break;
        case 2: sTag="X2_IT_MNECK002"; break;
        case 3: sTag="nw_it_mneck027"; break;
        case 4: sTag="NW_IT_MNECK037"; break;
        case 5: sTag="X0_IT_MNECK007"; break;
        case 6: sTag="NW_IT_MNECK010"; break;
        case 7: sTag="X0_IT_MNECK003"; break;
        case 8: sTag="NW_IT_MNECK018"; break;
        case 9: sTag="NW_IT_MNECK002"; break;
        case 10: sTag="NW_IT_MNECK004"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MNECK015"; break;
        case 2: sTag="X2_IT_MNECK004"; break;
        case 3: sTag="nw_it_mneck028"; break;
        case 4: sTag="NW_IT_MNECK011"; break;
        case 5: sTag="NW_IT_MNECK019"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_IT_MNECK021"; break;
        case 2: sTag="X2_IT_MNECK003"; break;
        case 3: sTag="X2_IT_MNECK017"; break;
        case 4: sTag="X2_IT_MNECK006"; break;
        case 5: sTag="X2_IT_MNECK011"; break;
        }
    }
return sTag;
}

string GetRing(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(11)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MRING006"; break;
        case 2: sTag="NW_IT_MRING010"; break;
        case 3: sTag="NW_IT_MRING009"; break;
        case 4: sTag="X0_IT_MRING005"; break;
        case 5: sTag="nw_it_mring024"; break;
        case 6: sTag="NW_IT_MRING012"; break;
        case 7: sTag="NW_IT_MRING011"; break;
        case 8: sTag="NW_IT_MRING001"; break;
        case 9: sTag="NW_IT_MRING031"; break;
        case 10: sTag="NW_IT_MRING013"; break;
        case 11: sTag="en3_mrofregen"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(18)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MRING014"; break;
        case 2: sTag="X0_IT_MRING007"; break;
        case 3: sTag="X0_IT_MRING008"; break;
        case 4: sTag="NW_IT_MRING029"; break;
        case 5: sTag="X0_IT_MRING013"; break;
        case 6: sTag="X0_IT_MRING001"; break;
        case 7: sTag="X0_IT_MRING010"; break;
        case 8: sTag="nw_it_mring025"; break;
        case 9: sTag="X0_IT_MRING002"; break;
        case 10: sTag="NW_IT_MRING005"; break;
        case 11: sTag="X0_IT_MRING011"; break;
        case 12: sTag="NW_IT_MRING008"; break;
        case 13: sTag="NW_IT_MRING032"; break;
        case 14: sTag="X0_IT_MRING014"; break;
        case 15: sTag="X2_IT_MRING006"; break;
        case 16: sTag="NW_IT_NOVEL001"; break;
        case 17: sTag="en3_item"; break;
        case 18: sTag="ZEP_NECRO_RING"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(13)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MRING015"; break;
        case 2: sTag="X0_IT_MRING009"; break;
        case 3: sTag="x2_nash_ring"; break;
        case 4: sTag="nw_it_mring026"; break;
        case 5: sTag="X0_IT_MRING006"; break;
        case 6: sTag="NW_IT_MRING007"; break;
        case 7: sTag="NW_IT_MRING003"; break;
        case 8: sTag="NW_IT_MRING018"; break;
        case 9: sTag="NW_IT_MRING033"; break;
        case 10: sTag="x2_ring_pet"; break;
        case 11: sTag="X1_IT_MRING001"; break;
        case 12: sTag="X1_IT_MRING002"; break;
        case 13: sTag="en5_ring2"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(10)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MRING016"; break;
        case 2: sTag="nw_it_mring027"; break;
        case 3: sTag="X0_IT_MRING004"; break;
        case 4: sTag="X2_IT_MRING001"; break;
        case 5: sTag="X2_IT_MRING002"; break;
        case 6: sTag="X2_IT_MRING003"; break;
        case 7: sTag="X2_IT_MRING004"; break;
        case 8: sTag="X2_IT_MRING005"; break;
        case 9: sTag="NW_IT_MRING019"; break;
        case 10: sTag="en5_ring1"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MRING017"; break;
        case 2: sTag="nw_it_mring028"; break;
        case 3: sTag="X0_IT_MRING012"; break;
        case 4: sTag="NW_IT_MRING030"; break;
        case 5: sTag="NW_IT_MRING020"; break;
        case 6: sTag="NW_IT_MRING004"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(12)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_IT_MRING020"; break;
        case 2: sTag="X2_IT_MRING017"; break;
        case 3: sTag="X2_IT_MRING019"; break;
        case 4: sTag="X2_IT_MRING007"; break;
        case 5: sTag="X2_IT_MRING008"; break;
        case 6: sTag="X2_IT_MRING010"; break;
        case 7: sTag="X2_IT_MRING009"; break;
        case 8: sTag="NW_IT_MRING002"; break;
        case 9: sTag="X2_IT_MRING011"; break;
        case 10: sTag="X2_IT_MRING025"; break;
        case 11: sTag="X2_IT_MRING012"; break;
        case 12: sTag="X2_IT_MRING018"; break;
        }
    }
return sTag;
}

string GetHead(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_ARMHE005"; break;
        case 2: sTag="X0_ARMHE007"; break;
        case 3: sTag="X0_ARMHE008"; break;
        case 4: sTag="X0_ARMHE016"; break;
        case 5: sTag="NW_ARMHE011"; break;
        case 6: sTag="NW_IT_NOVEL004"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="x2_it_adahelm"; break;
        case 2: sTag="X0_ARMHE004"; break;
        case 3: sTag="NW_ARMHE012"; break;
        case 4: sTag="X0_ARMHE009"; break;
        case 5: sTag="X0_ARMHE001"; break;
        case 6: sTag="NW_ARMHE008"; break;
        case 7: sTag="NW_ARMHE006"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="x2_helm_001"; break;
        case 2: sTag="X0_ARMHE002"; break;
        case 3: sTag="NW_ARMHE009"; break;
        case 4: sTag="NW_ARMHE007"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(9)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_ARMHE014"; break;
        case 2: sTag="X0_ARMHE003"; break;
        case 3: sTag="X0_ARMHE006"; break;
        case 4: sTag="NW_ARMHE010"; break;
        case 5: sTag="X0_ARMHE010"; break;
        case 6: sTag="X0_ARMHE017"; break;
        case 7: sTag="X2_ARMHE001"; break;
        case 8: sTag="X0_ARMHE013"; break;
        case 9: sTag="X2_ARMHE002"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_ARMHE015"; break;
        case 2: sTag="X0_ARMHE012"; break;
        case 3: sTag="x2_helm_003"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="x2_helm_004"; break;
        case 2: sTag="X0_ARMHE011"; break;
        case 3: sTag="x2_helm_002"; break;
        }
    }
return sTag;
}

string GetArmor(object oPC,int iItemLevel=1)
{
string sTag;
int iArmor;

iArmor = ENGetArmorType(oPC);
if (iArmor == 0 || iArmor > 5)
    iArmor = Random(5)+1;
if (iArmor == 2 && Random(10)==0)
    iArmor = 1;
if (iArmor == 3 && Random(10)==0)
    iArmor = Random(2)+1;

if (Random(3)==0)
    sTag = GetShield(oPC,iItemLevel);
else
    {
    switch (iArmor)
        {
        case 1: sTag=GetLightArmor(oPC,iItemLevel); break;
        case 2: sTag=GetMediumArmor(oPC,iItemLevel); break;
        case 3: sTag=GetHeavyArmor(oPC,iItemLevel); break;
        case 4: sTag=GetRobes(oPC,iItemLevel); break;
        case 5: sTag=GetMonkArmor(oPC,iItemLevel); break;
        }
    }
return sTag;
}

string GetLightArmor(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL046"; break;
        case 2: sTag="NW_MAARCL011"; break;
        case 3: sTag="NW_MAARCL044"; break;
        case 4: sTag="x2_it_mithralsh"; break;
        case 5: sTag="NW_MAARCL043"; break;
        case 6: sTag="NW_MAARCL045"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(10)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL067"; break;
        case 2: sTag="NW_MAARCL013"; break;
        case 3: sTag="NW_MAARCL006"; break;
        case 4: sTag="NW_MAARCL032"; break;
        case 5: sTag="NW_MAARCL012"; break;
        case 6: sTag="NW_MAARCL071"; break;
        case 7: sTag="NW_MAARCL072"; break;
        case 8: sTag="X1_MAARCL001"; break;
        case 9: sTag="NW_MAARCL075"; break;
        case 10: sTag="NW_MAARCL007"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(12)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL079"; break;
        case 2: sTag="NW_MAARCL003"; break;
        case 3: sTag="NW_MAARCL001"; break;
        case 4: sTag="NW_MCLOTH005"; break;
        case 5: sTag="NW_MAARCL017"; break;
        case 6: sTag="X0_MAARCL041"; break;
        case 7: sTag="NW_MAARCL083"; break;
        case 8: sTag="NW_MAARCL002"; break;
        case 9: sTag="NW_MAARCL084"; break;
        case 10: sTag="NW_MAARCL034"; break;
        case 11: sTag="NW_MAARCL008"; break;
        case 12: sTag="NW_MAARCL087"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_MAARCL009"; break;
        case 2: sTag="NW_MAARCL004"; break;
        case 3: sTag="NW_MAARCL009"; break;
        case 4: sTag="X0_MAARCL003"; break;
        case 5: sTag="X0_MAARCL001"; break;
        case 6: sTag="NW_MAARCL005"; break;
        case 7: sTag="NW_IT_NOVEL003"; break;
        case 8: sTag="X0_MAARCL005"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_MAARCL010"; break;
        case 2: sTag="x2_cus_bindingsofblood"; break;
        case 3: sTag="NW_MAARCL033"; break;
        case 4: sTag="X0_MAARCL004"; break;
        case 5: sTag="X0_MAARCL002"; break;
        case 6: sTag="X0_MAARCL006"; break;
        case 7: sTag="en5_light5_1"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_MAARCL033"; break;
        case 2: sTag="x2_cus_dancerssilhouette"; break;
        case 3: sTag="x2_cus_fletchersfriend"; break;
        case 4: sTag="X2_MAARCL027"; break;
        case 5: sTag="X2_MAARCL025"; break;
        case 6: sTag="X2_MAARCL029"; break;
        }
    }

return sTag;
}


string GetMediumArmor(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL049"; break;
        case 2: sTag="NW_MAARCL035"; break;
        case 3: sTag="NW_MAARCL047"; break;
        case 4: sTag="x2_it_mithralch"; break;
        case 5: sTag="NW_MAARCL048"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL065"; break;
        case 2: sTag="NW_MAARCL040"; break;
        case 3: sTag="x2_it_adachain"; break;
        case 4: sTag="NW_MAARCL066"; break;
        case 5: sTag="NW_MAARCL058"; break;
        case 6: sTag="NW_MAARCL036"; break;
        case 7: sTag="NW_MAARCL070"; break;
        case 8: sTag="NW_MAARCL073"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL077"; break;
        case 2: sTag="NW_MAARCL014"; break;
        case 3: sTag="NW_MAARCL016"; break;
        case 4: sTag="NW_MAARCL078"; break;
        case 5: sTag="NW_MAARCL037"; break;
        case 6: sTag="NW_MAARCL082"; break;
        case 7: sTag="NW_MAARCL085"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_MAARCL015"; break;
        case 2: sTag="X0_MAARCL013"; break;
        case 3: sTag="NW_MAARCL039"; break;
        case 4: sTag="NW_MAARCL061"; break;
        case 5: sTag="X0_MAARCL007"; break;
        case 6: sTag="NW_MAARCL010"; break;
        case 7: sTag="X0_MAARCL011"; break;
        case 8: sTag="x2_armor_001"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_MAARCL016"; break;
        case 2: sTag="X0_MAARCL014"; break;
        case 3: sTag="NW_MAARCL015"; break;
        case 4: sTag="X0_MAARCL008"; break;
        case 5: sTag="X0_MAARCL012"; break;
        case 6: sTag="en5_medium5_1"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_MAARCL039"; break;
        case 2: sTag="X2_MAARCL037"; break;
        case 3: sTag="X2_MAARCL031"; break;
        case 4: sTag="X2_MAARCL050"; break;
        case 5: sTag="X2_MAARCL035"; break;
        case 6: sTag="X2_MAARCL049"; break;
        }
    }
return sTag;
}

string GetHeavyArmor(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL051"; break;
        case 2: sTag="NW_MAARCL022"; break;
        case 3: sTag="NW_MAARCL029"; break;
        case 4: sTag="NW_MAARCL053"; break;
        case 5: sTag="NW_MAARCL052"; break;
        case 6: sTag="NW_MAARCL059"; break;
        case 7: sTag="NW_MAARCL050"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(12)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL064"; break;
        case 2: sTag="x2_it_adaplate"; break;
        case 3: sTag="NW_MAARCL021"; break;
        case 4: sTag="NW_MAARCL025"; break;
        case 5: sTag="NW_MAARCL024"; break;
        case 6: sTag="NW_MAARCL068"; break;
        case 7: sTag="NW_MAARCL026"; break;
        case 8: sTag="NW_MAARCL069"; break;
        case 9: sTag="NW_MAARCL020"; break;
        case 10: sTag="NW_MAARCL074"; break;
        case 11: sTag="X0_MAARCL037"; break;
        case 12: sTag="NW_MAARCL060"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MAARCL076"; break;
        case 2: sTag="NW_MAARCL080"; break;
        case 3: sTag="NW_MAARCL081"; break;
        case 4: sTag="X0_MAARCL036"; break;
        case 5: sTag="NW_MAARCL062"; break;
        case 6: sTag="NW_MAARCL063"; break;
        case 7: sTag="NW_MAARCL086"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(9)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_MAARCL019"; break;
        case 2: sTag="NW_MAARCL054"; break;
        case 3: sTag="NW_MAARCL028"; break;
        case 4: sTag="NW_MAARCL042"; break;
        case 5: sTag="X0_MAARCL023"; break;
        case 6: sTag="X0_MAARCL021"; break;
        case 7: sTag="NW_MAARCL041"; break;
        case 8: sTag="X0_MAARCL017"; break;
        case 9: sTag="NW_MAARCL018"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(6)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_MAARCL020"; break;
        case 2: sTag="X0_MAARCL024"; break;
        case 3: sTag="X0_MAARCL022"; break;
        case 4: sTag="NW_MAARCL027"; break;
        case 5: sTag="X0_MAARCL018"; break;
        case 6: sTag="en5_fullplate1"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_MAARCL043"; break;
        case 2: sTag="x2_cus_armoroffaith"; break;
        case 3: sTag="x2_cus_casielssoul"; break;
        case 4: sTag="x2_armor_004"; break;
        case 5: sTag="X2_MAARCL045"; break;
        case 6: sTag="X2_MAARCL041"; break;
        case 7: sTag="x2_cus_thegildeddefender"; break;
        case 8: sTag="x2_cus_theironskeleton"; break;
        }
    }
return sTag;
}

string GetMonkArmor(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(2)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH018"; break;
        case 2: sTag="NW_MCLOTH015"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH019"; break;
        case 2: sTag="NW_MCLOTH016"; break;
        case 3: sTag="X0_CLOTH002"; break;
        case 4: sTag="NW_MCLOTH013"; break;
        case 5: sTag="X0_CLOTH001"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(2)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH020"; break;
        case 2: sTag="X0_CLOTH004"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH021"; break;
        case 2: sTag="x2_cus_robe1"; break;
        case 3: sTag="NW_MCLOTH017"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH022"; break;
        case 2: sTag="x2_cus_lastwords"; break;
        case 3: sTag="en5_monkrobe5_1"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(1)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_MCLOTH001"; break;
        }
    }
return sTag;
}

string GetRobes(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH007"; break;
        case 2: sTag="NW_MCLOTH008"; break;
        case 3: sTag="NW_MCLOTH010"; break;
        case 4: sTag="X1_MCLOTH001"; break;
        case 5: sTag="NW_MCLOTH009"; break;
        case 6: sTag="NW_MCLOTH006"; break;
        case 7: sTag="en5_magerobe1"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_MDUERAR010"; break;
        case 2: sTag="NW_MCLOTH014"; break;
        case 3: sTag="X0_CLOTH005"; break;
        case 4: sTag="X0_CLOTH003"; break;
        case 5: sTag="NW_MCLOTH001"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(2)+1;
    switch (iRandom)
        {
        case 1: sTag="x2_sequencer1"; break;
        case 2: sTag="X0_CLOTH004"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(2)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH012"; break;
        case 2: sTag="x2_cus_robe1"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_MCLOTH004"; break;
        case 2: sTag="x2_sequencer2"; break;
        case 3: sTag="NW_MCLOTH003"; break;
        case 4: sTag="NW_MCLOTH002"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="x2_sequencer3"; break;
        case 2: sTag="X2_MCLOTH005"; break;
        case 3: sTag="x2_cus_shiftertunic"; break;
        }
    }
return sTag;
}

string GetShield(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(12)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_ASHMLW002"; break;
        case 2: sTag="X2_ASHMLW006"; break;
        case 3: sTag="X2_IT_IWOODSHLDL"; break;
        case 4: sTag="NW_ASHMSW005"; break;
        case 5: sTag="x2_it_ironwshlds"; break;
        case 6: sTag="nw_ashmsw010"; break;
        case 7: sTag="nw_ashmsw011"; break;
        case 8: sTag="x2_smchaosshield"; break;
        case 9: sTag="NW_ASHMSW002"; break;
        case 10: sTag="NW_ASHMTO005"; break;
        case 11: sTag="x2_it_ironwshldt"; break;
        case 12: sTag="NW_ASHMTO002"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_ASHMLW008"; break;
        case 2: sTag="X0_ASHMLW003"; break;
        case 3: sTag="NW_ASHMSW003"; break;
        case 4: sTag="NW_ASHMSW006"; break;
        case 5: sTag="NW_ASHMSW008"; break;
        case 6: sTag="NW_ASHMTO007"; break;
        case 7: sTag="nw_ashmto010"; break;
        case 8: sTag="NW_ASHMTO008"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(10)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_ASHMLW009"; break;
        case 2: sTag="NW_ASHMLW006"; break;
        case 3: sTag="NW_ASHMLW004"; break;
        case 4: sTag="NW_ASHMLW007"; break;
        case 5: sTag="NW_ASHMSW007"; break;
        case 6: sTag="NW_ASHMSW009"; break;
        case 7: sTag="nw_ashmto011"; break;
        case 8: sTag="NW_ASHMTO003"; break;
        case 9: sTag="NW_ASHMTO004"; break;
        case 10: sTag="NW_ASHMTO009"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_ASHMLW001"; break;
        case 2: sTag="NW_ASHMLW005"; break;
        case 3: sTag="NW_ASHMLW003"; break;
        case 4: sTag="NW_ASHMSW004"; break;
        case 5: sTag="X0_ASHMSW001"; break;
        case 6: sTag="NW_ASHMTO006"; break;
        case 7: sTag="X0_ASHMTO001"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="X0_ASHMLW002"; break;
        case 2: sTag="X0_ASHMSW002"; break;
        case 3: sTag="X0_ASHMTO002"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_ASHMLW003"; break;
        case 2: sTag="X2_ASHMLW005"; break;
        case 3: sTag="X2_ASHMSW003"; break;
        case 4: sTag="X2_ASHMTO005"; break;
        case 5: sTag="X2_ASHMTO003"; break;
        }
    }
return sTag;
}


string GetMiscMagic(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(14)+1;
    switch (iRandom)
        {
        case 1: sTag="nw_wmgmrd006"; break;
        case 2: sTag="NW_WMGST006"; break;
        case 3: sTag="NW_IT_MSMLMISC23"; break;
        case 4: sTag="X0_IT_MTHNMISC04"; break;
        case 5: sTag="X0_IT_MTHNMISC05"; break;
        case 6: sTag="X0_IT_MTHNMISC06"; break;
        case 7: sTag="X0_IT_MTHNMISC15"; break;
        case 8: sTag="NW_IT_CONTAIN005"; break;
        case 9: sTag="NW_IT_MMIDMISC03"; break;
        case 10: sTag="X0_IT_MSMLMISC06"; break;
        case 11: sTag="NW_IT_CONTAIN003"; break;
        case 12: sTag="nw_wmgwn013"; break;
        case 13: sTag="nw_wmgwn006"; break;
        case 14: sTag="en6_hcard"; break;
        }
    }

if (iItemLevel == 2)
    {
    iRandom = Random(20)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_WMGMRD005"; break;
        case 2: sTag="NW_WMGMRD003"; break;
        case 3: sTag="NW_WMGRD002"; break;
        case 4: sTag="X0_WMGMRD007"; break;
        case 5: sTag="NW_WMGST004"; break;
        case 6: sTag="NW_IT_CONTAIN006"; break;
        case 7: sTag="X0_IT_MSMLMISC01"; break;
        case 8: sTag="X0_IT_MSMLMISC02"; break;
        case 9: sTag="X0_IT_MMEDMISC01"; break;
        case 10: sTag="X0_IT_MTHNMISC21"; break;
        case 11: sTag="X0_IT_MTHNMISC17"; break;
        case 12: sTag="X0_IT_MTHNMISC08"; break;
        case 13: sTag="X0_IT_MTHNMISC09"; break;
        case 14: sTag="X0_IT_MTHNMISC16"; break;
        case 15: sTag="X0_IT_MSMLMISC05"; break;
        case 16: sTag="nw_wmgwn004"; break;
        case 17: sTag="nw_wmgrd002"; break;
        case 18: sTag="nw_wmgwn012"; break;
        case 19: sTag="en5_misc1"; break;
        case 20: sTag="en6_hcard"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(21)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_WMGMRD004"; break;
        case 2: sTag="NW_WMGRD002"; break;
        case 3: sTag="NW_WMGST005"; break;
        case 4: sTag="NW_WMGST003"; break;
        case 5: sTag="X0_IT_MTHNMISC18"; break;
        case 6: sTag="X0_IT_MTHNMISC19"; break;
        case 7: sTag="X0_IT_MTHNMISC13"; break;
        case 8: sTag="X0_IT_MSMLMISC03"; break;
        case 9: sTag="X0_IT_MSMLMISC04"; break;
        case 10: sTag="X0_IT_MTHNMISC14"; break;
        case 11: sTag="NW_IT_MMIDMISC04"; break;
        case 12: sTag="X0_IT_MMEDMISC06"; break;
        case 13: sTag="nw_wmgwn007"; break;
        case 14: sTag="nw_wmgwn003"; break;
        case 15: sTag="nw_wmgwn010"; break;
        case 16: sTag="nw_wmgwn011"; break;
        case 17: sTag="nw_wmgwn005"; break;
        case 18: sTag="nw_wmgwn008"; break;
        case 19: sTag="nw_wmgwn009"; break;
        case 20: sTag="nw_wmgrd002"; break;
        case 21: sTag="nw_wmgwn012"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(10)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_WMGMRD002"; break;
        case 2: sTag="NW_WMGST002"; break;
        case 3: sTag="X0_IT_MMEDMISC02"; break;
        case 4: sTag="X0_IT_MMEDMISC03"; break;
        case 5: sTag="NW_IT_MMIDMISC01"; break;
        case 6: sTag="NW_IT_MMIDMISC02"; break;
        case 7: sTag="X0_IT_MMEDMISC05"; break;
        case 8: sTag="X0_IT_MTHNMISC11"; break;
        case 9: sTag="NW_IT_MSMLMISC05"; break;
        case 10: sTag="nw_wmgwn002"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(10)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_NOVEL008"; break;
        case 2: sTag="X2_WMGST001"; break;
        case 3: sTag="nw_wblmcl012"; break;
        case 4: sTag="nw_wmgmrd003"; break;
        case 5: sTag="nw_wmgst004"; break;
        case 6: sTag="nw_wmgst005"; break;
        case 7: sTag="nw_wblmcl012"; break;
        case 8: sTag="nw_wmgmrd004"; break;
        case 9: sTag="nw_wmgst002"; break;
        case 10: sTag="nw_wmgmrd005"; break;
        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_NOVEL002"; break;
        case 2: sTag="X0_IT_MTHNMISC10"; break;
        case 3: sTag="nw_wmgmrd004"; break;
        case 4: sTag="nw_wmgst002"; break;
        case 5: sTag="nw_wmgmrd005"; break;
        case 6: sTag="nw_wmgmrd002"; break;
        case 7: sTag="nw_wmgst003"; break;
        case 8: sTag="nw_wblmcl012"; break;
        }
    }

return sTag;
}

void GetRandomMagic(object oCreature,int iItemLevel=1, int iType=0,object oPC=OBJECT_SELF)
{
int iEnchantments;
int iRandom;
itemproperty iProperty;
object oItem;
string sTag;
string sPlus;
string sName;
int iPosition;
int iRandom2;
int iArmor;
int iProperties;
int iIndex;
int iPreCount;
int iPostCount;
int iTest;
int iTwoHanded;

int iArcane	= GetLevelByClass(CLASS_TYPE_WIZARD, oPC)
			+ GetLevelByClass(CLASS_TYPE_SORCERER, oPC)
			+ GetLevelByClass(CLASS_TYPE_DRAGONFIRE_ADEPT, oPC)
			+ GetLevelByClass(CLASS_TYPE_DRAGON_SHAMAN, oPC)			
			+ GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oPC)
			+ GetLevelByClass(CLASS_TYPE_BEGUILER, oPC)
			+ GetLevelByClass(CLASS_TYPE_SHADOWCASTER, oPC)
			+ GetLevelByClass(CLASS_TYPE_WARMAGE, oPC)
			+ GetLevelByClass(CLASS_TYPE_BINDER, oPC)
			+ GetLevelByClass(CLASS_TYPE_TRUENAMER, oPC)			
			+ GetLevelByClass(CLASS_TYPE_WARLOCK, oPC);	

if (!GetObjectType(oPC) == OBJECT_TYPE_CREATURE)
    oPC = GetRandomPC();

if (!(GetObjectType(oPC) == OBJECT_TYPE_CREATURE))
    if (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE)
        oPC=oCreature;
    else
        oPC = GetRandomPC();

iRandom = Random(12)+1;

if (iType>0)
    iRandom=iType;

switch (iRandom)
    {
    case 1: case 2:
            if (iArcane > 0)
                {
                if (Random(4)==0)
                    {
                    iRandom2=Random(5)+1;
                    switch (iRandom2)
                        {
                        case 1: case 2: sTag = "en3_magestaff";
                                sTag = sTag + IntToString(Random(4)+1);
                                iPosition = -1;
                                break;
                        case 3: sTag = "en3_wand";
                                iPosition = -2;
                                break;
                        case 4:  sTag = "en3_rod";
                                iPosition = -2;
                                break;
                        case 5: sTag = "en3_misc";
                                sTag = sTag + IntToString(Random(6)+1);
                                iPosition = -3;
                                break;
                        }
                    } else {
                    GetWeaponType(oPC);
                    sTag = "en3_" + GetWeaponTag(oPC);
                    iPosition = INVENTORY_SLOT_RIGHTHAND;
                    }
                }
            else if (GetLevelByClass(CLASS_TYPE_BARD,oPC)>0)
                {
                if (Random(6)==0)
                    {
                    sTag = "en3_instrument";
                    sTag = sTag + IntToString(Random(3)+1);
                    iPosition = -4;
                    } else {
                    GetWeaponType(oPC);
                    sTag = "en3_" + GetWeaponTag(oPC);
                    iPosition = INVENTORY_SLOT_RIGHTHAND;
                    }
                }
            else
                {
                GetWeaponType(oPC);
                sTag = "en3_" + GetWeaponTag(oPC);
                iPosition = INVENTORY_SLOT_RIGHTHAND;
                }
            break;
    case 3: case 4: if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oPC) && Random(2) == 0)
                {
                iRandom2=Random(3)+1;
                switch(iRandom2)
                    {
                    case 1: sTag = "en3_sshield"; break;
                    case 2: sTag = "en3_lshield"; break;
                    case 3: sTag = "en3_tshield"; break;
                    }
                iPosition = INVENTORY_SLOT_LEFTHAND;
                } else {
                    iArmor = ENGetArmorType(oPC);
                    sTag = GetArmorTag(iArmor);
                    iPosition = INVENTORY_SLOT_CHEST;
                }
            break;
    case 5: sTag = SetTagName("en3_gloves"); iPosition = INVENTORY_SLOT_ARMS; break;
    case 6: sTag = SetTagName("en3_belt"); iPosition = INVENTORY_SLOT_BELT; break;
    case 7: sTag = SetTagName("en3_boots"); iPosition = INVENTORY_SLOT_BOOTS; break;
    case 8: sTag = SetTagName("en3_cloak"); iPosition = INVENTORY_SLOT_CLOAK; break;
    case 9: sTag = SetTagName("en3_amulet"); iPosition = INVENTORY_SLOT_NECK; break;
    case 10: sTag = SetTagName("en3_ring"); iPosition = INVENTORY_SLOT_LEFTRING; break;
    case 11: sTag = "en3_helm" + IntToString(Random(8)+1); iPosition = INVENTORY_SLOT_HEAD;break;
    case 12: iRandom2 = Random(5)+1;
            switch (iRandom2)
                {
                case 1: if (iArcane > 0)
                            {
                            sTag = "en3_magestaff";
                            sTag = sTag + IntToString(Random(4)+1);
                            iPosition = -1;
                            } else {
                            sTag = "en3_misc";
                            sTag = sTag + IntToString(Random(6)+1);
                            iPosition = -3;
                            }
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

iTwoHanded = GetTwoHanded(sTag);

if (iPosition == INVENTORY_SLOT_RIGHTHAND)
    sTag = sTag + "2";
if (iPosition == INVENTORY_SLOT_CHEST)
    sTag = sTag + IntToString(Random(3)+2);
if (iPosition == INVENTORY_SLOT_LEFTHAND)
    sTag = sTag + IntToString(Random(4)+2);

oItem = CreateItemOnObject(sTag,oCreature);
if (iTwoHanded==TRUE)
    SetLocalInt(oItem,"TwoHanded",1);

iEnchantments = 2;

sName=GetName(oItem);
sPlus="";

if (iPosition == INVENTORY_SLOT_RIGHTHAND)
    {
    if (IPGetIsRangedWeapon(oItem))
        {
        iProperty=ItemPropertyAttackBonus(iItemLevel);
        IPSafeAddItemProperty(oItem,iProperty);
        if (Random(4)==0)
            {
            iProperty=ItemPropertyMaxRangeStrengthMod(iItemLevel);
            IPSafeAddItemProperty(oItem,iProperty);
            iEnchantments++;
            }
        }
    else
        {
        if (sTag == "en3_monkgloves2")
            {
            iProperty=ItemPropertyAttackBonus(iItemLevel);
            IPSafeAddItemProperty(oItem,iProperty);
            iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,GetEnchantBonus(iItemLevel));
            IPSafeAddItemProperty(oItem,iProperty);
            iEnchantments++;
            } else {
            iProperty=ItemPropertyEnhancementBonus(iItemLevel);
            IPSafeAddItemProperty(oItem,iProperty);
            }
        }
    sPlus="+" + IntToString(iItemLevel);
    }
if (iPosition == INVENTORY_SLOT_LEFTHAND || iPosition == INVENTORY_SLOT_CHEST)
    {
    iProperty=ItemPropertyACBonus(iItemLevel);
    IPSafeAddItemProperty(oItem,iProperty);
    sPlus="+" + IntToString(iItemLevel);
    }


iProperties = 0;

if (iPosition < -1)
    {
    iProperty=GetCastSpell(iItemLevel);
    IPSafeAddItemProperty(oItem,iProperty);
    if (Random(2)==0)
        {
        iProperty=GetCastSpell(iItemLevel);
        IPSafeAddItemProperty(oItem,iProperty);
        }
    if (Random(3)==0)
        {
        iProperty=GetCastSpell(iItemLevel);
        IPSafeAddItemProperty(oItem,iProperty);
        }
    iProperties=99;
    iEnchantments=0;
    }

if (iPosition == -1)
    {
    iProperty=ItemPropertyEnhancementBonus(iItemLevel);
    IPSafeAddItemProperty(oItem,iProperty);
    iProperty=GetCastSpell(iItemLevel);
    IPSafeAddItemProperty(oItem,iProperty);
    if (Random(2)==0)
        {
        iProperty=GetCastSpell(iItemLevel);
        IPSafeAddItemProperty(oItem,iProperty);
        }
    if (Random(3)==0)
        {
        iProperty=GetCastSpell(iItemLevel);
        IPSafeAddItemProperty(oItem,iProperty);
        }
    if (Random(3)==0)
        {
        iEnchantments = IPGetNumberOfItemProperties(oItem)+1;
        } else {
        iProperties=99;
        iEnchantments=0;
        }
    }

iIndex=0;
while (iProperties < iEnchantments)
    {
    iIndex++;
    if (iPosition==INVENTORY_SLOT_RIGHTHAND && !IPGetIsRangedWeapon(oItem))
        iProperty=WeaponProperty(iItemLevel,oItem);
    else if (iPosition==INVENTORY_SLOT_LEFTHAND || iPosition==INVENTORY_SLOT_CHEST)
        iProperty=ArmorProperty(iItemLevel,oItem);
    else
        iProperty=MiscProperty(iItemLevel,oItem);

    IPSafeAddItemProperty(oItem,iProperty);

    iProperties = IPGetNumberOfItemProperties(oItem);
    if (iIndex > 50)
        iProperties=99;
    }

sName=GetName(oItem);
sName=Trim(sName);
iPreCount = GetLocalInt(oItem,"ItemPreNameCount");
iPostCount = GetLocalInt(oItem,"ItemPostNameCount");

if (iPreCount>0 || iPostCount>0 || sPlus !="")
    {
    if (GetStringLeft(sName,9) == "Enchanted")
        sName=GetStringRight(sName,GetStringLength(sName)-10);
    if (GetStringLeft(sName,7) == "Magical")
        sName=GetStringRight(sName,GetStringLength(sName)-8);
    }

if (iPreCount>0)
    sName = GetLocalString(oItem,"ItemPreName") + " " + sName;
if (iPostCount>0)
    sName = sName + GetLocalString(oItem,"ItemPostName");
if (sPlus != "")
    sName = sPlus + " " + sName;

iTest=0;

if (GetStringLeft(sName,10) == "en3_gloves" && Random(20)==0)
    iTest=1;
if (GetStringLeft(sName,8) == "en3_belt" && Random(20)==0)
    iTest=1;
if (GetStringLeft(sName,9) == "en3_boots" && Random(20)==0)
    iTest=1;
if (GetStringLeft(sName,9) == "en3_cloak" && Random(20)==0)
    iTest=1;
if (GetStringLeft(sName,10) == "en3_amulet" && Random(20)==0)
    iTest=1;
if (GetStringLeft(sName,8) == "en3_ring" && Random(20)==0)
    iTest=1;
if (GetStringLeft(sName,8) == "en3_helm" && Random(20)==0)
    iTest=1;

if (iTest==1)
    {
    iRandom=Random(6)+1;
    if (iRandom==1)
        sName="Talbert's " + sName;
    if (iRandom==2)
        sName="Elrondel's " + sName;
    if (iRandom==3)
        sName="Gargash's " + sName;
    if (iRandom==4)
        sName="Zod's " + sName;
    if (iRandom==5)
        sName="Taendel's " + sName;
    if (iRandom==6)
        sName="Phaelen's " + sName;
    }
SetName(oItem,sName);

}

string SetTagName(string sItemName)
{
if (Random(5)>0)
    sItemName = sItemName + ItS(Random(4)+1);

return sItemName;
}

string Trim(string sString)
{
int iFlag;

iFlag=TRUE;
while (iFlag)
    {
    if (GetStringLeft(sString,1) == " ")
        sString=GetStringRight(sString,GetStringLength(sString)-1);
    else
        iFlag=FALSE;
    }

iFlag=TRUE;
while (iFlag)
    {
    if (GetStringRight(sString,1) == " ")
        sString=GetStringLeft(sString,GetStringLength(sString)-1);
    else
        iFlag=FALSE;
    }
return sString;
}

void SetPostName(object oItem,string sName)
{
int iCount;

iCount = GetLocalInt(oItem,"ItemPostNameCount");
iCount++;
SetLocalInt(oItem,"ItemPostNameCount",iCount);

if (iCount == 1)
    SetLocalString(oItem,"ItemPostName"," of " + sName);
else if (iCount == 2)
    SetLocalString(oItem,"ItemPostName",GetLocalString(oItem,"ItemPostName") + " and " + sName);
else
    SetLocalString(oItem,"ItemPostName"," of Power");

}

void SetPreName(object oItem,string sName,string sAltName)
{
int iCount;

iCount = GetLocalInt(oItem,"ItemPreNameCount");
iCount++;
SetLocalInt(oItem,"ItemPreNameCount",iCount);

if (iCount == 1)
    SetLocalString(oItem,"ItemPreName",sName);
else
    SetPostName(oItem,sAltName);
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

int GetUnlimitedEnchantBonus(int iEnchant)
{
int iBonus;

iBonus = IP_CONST_UNLIMITEDAMMO_PLUS1;

if (iEnchant > 5)
    iBonus = IP_CONST_UNLIMITEDAMMO_PLUS5;

switch (iEnchant)
    {
    case 1: iBonus = IP_CONST_UNLIMITEDAMMO_PLUS1; break;
    case 2: iBonus = IP_CONST_UNLIMITEDAMMO_PLUS2; break;
    case 3: iBonus = IP_CONST_UNLIMITEDAMMO_PLUS3; break;
    case 4: iBonus = IP_CONST_UNLIMITEDAMMO_PLUS4; break;
    case 5: iBonus = IP_CONST_UNLIMITEDAMMO_PLUS5; break;
    }

return iBonus;
}

void SetABName(object oItem,int iX)
{
if (iX==IP_CONST_ABILITY_CHA)
    SetPostName(oItem,"Charisma");
if (iX==IP_CONST_ABILITY_CON)
    SetPostName(oItem,"Constitution");
if (iX==IP_CONST_ABILITY_DEX)
    SetPostName(oItem,"Dexterity");
if (iX==IP_CONST_ABILITY_INT)
    SetPostName(oItem,"Intelligence");
if (iX==IP_CONST_ABILITY_STR)
    SetPostName(oItem,"Strength");
if (iX==IP_CONST_ABILITY_WIS)
    SetPostName(oItem,"Wisdom");
}

itemproperty WeaponProperty(int iEnchant, object oItem)
{
int iX;
int iY;
int iZ;
int iRandom;
int iRandom2;
int iRandom3;
int iEnchant2;
itemproperty iProperty;
string sX;

iRandom=Random(100)+1;
if (iRandom<5)
    {
    if (GetTag(oItem) == "en3_monkgloves2")
        iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d4);
    else
        iProperty=ItemPropertyAttackBonus(iEnchant + Random(2)+1);
    SetPostName(oItem,"Accuracy");
    }
else if (iRandom<7)
    {
    iRandom2 = Random(5);
    iProperty=ItemPropertyAttackBonusVsAlign(iRandom2,iEnchant + Random(3)+2);
    SetPostName(oItem,"Vengence");
    }
else if (iRandom<9)
    {
    if (iEnchant>3 && !(GetTag(oItem) == "en3_monkgloves2"))
        iProperty=ItemPropertyHolyAvenger();
    else
        iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6);
    SetPreName(oItem,"Holy","Divine Might");
    }
else if (iRandom<12)
    {
    iX = Random(20);
    iProperty=ItemPropertyMassiveCritical(iX);
    SetPreName(oItem,"Punishing","Punishment");
    }
else if (iRandom<15)
    {
    //vamp 1
    iX = Random(iEnchant) + 1 + (iEnchant-1)/2;
    iProperty=ItemPropertyVampiricRegeneration(iX);
    SetPreName(oItem,"Vampiric","Life Stealing");
    }
else if (iRandom<18)
    {
    //keen
    iProperty=ItemPropertyKeen();
    SetPreName(oItem,"Sharp","Sharpness");
    }
else if (iRandom<20)
    {
    //enchant vs Align
    if (GetTag(oItem) == "en3_monkgloves2")
        iProperty=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d6);
    else
        {
        iEnchant2 = iEnchant+1+Random(3);
        iZ = Random(6);
        iProperty=ItemPropertyEnhancementBonusVsAlign(iZ,iEnchant2);
        }
    SetPostName(oItem,"Vengence");
    }
else if (iRandom<21)
    {
    iProperty=ItemPropertyHaste();
    if (Random(2)==0)
        SetPostName(oItem,"Speed");
    else
        SetPreName(oItem,"Quick","Quickness");
    }
else if (iRandom<23)
    {
    //dmg bonus (any)
    iX = DamageType();
    iY = DamageBonus();
    iProperty=ItemPropertyDamageBonus(iX,iY);
    SetDBName(oItem,iX);
    }
else if (iRandom<25)
    {
    //dmg bonus vs Align
    iX = DamageType();
    iY = DamageBonus();
    iZ = Random(6);
    iProperty=ItemPropertyDamageBonusVsAlign(iZ,iX,iY);
    SetPostName(oItem,"Vengence");
    }
else if (iRandom<26)
    {
    //dmg bonus vs Race
    iX = DamageType();
    iY = DamageBonus();
    iZ = Random(24);
    iProperty=ItemPropertyDamageBonusVsRace(iZ,iX,iY);
    SetPostName(oItem,"Vengence");
    }
else if (iRandom<50)
    {
    //dmg bonus based on iEnchant
    iX = DamageType();
    iRandom2 = Random(5)+ iEnchant;
    iY = IP_CONST_DAMAGEBONUS_1;
    switch (iRandom2)
        {
        case 1: iY=IP_CONST_DAMAGEBONUS_2; break;
        case 2: iY=IP_CONST_DAMAGEBONUS_1d4; break;
        case 3: iY=IP_CONST_DAMAGEBONUS_1d6; break;
        case 4: iY=IP_CONST_DAMAGEBONUS_1d8; break;
        case 5: iY=IP_CONST_DAMAGEBONUS_1d10; break;
        case 6: iY=IP_CONST_DAMAGEBONUS_1d12; break;
        }
    iProperty=ItemPropertyDamageBonus(iX,iY);
    SetDBName(oItem,iX);
    }
else if (iRandom<51)
    {
    iRandom2=Random(6);
    if (iRandom2==0) { iX=IP_CONST_ONHIT_BLINDNESS; }
    if (iRandom2==1) { iX=IP_CONST_ONHIT_CONFUSION; }
    if (iRandom2==2) { iX=IP_CONST_ONHIT_SLEEP; }
    if (iRandom2==3) { iX=IP_CONST_ONHIT_DAZE; }
    if (iRandom2==4) { iX=IP_CONST_ONHIT_DEAFNESS; }
    if (iRandom2==5) { iX=IP_CONST_ONHIT_FEAR; }
    iRandom2=Random(4);
    if (iRandom2<2) { iY=IP_CONST_ONHIT_SAVEDC_16; }
    if (iRandom2==2) { iY=IP_CONST_ONHIT_SAVEDC_18; }
    if (iRandom2==3) { iY=IP_CONST_ONHIT_SAVEDC_20; }
    iRandom2=Random(3);
    if (iRandom2==1) { iZ=IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS; }
    if (iRandom2==2) { iZ=IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS; }
    if (iRandom2==3) { iZ=IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS; }

    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    SetPostName(oItem,"Enchantment");
    }
else if (iRandom<52)
    {
    iRandom2=Random(3);
    if (iRandom2==0) { iX=IP_CONST_ONHIT_DISPELMAGIC; }
    if (iRandom2==1) { iX=IP_CONST_ONHIT_GREATERDISPEL; }
    if (iRandom2==2) { iX=IP_CONST_ONHIT_SILENCE; }
    iRandom2=Random(4);
    if (iRandom2<2) { iY=IP_CONST_ONHIT_SAVEDC_16; }
    if (iRandom2==2) { iY=IP_CONST_ONHIT_SAVEDC_18; }
    if (iRandom2==3) { iY=IP_CONST_ONHIT_SAVEDC_20; }
    iRandom2=Random(3);
    if (iRandom2==1) { iZ=IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS; }
    if (iRandom2==2) { iZ=IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS; }
    if (iRandom2==3) { iZ=IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS; }

    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    if (iX==IP_CONST_ONHIT_SILENCE)
        SetPostName(oItem,"Silencing");
    else
        SetPostName(oItem,"Dispelling");
    }
else if (iRandom<53)
    {
    iRandom2=Random(3);
    if (iRandom2<3) { iX=IP_CONST_ONHIT_SLOW; sX="Slowing"; }
    if (iRandom2<5) { iX=IP_CONST_ONHIT_HOLD; sX="Holding"; }
    if (iRandom2<7) { iX=IP_CONST_ONHIT_STUN; sX="Stunning"; }
    if (iRandom2<9) { iX=IP_CONST_ONHIT_WOUNDING; sX="Wounding"; }
    if (iRandom2==9) { iX=IP_CONST_ONHIT_VORPAL; sX="Death"; }
    if (iRandom2==10) { iX=IP_CONST_ONHIT_SLAYALIGNMENTGROUP; sX="Slaying"; }
    iRandom2=Random(4);
    if (iRandom2<2) { iY=IP_CONST_ONHIT_SAVEDC_16; }
    if (iRandom2==2) { iY=IP_CONST_ONHIT_SAVEDC_18; }
    if (iRandom2==3) { iY=IP_CONST_ONHIT_SAVEDC_20; }
    iRandom2=Random(3);
    if (iRandom2==1) { iZ=IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS; }
    if (iRandom2==2) { iZ=IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS; }
    if (iRandom2==3) { iZ=IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS; }

    if (iX==IP_CONST_ONHIT_SLAYALIGNMENTGROUP)
        {
        iRandom2=Random(5);
        if (iRandom2==1) { iZ=IP_CONST_ALIGNMENTGROUP_ALL; }
        if (iRandom2==2) { iZ=IP_CONST_ALIGNMENTGROUP_CHAOTIC; }
        if (iRandom2==3) { iZ=IP_CONST_ALIGNMENTGROUP_LAWFUL; }
        if (iRandom2==4) { iZ=IP_CONST_ALIGNMENTGROUP_EVIL; }
        if (iRandom2==5) { iZ=IP_CONST_ALIGNMENTGROUP_NEUTRAL; }
        }
    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    SetPostName(oItem,sX);
    }
else if (iRandom<54)
    {
    iRandom2=Random(2);
    if (iRandom2==0) { iX=IP_CONST_ONHIT_DISEASE; sX="Disease"; }
    if (iRandom2==1) { iX=IP_CONST_ONHIT_ITEMPOISON; sX="Poisoning"; }
    iRandom2=Random(4);
    if (iRandom2<2) { iY=IP_CONST_ONHIT_SAVEDC_16; }
    if (iRandom2==2) { iY=IP_CONST_ONHIT_SAVEDC_18; }
    if (iRandom2==3) { iY=IP_CONST_ONHIT_SAVEDC_20; }
    if (iX==IP_CONST_ONHIT_DISEASE)
        {
        iZ=Random(18);
        } else {
        iZ=Random(46);
        }
    iProperty=ItemPropertyOnHitProps(iX,iY,iZ);
    SetPostName(oItem,sX);
    }
else if (iRandom<55)
    {
    iRandom2=Random(17);
    if (iRandom2<2) { iX=IP_CONST_ONHIT_CASTSPELL_MAGIC_MISSILE; sX="Magic Missles"; }
    if (iRandom2<4) { iX=IP_CONST_ONHIT_CASTSPELL_FLARE; sX="the Flare"; }
    if (iRandom2<6) { iX=IP_CONST_ONHIT_CASTSPELL_ELECTRIC_JOLT; sX="Sparks"; }
    if (iRandom2<8) { iX=IP_CONST_ONHIT_CASTSPELL_ACID_SPLASH; sX="Acid"; }
    if (iRandom2<10) { iX=IP_CONST_ONHIT_CASTSPELL_CONTAGION; sX="Contagion"; }
    if (iRandom2<12) { iX=IP_CONST_ONHIT_CASTSPELL_DISMISSAL; sX="Dismissal"; }
    if (iRandom2<14) { iX=IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE; sX="Cursing"; }
    if (iRandom2<16) { iX=IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH; sX="Vampires"; }
    if (iRandom2==16) { iX=IP_CONST_ONHIT_CASTSPELL_LIGHTNING_BOLT; sX="Lightning Bolts"; }
    if (iRandom2==17) { iX=IP_CONST_ONHIT_CASTSPELL_FIREBALL; sX="Fireballs"; }
    iY=1;
    if (Random(6)==0)
        if (Random(10)==0)
            iY=3;
        else
            iY=2;
    iProperty=ItemPropertyOnHitCastSpell(iX,iY);
    SetPostName(oItem,sX);
    }
else if (iRandom<70)
    {
    iProperty=ItemPropertyACBonus(Random(iEnchant)+1);
    SetPostName(oItem,"Defending");
    }
else if (iRandom<75)
    {
    iProperty=ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,Random(iEnchant)+1);
    SetPostName(oItem,"Strength");
    }
else if (iRandom<76)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_1);
    SetDBName(oItem,iX);
    }
else if (iRandom<77)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_2);
    SetDBName(oItem,iX);
    }
else if (iRandom<78)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_3);
    SetDBName(oItem,iX);
    }
else if (iRandom<79)
    {
    iX = DamageType();
    if (Random(3)==0)
        iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_4);
    else
        iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_5);
    SetDBName(oItem,iX);
    }
else if (iRandom<80)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_1d4);
    SetDBName(oItem,iX);
    }
else if (iRandom<81)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_2d4);
    SetDBName(oItem,iX);
    }
else if (iRandom<82)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4);
    SetPostName(oItem,"the Heavens");
    }
else if (iRandom<83)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4);
    SetPostName(oItem,"Undead Smiting");
    }
else if (iRandom<84)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4);
    SetPostName(oItem,"Demonic Smiting");
    }
else if (iRandom<85)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d6);
    SetPreName(oItem,"Dragonbane","Dragonslaying");
    }
else if (iRandom<86)
    {
    if (Random(2)==0)
        {
        iProperty=ItemPropertyFreeAction();
        SetPostName(oItem,"Freedom");
        } else {
        iProperty=ItemPropertyImprovedEvasion();
        SetPostName(oItem,"Evasion");
        }
    }
else if (iRandom<87)
    {
    if (GetLocalInt(oItem,"TwoHanded") == 0)
        {
        iProperty=ItemPropertyBonusFeat(IP_CONST_FEAT_AMBIDEXTROUS);
        IPSafeAddItemProperty(oItem,iProperty);
        iProperty=ItemPropertyBonusFeat(IP_CONST_FEAT_TWO_WEAPON_FIGHTING);
        SetPreName(oItem,"Offhand","Dueling");
        } else {
        iX=IP_CONST_FEAT_CLEAVE;
        iProperty=ItemPropertyBonusFeat(iX);
        SetPostName(oItem,"Cleaving");
        }
    }
else if (iRandom<88)
    {
    iRandom2=Random(3);
    if (iRandom2==0) { iX=IP_CONST_FEAT_SNEAK_ATTACK_1D6; }
    if (iRandom2==1) { iX=IP_CONST_FEAT_SNEAK_ATTACK_2D6; }
    if (iRandom2==2) { iX=IP_CONST_FEAT_SNEAK_ATTACK_3D6; }
    iProperty=ItemPropertyBonusFeat(iX);
    if (Random(2)==0)
        SetPostName(oItem,"the Assassin");
    else
        SetPostName(oItem,"the Night");
    }
else if (iRandom<89)
    {
    iX=IP_CONST_FEAT_CLEAVE;
    iProperty=ItemPropertyBonusFeat(iX);
    SetPostName(oItem,"Cleaving");
    }
else if (iRandom<90)
    {
    iRandom=(6)+iEnchant;
    iX=IP_CONST_CASTSPELL_HEAL_11;
    if (iRandom==1) { iX=IP_CONST_CASTSPELL_BLESS_2; }
    if (iRandom==2) { iX=IP_CONST_CASTSPELL_LESSER_RESTORATION_3; }
    if (iRandom==3) { iX=IP_CONST_CASTSPELL_MAGIC_MISSILE_5; }
    if (iRandom==4) { iX=IP_CONST_CASTSPELL_BARKSKIN_3; }
    if (iRandom==5) { iX=IP_CONST_CASTSPELL_BULLS_STRENGTH_3; }
    if (iRandom==6) { iX=IP_CONST_CASTSPELL_DIVINE_MIGHT_5; }
    if (iRandom==7) { iX=IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_10; }
    if (iRandom==8) { iX=IP_CONST_CASTSPELL_FIREBALL_10; }
    if (iRandom==9) { iX=IP_CONST_CASTSPELL_STONESKIN_7; }
    if (iRandom==10) { iX=IP_CONST_CASTSPELL_HEAL_11; }
    if (iRandom==11) { iX=IP_CONST_CASTSPELL_METEOR_SWARM_17; }

    iProperty=ItemPropertyCastSpell(iX,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
    SetPostName(oItem,"Magic");
    }
else if (iRandom<99)
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_1d6);
    SetDBName(oItem,iX);
    }
else if (iRandom<100)
    {
    iRandom2=Random(50);
    if (iRandom2>0)
        {
        iX = DamageType();
        iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_2d6);
        SetDBName(oItem,iX);
        } else {
        //on hit cast spell
        iX = Random(130);
        iY = Random(26)+5;
        if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
            iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
        iProperty=ItemPropertyOnHitCastSpell(iX,iY);
        SetPreName(oItem,"Legendary","Legends");
        }
    }
else
    {
    iX = DamageType();
    iProperty=ItemPropertyDamageBonus(iX,IP_CONST_DAMAGEBONUS_1d6);
    SetDBName(oItem,iX);
    }

return iProperty;
}

itemproperty ArmorProperty(int iEnchant, object oItem)
{
int iRandom;
int iRandom2;
int iX;
int iY;
itemproperty iProperty;

iRandom=Random(100)+1;

if (iRandom<10)
    {
    iRandom2 = Random(5);
    iProperty=ItemPropertyACBonusVsAlign(iRandom2,iEnchant + Random(3)+2);
    SetPostName(oItem,"Protection");
    }
if (iRandom<15)
    {
    //AbilityBonus
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+1;
    iProperty = ItemPropertyAbilityBonus(iX,Random(iEnchant)+1);
    SetABName(oItem,iX);
    }
else if (iRandom<17)
    {
    iRandom2=Random(28);
    iProperty=ItemPropertySkillBonus(iRandom2,iEnchant * 3);
    SetPostName(oItem,"Skill");
    }
else if (iRandom<22)
    {
    //SavingthrowBonus
    iRandom2 = Random(3);
    iProperty=ItemPropertyBonusSavingThrow(iRandom2,iEnchant);
    SetPostName(oItem,"Protection");
    }
else if (iRandom<27)
    {
    //SavingthrowBonus vs X
    iRandom2 = Random(14);
    iProperty=ItemPropertyBonusSavingThrowVsX(iRandom2,iEnchant);
    SetPostName(oItem,"Protection");
    }
else if (iRandom<32)
    {
    iProperty=ItemPropertyBonusSpellResistance(iEnchant-1);
    SetPostName(oItem,"Resistance");
    }
else if (iRandom<35)
    {
    //Bonus Feat
    iRandom2 = Random(27);
    iProperty=ItemPropertyBonusFeat(iRandom2);
    SetPostName(oItem,"Ability");
    }
else if (iRandom<40)
    {
    //Cast Spell
    iProperty=GetCastSpell(iEnchant);
    SetPostName(oItem,"Magic");
    }
else if (iRandom<50)
    {
    //Damage Resistance
    iX=Random(13);
    if (iX == 3)
        iX = 1;
    iY=Random(10);
    iProperty=ItemPropertyDamageResistance(iX,iEnchant);
    SetPostName(oItem,"Resistance");
    }
else if (iRandom<53)
    {
    //Damage Reduction
    iX=Random(2);
    iY=Random((iEnchant+1)/2);
    if (Random(10)==0)
        iY++;
    if (iEnchant>4 && iY ==0)
        iY=1;
    iProperty=ItemPropertyDamageReduction(Random(iEnchant),iY);
    SetPostName(oItem,"Shielding");
    }
else if (iRandom<57)
    {
    //FreedomOfMovement
    iProperty=ItemPropertyFreeAction();
    SetPostName(oItem,"Freedom");
    }
else if (iRandom<58)
    {
    //Haste
    iProperty=ItemPropertyHaste();
    SetPostName(oItem,"Speed");
    }
else if (iRandom<60)
    {
    //TrueSeeing
    iProperty=ItemPropertyTrueSeeing();
    SetPostName(oItem,"True Seeing");
    }
else if (iRandom<66)
    {
    //Regeneration
    iProperty=ItemPropertyRegeneration(Random(iEnchant)+1);
    SetPostName(oItem,"Regeneration");
    }
else if (iRandom<68)
    {
    //immune Misc
    iRandom2=Random(10);
    iProperty=ItemPropertyImmunityMisc(iRandom2);
    SetPostName(oItem,"Immunity");
    }
else if (iRandom<70)
    {
    //immune Damage
    iX=Random(13);
    if (iX == 3)
        iX = 1;
    iY=Random(7);
    iProperty=ItemPropertyDamageImmunity(iX,iY);
    SetPostName(oItem,"Immunity");
    }
else if (iRandom<72)
    {
    iProperty=ItemPropertyImprovedEvasion();
    SetPostName(oItem,"Evasion");
    }
else if (iRandom<73)
    {
    iProperty=ItemPropertyDarkvision();
    SetPostName(oItem,"Vision");
    }
else if (iRandom<74)
    {
    iProperty=ItemPropertyLight(Random(4),Random(7));
    SetPostName(oItem,"Light");
    }
else if (iRandom<80)
    {
    iProperty=ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,iEnchant);
    SetPostName(oItem,"Universal Protection");
    }

else if (iRandom<85)
    {
    //Damage Reduction
    iX=Random(2);
    iY=Random((iEnchant+1)/2);
    iProperty=ItemPropertyDamageReduction(0,0);
    SetPostName(oItem,"Minor Physical Shielding");
    }
else if (iRandom<87)
    {
    //Damage Reduction
    iX=Random(2);
    iY=Random((iEnchant+1)/2);
    iProperty=ItemPropertyDamageReduction(0,1);
    SetPostName(oItem,"Physical Shielding");
    }
else if (iRandom<88)
    {
    //Damage Reduction
    iX=0;
    if (Random(10)==0)
        iX=1;
    iProperty=ItemPropertyDamageReduction(Random(5),iX);
    SetPostName(oItem,"Physical Shielding");
    }
else if (iRandom<92)
    {
    //Damage Reduction
    iRandom2=Random(3);
    if (iRandom2==0)
        iX = IP_CONST_DAMAGETYPE_BLUDGEONING;
    else if (iRandom2==1)
        iX = IP_CONST_DAMAGETYPE_SLASHING;
    else
        iX = IP_CONST_DAMAGETYPE_PIERCING;

    if (iEnchant<5)
        iY=Random(iEnchant);
    else
        iY=Random(3)+3;

    iProperty=ItemPropertyDamageResistance(iX,iY);
    SetPostName(oItem,"Shielding");
    }
else if (iRandom<99)
    {
    //AbilityBonus
    iRandom2=Random(4);
    if (iRandom2==0)
        iX = IP_CONST_ABILITY_DEX;
    else if (iRandom2==1)
        iX = IP_CONST_ABILITY_CON;
    else
        iX = IP_CONST_ABILITY_STR;
    iProperty = ItemPropertyAbilityBonus(iX,Random(iEnchant-1)+2);
    SetABName(oItem,iX);
    }
else if (iRandom<100)
    {
    iRandom2 = Random(50)+1;
    if (iRandom2<11)
        {
        iX = Random(6);
        iY = Random(4)+5;
        iProperty = ItemPropertyAbilityBonus(iX,iY);
        SetABName(oItem,iX);
        }
    else if (iRandom2<21)
        {
        iRandom2 = Random(6)+6;
        iProperty=ItemPropertyBonusSpellResistance(iRandom2);
        SetPostName(oItem,"Exceptional Resistance");
        }
    else if (iRandom2<31)
        {
        //Damage Reduction
        iX=Random(3)+2;
        iY=Random(2)+2;
        iProperty=ItemPropertyDamageReduction(iX,iY);
        SetPostName(oItem,"Exceptional Shielding");
        }
    else if (iRandom2<40)
        {
        //Regeneration
        iX=Random(5)+6;
        iProperty=ItemPropertyRegeneration(iX);
        SetPostName(oItem,"the Troll");
        }
    else if (iRandom2<50)
        {
        //immune spell by level
        iRandom2 = Random(9)+1;
        iProperty=ItemPropertyImmunityToSpellLevel(iRandom2);
        SetPostName(oItem,"Magical Defense");
        }
    else if (iRandom<51)
        {
        //immune spell school
        iRandom2=Random(8);
        iProperty=ItemPropertySpellImmunitySchool(iRandom2);
        SetPostName(oItem,"Legendary Immunity");
        }
    }
else
    {
    iRandom2=Random(50);
    if (iRandom2>0)
        {
        iProperty=ItemPropertyHaste();
        } else {
        //on hit cast spell
        iX = Random(130);
        iY = Random(26)+5;
        if (iX == IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
            iX = IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH;
        iProperty=ItemPropertyOnHitCastSpell(iX,iY);
        }
    }
return iProperty;
}

itemproperty MiscProperty(int iEnchant, object oItem)
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

if (iRandom<15)
    {
    //AbilityBonus
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+1;
    iProperty = ItemPropertyAbilityBonus(iX,Random(iEnchant)+1);
    SetABName(oItem,iX);
    }
else if (iRandom<30)
    {
    iProperty=ItemPropertyACBonus(iEnchant);
    SetPostName(oItem,"+" + IntToString(iEnchant) + " Defense");
    }
else if (iRandom<32)
    {
    iRandom2=Random(28);
    iProperty=ItemPropertySkillBonus(iRandom2,iEnchant * 3);
    SetPostName(oItem,"Skill");
    }
else if (iRandom<35)
    {
    iRandom2 = Random(5);
    iProperty=ItemPropertyACBonusVsAlign(iRandom2,iEnchant + Random(3)+2);
    SetPostName(oItem,"Protection");
    }
else if (iRandom<40)
    {
    //SavingthrowBonus
    iRandom3 = Random(3);
    iProperty=ItemPropertyBonusSavingThrow(iRandom3,iEnchant);
    SetPostName(oItem,"Protection");
    }
else if (iRandom<45)
    {
    //SavingthrowBonus vs X
    iRandom3 = Random(14);
    iProperty=ItemPropertyBonusSavingThrowVsX(iRandom3,iEnchant);
    SetPostName(oItem,"Protection");
    }
else if (iRandom<50)
    {
    iProperty=ItemPropertyBonusSpellResistance(iEnchant-1);
    SetPostName(oItem,"Spell Resistance");
    }
else if (iRandom<52)
    {
    //Bonus Feat
    iRandom3 = Random(27);
    iProperty=ItemPropertyBonusFeat(iRandom3);
    SetPostName(oItem,"Ability");
    }
else if (iRandom<55)
    {
    //Cast Spell
    iProperty=GetCastSpell(iEnchant);
    SetPostName(oItem,"Magic");
    }
else if (iRandom<60)
    {
    iX = IP_CONST_DAMAGETYPE_MAGICAL;
    iY=Random(8);
    if (iY==0) { iX=IP_CONST_DAMAGETYPE_ACID; }
    if (iY==1) { iX=IP_CONST_DAMAGETYPE_COLD; }
    if (iY==2) { iX=IP_CONST_DAMAGETYPE_DIVINE; }
    if (iY==3) { iX=IP_CONST_DAMAGETYPE_ELECTRICAL; }
    if (iY==4) { iX=IP_CONST_DAMAGETYPE_FIRE; }
    if (iY==5) { iX=IP_CONST_DAMAGETYPE_MAGICAL; }
    if (iY==6) { iX=IP_CONST_DAMAGETYPE_SONIC; }
    if (iY==7) { iX=IP_CONST_DAMAGETYPE_NEGATIVE; }
    iProperty=ItemPropertyDamageResistance(iX,iEnchant);

    SetPostName(oItem,"Magical Shielding");
    }
else if (iRandom<62)
    {
    //Damage Reduction
    iX=Random(2);
    iY=Random((iEnchant+1)/2);
    if (Random(10)==0)
        iY++;
    if (iEnchant>4 && iY ==0)
        iY=1;
    iProperty=ItemPropertyDamageReduction(Random(iEnchant),iY);
    SetPostName(oItem,"Shielding");
    }
else if (iRandom<65)
    {
    //FreedomOfMovement
    iProperty=ItemPropertyFreeAction();
    SetPostName(oItem,"Freedom");
    }
else if (iRandom<66)
    {
    //Haste
    iProperty=ItemPropertyHaste();
    SetPostName(oItem,"Speed");
    }
else if (iRandom<68)
    {
    //TrueSeeing
    iProperty=ItemPropertyTrueSeeing();
    SetPostName(oItem,"True Seeing");
    }
else if (iRandom<72)
    {
    //Regeneration
    iProperty=ItemPropertyRegeneration(Random(iEnchant)+1);
    SetPostName(oItem,"Regeneration");
    }
else if (iRandom<74)
    {
    iRandom3=Random(10);
    iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
    SetPostName(oItem,"Courage");
    }
else if (iRandom<75)
    {
    iRandom3=Random(10);
    iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    SetPostName(oItem,"Life");
    }
else if (iRandom<76)
    {
    //immune Damage
    iX=Random(13);
    if (iX == 3)
        iX = 1;
    iY=Random(7);
    iProperty=ItemPropertyDamageImmunity(iX,iY);
    SetPostName(oItem,"Immunity");
    }
else if (iRandom<77)
    {
    iProperty=ItemPropertyImprovedEvasion();
    SetPostName(oItem,"Evasion");
    }
else if (iRandom<79)
    {
    iProperty=ItemPropertyDarkvision();
    SetPostName(oItem,"Vision");
    }
else if (iRandom<80)
    {
    iProperty=ItemPropertyLight(Random(4),Random(7));
    SetPostName(oItem,"Light");
    }
else if (iRandom<82)
    {
    iProperty=ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,iEnchant);
    SetPostName(oItem,"Universal Protection");
    }
else if (iRandom<83)
    {
    //AbilityBonus
    iX = Random(6);
    iRandom2 = Random(6) + 1;
    iY = Random(3)+1;
    iProperty = ItemPropertyAbilityBonus(iX,Random(iEnchant)+1);
    SetABName(oItem,iX);
    }
else if (iRandom<84)
    {
    if (Random(10)>0)
        iProperty=ItemPropertyImmunityToSpellLevel(1);
    else
        if (Random(10)>0)
            iProperty=ItemPropertyImmunityToSpellLevel(2);
        else
            iProperty=ItemPropertyImmunityToSpellLevel(3);

    SetPostName(oItem,"Spell Immunity");
    }
else if (iRandom<85)
    {
    if (Random(50)>0)
        {
        iProperty=ItemPropertySpellImmunitySpecific(Random(364));
        SetPostName(oItem,"Spell Protection");
        }
    else
        {
        iProperty=ItemPropertySpellImmunitySchool(Random(8));
        SetPostName(oItem,"Magic Protection");
        }
    }
else if (iRandom<86)
    {
    if (Random(3)==0)
        {
        iProperty=ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_BLUDGEONING,Random(4));
        SetPostName(oItem,"Physical Shielding");
        }
    else if (Random(2)==0)
        {
        iProperty=ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_SLASHING,Random(4));
        SetPostName(oItem,"Physical Shielding");
        }
    else
        {
        iProperty=ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_PIERCING,Random(4));
        SetPostName(oItem,"Physical Shielding");
        }
    }
else if (iRandom<91)
    {
    iProperty=ItemPropertyACBonus(iEnchant);
    SetPostName(oItem,"+" + IntToString(iEnchant) + " Defense");
    }
else if (iRandom<92)
    {
    //immune Misc
    iRandom3=Random(10);
    iProperty=ItemPropertyImmunityMisc(iRandom3);
    SetPostName(oItem,"Immunity");
    }
else if (iRandom<93)
    {
    if (Random(2)==0)
        {
        iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
        SetPostName(oItem,"the Mind's Guard");
        } else {
        iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
        SetPostName(oItem,"the Guardian Angel");
        }
    }
else if (iRandom<94)
    {
    iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_PARALYSIS);
    SetPostName(oItem,"Movement");
    }
else if (iRandom<95)
    {
    iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
    SetPostName(oItem,"Health");
    }
else if (iRandom<96)
    {
    iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
    SetPostName(oItem,"Health");
    }
else if (iRandom<97)
    {
    iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
    SetPostName(oItem,"Life");
    }
else if (iRandom<98)
    {
    if (Random(2)==0)
        {
        iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN);
        SetPostName(oItem,"the Oak");
        } else {
        iProperty=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB);
        SetPostName(oItem,"the Assassin's guard");
        }
    }
else if (iRandom<100)
    {
    iProperty=ItemPropertyACBonus(iEnchant);
    SetPostName(oItem,"+" + IntToString(iEnchant) + " Defense");
    }
else if (iRandom<101)
    {
    iRandom2 = Random(50)+1;
    if (iRandom2<11)
        {
        iX = Random(6);
        iY = Random(4)+5;
        iProperty = ItemPropertyAbilityBonus(iX,iY);
        SetABName(oItem,iX);
        }
    else if (iRandom2<21)
        {
        iRandom3 = Random(6)+6;
        iProperty=ItemPropertyBonusSpellResistance(iRandom3);
        SetPostName(oItem,"Exceptional Resistance");
        }
    else if (iRandom2<31)
        {
        //Damage Reduction
        iX=Random(3)+2;
        iY=Random(2)+2;
        iProperty=ItemPropertyDamageReduction(iX,iY);
        SetPostName(oItem,"Exceptional Shielding");
        }
    else if (iRandom2<40)
        {
        //Regeneration
        iX=Random(5)+6;
        iProperty=ItemPropertyRegeneration(iX);
        SetPostName(oItem,"the Troll");
        }
    else if (iRandom2<50)
        {
        //immune spell by level
        iRandom3 = Random(9)+1;
        iProperty=ItemPropertyImmunityToSpellLevel(iRandom3);
        SetPostName(oItem,"Magical Defense");
        }
    else if (iRandom<51)
        {
        //immune spell school
        iRandom3=Random(8);
        iProperty=ItemPropertySpellImmunitySchool(iRandom3);
        SetPostName(oItem,"Legendary Immunity");
        }
    }
else
    {
    iProperty=ItemPropertyACBonus(iEnchant);
    SetPostName(oItem,"+" + IntToString(iEnchant) + " Defense");
    }

return iProperty;
}

void SetDBName(object oItem,int iX)
{
switch (iX)
    {
    case IP_CONST_DAMAGETYPE_ACID: SetPreName(oItem,"Acidic","Acid"); break;
    case IP_CONST_DAMAGETYPE_BLUDGEONING: SetPreName(oItem,"Bludgeoning","Bludgeoning"); break;
    case IP_CONST_DAMAGETYPE_COLD: SetPreName(oItem,"Freezing","Winter"); break;
    case IP_CONST_DAMAGETYPE_ELECTRICAL: SetPreName(oItem,"Lightning","Storms"); break;
    case IP_CONST_DAMAGETYPE_FIRE: SetPreName(oItem,"Flaming","Flames"); break;
    case IP_CONST_DAMAGETYPE_PIERCING: SetPreName(oItem,"Piercing","Wounds"); break;
    case IP_CONST_DAMAGETYPE_SLASHING: SetPreName(oItem,"Wounding","Wounds"); break;
    case IP_CONST_DAMAGETYPE_SONIC: SetPreName(oItem,"Thunderous","Thunder"); break;
    case IP_CONST_DAMAGETYPE_DIVINE: SetPreName(oItem,"Divine","Holy Might"); break;
    case IP_CONST_DAMAGETYPE_MAGICAL: SetPreName(oItem,"Magical","Magic"); break;
    case IP_CONST_DAMAGETYPE_NEGATIVE: SetPreName(oItem,"Demonic","Death"); break;
    case IP_CONST_DAMAGETYPE_POSITIVE: SetPreName(oItem,"Righteous","Righteous Might"); break;
    }
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

int CastSpellUses()
{
int iRandom;
int iSpellUse;

iRandom = Random(14)+1;
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
    }

return iSpellUse;
}

itemproperty GetCastSpell(int iItemLevel)
{
int iX;
int iY;
int iSpell;
int iRandom;
itemproperty iProperty;

if (iItemLevel == 1)
    iRandom=Random(18)+1;
if (iItemLevel == 2)
    iRandom=Random(48)+1;
if (iItemLevel == 3)
    iRandom=Random(64)+19;   //82
if (iItemLevel == 4)
    iRandom=Random(48)+49;    //96
if (iItemLevel >4)
    iRandom=Random(50)+49;    //99

iSpell = IP_CONST_CASTSPELL_BARKSKIN_6;
switch (iRandom)
    {
    //ItemLevel 1
    case 1: iSpell =IP_CONST_CASTSPELL_BARKSKIN_6; break;
    case 2: iSpell =IP_CONST_CASTSPELL_BLESS_2; break;
    case 3: iSpell =IP_CONST_CASTSPELL_BULLS_STRENGTH_3; break;
    case 4: iSpell =IP_CONST_CASTSPELL_BURNING_HANDS_5; break;
    case 5: iSpell =IP_CONST_CASTSPELL_COLOR_SPRAY_2; break;
    case 6: iSpell =IP_CONST_CASTSPELL_GHOSTLY_VISAGE_3; break;
    case 7: iSpell =IP_CONST_CASTSPELL_FLAME_LASH_3; break;
    case 8: iSpell =IP_CONST_CASTSPELL_INVISIBILITY_3; break;
    case 9: iSpell =IP_CONST_CASTSPELL_INVISIBILITY_PURGE_5; break;
    case 10: iSpell =IP_CONST_CASTSPELL_MAGIC_MISSILE_5; break;
    case 11: iSpell =IP_CONST_CASTSPELL_SEE_INVISIBILITY_3; break;
    case 12: iSpell =IP_CONST_CASTSPELL_SEARING_LIGHT_5; break;
    case 13: iSpell = IP_CONST_CASTSPELL_SLEEP_5; break;
    case 14: iSpell = IP_CONST_CASTSPELL_SOUND_BURST_3; break;
    case 15: iSpell = IP_CONST_CASTSPELL_STINKING_CLOUD_5; break;
    case 16: iSpell = IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_5; break;
    case 17: iSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_5; break;
    case 18: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3; break;

    //ItemLevel 2
    case 19: iSpell = IP_CONST_CASTSPELL_CALL_LIGHTNING_5; break;
    case 20: iSpell = IP_CONST_CASTSPELL_ANIMATE_DEAD_5; break;
    case 21: iSpell = IP_CONST_CASTSPELL_AURAOFGLORY_7; break;
    case 22: iSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_9; break;
    case 23: iSpell = IP_CONST_CASTSPELL_CONTINUAL_FLAME_7; break;
    case 24: iSpell = IP_CONST_CASTSPELL_CONFUSION_10; break;
    case 25: iSpell = IP_CONST_CASTSPELL_CONE_OF_COLD_9; break;
    case 26: iSpell = IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_5; break;
    case 27: iSpell = IP_CONST_CASTSPELL_DISPEL_MAGIC_10; break;
    case 28: iSpell = IP_CONST_CASTSPELL_DISPLACEMENT_9; break;
    case 29: iSpell = IP_CONST_CASTSPELL_DOMINATE_PERSON_7; break;
    case 30: iSpell = IP_CONST_CASTSPELL_ETHEREAL_VISAGE_9; break;
    case 31: iSpell = IP_CONST_CASTSPELL_EVARDS_BLACK_TENTACLES_7; break;
    case 32: iSpell = IP_CONST_CASTSPELL_FIREBALL_5; break;
    case 33: iSpell = IP_CONST_CASTSPELL_FLAME_STRIKE_7; break;
    case 34: iSpell = IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_7; break;
    case 35: iSpell = IP_CONST_CASTSPELL_HASTE_10; break;
    case 36: iSpell = IP_CONST_CASTSPELL_HOLD_MONSTER_7; break;
    case 37: iSpell = IP_CONST_CASTSPELL_ICE_STORM_9; break;
    case 38: iSpell = IP_CONST_CASTSPELL_IMPROVED_INVISIBILITY_7; break;
    case 39: iSpell = IP_CONST_CASTSPELL_LESSER_PLANAR_BINDING_9; break;
    case 40: iSpell = IP_CONST_CASTSPELL_MELFS_ACID_ARROW_9; break;
    case 41: iSpell = IP_CONST_CASTSPELL_MINOR_GLOBE_OF_INVULNERABILITY_7; break;
    case 42: iSpell = IP_CONST_CASTSPELL_POLYMORPH_SELF_7; break;
    case 43: iSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10; break;
    case 44: iSpell = IP_CONST_CASTSPELL_RESTORATION_7; break;
    case 45: iSpell = IP_CONST_CASTSPELL_STONESKIN_7; break;
    case 46: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_V_9; break;
    case 47: iSpell = IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5; break;
    case 48: iSpell = IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9; break;

    //ItemLevel 3
    case 49: iSpell = IP_CONST_CASTSPELL_ACID_FOG_11; break;
    case 50: iSpell = IP_CONST_CASTSPELL_ANIMATE_DEAD_10; break;
    case 51: iSpell = IP_CONST_CASTSPELL_BIGBYS_FORCEFUL_HAND_15; break;
    case 52: iSpell = IP_CONST_CASTSPELL_BLADE_BARRIER_11; break;
    case 53: iSpell = IP_CONST_CASTSPELL_CALL_LIGHTNING_10; break;
    case 54: iSpell = IP_CONST_CASTSPELL_CATS_GRACE_10; break;
    case 55: iSpell = IP_CONST_CASTSPELL_CHAIN_LIGHTNING_11; break;
    case 56: iSpell = IP_CONST_CASTSPELL_CLOUDKILL_9; break;
    case 57: iSpell = IP_CONST_CASTSPELL_CREATE_UNDEAD_11; break;
    case 58: iSpell = IP_CONST_CASTSPELL_CREEPING_DOOM_13; break;
    case 59: iSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15; break;
    case 60: iSpell = IP_CONST_CASTSPELL_ELEMENTAL_SHIELD_12; break;
    case 61: iSpell = IP_CONST_CASTSPELL_ENERGY_BUFFER_11; break;
    case 62: iSpell = IP_CONST_CASTSPELL_FINGER_OF_DEATH_13; break;
    case 63: iSpell = IP_CONST_CASTSPELL_FIRE_STORM_13; break;
    case 64: iSpell = IP_CONST_CASTSPELL_FLAME_ARROW_12; break;
    case 65: iSpell = IP_CONST_CASTSPELL_GLOBE_OF_INVULNERABILITY_11; break;
    case 66: iSpell = IP_CONST_CASTSPELL_GREATER_BULLS_STRENGTH_11; break;
    case 67: iSpell = IP_CONST_CASTSPELL_GREATER_PLANAR_BINDING_15; break;
    case 68: iSpell = IP_CONST_CASTSPELL_GREATER_SHADOW_CONJURATION_9; break;
    case 69: iSpell = IP_CONST_CASTSPELL_GREATER_STONESKIN_11; break;
    case 70: iSpell = IP_CONST_CASTSPELL_HEAL_11; break;
    case 71: iSpell = IP_CONST_CASTSPELL_HORRID_WILTING_15; break;
    case 72: iSpell = IP_CONST_CASTSPELL_INCENDIARY_CLOUD_15; break;
    case 73: iSpell = IP_CONST_CASTSPELL_INFERNO_15; break;
    case 74: iSpell = IP_CONST_CASTSPELL_INFLICT_CRITICAL_WOUNDS_12; break;
    case 75: iSpell = IP_CONST_CASTSPELL_ISAACS_LESSER_MISSILE_STORM_13; break;
    case 76: iSpell = IP_CONST_CASTSPELL_MASS_CHARM_15; break;
    case 77: iSpell = IP_CONST_CASTSPELL_PLANAR_ALLY_15; break;
    case 78: iSpell = IP_CONST_CASTSPELL_POWER_WORD_STUN_13; break;
    case 79: iSpell = IP_CONST_CASTSPELL_RAISE_DEAD_9; break;
    case 80: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13; break;
    case 81: iSpell = IP_CONST_CASTSPELL_SUNBEAM_13; break;
    case 82: iSpell = Random(365); break;
    //ItemLevel 4
    case 83: iSpell = IP_CONST_CASTSPELL_CONTROL_UNDEAD_20; break;
    case 84: iSpell = IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_18; break;
    case 85: iSpell = IP_CONST_CASTSPELL_DISMISSAL_18; break;
    case 86: iSpell = IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_15; break;
    case 87: iSpell = IP_CONST_CASTSPELL_DOMINATE_MONSTER_17; break;
    case 88: iSpell = IP_CONST_CASTSPELL_FLAME_STRIKE_18; break;
    case 89: iSpell = IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15; break;
    case 90: iSpell = IP_CONST_CASTSPELL_PREMONITION_15; break;
    case 91: iSpell = IP_CONST_CASTSPELL_PRISMATIC_SPRAY_13; break;
    case 92: iSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20; break;
    case 93: iSpell = IP_CONST_CASTSPELL_RESURRECTION_13; break;
    case 94: iSpell = IP_CONST_CASTSPELL_SHAPECHANGE_17; break;
    case 95: iSpell = IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17; break;
    case 96: iSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17; break;

    //ItemLevel 5
    case 97: iSpell = IP_CONST_CASTSPELL_BIGBYS_CRUSHING_HAND_20; break;
    case 98: iSpell = IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20; break;
    case 99: iSpell = IP_CONST_CASTSPELL_SUNBURST_20; break;
    }

iY=CastSpellUses();
iProperty=ItemPropertyCastSpell(iSpell,iY);

return iProperty;
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

iProperty = MiscProperty(6,oItem);
IPSafeAddItemProperty(oItem,iProperty);

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

//:: void main (){}
