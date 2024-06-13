int FeatCheck(int nFeatWeaponType, object oCreature);
void MakeFeatList(object oCreature, string sWeapon);
void GetWeaponType(object oCreature);
int ENGetArmorType(object oCreature);
string GetMartialWeapon(object oCreature);
string GetExoticWeapon(object oCreature);
string GetSimpleWeapon(object oCreature);

int FeatCheck(int nFeat, object oCreature)
{
    if (GetHasFeat(nFeat, oCreature) == TRUE)
    return TRUE;
    else
    return FALSE;
}

void MakeFeatList(object oCreature, string sWeapon)
{
int iWeapons;
string sWeaponNumber;

iWeapons = GetLocalInt(oCreature,"Weapons");
if (iWeapons<7)
  {
  iWeapons++;
  SetLocalInt(oCreature,"Weapons",iWeapons);
  sWeaponNumber = "Weapon" + IntToString(iWeapons);
  SetLocalString(oCreature,sWeaponNumber,sWeapon);
  }
}

void GetWeaponType(object oCreature)
{
int iRandom;

    SetLocalInt(oCreature,"Weapons",0);
    SetLocalString(oCreature,"Weapon1","");
    SetLocalString(oCreature,"Weapon2","");
    SetLocalString(oCreature,"Weapon3","");
    SetLocalString(oCreature,"Weapon4","");
    SetLocalString(oCreature,"Weapon5","");
    SetLocalString(oCreature,"Weapon6","");

    // * CHoose the weapon type to create
    if (FeatCheck(FEAT_WEAPON_FOCUS_BASTARD_SWORD, oCreature))
    {
        MakeFeatList(oCreature,"bsword");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_BATTLE_AXE,oCreature))
    {
        MakeFeatList(oCreature,"battleaxe");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_CLUB,oCreature))
    {
        MakeFeatList(oCreature,"club");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_DAGGER,oCreature))
    {
        MakeFeatList(oCreature,"dagger");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_DART,oCreature))
    {
        MakeFeatList(oCreature,"dart");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_DIRE_MACE,oCreature))
    {
        MakeFeatList(oCreature,"diremace");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_DOUBLE_AXE,oCreature))
    {
        MakeFeatList(oCreature,"doubleaxe");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_GREAT_AXE,oCreature))
    {
        MakeFeatList(oCreature,"greataxe");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_GREAT_SWORD,oCreature))
    {
        MakeFeatList(oCreature,"greatsword");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_HALBERD,oCreature))
    {
        MakeFeatList(oCreature,"halberd");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_HAND_AXE,oCreature))
    {
        MakeFeatList(oCreature,"handaxe");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW,oCreature))
    {
        MakeFeatList(oCreature,"hxbow");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_HEAVY_FLAIL,oCreature))
    {
        MakeFeatList(oCreature,"hflail");
    }

    if (FeatCheck(FEAT_WEAPON_FOCUS_KATANA,oCreature))
    {
        MakeFeatList(oCreature,"katana");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_KUKRI,oCreature))
    {
        MakeFeatList(oCreature,"kukri");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW,oCreature))
    {
        MakeFeatList(oCreature,"lxbow");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_LIGHT_FLAIL,oCreature))
    {
        MakeFeatList(oCreature,"lflail");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_LIGHT_HAMMER,oCreature))
    {
        MakeFeatList(oCreature,"lhammer");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_LIGHT_MACE,oCreature))
    {
        MakeFeatList(oCreature,"mace");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_LONG_SWORD,oCreature))
    {
        MakeFeatList(oCreature,"lsword");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_LONGBOW,oCreature))
    {
        MakeFeatList(oCreature,"longbow");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_MORNING_STAR,oCreature))
    {
        MakeFeatList(oCreature,"mstar");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_RAPIER,oCreature))
    {
        MakeFeatList(oCreature,"rapier");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SCIMITAR,oCreature))
    {
        MakeFeatList(oCreature,"scimitar");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SCYTHE,oCreature))
    {
        MakeFeatList(oCreature,"scythe");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SHORT_SWORD,oCreature))
    {
        MakeFeatList(oCreature,"ssword");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SHORTBOW,oCreature))
    {
        MakeFeatList(oCreature,"sbow");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SHURIKEN,oCreature))
    {
        MakeFeatList(oCreature,"shuriken");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SICKLE,oCreature))
    {
        MakeFeatList(oCreature,"sickle");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SLING,oCreature))
    {
        MakeFeatList(oCreature,"sling");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_SPEAR,oCreature))
    {
        MakeFeatList(oCreature,"spear");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_STAFF,oCreature))
    {
        MakeFeatList(oCreature,"staff");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_THROWING_AXE,oCreature))
    {
        MakeFeatList(oCreature,"taxe");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD,oCreature))
    {
        MakeFeatList(oCreature,"tbsword");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_WAR_HAMMER,oCreature))
    {
        MakeFeatList(oCreature,"warhammer");
    }
    if (FeatCheck(FEAT_WEAPON_FOCUS_DWAXE,oCreature))
    {
        MakeFeatList(oCreature,"dwaxe");
    }

