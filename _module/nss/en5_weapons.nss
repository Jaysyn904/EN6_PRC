//#include "NW_O2_CONINCLUDE"
#include "en5_misc"

void MakeWeaponList(object oCreature, string sWeapon)
{
int iWeapons;
string sWeaponNumber;

iWeapons = GetLocalInt(oCreature,"Weapons");
iWeapons++;
SetLocalInt(oCreature,"Weapons",iWeapons);
sWeaponNumber = "Weapon" + IntToString(iWeapons);
SetLocalString(oCreature,sWeaponNumber,sWeapon);
}

void ClearWeaponList(object oCreature)
{
int iWeapons;
int iIndex;

iWeapons = GetLocalInt(oCreature,"Weapons");
iIndex=1;

while (iIndex <= iWeapons)
    {
    SetLocalString(oCreature,"Weapon" + IntToString(iIndex),"");
    iIndex++;
    }
SetLocalInt(oCreature,"Weapons",0);
}

string GetWeaponFromList(object oCreature)
{
int iWeapons;
int iRandom;
string sTag;

iWeapons = GetLocalInt(oCreature,"Weapons");
iRandom = Random(iWeapons) + 1;
sTag = GetLocalString(oCreature,"Weapon" + IntToString(iRandom));

return sTag;
}

int GetRange(int iRange,int iItemLevel)
{
int iResult;

iResult = FALSE;

if (iRange == 1 && iItemLevel == 1)
    iResult = TRUE;
if (iRange == 2 && iItemLevel == 1)
    iResult = TRUE;
if (iRange == 3 && iItemLevel == 2)
    iResult = TRUE;
if (iRange == 4 && iItemLevel == 3)
    iResult = TRUE;
if (iRange == 5 && iItemLevel == 4)
    iResult = TRUE;
if (iRange == 6 && iItemLevel > 4)
    iResult = TRUE;

return iResult;
}

string CreateMonkGloves(object oPC,int iItemLevel=1)
{
int iRandom;
string sTag;

if (iItemLevel == 1)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MGLOVE016"; break;
        case 2: sTag="NW_IT_MGLOVE021"; break;
        case 3: sTag="NW_IT_MGLOVE026"; break;
        case 4: sTag="en5_mgloves1_1"; break;
        }
    }
if (iItemLevel == 2)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MGLOVE017"; break;
        case 2: sTag="X1_IT_MGLOVE001"; break;
        case 3: sTag="NW_IT_MGLOVE022"; break;
        case 4: sTag="NW_IT_MGLOVE027"; break;
        case 5: sTag="en5_mgloves2_1"; break;
        }
    }
if (iItemLevel == 3)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MGLOVE018"; break;
        case 2: sTag="NW_IT_MGLOVE023"; break;
        case 3: sTag="NW_IT_MGLOVE028"; break;
        case 4: sTag="en5_mgloves3_1"; break;
        }
    }
if (iItemLevel == 4)
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MGLOVE019"; break;
        case 2: sTag="NW_IT_MGLOVE024"; break;
        case 3: sTag="NW_IT_MGLOVE029"; break;
        }
    }
if (iItemLevel == 5)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag="NW_IT_MGLOVE020"; break;
        case 2: sTag="NW_IT_MGLOVE025"; break;
        case 3: sTag="NW_IT_MGLOVE030"; break;
        case 4: sTag="en5_mgloves5_1"; break;

        }
    }
if (iItemLevel == 6)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag="X2_IT_MGLOVE001"; break;
        case 2: sTag="X2_GLOVE_BAL"; break;
        case 3: sTag="X2_IT_MGLOVE006"; break;
        case 4: sTag="X2_IT_MGLOVE011"; break;
        case 5: sTag="en5_mgloves6_1"; break;

        }
    }

return sTag;
}


string CreateBastardSword(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_bsword";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=4; break;
}

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}



