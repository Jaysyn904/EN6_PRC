#include "qst_include"

void GetRandomEvent(object oPC);
object GetRandomEventMob(string sTag,location lLoc,int iEquip=0,int iLevel=0,int iClass=EN5_CLASS_FIGHTER);
string GetGoodColor();
string GetEvilColor();

void main()
{
object oPC=GetEnteringObject();

if (GetLocalInt(OBJECT_SELF,"DoOnce")>0)
    return;

if (GetIsPC(oPC))
    {
    SetLocalInt(OBJECT_SELF,"DoOnce",1);
    if (Random(16)==0)
        GetRandomEvent(oPC);
    }
}

void GetRandomEvent(object oPC)
{
string sZone;
string sTag;
int iMinLevel;
int iMaxLevel;
int iLevel;
int iClass;
int iEquip;
int iRandom;
int iFight;
int iRaider;
int iRandomEvent;
int iDragon;
object oWP;
object oMob;
location lLoc;

sZone=GetLocalString(GetArea(oPC),"Zone");
iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

oWP = GetObjectByTag("WP_" + GetTag(OBJECT_SELF));
if (GetIsObjectValid(oWP))
    lLoc=GetLocation(oWP);
else
    lLoc=GetLocation(oPC);

iRandomEvent=Random(4);

if (iRandomEvent < 2)
    {
    sTag="en5_bandit";
    if (iMaxLevel>10)
        {
        if (Random(3)==0)
            sTag="en5_merc";
        else
            if (Random(2)==0)
                if (iMaxLevel<25)
                    sTag="en6_slaver";
                else
                    sTag="en5_merc";
            else
                sTag="en5_assassin";
        }
    iLevel=Random(iMaxLevel-iMinLevel+1) + iMinLevel;
    iClass=EN5_CLASS_ROGUE;
    iEquip=2;
    if (Random(6)==0)
        iFight=1;
    }
else if (iRandomEvent<3)
    {
    iRandom=Random(8);
    if (iRandom<2)
        sTag="en5_horc_e";
    else if (iRandom<3)
        sTag="en5_dwarf_e";
    else if (iRandom<4)
        sTag="en5_drow_e";
    else
        sTag="en5_human_e";
    iRaider=1;
    iLevel=Random(iMaxLevel-iMinLevel+1) + iMinLevel;
    iRandom=Random(5);
    if (iRandom<2)
        iClass=EN5_CLASS_FIGHTER;
    else if (iRandom<3)
        iClass=EN5_CLASS_ROGUE;
    else if (iRandom<3)
        iClass=EN5_CLASS_CLERIC;
    else
        if (sTag!="en5_horc_e" && sTag!="en5_dwarf_e")
            iClass=EN5_CLASS_WIZARD;
        else
            iClass=EN5_CLASS_BARBARIAN;
    iEquip=2;
    if (Random(6)==0)
        iFight=1;
    }
else
    {
    if (Random(6)==0)
        iFight=1;
    if (iMaxLevel<2)
        {
        iRandom=Random(3);
        if (iRandom<1)
            sTag="en5_kobold";
        else if (iRandom<2)
            sTag="en5_goblin1";
        else
            sTag="en5_orc1";
        iEquip=1;
        }
    else if (iMaxLevel<5)
        {
        iRandom=Random(4);
        if (iRandom<1)
            sTag="EN5_MINOTAUR";
        else if (iRandom<2)
            sTag="en5_ogre01";
        else if (iRandom<3)
            sTag="EN5_OLDWARRA";
        else
            sTag="en5_uorc1";
        iEquip=1;
        }
    else if (iMaxLevel<9)
        {
        iRandom=Random(3);
        if (iRandom<1)
            sTag="EN5_SALA";
        else if (iRandom<2)
            sTag="EN5_TROLL";
        else
            sTag="EN5_ETTIN";
        }
    else if (iMaxLevel<13)
        {
        iRandom=Random(3);
        if (iRandom<1)
            {
            if (Random(3)==0)
                sTag="EN5_HALFDRASOR";
            else
                if (Random(2)==0)
                    sTag="EN5_HALFDRACLR";
                else
                    sTag="EN5_HALFDRAFTR";
            }
        else if (iRandom<2)
            sTag="EN5_CYCLOPS";
        else
            sTag="EN5_GOLFLESH";
        }
    else if (iMaxLevel<18)
        {
        iRandom=Random(4);
        if (iRandom<1)
            sTag="EN5_BEHOLDER";
        else if (iRandom<2)
            sTag="EN5_MOHRG";
        else if (iRandom<3)
            sTag="en5_gnthill";
        else
            {
            if (Random(3)==0)
                {
                sTag="NW_DRG" + GetEvilColor() + "001";
                iDragon=1;
                if (Random(2)==0)
                    iFight=2;
                }
            else
                sTag="en5_gnthill";
            }
        }
    else if (iMaxLevel<22)
        {
        iRandom=Random(4);
        if (iRandom<1)
            sTag="en5_mindfdark";
        else if (iRandom<2)
            sTag="EN5_OGREELITE";
        else if (iRandom<3)
            sTag="en5_gnthill";
        else
            {
            if (Random(2)==0)
                sTag="NW_DRG" + GetEvilColor() + "001";
            else
                sTag="NW_DRG" + GetEvilColor() + "002";
            iDragon=1;
            if (Random(3)==0)
                iFight=2;
            }
        }
    else if (iMaxLevel<27)
        {
        if (Random(4)==0)
            {
            sTag="NW_DRG" + GetEvilColor() + "003";
            iDragon=1;
            if (Random(6)==3)
                sTag="X2_DRAGONSHAD001";
            if (Random(4)==0)
                iFight=2;
            } else {
            iRandom=Random(5);
            if (iRandom<1)
                sTag="en5_drow";
            else if (iRandom<2)
                sTag="en5_duergar";
            else if (iRandom<3)
                sTag="EN5_FEYRI1";
            else if (iRandom<4)
                sTag="en5_shade1";
            else
                sTag="en5_tiefling1";
            iLevel=Random(iMaxLevel-iMinLevel+1) + iMinLevel;
            iRandom=Random(5);
            if (iRandom<2)
                iClass=EN5_CLASS_FIGHTER;
            else if (iRandom<3)
                iClass=EN5_CLASS_ROGUE;
            else if (iRandom<3)
                iClass=EN5_CLASS_CLERIC;
            else
                iClass=EN5_CLASS_WIZARD;
            iEquip=2;
            }
        }
    else
        {
        iRandom=Random(5);
        if (iRandom<1)
            sTag="en5_drow";
        else if (iRandom<2)
            sTag="en5_duergar";
        else if (iRandom<3)
            sTag="EN5_FEYRI1";
        else if (iRandom<4)
            sTag="en5_shade1";
        else
            sTag="en5_tiefling1";
        iLevel=Random(iMaxLevel-iMinLevel+1) + iMinLevel;
        iRandom=Random(5);
        if (iRandom<2)
            iClass=EN5_CLASS_FIGHTER;
        else if (iRandom<3)
            iClass=EN5_CLASS_ROGUE;
        else if (iRandom<3)
            iClass=EN5_CLASS_CLERIC;
        else
            iClass=EN5_CLASS_WIZARD;
        iEquip=2;
        }
    }

oMob=GetRandomEventMob(sTag,lLoc,iEquip,iLevel,iClass);
if (iRaider==1)
    SetName(oMob,GetName(oMob) + " Raider");
if (iMaxLevel>5 && Random(2)==0 && iDragon==0)
    {
    oMob=GetRandomEventMob(sTag,lLoc,iEquip,iLevel,EN5_CLASS_FIGHTER);
    if (iRaider==1)
        SetName(oMob,GetName(oMob) + " Raider");
    }

if (iDragon==1)
    {
    GetMagicItem(oMob,GetItemLevel(FloatToInt(GetChallengeRating(oMob))),0,GetRandomPC());
    }

if (iFight==1)
    {
    iRandom=Random(8);
    if (iRandom<3)
        sTag="en5_human";
    else if (iRandom<5)
        sTag="en5_elf";
    else if (iRandom<7)
        sTag="en5_dwarf";
    else
        sTag="en5_halfling";

    iLevel=Random(iMaxLevel-iMinLevel+1) + iMinLevel;
    iRandom=Random(5);
    if (iRandom<2)
        iClass=EN5_CLASS_FIGHTER;
    else if (iRandom<3)
        iClass=EN5_CLASS_ROGUE;
    else if (iRandom<3)
        iClass=EN5_CLASS_CLERIC;
    else
        if (sTag!="en5_dwarf")
            iClass=EN5_CLASS_WIZARD;
        else
            iClass=EN5_CLASS_BARBARIAN;
    iEquip=2;

    oMob=GetRandomEventMob(sTag,lLoc,iEquip,iLevel,iClass);
    if (iMaxLevel>5 && Random(2)==0)
        oMob=GetRandomEventMob(sTag,lLoc,iEquip,iLevel,EN5_CLASS_FIGHTER);
    }
if (iFight==2)
    {
    if (iMaxLevel<16)
        sTag="NW_DRG" + GetGoodColor() + "001";
    else if (iMaxLevel<22)
        {
        if (Random(2)==0)
            sTag="NW_DRG" + GetGoodColor() + "001";
        else
            sTag="NW_DRG" + GetGoodColor() + "002";
         }
    else
        sTag="NW_DRG" + GetGoodColor() + "003";
    oMob=GetRandomEventMob(sTag,lLoc);
    }
}

