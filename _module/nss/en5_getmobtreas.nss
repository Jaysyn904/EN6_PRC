#include "en5_misc"
#include "en5_treasure"

void CreateMiscHealingKit(object oTarget, int iItemLevel);
void CreateMiscPotion(object oTarget, int iItemLevel);
void CreateMiscJewel(object oTarget, int iItemLevel);
void CreateMiscGem(object oTarget, int iItemLevel);
void CreateMiscProjectile(object oTarget,int iLevel);
void GiveSpecialItems();
void CreateAmmo(object oTarget, int iItemLevel);

void main()
{
object oMob;
int iItemLevel;
int iRandom;
int iRacialType;
int iLevel;
int iBoss;
int iGoldHigh;
int iGoldMedium;
int iGoldLow;
int iHealingKit;
int iPotion;
int iGem;
int iJewel;
int iProjectile;
int iMagic;
int iAmmo;
int iItems;
int iMagicLevel;

oMob=OBJECT_SELF;
iLevel=GetLocalInt(oMob,"EN5_iLevel");
iBoss=GetLocalInt(oMob,"EN5_iBoss");
iItemLevel=GetItemLevel(iLevel);
iRacialType=GetRacialType(oMob);

iGoldHigh=0;
iGoldMedium=0;
iGoldLow=0;
iHealingKit=0;
iPotion=0;
iGem=0;
iJewel=0;
iProjectile=0;
iMagic=0;
iAmmo=0;
iItems=0;

if (iRacialType == RACIAL_TYPE_UNDEAD || iRacialType == RACIAL_TYPE_SHAPECHANGER)
    {
    iItems=1;
    if (iBoss==3)
        {
        iGoldHigh=0;
        iGoldMedium=0;
        iGoldLow=0;
        iHealingKit=0;
        iPotion=20;
        iGem=50;
        iJewel=25;
        iProjectile=0;
        iMagic=100;
        iAmmo=1;
        }
    else if (iBoss==1 || iBoss==2)
        {
        iGoldHigh=0;
        iGoldMedium=0;
        iGoldLow=0;
        iHealingKit=0;
        iPotion=10;
        iGem=40;
        iJewel=15;
        iProjectile=0;
        iMagic=iLevel/10+10;
        iAmmo=1;
        }
    else if (iBoss==0)
        {
        iGoldHigh=0;
        iGoldMedium=0;
        iGoldLow=0;
        iHealingKit=0;
        iPotion=5;
        iGem=20;
        iJewel=10;
        iProjectile=0;
        iMagic=iLevel/10;
        if (iLevel>4 && iMagic==0)
            iMagic=1;
        iAmmo=1;
       }
    }

if (iRacialType == RACIAL_TYPE_DRAGON)
    {
    iItems=1;
    if (iBoss==3)
        {
        iGoldHigh=90;
        iGoldMedium=10;
        iGoldLow=1;
        iHealingKit=0;
        iPotion=20;
        iGem=50;
        iJewel=50;
        iProjectile=0;
        iMagic=100;
        }
    else if (iBoss==1 || iBoss==2)
        {
        iGoldHigh=50;
        iGoldMedium=30;
        iGoldLow=20;
        iHealingKit=0;
        iPotion=10;
        iGem=25;
        iJewel=25;
        iProjectile=0;
        iMagic=iLevel/10+10;
        }
    else if (iBoss==0)
        {
        iGoldHigh=20;
        iGoldMedium=30;
        iGoldLow=50;
        iHealingKit=0;
        iPotion=5;
        iGem=15;
        iJewel=15;
        iProjectile=0;
        iMagic=iLevel/10;
        if (iLevel>4 && iMagic==0)
            iMagic=1;

       }
    }

if (iRacialType == RACIAL_TYPE_OUTSIDER)
    {
    iItems=1;
    if (iBoss==3)
        {
        iGoldHigh=90;
        iGoldMedium=10;
        iGoldLow=1;
        iHealingKit=0;
        iPotion=20;
        iGem=50;
        iJewel=50;
        iProjectile=0;
        iMagic=100;
        }
    else if (iBoss==1 || iBoss==2)
        {
        iGoldHigh=50;
        iGoldMedium=30;
        iGoldLow=20;
        iHealingKit=0;
        iPotion=10;
        iGem=25;
        iJewel=25;
        iProjectile=0;
        iMagic=iLevel/10+10;
        }
    else if (iBoss==0)
        {
        iGoldHigh=10;
        iGoldMedium=10;
        iGoldLow=10;
        iHealingKit=0;
        iPotion=5;
        iGem=25;
        iJewel=10;
        iProjectile=0;
        iMagic=iLevel/10;
        if (iLevel>4 && iMagic==0)
            iMagic=1;
       }
    }

if (iRacialType == RACIAL_TYPE_DWARF ||
    iRacialType ==RACIAL_TYPE_ELF || iRacialType == RACIAL_TYPE_FEY ||
    iRacialType ==RACIAL_TYPE_GIANT || iRacialType == RACIAL_TYPE_GNOME ||
    iRacialType == RACIAL_TYPE_HALFELF || iRacialType == RACIAL_TYPE_HALFLING ||
    iRacialType == RACIAL_TYPE_HALFORC || iRacialType == RACIAL_TYPE_HUMAN ||
    iRacialType == RACIAL_TYPE_HUMANOID_GOBLINOID || iRacialType == RACIAL_TYPE_HUMANOID_MONSTROUS ||
    iRacialType == RACIAL_TYPE_HUMANOID_ORC || iRacialType ==  RACIAL_TYPE_HUMANOID_REPTILIAN)
    {
    iItems=1;
    if (iBoss==3)
        {
        iGoldHigh=65;
        iGoldMedium=35;
        iGoldLow=1;
        iHealingKit=10;
        iPotion=15;
        iGem=15;
        iJewel=10;
        iProjectile=4;
        iMagic=100;
        iAmmo=5;
        }
    else if (iBoss==1 || iBoss==2)
        {
        iGoldHigh=15;
        iGoldMedium=30;
        iGoldLow=50;
        iHealingKit=5;
        iPotion=10;
        iGem=10;
        iJewel=10;
        iProjectile=3;
        iMagic=iLevel/10+10;
        iAmmo=3;
        }
    else if (iBoss==0)
        {
        iGoldHigh=5;
        iGoldMedium=15;
        iGoldLow=40;
        iHealingKit=2;
        iPotion=5;
        iGem=3;
        iJewel=1;
        iProjectile=1;
        iMagic=iLevel/10;
        iAmmo=1;
        if (iLevel>4 && iMagic==0)
            iMagic=1;

       }
    }

if (iItems==1)
    {
    iMagicLevel = GetLocalInt(GetModule(),"MagicLevel");
    if (iMagicLevel == 1)
        {
        iPotion=iPotion+2;
        iGoldHigh=iGoldHigh+2;
        if (iBoss==1 || iBoss==2)
            iMagic=iMagic + iMagic/2;
        if (iBoss==0 && iLevel>20)
            iMagic=iMagic+1;
        }
    if (iMagicLevel == 2)
        {
        iPotion=iPotion+3;
        iGoldHigh=iGoldHigh+5;
        iAmmo=iAmmo+1;

        if (iBoss==1 || iBoss==2)
            iMagic=iMagic *2;
        if (iBoss==0 && iLevel>5)
            iMagic=iMagic+1;
        }
    if (iMagicLevel == 3)
        {
        iPotion=iPotion+4;
        iGoldHigh=iGoldHigh+8;
        iAmmo=iAmmo+2;

        if (iBoss==1 || iBoss==2)
            iMagic=iMagic * 3;
        if (iBoss==0 && iLevel<21)
            iMagic=iMagic+1;
        if (iBoss==0 && iLevel>20)
            iMagic=iMagic+2;
        }
    }

iRandom=Random(100);
if (iRandom<iGoldHigh)
    {
    if (iLevel<16)
        CreateItemOnObject("NW_IT_GOLD001", oMob,Random(50*iLevel)+1);
    else
        CreateItemOnObject("NW_IT_GOLD001", oMob,Random(25*(iLevel-15) + 750)+1);
    }
else if (iRandom< (iGoldHigh + iGoldMedium))
    {
    if (iLevel<16)
        CreateItemOnObject("NW_IT_GOLD001", oMob,Random(30*iLevel)+1);
    else
        CreateItemOnObject("NW_IT_GOLD001", oMob,Random(15*(iLevel-15) + 450)+1);
    }
else if (iRandom< (iGoldHigh + iGoldMedium + iGoldLow))
    {
    if (iLevel<16)
        CreateItemOnObject("NW_IT_GOLD001", oMob,Random(15*iLevel)+1);
    else
        CreateItemOnObject("NW_IT_GOLD001", oMob,Random(5*(iLevel-15) + 225)+1);
    }

if (Random(100)<iHealingKit)
    CreateMiscHealingKit(oMob,iItemLevel);
if (Random(100)<iPotion)
    CreateMiscPotion(oMob,iItemLevel);
if (Random(100)<iGem)
    CreateMiscGem(OBJECT_SELF,iItemLevel);
if (Random(100)<iJewel)
    CreateMiscJewel(OBJECT_SELF,iItemLevel);
if (Random(100)<iProjectile)
    CreateMiscProjectile(OBJECT_SELF,iItemLevel);
if (Random(100)<iAmmo)
    CreateAmmo(OBJECT_SELF,iItemLevel);

iItemLevel = GetItemLevel(GetHitDice(oMob));
iRandom=Random(100);

while (iItemLevel>0)
    {
    if (iRandom<iMagic)
        {
        GetMagicItem(oMob,iItemLevel);
        iItemLevel=0;
        } else {
        iItemLevel--;
        iRandom--;
        }
    }
/*
if (Random(100)<iMagic)
    DelayCommand(2.0f,ExecuteScript("en5_createitem",oMob));
*/

}