string CreateBattleAxe(object oPC,int iItemLevel=1)
{

        string sItem = "";


        if (GetRange(1, iItemLevel))    // * 800
        {
                  int nRandom = Random(2) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_waxmbt002"; break;
                       case 2: sItem = "NW_WAXMBT008"; break;
                  }

        }
        else if (GetRange(2, iItemLevel))   // * 200 - 2500
        {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_waxmbt010"; break;
                       case 2: sItem = "en5_battleaxe1"; break;
                       case 3: sItem = "NW_WAXMBT009"; break;
                  }

        }
        else if (GetRange(3, iItemLevel))   // * 800 - 10000
        {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_waxmbt011"; break;
                       case 2: sItem = "en5_battleaxe2"; break;
                       case 3: sItem = "nw_waxmbt003"; break;
                       case 4: sItem = "nw_waxmbt006"; break;
                       case 5: sItem = "NW_IT_NOVEL006"; break;
                   }

        }
        else if (GetRange(4, iItemLevel))   // * 2500 - 16500
        {
                  int nRandom = Random(4) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "X0_WAXMBT001"; break;
                       case 2: sItem = "en5_battleaxe3"; break;
                       case 3: sItem = "nw_waxmbt004"; break;
                       case 4: sItem = "nw_waxmbt005"; break;
                   }

        }
        else if (GetRange(5, iItemLevel))   // * 8000 - 25000
        {
                  int nRandom = Random(2) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "X0_WAXMBT002"; break;
                       case 2: sItem = "en5_battleaxe4"; break;
                   }

        }
        else if (GetRange(6, iItemLevel))   // * 16000 and up
        {
                   int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "X2_WAXMBT003"; break;
                       case 2: sItem = "en5_battleaxe5"; break;
                       case 3: sItem = "X2_WAXMBT005"; break;
                   }

        }

          return sItem;
}


