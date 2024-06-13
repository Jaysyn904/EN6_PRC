#include "en5_encounters"

void SpawnZone(object oArea);
void SpawnCamps(string sZone, int iSpawnType,int iAdventureZone);
void SpawnAreaCamp(string sZone,int iLevel,int iSpawnType,int iCamp, int iAdventureZone);
void SpawnEncounters(object oArea, int iSpawnType);
void SpawnAreaEncounter(string sZone,int iLevel,int iSpawnType,int iEncounter, string sType="S");
void CreateChest(string sZone,int iCamp,int iLevel);
void LockDoorsAndChests(string sZone,int iMinLevel,int iMaxLevel);
void CreateTraps(string sZone,int iMinLevel,int iMaxLevel);
void ZoneSpecial(string sZone);
location GetRandomLoc(object oLoc, int iDir);
object SpawnAtCamp(object oWP,string sTag, int iDir=0,int iLevel=0,int iClass=0);
object SpawnSpecial(string sZone,string sTag,int iSpot, int iLevel=0,int iClass=0);
void ExecuteSpawnAtCamp(object oWP,string sTag, int iDir=0,int iLevel=0,int iClass=0);
void GetGypsies(string sZone);
void GetZoneBandits(string sZone,int iSpot=0);
void GetEvilParty(string sZone,int iSpot=0);
void GetEvilRaiders(string sZone,int iSpot=0);
void GetGoodParty(string sZone,int iSpot=0);
void GetGuards(string sZone,int iSpot=1);
void GetChampion(string sZone,int iSpot=0);
object GetSpecialSpot(string sZone,int iSpecialSpot=0);
int GetSpecialRandomLevel(string sZone);
int GetSpecialRandomClass(int iEvil=0);

void SpawnZone(object oArea)
{
string sZone;
object oWP;
int iSpawnType;
int iCampType;
int iAdventure;
int iMinLevel;
int iMaxLevel;

sZone = GetLocalString(oArea,"Zone");

iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

oWP=GetObjectByTag(sZone+"_INFO");
iAdventure=GetLocalInt(oWP,"AdventureZone");


if (iAdventure==1)
    SetLocalInt(OBJECT_SELF,"EN5_RespawnChance",80);
else
    SetLocalInt(OBJECT_SELF,"EN5_RespawnChance",100);

iCampType = GetLocalInt(oWP,"CampType");
iSpawnType = GetLocalInt(oWP,"SpawnType");

SetLocalString(GetModule(),"SPAWN_CampType","C");
SetLocalInt(GetModule(),"MobWander",25);
SpawnCamps(sZone,iCampType,iAdventure);
SetLocalInt(GetModule(),"MobWander",75);

SetLocalInt(OBJECT_SELF,"EN5_RespawnChance",50);

SpawnEncounters(oArea,iSpawnType);
SetLocalInt(GetModule(),"MobWander",0);

CreateTraps(sZone,iMinLevel,iMaxLevel);
LockDoorsAndChests(sZone,iMinLevel,iMaxLevel);

SetLocalInt(OBJECT_SELF,"EN5_RespawnChance",100);
}

void SpawnCamps(string sZone, int iSpawnType,int iAdventureZone)
{
string sCampTest;
int iCamp;
int iMinLevel;
int iMaxLevel;
int iLevel;
object oCamp;

iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

iCamp=1;
sCampTest = sZone + "_C" + IntToString(iCamp) + "_1";
oCamp = GetObjectByTag(sCampTest);
while (GetIsObjectValid(oCamp))
    {
    if (Random(100)<GetLocalInt(OBJECT_SELF,"EN5_RespawnChance") && GetLocalInt(oCamp,"Quest")==0)
        {
        if (GetLocalInt(GetModule(),sZone+"_SpawnMin") == 0)
            {
            iLevel=iMinLevel;
            SetLocalInt(GetModule(),sZone+"_SpawnMin",1);
            } else {
            iLevel=Random(iMaxLevel-iMinLevel+1)+iMinLevel;
            }
        if (!GetIsObjectValid(GetObjectByTag(sCampTest + "_S")))
            SpawnAreaCamp(sZone,iLevel,iSpawnType,iCamp,iAdventureZone);
        }
    iCamp++;
    sCampTest = sZone + "_C" + IntToString(iCamp) + "_1";
    oCamp = GetObjectByTag(sCampTest);
    }
}