object GetRandomEventMob(string sTag,location lLoc,int iEquip=0,int iLevel=0,int iClass=EN5_CLASS_FIGHTER)
{
object oMob;

oMob=CreateObject(OBJECT_TYPE_CREATURE,sTag,lLoc);
if (iLevel>0)
    LevelMob(oMob,iLevel,iClass);
if (iEquip==1)
    DelayCommand(0.1,EquipWeapon(oMob));
if (iEquip==2)
    DelayCommand(0.1,EquipMob(oMob));

AssignCommand(oMob,SetIsDestroyable(TRUE, FALSE, TRUE));
DelayCommand(0.5,SetLootable(oMob,TRUE));

return oMob;
}

string GetEvilColor()
{
int iRandom;
string sColor;

iRandom=Random(5);
if (iRandom<1)
    sColor="BLACK";
else if (iRandom<2)
    sColor="WHITE";
else if (iRandom<3)
    sColor="BLUE";
else if (iRandom<4)
    sColor="GREEN";
else
    sColor="RED";

return sColor;
}


string GetGoodColor()
{
int iRandom;
string sColor;

iRandom=Random(5);
if (iRandom<1)
    sColor="BRASS";
else if (iRandom<2)
    sColor="BRNZ";
else if (iRandom<3)
    sColor="COPP";
else if (iRandom<4)
    sColor="GOLD";
else
    sColor="SILV";

return sColor;
}