void CreateMiscHealingKit(object oTarget, int iItemLevel)
{
    string sKit = "";
    if (iItemLevel==1)      // 200
    {
        int nRandom = Random(1) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit001";  break;
        }
    }
    else if (iItemLevel==2)  // 800
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit001";  break;
            case 2: sKit = "nw_it_medkit002";  break;
        }

    }
    else if (iItemLevel==3)   // 200 - 2500
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit002"; break;
            case 2: sKit = "nw_it_medkit003";  break;
        }

   }
    else if (iItemLevel==4)  // 800 - 10000
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit003";break;
            case 2: sKit = "nw_it_medkit004"; break;
        }

    }
    else if (iItemLevel==5)  // 2000 -16500
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit003"; break;
            case 2: sKit = "nw_it_medkit004";break;
        }

    }
    else if (iItemLevel==6)   // 2000 - ?
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit003"; break;
            case 2: sKit = "nw_it_medkit004";break;
         }

    }
    //dbSpeak("Create Healing Kit");

    CreateItemOnObject(sKit, oTarget, 1);

}

void CreateMiscPotion(object oTarget, int iItemLevel)
{
    string sPotion = "";

    if (iItemLevel==1)
    {
        int nRandom = d10();
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: sPotion = "nw_it_mpotion001"; break;
            case 5: case 6: case 7: sPotion = "nw_it_mpotion020";  break;
            case 8: sPotion = "nw_it_mpotion002";  break;
            case 9: sPotion = "nw_it_mpotion009";  break;
            case 10: sPotion = "nw_it_mpotion005";  break;
        }

    }
    else if (iItemLevel==2)
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: sPotion = "nw_it_mpotion001"; break;
            case 4: case 5: case 6: case 7: case 8: sPotion = "nw_it_mpotion020";  break;
            case 9: case 10: case 11: case 12: sPotion = "nw_it_mpotion002";  break;
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    else if (iItemLevel==3)
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: case 10: case 11: case 12:
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    else if (iItemLevel==4)
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: case 10: case 11: case 12: sPotion = "nw_it_mpotion003"; break;
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    else  // keep 5 and 6 the same
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: sPotion = "nw_it_mpotion003" ;
            case 10: case 11: case 12: case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    CreateItemOnObject(sPotion, oTarget, 1);
}