void SpawnAreaCamp(string sZone,int iLevel,int iSpawnType,int iCamp, int iAdventureZone)
{
string sTag;
int iBoss;
int iRandom;
int iRacialType;
object oBoss;

if (iAdventureZone<2)
    {
    iRandom = Random(100)+1;
    if (iRandom < 4)
        iBoss = 3;
    else if (iRandom < 51)
        iBoss = 1;
    else
        iBoss = 0;
    }
else if (iAdventureZone==2)
    {
    iRandom = Random(100)+1;
    if (iRandom<8)
        iBoss=3;
    else
        iBoss=1;
    }
else
    {
    iRandom = Random(100)+1;
    if (iRandom<5)
        iBoss=3;
    else if (iRandom<50)
        iBoss=1;
    else
        iBoss=0;
    }

sTag=sZone + "_C" + IntToString(iCamp) + "_1";
if (GetLocalInt(GetObjectByTag(sTag),"Boss")>0)
    iBoss=GetLocalInt(GetObjectByTag(sTag),"Boss");

oBoss = SpawnCamp(sZone,iLevel,iSpawnType,iCamp,iBoss);


if (GetLocalInt(oBoss,"iBoss")>0 && iAdventureZone <2)
    {
    SetLocalInt(oBoss,"BonusXP",1);
    if (GetLocalInt(GetObjectByTag(sTag),"SpawnChestOnce") == 0)
        CreateChest(sZone,iCamp,iLevel);
    SetLocalInt(GetObjectByTag(sTag),"SpawnChestOnce",1);
    }
if (GetLocalInt(oBoss,"iBoss")>0 && iAdventureZone > 1)
    {
    SetLocalInt(oBoss,"BonusXP",1);
    }

}

void SpawnEncounters(object oArea, int iSpawnType)
{
string sEncounterTest;
string sZone;
int iEncounter;
int iMinLevel;
int iMaxLevel;
int iIndoorsOutdoors;
int iLevel;
object oEncounter;

sZone = GetLocalString(oArea,"Zone");

iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

iIndoorsOutdoors=1;
if (GetIsAreaAboveGround(oArea) && !(GetIsAreaInterior(oArea)))
    iIndoorsOutdoors=0;

SetupEncounters(iSpawnType,iMinLevel,iMaxLevel,iIndoorsOutdoors);

iEncounter = 1;
sEncounterTest = sZone + "_S_" + IntToString(iEncounter);
oEncounter = GetObjectByTag(sEncounterTest);

while (GetIsObjectValid(oEncounter))
    {

    if (Random(100)<GetLocalInt(OBJECT_SELF,"EN5_RespawnChance") && GetLocalInt(oEncounter,"Quest")==0)
        {
        if (GetLocalInt(GetModule(),sZone+"_SpawnMin_SS") == 0)
            {
            iLevel=iMinLevel;
            SetLocalInt(GetModule(),sZone+"_SpawnMin_SS",1);
            } else {
            iLevel=Random(iMaxLevel-iMinLevel+1)+iMinLevel;
            }
        SpawnAreaEncounter(sZone,iLevel,iSpawnType,iEncounter);
        }
    iEncounter++;
    sEncounterTest = sZone + "_S_" + IntToString(iEncounter);
    oEncounter = GetObjectByTag(sEncounterTest);
    }

iEncounter = 1;
sEncounterTest = sZone + "_F_" + IntToString(iEncounter);
oEncounter = GetObjectByTag(sEncounterTest);

while (GetIsObjectValid(oEncounter))
    {

    if (Random(5)==0)
        {
        iLevel=Random(iMaxLevel-iMinLevel+1)+iMinLevel;
        SpawnAreaEncounter(sZone,iLevel,iSpawnType,iEncounter,"F");
        }
    iEncounter++;
    sEncounterTest = sZone + "_F_" + IntToString(iEncounter);
    oEncounter = GetObjectByTag(sEncounterTest);
    }
}