//    if (FeatCheck(FEAT_WEAPON_FOCUS_WHIP,oCreature))
//    {
//        MakeFeatList(oCreature,"whip");
//    }

    if (FeatCheck(FEAT_IMPROVED_UNARMED_STRIKE,oCreature))
    {
        MakeFeatList(oCreature,"monkgloves");
    }

    if (FeatCheck(FEAT_WEAPON_FOCUS_KAMA,oCreature))
    {
        MakeFeatList(oCreature,"kama");
    }

    if (GetLocalInt(oCreature,"Weapons")==0)
    {
        // * if get to this point then the PC did not have Weapon Focus
        // * in anything then do additional logic to give an appropriate weapon

        if (GetLevelByClass(CLASS_TYPE_DRUID, oCreature) >= 1)
        {
            iRandom = Random(6) + 1;
            switch (iRandom)
                {
                case 1: MakeFeatList(oCreature,"scimitar"); break;
                case 2: MakeFeatList(oCreature,"sickle"); break;
                case 3: MakeFeatList(oCreature,"club"); break;
                case 4: MakeFeatList(oCreature,"mace"); break;
                case 5: MakeFeatList(oCreature,"spear"); break;
                case 6: MakeFeatList(oCreature,"staff"); break;
                }
        }
        else
        if (GetLevelByClass(CLASS_TYPE_WIZARD, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_SORCERER, oCreature) >= 1)
        {
            MakeFeatList(oCreature,"dagger");

        }
        else
        if (GetLevelByClass(CLASS_TYPE_PALADIN, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_FIGHTER, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_RANGER, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_BARBARIAN, oCreature) >= 1 )
        {
            MakeFeatList(oCreature,GetMartialWeapon(oCreature));
        }
        else
        if (GetLevelByClass(CLASS_TYPE_MONK, oCreature) >= 1)
        {
            iRandom = Random(2) + 1;
            switch (iRandom)
                {
                case 1: MakeFeatList(oCreature,"kama"); break;
                case 2: MakeFeatList(oCreature,"shuriken"); break;
                }
        }
        else
        if (GetLevelByClass(CLASS_TYPE_CLERIC, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_BARD, oCreature) >= 1)
        {
            iRandom = Random(3) + 1;
            switch (iRandom)
                {
                case 1: MakeFeatList(oCreature,"mace"); break;
                case 2: MakeFeatList(oCreature,"club"); break;
                case 3: MakeFeatList(oCreature,"mstar"); break;
                }
        }
        else
        if (GetLevelByClass(CLASS_TYPE_ROGUE, oCreature) >= 1)
        {
            iRandom = Random(4) + 1;
            switch (iRandom)
                {
                case 1: MakeFeatList(oCreature,"dagger"); break;
                case 2: MakeFeatList(oCreature,"handaxe"); break;
                case 3: MakeFeatList(oCreature,"ssword"); break;
                case 4: MakeFeatList(oCreature,"rapier"); break;
                }
        }
    }
}

string GetMartialWeapon(object oCreature)
{
int iRandom;
string sTag;

sTag = "lsword";
if (GetCreatureSize(oCreature) == CREATURE_SIZE_SMALL ||  GetCreatureSize(oCreature) == CREATURE_SIZE_TINY)
    {
    iRandom = Random(10) + 1;
    switch (iRandom)
        {
        case 1: sTag="lsword"; break;
        case 2: sTag="handaxe"; break;
        case 3: sTag="rapier"; break;
        case 4: sTag="ssword"; break;
        case 5: sTag="scimitar"; break;
        case 6: sTag="warhammer"; break;
        case 7: sTag="mstar"; break;
        case 8: sTag="lflail"; break;
        case 9: sTag="lhammer"; break;
        case 10: sTag="sbow"; break;
        }
    } else {
    iRandom = Random(15) + 1;
    switch (iRandom)
        {
        case 1: sTag="lsword"; break;
        case 2: sTag="battleaxe"; break;
        case 3: sTag="greataxe"; break;
        case 4: sTag="greatsword"; break;
        case 5: sTag="halberd"; break;
        case 6: sTag="handaxe"; break;
        case 7: sTag="rapier"; break;
        case 8: sTag="ssword"; break;
        case 9: sTag="scimitar"; break;
        case 10: sTag="warhammer"; break;
        case 11: sTag="mstar"; break;
        case 12: sTag="hflail"; break;
        case 13: sTag="lflail"; break;
        case 14: sTag="lhammer"; break;
        case 15: if (Random(3)==0)
                    sTag="hxbow";
                 else
                    sTag="longbow";
                 break;
        }
    }
return sTag;
}

