#include "prc_x2_itemprop"

void GetPowers(object oPC);
void SetPower(object oPC,int iPower);

void main()
{
object oPC;
object oMob;
object oItem;
itemproperty ip;
effect eVis;
effect eDam;
int iRandom;
int iRandom2;
int iPlus;
string sTag;
string sString;
oPC=GetPlaceableLastClickedBy();

if (GetDistanceBetween(oPC,OBJECT_SELF) > 5.0)
    {
    SendMessageToPC(oPC,"You are too far away to drink from the fountain.");
    AssignCommand(oPC,ClearAllActions());
    }
else
    {
    if (GetLocalInt(oPC,"MagicPool") == 0)
        {
        SetLocalInt(oPC,"MagicPool",1);

        sString="You drink from the fountain.";
        AssignCommand(oPC,ClearAllActions());

        if (GetLocalInt(oPC,"PCRacePower") > 0)
            iRandom=iRandom-3;

        iRandom=GetLocalInt(oPC,"TM1_FOUNTAIN");
        if (iRandom==0)
            iRandom=Random(50);

        if (iRandom<5)
            {
            ActionCastSpellAtObject(SPELL_BESTOW_CURSE,oPC,METAMAGIC_ANY,TRUE);
            }
        else if (iRandom<10)
            {
            ActionCastSpellAtObject(SPELL_SLOW,oPC,METAMAGIC_ANY,TRUE);
            CreateObject(OBJECT_TYPE_CREATURE,"EN5_WILLOWISP",GetLocation(oPC));
            }
        else if (iRandom<15)
            {
            if (Random(2)==0)
                ActionCastSpellAtObject(SPELL_INFESTATION_OF_MAGGOTS,oPC,METAMAGIC_ANY,TRUE);
            else
                AssignCommand(oPC,ActionCastSpellAtObject(SPELL_WAR_CRY,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<20)
            {
            CreateObject(OBJECT_TYPE_CREATURE,"EN5_INVSTALK",GetLocation(oPC));
            }
        else if (iRandom<25)
            {
            ActionCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS,oPC,METAMAGIC_ANY,TRUE);
            if (Random(2)==0)
                {
                iRandom2=Random(5)+1;
                if (iRandom2==1)
                    sTag="EN5_AIR";
                else if (iRandom2==2)
                    sTag="EN5_FIRE";
                else if (iRandom2==3)
                    sTag="en5_dust_ele";
                else
                    sTag="en5_ice_ele";
                CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(oPC));
                }
            }
        else if (iRandom<30)
            {
            if (Random(10)==0)
                {
                sString="You drink from the fountain and feel the power of magic wash over you.";
                SetPower(oPC,11);
                }
            else
                AssignCommand(oPC,ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<35)
            {
            if (Random(5)==0)
                {
                oItem=GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
                if (!GetIsObjectValid(oItem) && GetLevelByClass(CLASS_TYPE_MONK,oPC) > 0)
                    oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
                if (GetIsObjectValid(oItem))
                    {
                    sString="You drink the water and your weapon glows softly.";
                    iPlus=IPGetWeaponEnhancementBonus(oItem)+1;
                    ip=ItemPropertyEnhancementBonus(iPlus);
                    IPSafeAddItemProperty(oItem,ip);
                    iRandom2=Random(6);
                    if (iRandom2==0)
                        {
                        iPlus=IPGetWeaponEnhancementBonus(oItem)+1;
                        ip=ItemPropertyEnhancementBonus(iPlus);
                        IPSafeAddItemProperty(oItem,ip);
                        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1d6);
                        IPSafeAddItemProperty(oItem,ip);
                        SetName(oItem,"Magically Enhanced " + GetName(oItem));
                        }
                    else if (iRandom2<3)
                        {
                        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1);
                        IPSafeAddItemProperty(oItem,ip);
                        }
                    } else {
                    sString="It just tastes like water.";
                    }
                } else {
                AssignCommand(oPC,ActionCastSpellAtObject(SPELL_GREATER_MAGIC_WEAPON,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
                }
            }
        else if (iRandom<40)
            {
            AssignCommand(oPC,ActionCastSpellAtObject(SPELL_STONESKIN,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<45)
            {
            AssignCommand(oPC,ActionCastSpellAtObject(SPELL_TENSERS_TRANSFORMATION,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<48)
            {
            AssignCommand(oPC,ActionCastSpellAtObject(SPELL_BLESS,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<49)
            {
            ExecuteScript("en6_draw",oPC);
            }
        else if (iRandom<50)
            {
            GetPowers(oPC);
            sString = "You feel the power of magic rush through you.";
            }

        SendMessageToPC(oPC,sString);
        } else {
        AssignCommand(oPC,ClearAllActions());
        DelayCommand(0.7,SendMessageToPC(oPC,"It tastes like water."));
        }
    }
}

void GetPowers(object oPC)
{
int iRandom;
string sString;
effect eVis;

iRandom=Random(5)+1;

switch (iRandom)
    {
    case 1: SetPower(oPC,2); sString="The magic becomes one with your flesh granting you with power."; break;
    case 2: SetPower(oPC,4); sString="The magic creates a fiery shield around you."; break;
    case 3: SetLocalInt(oPC,"WeaponBonus",Random(4)+1); sString="You have gained the ability to imbue your weapon with power."; break;
    case 4: SetLocalInt(oPC,"SpecialWeapon",3); sString="You have gained the ability to imbue your weapon with power."; break;
    case 5: SetPower(oPC,Random(5)+6); sString="The magic surges in you to untold heights granting you great power."; break;
    }

DelayCommand(0.5,SendMessageToPC(oPC,sString));

}

void SetPower(object oPC,int iPower)
{
effect eVis;

if (GetLocalInt(oPC,"SpecialPowers")==0)
    {
    SetLocalInt(oPC,"SpecialPowers",iPower);
    eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
    }
else
    {
    SetLocalInt(oPC,"SpecialPowers",12);
    eVis = EffectVisualEffect(VFX_IMP_HEALING_X);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
    eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
    DelayCommand(2.6,SendMessageToPC(oPC,"The powers of the pool combine with the powers you obtained from the bloodstain alter and you feel a surge of magic rush through you unlike anything you have ever felt before.  You feel almost... god-like."));
    }

ExecuteScript("en6_special",oPC);
}