void SpawnAreaEncounter(string sZone,int iLevel,int iSpawnType,int iEncounter, string sType="S")
{
object oMob;
string sTag;
string sEncounter;
int iRandom;
int iRacialType;

SetLocalString(GetModule(),"SPAWN_Zone",sZone);
SetLocalInt(GetModule(),"SPAWN_Encounter",iEncounter);

sEncounter = sZone + "_" + sType + "_" + IntToString(iEncounter);
sTag = GetRandomMob();

if (iSpawnType == 2 && Random(4)==0)
    {
    if (Random(2)==0)
        sTag ="en5_WOLFWINT";
    else
        sTag ="en5_pbear";
    }

if (Random(10)>0)
    oMob = GetMob(sTag,sEncounter);
else
    oMob=GetSingleSpawnMob(sEncounter,0,iLevel);

}

void CreateTraps(string sZone,int iMinLevel,int iMaxLevel)
{
int iTrap;
int iLevel;
int iChance;
string sTrapTest;
object oTrap;
location lLoc;

iChance=15;
if (HasRogue())
    iChance=10;
iTrap=1;
sTrapTest = sZone + "_Trap" + IntToString(iTrap);
oTrap = GetObjectByTag(sTrapTest);
while (GetIsObjectValid(oTrap))
    {
    iLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;
    lLoc=GetLocation(oTrap);
    if (GetLocalInt(oTrap,"DoOnce") == 0 && Random(iChance)==0)
        CreateTrapAtLocation(GetTrapType(iLevel),lLoc,2.0f,"",STANDARD_FACTION_HOSTILE,"en6_trap_disarm");
    SetLocalInt(oTrap,"DoOnce",1);
    iTrap++;
    sTrapTest = sZone + "_Trap" + IntToString(iTrap);
    oTrap = GetObjectByTag(sTrapTest);
    }
}

void LockDoorsAndChests(string sZone,int iMinLevel,int iMaxLevel)
{
int iDoor;
int iLevel;
int iChance;
string sDoorTest;
object oDoor;

iChance=15;
if (HasRogue())
    iChance=10;
iDoor=1;
sDoorTest = sZone + "_Door" + IntToString(iDoor);
oDoor = GetObjectByTag(sDoorTest);
while (GetIsObjectValid(oDoor))
    {
    iLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;
    if (GetLocalInt(oDoor,"DoOnce") == 0)
        {
        if (Random(iChance)==0)
            {
            SetLockUnlockDC(oDoor,3+iLevel+Random(3));
            SetLocked(oDoor,TRUE);
            }
        if (Random(iChance)==0)
            CreateTrapOnObject(GetTrapType(iLevel),oDoor,STANDARD_FACTION_HOSTILE,"en6_trap_disarm");
        }
    SetLocalInt(oDoor,"DoOnce",1);
    iDoor++;
    sDoorTest = sZone + "_Door" + IntToString(iDoor);
    oDoor = GetObjectByTag(sDoorTest);
    }

iDoor=1;
sDoorTest = sZone + "_Chest" + IntToString(iDoor);
oDoor = GetObjectByTag(sDoorTest);
while (GetIsObjectValid(oDoor))
    {
    iLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;
    if (GetLocalInt(oDoor,"DoOnce") == 0)
        {
        if (Random(10)==0)
            {
            SetLockUnlockDC(oDoor,3+iLevel+Random(3));
            SetLocked(oDoor,TRUE);
            }
        if (Random(10)==0)
            CreateTrapOnObject(GetTrapType(iLevel),oDoor,STANDARD_FACTION_HOSTILE,"en6_trap_disarm");
        }
    SetLocalInt(oDoor,"DoOnce",1);
    iDoor++;
    sDoorTest = sZone + "_Chest" + IntToString(iDoor);
    oDoor = GetObjectByTag(sDoorTest);
    }
}

void CreateChest(string sZone,int iCamp,int iLevel)
{
string sChest;
object oChest;
location lLoc;
object oTest;
string sTag;

sTag=sZone + "_C" + IntToString(iCamp) + "_Treasure";
oTest=GetObjectByTag(sTag);
lLoc=GetLocation(oTest);
sChest="en_c_treasure" + IntToString(Random(6)+1);
oChest = CreateObject(OBJECT_TYPE_PLACEABLE,sChest,lLoc);
SetLocalInt(oChest,"Level",iLevel);
if (GetIsObjectValid(oChest))
    {
    if (Random(10)==0 && GetName(oChest) != "Barrel")
        {
        SetLockUnlockDC(oChest,3+iLevel+Random(3));
        SetLocked(oChest,TRUE);
        }

    if (Random(10)==0)
        {
        CreateTrapOnObject(GetTrapType(iLevel),oChest,STANDARD_FACTION_HOSTILE,"en6_trap_disarm");
        }

    }
}