void CreateMiscGem(object oTarget, int iItemLevel)
{
    string sGem = "nw_it_gem001";
    if (iItemLevel==1)
    {
        int nRandom = Random(9) + 1;
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem001";  break;
            case 2: sGem = "nw_it_gem007";  break;
            case 3: sGem = "nw_it_gem002";  break;
            case 4: case 5: sGem = "nw_it_gem004"; break;
            case 6: case 7: sGem = "nw_it_gem014"; break;
            case 8: sGem = "nw_it_gem003";         break;
            case 9: sGem = "nw_it_gem015";         break;
        }
    }
    else if (iItemLevel==2)               // 30 GP Avg; 150 gp Max
    {
        int nRandom = d12();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem001";         break;
            case 2: sGem = "nw_it_gem007";         break;
            case 3: sGem = "nw_it_gem002";         break;
            case 4: sGem = "nw_it_gem004";         break;
            case 5: case 6: sGem = "nw_it_gem014";  break;
            case 7: case 8: sGem = "nw_it_gem003";  break;
            case 9: case 10: sGem = "nw_it_gem015"; break;
            case 11: sGem = "nw_it_gem011";         break;
            case 12: sGem = "nw_it_gem013";         break;
        }

    }
    else if (iItemLevel==3)  // 75GP Avg; 500 gp max
    {
        int nRandom = d2();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";         break;
            case 2: sGem = "nw_it_gem010";         break;
        }

    }
    else if (iItemLevel==4)  // 150 gp avg; 1000 gp max
    {
        int nRandom = d3();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";  break;
            case 2: sGem = "nw_it_gem010";    break;
            case 3: sGem = "nw_it_gem008";           break;
        }
    }
    else if (iItemLevel==5)  // 300 gp avg; any
    {
        int nRandom = d6();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";  break;
            case 2: sGem = "nw_it_gem010";    break;
            case 3: case 4: sGem = "nw_it_gem008";           break;
            case 5: sGem = "nw_it_gem009";           break;
            case 6: sGem = "nw_it_gem009";           break;
        }
    }
    else if (iItemLevel==6)// * Anything higher than level 15    500 gp avg; any
    {
        int nRandom = Random(8) + 1;
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";  break;
            case 2: sGem = "nw_it_gem010";    break;
            case 3: case 4: sGem = "nw_it_gem008";           break;
            case 5: sGem = "nw_it_gem009";           break;
            case 6: sGem = "nw_it_gem009";           break;
            case 7: sGem = "nw_it_gem006";           break;
            case 8: sGem = "nw_it_gem012";           break;
        }
    }
  //dbSpeak("Create Gem");
  CreateItemOnObject(sGem, oTarget, 1);
}
void CreateMiscJewel(object oTarget, int iItemLevel)
{
    string sJewel = "";

    if (iItemLevel==1)        // 15 gp avg; 75 gp max
    {
      int nRandom = d2();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";   break;
        case 2: sJewel = "nw_it_mneck020";   break;
      }
    }
    else if (iItemLevel==2)   // 30 GP Avg; 150 gp Max
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";            break;
        case 2: case 3: sJewel = "nw_it_mneck020";    break;
        case 4: sJewel = "nw_it_mring022";            break;
        case 5: case 6: sJewel = "nw_it_mneck023";            break;          }
    }
    else if (iItemLevel==3)  // 75GP Avg; 500 gp max
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";           break;
        case 2: case 3: sJewel = "nw_it_mneck020";   break;
        case 4: case 5: sJewel = "nw_it_mring022";   break;
        case 6: sJewel = "nw_it_mneck021";           break;
      }
    }
    else if (iItemLevel==4)  // 150 gp avg; 1000 gp max
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";            break;
        case 2: sJewel = "nw_it_mring022";            break;
        case 3: case 4: case 5: sJewel = "nw_it_mneck021";    break;
        case 6: sJewel = "nw_it_mring023";            break;
      }
    }
    else if (iItemLevel==5)  // 300 gp avg; any
    {
      int nRandom = d8();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring022";           break;
        case 2: case 3: sJewel = "nw_it_mneck021";   break;
        case 4: case 5: case 6: sJewel = "nw_it_mring023"; break;
        case 7: case 8: sJewel = "nw_it_mneck022";               break;
      }
    }
    else if (iItemLevel==6)
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring022";              break;
        case 2: sJewel = "nw_it_mneck021";              break;
        case 3: case 4: sJewel = "nw_it_mring023";      break;
        case 5: case 6: sJewel = "nw_it_mneck022";      break;
      }
    }
  //dbSpeak("Create Jewel");

  CreateItemOnObject(sJewel, oTarget, 1);

}