string CreateClub(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_club";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=4; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}


string CreateDagger(object oPC,int iItemLevel=1)
{

string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_dagger";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=4; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateDart(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_dart";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=1; break;
    case 5: iLevelNumber=1; break;
    case 6: iLevelNumber=1; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateDireMace(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_dmace";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateDoubleAxe(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_daxe";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=4; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateGreatAxe(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_gaxe";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=5; break;
    case 3: iLevelNumber=4; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateGreatSword(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_gsword";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=5; break;
    case 3: iLevelNumber=4; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateHalberd(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_halberd";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=5; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateHandAxe(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_haxe";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateHeavyCrossbow(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_hxbow";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=1; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);


return sItem;
}

string CreateHeavyFlail(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_hflail";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=4; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateKama(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_kama";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=4; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateKatana(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_katana";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=4; break;
    case 5: iLevelNumber=4; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateKukri(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_kukri";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=4; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateLightCrossbow(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_lxbow";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateLightFlail(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_lflail";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateLightHammer(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_lhammer";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=4; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateLightMace(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_mace";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=4; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=5; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateLongSword(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_lsword";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=5; break;
    case 4: iLevelNumber=4; break;
    case 5: iLevelNumber=4; break;
    case 6: iLevelNumber=4; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateLongbow(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_lbow";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=4; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=4; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateMorningstar(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_mstar";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateRapier(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_rapier";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateScimitar(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_scimitar";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=4; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=4; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateScythe(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_scythe";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=4; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateShortsword(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_ssword";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=4; break;
    case 3: iLevelNumber=4; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=5; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateShortbow(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_sbow";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=5; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=4; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateShuriken(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_shuriken";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=4; break;
    case 3: iLevelNumber=1; break;
    case 4: iLevelNumber=1; break;
    case 5: iLevelNumber=1; break;
    case 6: iLevelNumber=1; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateSickle(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_sickle";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=4; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateSling(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_sling";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=1; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=1; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateSpear(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_spear";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=3; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateStaff(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_staff";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=5; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateThrowingAxe(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_taxe";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=1; break;
    case 3: iLevelNumber=4; break;
    case 4: iLevelNumber=1; break;
    case 5: iLevelNumber=2; break;
    case 6: iLevelNumber=1; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}


string CreateTwoBladedSword(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_tbsword";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=4; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=4; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateDwarvenWaraxe(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_dwaxe";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=2; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=3; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateWarhammer(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_whammer";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=3; break;
    case 2: iLevelNumber=3; break;
    case 3: iLevelNumber=2; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=4; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}

string CreateWhip(object oPC,int iItemLevel=1)
{
string sItem;
string sTag;
int iLevelNumber;
int iRandom;

sTag="en5_whip";
iLevelNumber=1;
switch (iItemLevel)
    {
    case 1: iLevelNumber=1; break;
    case 2: iLevelNumber=2; break;
    case 3: iLevelNumber=3; break;
    case 4: iLevelNumber=2; break;
    case 5: iLevelNumber=3; break;
    case 6: iLevelNumber=2; break;
    }

iRandom = Random(iLevelNumber)+1;
sItem = sTag + IntToString(iItemLevel) + "_" + IntToString(iRandom);

return sItem;
}


int Prefers(int nFeatWeaponType, object oAdventurer)
{
    if (GetHasFeat(nFeatWeaponType, oAdventurer) == TRUE)
    return TRUE;
    else
    return FALSE;
}

string GetMagicWeapon(object oCreature, int iItemLevel)
{
int iRandom;
string sTag;
object oPC;

oPC=oCreature;
if (GetObjectType(oCreature) != OBJECT_TYPE_CREATURE)
    oPC = GetRandomPC();
else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL,oCreature) == FALSE && GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE,oCreature) == FALSE && GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC,oCreature) == FALSE && GetHasFeat(FEAT_WEAPON_PROFICIENCY_WIZARD,oCreature) == FALSE && GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE,oCreature) == FALSE && GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK,oCreature) == FALSE && GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID,oCreature) == FALSE)
    oPC = GetRandomPC();
if (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE && !GetIsPC(oCreature))
    if (Random(4)==0)
        oPC = GetRandomPC();

ClearWeaponList(oPC);

if (iItemLevel==1)
    {
    if (Random(20)==0)
        iItemLevel=2;
    }
else if (iItemLevel<6)
    {
    iRandom = Random(20)+1;
    if (iRandom<2)
        iItemLevel=iItemLevel-1;
    else if (iRandom<3)
        iItemLevel=iItemLevel+1;
    }
else if (iItemLevel==6)
    {
    iRandom = Random(10)+1;
    if (iRandom<2)
        iItemLevel=iItemLevel-1;
    }

    if (Prefers(FEAT_WEAPON_FOCUS_UNARMED_STRIKE, oPC) == TRUE)
    {
        sTag=CreateMonkGloves(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
    if (Prefers(FEAT_WEAPON_FOCUS_BASTARD_SWORD, oPC) == TRUE)
    {
        sTag=CreateBastardSword(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_BATTLE_AXE,oPC))
    {
        sTag=CreateBattleAxe(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_DWAXE,oPC))
    {
        sTag=CreateDwarvenWaraxe(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_WHIP,oPC))
    {
        sTag=CreateWhip(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_CLUB,oPC))
    {
        sTag=CreateClub(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_DAGGER,oPC))
    {
        sTag=CreateDagger(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_DART,oPC))
    {
        sTag=CreateDart(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_DIRE_MACE,oPC))
    {
        sTag=CreateDireMace(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_DOUBLE_AXE,oPC))
    {
        sTag=CreateDoubleAxe(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_GREAT_AXE,oPC))
    {
        sTag=CreateGreatAxe(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_GREAT_SWORD,oPC))
    {
        sTag=CreateGreatSword(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_HALBERD,oPC))
    {
        sTag=CreateHalberd(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_HAND_AXE,oPC))
    {
        sTag=CreateHandAxe(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW,oPC))
    {
        sTag=CreateHeavyCrossbow(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_HEAVY_FLAIL,oPC))
    {
        sTag=CreateHeavyFlail(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_KAMA,oPC))
    {
        sTag=CreateKama(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_KATANA,oPC))
    {
        sTag=CreateKatana(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_KUKRI,oPC))
    {
        sTag=CreateKukri(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW,oPC))
    {
        sTag=CreateLightCrossbow(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_LIGHT_FLAIL,oPC))
    {
        sTag=CreateLightFlail(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_LIGHT_HAMMER,oPC))
    {
        sTag=CreateLightHammer(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_LIGHT_MACE,oPC))
    {
        sTag=CreateLightMace(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_LONG_SWORD,oPC))
    {
        sTag=CreateLongSword(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_LONGBOW,oPC))
    {
        sTag=CreateLongbow(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_MORNING_STAR,oPC))
    {
        sTag=CreateMorningstar(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_RAPIER,oPC))
    {
        sTag=CreateRapier(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SCIMITAR,oPC))
    {
        sTag=CreateScimitar(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SCYTHE,oPC))
    {
        sTag=CreateScythe(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SHORT_SWORD,oPC))
    {
        sTag=CreateShortsword(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SHORTBOW,oPC))
    {
        sTag=CreateShortbow(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SHURIKEN,oPC))
    {
        sTag=CreateShuriken(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SICKLE,oPC))
    {
        sTag=CreateSickle(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SLING,oPC))
    {
        sTag=CreateSling(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_SPEAR,oPC))
    {
        sTag=CreateSpear(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_STAFF,oPC))
    {
        sTag=CreateStaff(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_THROWING_AXE,oPC))
    {
        sTag=CreateThrowingAxe(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD,oPC))
    {
        sTag=CreateTwoBladedSword(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }
     if (Prefers(FEAT_WEAPON_FOCUS_WAR_HAMMER,oPC))
    {
        sTag=CreateWarhammer(oPC, iItemLevel);
        MakeWeaponList(oPC,sTag);
    }

sTag = GetWeaponFromList(oPC);

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
			+ GetLevelByClass(CLASS_TYPE_PSION, oPC)
			+ GetLevelByClass(CLASS_TYPE_WILDER, oPC)
			+ GetLevelByClass(CLASS_TYPE_HEALER, oPC)			
			+ GetLevelByClass(CLASS_TYPE_WARLOCK, oPC);	
			
int iRogue	= GetLevelByClass(CLASS_TYPE_ROGUE, oPC)
			+ GetLevelByClass(CLASS_TYPE_SCOUT, oPC)
			+ GetLevelByClass(CLASS_TYPE_NINJA, oPC)
			+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
			+ GetLevelByClass(CLASS_TYPE_BARD, oPC)
			+ GetLevelByClass(CLASS_TYPE_PSYCHIC_ROGUE, oPC);
			
int iDivine	= GetLevelByClass(CLASS_TYPE_CLERIC, oPC) 	
			+ GetLevelByClass(CLASS_TYPE_ARCHIVIST, oPC)
			+ GetLevelByClass(CLASS_TYPE_FAVOURED_SOUL, oPC);	

int iWarrior	= GetLevelByClass(CLASS_TYPE_FIGHTER, oPC)
				+ GetLevelByClass(CLASS_TYPE_CW_SAMURAI, oPC)
				+ GetLevelByClass(CLASS_TYPE_KNIGHT, oPC)
				+ GetLevelByClass(CLASS_TYPE_MARSHAL, oPC)
				+ GetLevelByClass(CLASS_TYPE_SAMURAI, oPC)
				+ GetLevelByClass(CLASS_TYPE_SOULKNIFE, oPC)
				+ GetLevelByClass(CLASS_TYPE_INCARNATE, oPC)
				+ GetLevelByClass(CLASS_TYPE_HEXBLADE, oPC)
				+ GetLevelByClass(CLASS_TYPE_DUSKBLADE, oPC)
				+ GetLevelByClass(CLASS_TYPE_PSYWAR, oPC)				
				+ GetLevelByClass(CLASS_TYPE_SWASHBUCKLER, oPC)
				+ GetLevelByClass(CLASS_TYPE_WARBLADE, oPC)
				+ GetLevelByClass(CLASS_TYPE_PALADIN, oPC)
				+ GetLevelByClass(CLASS_TYPE_RANGER, oPC)
				+ GetLevelByClass(CLASS_TYPE_CRUSADER, oPC)
				+ GetLevelByClass(CLASS_TYPE_SWORDSAGE, oPC);	

int iTribal = GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)
			+ GetLevelByClass(CLASS_TYPE_SHAMAN, oPC)
			+ GetLevelByClass(CLASS_TYPE_TOTEMIST, oPC);
			
int iDruidic	= GetLevelByClass(CLASS_TYPE_DRUID, oPC);				
			
if (sTag == "")
    {
        if (GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        {
            if (Random(3)==0)
                sTag=CreateKama(oPC, iItemLevel);
            else
                sTag=CreateMonkGloves(oPC, iItemLevel);
        }
        else
        if (iDruidic)
        {
            if (Random(2)==0)
                sTag=CreateScimitar(oPC, iItemLevel);
            else
                sTag=CreateClub(oPC, iItemLevel);
        }
        else
        if (iArcane)
        {
			if (Random(3)==0)
                sTag=CreateStaff(oPC, iItemLevel);
            else
                sTag=CreateDagger(oPC, iItemLevel);			
        }
        else
        if (iWarrior >= 1)
        {
            sTag=CreateLongSword(oPC, iItemLevel);
        }
        else
        if (iTribal >= 1)
        {
            if (Random(2)==0)
                sTag=CreateSpear(oPC, iItemLevel);
            else
                sTag=CreateClub(oPC, iItemLevel);
        }
        else
        if (iDivine >= 1)
        {
            sTag=CreateLightMace(oPC, iItemLevel);
        }
        else
        if (iRogue >= 1)
        {
            sTag=CreateShortsword(oPC, iItemLevel);
        }
    }

if (sTag == "")
    sTag = "nw_wswmdg002";

return sTag;
}

//:: void main() {}