int GetSpecialRandomClass(int iEvil=0)
{
int iRandom;
int iRandom2;
int iClass;

iRandom=Random(8);
if (iRandom<1)
    {
    if (Random(2)==0)
        iClass=EN5_CLASS_WIZARD;
    else
        iClass=EN5_CLASS_SORCERER;
    if (iEvil==1 && Random(4)==0)
        iClass=EN5_CLASS_PALEMASTER;
    }
else if (iRandom<3)
    {
    iRandom2=Random(6);
    if (iRandom2==0)
        iClass=EN5_CLASS_BARD;
    else if (iRandom2==1)
        if (iEvil==0)
            iClass=EN5_CLASS_DRAGON_DISCIPLE;
        else
            iClass=EN5_CLASS_ASSASSIN;
    else if (iRandom2==2)
        iClass=EN5_CLASS_SHADOWDANCER;
    else
        iClass=EN5_CLASS_ROGUE;
    }
else if (iRandom<5)
    iClass=EN5_CLASS_CLERIC;
else
    iRandom2=Random(8);
    if (iRandom2<1)
        iClass=EN5_CLASS_BARBARIAN;
    else if (iRandom2<2)
        iClass=EN5_CLASS_RANGER;
    else if (iRandom2<3)
        iClass=EN5_CLASS_MONK;
    else if (iRandom2<4)
        iClass=EN5_CLASS_WEAPON_MASTER;
    else if (iRandom2<5)
        if (iEvil==0)
            iClass=EN5_CLASS_PALADIN;
        else
            iClass=EN5_CLASS_BLACKGUARD;
    else
        iClass=EN5_CLASS_FIGHTER;

return iClass;
}

int GetSpecialRandomLevel(string sZone)
{
int iLevel;
int iSpecialLevel;
int iSpecialNumber;

iLevel=GetMinLevel(sZone);

if (iLevel<2)
    {
    iSpecialLevel=1;
    iSpecialNumber=1;
    }
else if (iLevel<5)
    {
    iSpecialLevel=iLevel-2;
    iSpecialNumber=2;
    }
else if (iLevel<10)
    {
    iSpecialLevel=iLevel-3;
    iSpecialNumber=3;
    }
else
    {
    iSpecialLevel=iLevel-5;
    iSpecialNumber=3;
    }
if (iSpecialLevel<1)
    iSpecialLevel=1;

if (iSpecialLevel>8 && iSpecialLevel<16)
    iSpecialLevel=iSpecialLevel + Random(2);
if (iSpecialLevel>15)
    iSpecialLevel=iSpecialLevel + Random(3);

SetLocalInt(GetModule(),"TEMP_SpecialNumber",iSpecialNumber);

return iSpecialLevel;
}

void ZoneSpecial(string sZone)
{
int iRandom;

if (Random(6)==0)
    {
    iRandom=Random(14);
    if (iRandom<1)
        {
        if (GetLocalInt(GetModule(),"Gypsies") == 0)
            {
            GetGypsies(sZone);
            SetLocalInt(GetModule(),"Gypsies",1);
            } else {
            GetZoneBandits(sZone);
            }
        }
    else if (iRandom<2)
        GetZoneBandits(sZone);
    else if (iRandom<3)
        GetEvilParty(sZone);
    else if (iRandom<4)
        GetEvilRaiders(sZone);
    else if (iRandom<5)
        GetGoodParty(sZone);
    else if (iRandom<6)
        GetGuards(sZone,1);
    else if (iRandom<7)
        GetEvilParty(sZone,1);
    else if (iRandom<8)
        GetZoneBandits(sZone,1);
    else if (iRandom<9)
        GetEvilRaiders(sZone,1);
    else if (iRandom<10)
        GetGoodParty(sZone,1);
    else if (iRandom<11)
        GetChampion(sZone,1);
    else if (iRandom<12)
        GetGoodParty(sZone,2);
    else if (iRandom<13)
        GetGuards(sZone,2);
    else
        {
        if (Random(2)==0)
            GetEvilParty(sZone,1);
        else
            GetEvilRaiders(sZone,1);
        }
    }
}