void CreateMiscProjectile(object oTarget,int iLevel)
{
int iRandom;
string sTag;

if (iLevel > 2 && Random(5)==0)
    {
    if (Random(2)==0)
        sTag="x2_it_acidbomb";
    else
        sTag="x2_it_firebomb";
    CreateItemOnObject(sTag, oTarget, 1);
    } else {
    sTag="X1_WMGRENADE00" + IntToString(Random(7)+1);
    CreateItemOnObject(sTag, oTarget, Random(4)+1);
    }

}

void CreateAmmo(object oTarget, int iItemLevel)
{
    string sAmmo = "";

    if (iItemLevel==1)           // * 200 gp max
    {
        int nRandom = d3();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";  break;
            case 2: sAmmo = "nw_wambo001";  break;
            case 3: sAmmo = "nw_wambu001";  break;
        }
      }
    else if (iItemLevel==2)       // * 800 gp max
    {
        int nRandom = d6();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";  break;
            case 2: sAmmo = "nw_wambo001";  break;
            case 3: sAmmo = "nw_wambu001";  break;
            case 4: sAmmo = "nw_wammar001"; break;
            case 5: sAmmo = "nw_wammbo001"; break;
            case 6: sAmmo = "nw_wammbo002"; break;
        }
    }
    else if (iItemLevel==3)    // *  - 2500 gp
    {
        int nRandom = d20();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";   break;
            case 2: sAmmo = "nw_wambo001";   break;
            case 3: sAmmo = "nw_wambu001";   break;
            case 4: sAmmo = "nw_wammar001";  break;
            case 5: sAmmo = "nw_wammbo001";  break;
            case 6: sAmmo = "nw_wammbo002";   break;
            case 7: sAmmo = "nw_wammbo003";  break;
            case 8: sAmmo = "nw_wammbu002";  break;
            case 9: sAmmo = "nw_wammar002";  break;
            case 10: sAmmo = "nw_wammar001"; break;
            case 11: sAmmo = "nw_wammar003"; break;
            case 12: sAmmo = "nw_wammar004"; break;
            case 13: sAmmo = "nw_wammar005"; break;
            case 14: sAmmo = "nw_wammar006"; break;
            case 15: sAmmo = "nw_wammbo004";  break;
            case 16: sAmmo = "nw_wammbo005"; break;
            case 17: sAmmo = "nw_wammbu004"; break;
            case 18: sAmmo = "nw_wammbu005"; break;
            case 19: sAmmo = "nw_wammbu006"; break;
            case 20: sAmmo = "nw_wammbu007"; break;
        }
    }
    else
    {
        int nRandom = d20();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";      break;
            case 2: sAmmo = "nw_wammbu001";     break;
            case 3: sAmmo = "nw_wammbu003";     break;
            case 4: sAmmo = "nw_wammar001";     break;
            case 5: sAmmo = "nw_wammbo001";      break;
            case 6: sAmmo = "nw_wammbo002";     break;
            case 7: sAmmo = "nw_wammbo003";     break;
            case 8: sAmmo = "nw_wammbu002";     break;
            case 9: sAmmo = "nw_wammar002";     break;
            case 10: sAmmo = "nw_wammar001";    break;
            case 11: sAmmo = "nw_wammar003";    break;
            case 12: sAmmo = "nw_wammar004";     break;
            case 13: sAmmo = "nw_wammar005";    break;
            case 14: sAmmo = "nw_wammar006";    break;
            case 15: sAmmo = "nw_wammbo004";    break;
            case 16: sAmmo = "nw_wammbo005";    break;
            case 17: sAmmo = "nw_wammbu004";    break;
            case 18: sAmmo = "nw_wammbu005";    break;
            case 19: sAmmo = "nw_wammbu006";    break;
            case 20: sAmmo = "nw_wammbu007";    break;
        }
    }
    //dbSpeak("ammo");
    CreateItemOnObject(sAmmo, oTarget, Random(20) + 5); // create up to 30 of the specified ammo type
}