string GetExoticWeapon(object oCreature)
{
int iRandom;
string sTag;

sTag = "diremace";
if (GetCreatureSize(oCreature) == CREATURE_SIZE_SMALL ||  GetCreatureSize(oCreature) == CREATURE_SIZE_TINY)
    {
    iRandom = Random(4) + 1;
    switch (iRandom)
        {
        case 1: sTag="kama"; break;
        case 2: sTag="katana"; break;
        case 3: sTag="kukri"; break;
        case 4: sTag="bsword"; break;
        }
    } else {
    iRandom = Random(7) + 1;
    switch (iRandom)
        {
        case 1: sTag="diremace"; break;
        case 2: sTag="doubleaxe"; break;
        case 3: sTag="kama"; break;
        case 4: sTag="katana"; break;
        case 5: sTag="kukri"; break;
        case 6: sTag="tbsword"; break;
        case 7: sTag="bsword"; break;
        }
    }
return sTag;
}
string GetSimpleWeapon(object oCreature)
{
int iRandom;
string sTag;

sTag = "mace";

if (GetCreatureSize(oCreature) == CREATURE_SIZE_SMALL ||  GetCreatureSize(oCreature) == CREATURE_SIZE_TINY)
    {
    iRandom = Random(6) + 1;
    switch (iRandom)
        {
        case 1: sTag="mace"; break;
        case 2: sTag="club"; break;
        case 3: sTag="dagger"; break;
        case 4: sTag="sickle"; break;
        case 5: sTag="spear"; break;
        case 6: sTag="morningstar"; break;
        }
    } else {
    iRandom = Random(7) + 1;
    switch (iRandom)
        {
        case 1: sTag="mace"; break;
        case 2: sTag="club"; break;
        case 3: sTag="dagger"; break;
        case 4: sTag="sickle"; break;
        case 5: sTag="spear"; break;
        case 6: sTag="morningstar"; break;
        case 7: sTag="staff"; break;
        }
    }

return sTag;
}

int ENGetArmorType(object oCreature)
{
int iArmor;

//Check classes first, then feats, then lastly monk so that monks always get robes
// iArmor
// 0 = None
// 1 = light
// 2 = medium
// 3 = heavy
// 4 = wizard robes
// 5 == monk robes

iArmor = 0;

        if (GetLevelByClass(CLASS_TYPE_WIZARD, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_SORCERER, oCreature) >= 1)
        {
            iArmor=4;
        }

        if (GetLevelByClass(CLASS_TYPE_DRUID, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_RANGER, oCreature) >= 1)
        {
            iArmor = 1;
        }

        if (GetLevelByClass(CLASS_TYPE_ROGUE, oCreature) >= 1)
        {
            iArmor = 1;
        }

        if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oCreature) >= 1)
        {
            iArmor = 2;
        }

        if (GetLevelByClass(CLASS_TYPE_PALADIN, oCreature) >= 1 || GetLevelByClass(CLASS_TYPE_FIGHTER, oCreature) >= 1)
        {
            iArmor = 3;
        }

        if (GetLevelByClass(CLASS_TYPE_CLERIC, oCreature) >= 1)
        {
            iArmor = 3;
        }

        if (FeatCheck(FEAT_ARMOR_PROFICIENCY_LIGHT,oCreature))
        {
            iArmor = 1;
        }

        if (FeatCheck(FEAT_ARMOR_PROFICIENCY_MEDIUM,oCreature))
        {
            iArmor = 2;
        }


        if (GetLevelByClass(CLASS_TYPE_BARD, oCreature) >= 1)
        {
            if (Random(2)==0)
                {
                iArmor = 1;
                }
            else
                {
                iArmor = 2;
                }
        }

        if (GetLevelByClass(CLASS_TYPE_RANGER, oCreature) >= 1)
        {
            if (Random(2)==0)
                {
                iArmor = 1;
                }
            else
                {
                iArmor = 2;
                }
        }
        if (GetLevelByClass(CLASS_TYPE_MONK, oCreature) >= 1)
        {
            iArmor = 5;
        }


//Moved heavy here in case Ranger has heavy armor feat and like goes that route

        if (FeatCheck(FEAT_ARMOR_PROFICIENCY_HEAVY,oCreature))
        {
            iArmor = 3;
        }

return iArmor;
}