void GetGypsies(string sZone)
{
object oWP;
object oMob;
location lLoc;

oWP=GetSpecialSpot(sZone,0);
lLoc=GetLocation(oWP);
CreateObject(OBJECT_TYPE_PLACEABLE,"en6_campfire",lLoc);
DelayCommand(0.1,ExecuteSpawnAtCamp(oWP,"en6_gypsy1", 1));
DelayCommand(0.1,ExecuteSpawnAtCamp(oWP,"en6_gypsy2", 2));
DelayCommand(0.1,ExecuteSpawnAtCamp(oWP,"en6_gypsy3", 3));

}

void GetZoneBandits(string sZone,int iSpot=0)
{
object oWP;
object oMob;
location lLoc;
int iLevel;
int iClass;
int iBandits;
int iBanditLevel;
int iIndex;
int iRandom;
string sTag;

oWP=GetSpecialSpot(sZone,iSpot);
lLoc=GetLocation(oWP);

if (iSpot==0)
    CreateObject(OBJECT_TYPE_PLACEABLE,"en6_campfire",lLoc);

iBanditLevel=GetSpecialRandomLevel(sZone);
iBandits=GetLocalInt(GetModule(),"TEMP_SpecialNumber");

iIndex=1;

while (iIndex<=iBandits)
    {
    iIndex++;

    iRandom=Random(12);
    if (iRandom==1)
        iClass=EN5_CLASS_WIZARD;
    else if (iRandom==2)
        iClass=EN5_CLASS_BARD;
    else if (iRandom<5)
        iClass=EN5_CLASS_CLERIC;
    else if (iRandom<8)
        iClass=EN5_CLASS_ASSASSIN;
    else
        iClass=EN5_CLASS_FIGHTER;

    if (iLevel<13)
        {
        if (Random(6)>0)
            sTag="en5_bandit2";
        else
            sTag="en5_bandit";
        }
    else
        {
        iRandom=Random(7);
        if (iRandom==0)
            sTag="en5_merc2";
        else if (iRandom==0)
            {
            sTag="en5_merc4";
            if (iClass==EN5_CLASS_WIZARD || iClass==EN5_CLASS_BARD)
                iClass=EN5_CLASS_BARBARIAN;
            }
        else if (iRandom==0)
            {
            sTag="en5_merc3";
            iClass=EN5_CLASS_BARBARIAN;
            }
        else
            sTag="en5_merc2";
        }
    if (iSpot==0)
        SpawnAtCamp(oWP,sTag,iIndex,iBanditLevel,iClass);
    else
        SpawnSpecial(sZone,sTag,iSpot,iBanditLevel,iClass);
    }

}

void GetEvilParty(string sZone,int iSpot=0)
{
object oWP;
object oMob;
location lLoc;
int iLevel;
int iClass;
int iNPCLevel;
int iNPCs;
int iIndex;
int iRandom;
string sTag;

oWP=GetSpecialSpot(sZone,iSpot);
lLoc=GetLocation(oWP);
if (iSpot==0)
    CreateObject(OBJECT_TYPE_PLACEABLE,"en6_campfire",lLoc);


iNPCLevel=GetSpecialRandomLevel(sZone);
iNPCs=GetLocalInt(GetModule(),"TEMP_SpecialNumber");

iIndex=1;

while (iIndex<=iNPCs)
    {
    iIndex++;

    iClass=GetSpecialRandomClass(1);
    iRandom=Random(8);
    if (iRandom<1)
        sTag="en5_horc_e";
    else if (iRandom<2)
        sTag="en5_halfling_e";
    else if (iRandom<3)
        sTag="en5_dwarf_e";
    else if (iRandom<4)
        sTag="en5_drow_e";
    else
        sTag="en5_human_e";

    if (sTag=="en5_horc_e")
        if (iClass==EN5_CLASS_SORCERER || iClass==EN5_CLASS_WIZARD || iClass == EN5_CLASS_PALEMASTER ||
            iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
                iClass=EN5_CLASS_BARBARIAN;
    if (sTag=="en5_dwarf_e")
        if (iClass == EN5_CLASS_PALEMASTER || iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
                iClass=EN5_CLASS_BARBARIAN;

    if (iSpot==0)
        SpawnAtCamp(oWP,sTag,iIndex,iNPCLevel,iClass);
    else
        SpawnSpecial(sZone,sTag,iSpot,iNPCLevel,iClass);

    }

}

void GetEvilRaiders(string sZone,int iSpot=0)
{
object oWP;
object oMob;
location lLoc;
int iLevel;
int iClass;
int iNPCLevel;
int iNPCs;
int iIndex;
int iRandom;
string sTag;

oWP=GetSpecialSpot(sZone,iSpot);
lLoc=GetLocation(oWP);
if (iSpot==0)
    CreateObject(OBJECT_TYPE_PLACEABLE,"en6_campfire",lLoc);


iNPCLevel=GetSpecialRandomLevel(sZone);
iNPCs=GetLocalInt(GetModule(),"TEMP_SpecialNumber");

iRandom=Random(8);
if (iRandom<2)
    sTag="en5_horc_e";
else if (iRandom<3)
    sTag="en5_dwarf_e";
else if (iRandom<4)
    sTag="en5_drow_e";
else
    sTag="en5_human_e";

iIndex=1;
while (iIndex<=iNPCs)
    {
    iIndex++;

    iClass=GetSpecialRandomClass(1);

    if (sTag=="en5_horc_e")
        if (iClass==EN5_CLASS_SORCERER || iClass==EN5_CLASS_WIZARD || iClass == EN5_CLASS_PALEMASTER ||
            iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
                iClass=EN5_CLASS_BARBARIAN;
    if (sTag=="en5_dwarf_e")
        if (iClass == EN5_CLASS_PALEMASTER || iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
                iClass=EN5_CLASS_BARBARIAN;

    if (iSpot==0)
        oMob=SpawnAtCamp(oWP,sTag,iIndex,iNPCLevel,iClass);
    else
        oMob=SpawnSpecial(sZone,sTag,iSpot,iNPCLevel,iClass);

    SetName(oMob,GetName(oMob) + " Raider");
    }

}

void GetChampion(string sZone,int iSpot=0)
{
object oWP;
object oMob;
location lLoc;
int iLevel;
int iClass;
int iNPCLevel;
int iNPCs;
int iIndex;
int iRandom;
int iRace;
int iFirst;
int iLast;
int iRandom2;
string sTag;
string sFirst;
string sLast;
string sFull;

oWP=GetSpecialSpot(sZone,iSpot);
lLoc=GetLocation(oWP);

iNPCLevel=GetMaxLevel(sZone);

iRandom=Random(8);
if (iRandom<1)
    sTag="en5_human_g";
if (iRandom<2)
    sTag="en5_horc_e";
else if (iRandom<3)
    sTag="en5_dwarf_e";
else if (iRandom<4)
    sTag="en5_drow_e";
else
    sTag="en5_human_e";


iClass=GetSpecialRandomClass(1);

if (sTag=="en5_human_g")
    if (Random(2)==0)
        iClass=EN5_CLASS_DIVINECHAMPION;
    else
        iClass=EN5_CLASS_PALADIN;
if (sTag=="en5_horc_e")
    if (iClass==EN5_CLASS_SORCERER || iClass==EN5_CLASS_WIZARD || iClass == EN5_CLASS_PALEMASTER ||
        iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
            iClass=EN5_CLASS_BARBARIAN;
if (sTag=="en5_dwarf_e")
    if (iClass == EN5_CLASS_PALEMASTER || iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
            iClass=EN5_CLASS_BARBARIAN;

if (iClass==EN5_CLASS_FIGHTER && Random(2)==0)
    iClass=EN5_CLASS_WEAPON_MASTER;

if (iSpot==0)
    oMob=SpawnAtCamp(oWP,sTag,iIndex,iNPCLevel,iClass);
else
    oMob=SpawnSpecial(sZone,sTag,iSpot,iNPCLevel,iClass);

iRace=GetRacialType(oMob);
switch (iRace)
    {
    case RACIAL_TYPE_DWARF: iFirst=NAME_FIRST_DWARF_MALE; iLast=NAME_LAST_DWARF; break;
    case RACIAL_TYPE_ELF: iFirst=NAME_FIRST_ELF_MALE; iLast=NAME_LAST_ELF; break;
    case RACIAL_TYPE_GNOME: iFirst=NAME_FIRST_GNOME_MALE; iLast=NAME_LAST_GNOME; break;
    case RACIAL_TYPE_HALFLING: iFirst=NAME_FIRST_HALFLING_MALE; iLast=NAME_LAST_HALFLING; break;
    case RACIAL_TYPE_HUMAN: iFirst=NAME_FIRST_HUMAN_MALE; iLast=NAME_LAST_HUMAN; break;
    case RACIAL_TYPE_HALFORC: iFirst=NAME_FIRST_HALFORC_MALE; iLast=NAME_LAST_HALFORC; break;
    }

sFirst=RandomName(iFirst);
sLast=RandomName(iLast);
sFull=sFirst + " " + sLast;

if (Random(2)==0)
    if (sTag=="en5_human_g")
        {
        iRandom2=Random(3)+1;
        if (iRandom2==1)
            sFull="Lord " + sLast;
        else if (iRandom2==2)
            sFull=sFirst + " the Bold";
        else
            sFull=sFirst + " the Daring";
        } else {
        iRandom2=Random(5)+1;
        if (iRandom2==1)
            sFull="Dreadlord " + sLast;
        else if (iRandom2==2)
            sFull=sFirst + " the Mighty";
        else if (iRandom2==3)
            sFull=sFirst + " the Devious";
        else if (iRandom2==4)
            sFull=sFirst + " the Corrupt";
        else
            sFull=sFirst + " the Conqueror";
        }

SetName(oMob,sFull);

ExecuteScript("en6_champ",oMob);

}

void GetGoodParty(string sZone,int iSpot=0)
{
object oWP;
object oMob;
location lLoc;
int iLevel;
int iClass;
int iNPCLevel;
int iNPCs;
int iIndex;
int iRandom;
string sTag;

oWP=GetSpecialSpot(sZone,iSpot);
lLoc=GetLocation(oWP);
if (iSpot==0)
    CreateObject(OBJECT_TYPE_PLACEABLE,"en6_campfire",lLoc);


iNPCLevel=GetSpecialRandomLevel(sZone);
iNPCs=GetLocalInt(GetModule(),"TEMP_SpecialNumber");

iIndex=1;

while (iIndex<=iNPCs)
    {
    iIndex++;

    iClass=GetSpecialRandomClass(0);
    iRandom=Random(8);
    if (iRandom<1)
        sTag="en5_gnome_g";
    else if (iRandom<2)
        sTag="en5_halfling_g";
    else if (iRandom<3)
        sTag="en5_dwarf_g";
    else if (iRandom<4)
        sTag="en5_elf_g";
    else
        sTag="en5_human_g";

    if (sTag=="en5_gnome_g")
        if (iClass==EN5_CLASS_ROGUE || iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
                iClass=EN5_CLASS_WIZARD;
    if (sTag=="en5_dwarf_g")
        if (iClass == EN5_CLASS_PALEMASTER || iClass==EN5_CLASS_SHADOWDANCER || iClass==EN5_CLASS_DRAGON_DISCIPLE || iClass==EN5_CLASS_BARD)
                iClass=EN5_CLASS_BARBARIAN;

    if (iSpot==0)
        SpawnAtCamp(oWP,sTag,iIndex,iNPCLevel,iClass);
    else
        SpawnSpecial(sZone,sTag,iSpot,iNPCLevel,iClass);
    }

}

void GetGuards(string sZone, int iSpot)
{
int iNPCLevel;
object oMob;

iNPCLevel=GetMinLevel(sZone);

if (iNPCLevel>20)
    {
    iNPCLevel=iNPCLevel-5;
    if (iNPCLevel<20)
        iNPCLevel=20;
    }
else if (iNPCLevel>10)
    {
    iNPCLevel=iNPCLevel-2;
    if (iNPCLevel<10)
        iNPCLevel=10;
    }

oMob=SpawnSpecial(sZone,"en6_guard",iSpot,iNPCLevel,EN5_CLASS_FIGHTER);
if (iNPCLevel<7)
    SetName(oMob,"Village Guard");
oMob=SpawnSpecial(sZone,"en6_guard",iSpot,iNPCLevel,EN5_CLASS_FIGHTER);
if (iNPCLevel<7)
    SetName(oMob,"Village Guard");

}

object GetSpecialSpot(string sZone,int iSpecialSpot=0)
{
int iSpot;
int iSpots;
object oWP;

if (iSpecialSpot==0)
    {
    iSpots=MaxObject(sZone + "_X_");
    iSpot=Random(iSpots)+1;
    iSpot=1;
    oWP=GetObjectByTag(sZone + "_X_" + IntToString(iSpot));
    }
else if (iSpecialSpot==1)
    oWP=GetObjectByTag(sZone + "_W");
else if (iSpecialSpot==2)
    oWP=GetObjectByTag(sZone + "_Town");
else
    oWP=GetObjectByTag(sZone + "_W");

return oWP;
}

void ExecuteSpawnAtCamp(object oWP,string sTag, int iDir=0,int iLevel=0,int iClass=0)
{
SpawnAtCamp(oWP,sTag,iDir,iLevel,iClass);
}

object SpawnAtCamp(object oWP,string sTag, int iDir=0,int iLevel=0,int iClass=0)
{
location lLoc;
object oMob;

lLoc=GetRandomLoc(oWP,iDir);
oMob=CreateObject(OBJECT_TYPE_CREATURE,sTag,lLoc);
if (iLevel>0)
    {
    LevelMob(oMob,iLevel,iClass);
    EquipMob(oMob);
    GetTreasureOnMob(oMob,iLevel,0);
    }
TurnToFaceObject(oMob,oWP);
return oMob;
}

object SpawnSpecial(string sZone,string sTag,int iSpot, int iLevel=0,int iClass=0)
{
location lLoc;
object oMob;
string sLocTag;

if (iSpot==1)
    sLocTag=sZone + "_W";
else
    sLocTag=sZone + "_Town";

lLoc=GetLocation(GetObjectByTag(sLocTag));

oMob=CreateObject(OBJECT_TYPE_CREATURE,sTag,lLoc,FALSE,sLocTag + "_S");
if (iLevel>0)
    {
    LevelMob(oMob,iLevel,iClass);
    AssignCommand(oMob,ClearAllActions());
    EquipMob(oMob);
    GetTreasureOnMob(oMob,iLevel,0);
    }
if (iSpot==2)
    {
    AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS));
    AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS));
    }
return oMob;
}


location GetRandomLoc(object oLoc, int iDir)
{
vector vPC;
int iRndX;
int iRndY;
vector vNew;
location lLoc;

vPC = GetPosition(oLoc);

if (iDir==0 || iDir>4)
    {
    iRndX = Random(4) + 4;
    iRndY = Random(4) + 4;
    if (Random(2) == 1) iRndX=iRndX * -1;
    if (Random(2) == 1) iRndY=iRndY * -1;
    vNew = vPC + Vector( iRndX/1.0, iRndY/1.0, 0.0 );
    lLoc = Location(GetArea(oLoc), vNew, VectorToAngle( -1.0 * vNew ) );
    }
if (iDir==1)
    {
    vNew = vPC + Vector( 2.0, 0.0, 0.0 );
    lLoc = Location(GetArea(oLoc), vNew, VectorToAngle( -1.0 * vNew ) );
    }
if (iDir==2)
    {
    vNew = vPC + Vector( - 2.0, 0.0, 0.0 );
    lLoc = Location(GetArea(oLoc), vNew, VectorToAngle( -1.0 * vNew ) );
    }
if (iDir==3)
    {
    vNew = vPC + Vector( 0.0, 2.0, 0.0 );
    lLoc = Location(GetArea(oLoc), vNew, VectorToAngle( -1.0 * vNew ) );
    }
if (iDir==4)
    {
    vNew = vPC + Vector( 0.0, -2.0, 0.0 );
    lLoc = Location(GetArea(oLoc), vNew, VectorToAngle( -1.0 * vNew ) );
    }

return lLoc;
}


