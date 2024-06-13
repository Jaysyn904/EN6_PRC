#include "en5_spawnzone"

void GetUndeadTheme2(int iCamp);
void GetPlanarTheme(int iCamp);

void main()
{
int iLevel;
int iHeartbeat;
int iAdventure;
int iRandom;
string sZone;
object oPC;
object oWP;

oPC = GetEnteringObject();
sZone=GetLocalString(OBJECT_SELF,"Zone");
oWP=GetObjectByTag(sZone+"_INFO");

if (GetIsPC(oPC) && GetIsObjectValid(oWP) && GetLocalInt(oWP,"EN5_SpawnZone") == 0)
    {
    SetLocalInt(oWP,"EN5_SpawnZone",1);
    //SpawnAreaCamp(sZone,iLevel,iSpawnType,iCamp,iAdventureZone);

    SetLocalString(GetModule(),"SPAWN_CampType","C");
    SetLocalInt(GetModule(),"MobWander",33);
    SetLocalString(GetModule(),"SPAWN_Zone","CW1");
    SetLocalInt(GetModule(),"SPAWN_Boss",1);

    iRandom=Random(2)+1;
    if (iRandom==1)
        {
        GetUndeadTheme2(1);
        GetUndeadTheme2(2);
        SetLocalInt(GetModule(),"SPAWN_Boss",3);
        GetUndeadTheme2(3);
        } else {
        GetPlanarTheme(1);
        GetPlanarTheme(2);
        SetLocalInt(GetModule(),"SPAWN_Boss",3);
        GetPlanarTheme(3);
        }
    SetLocalInt(GetModule(),"SPAWN_Boss",0);

    SetLocalInt(GetModule(),"MobWander",50);
    SpawnEncounters(oWP,0);
    SetLocalInt(GetModule(),"MobWander",0);
    CreateTraps("CW1",8,11);
    LockDoorsAndChests("CW1",8,11);
    }
}

void GetUndeadTheme2(int iCamp)
{
int iLevel;
int iRandom;

SetLocalInt(GetModule(),"SPAWN_Camp",iCamp);

if (iCamp==1)
    iLevel=Random(2)+8;
else
    iLevel=Random(3)+9;

if (iCamp<3)
    iRandom=Random(3)+1;
else
    iRandom=Random(3)+2;

if (iRandom==1)
    GetShade(iLevel);
if (iRandom==2)
    GetUndead(iLevel);
if (iRandom==3)
    GetNecromancers(iLevel);
if (iRandom==4)
    GetVampire(iLevel);

}

void GetPlanarTheme(int iCamp)
{
int iLevel;
int iRandom;

SetLocalInt(GetModule(),"SPAWN_Camp",iCamp);


if (iCamp==1)
    iLevel=Random(2)+8;
else
    iLevel=Random(3)+9;

if (iCamp<3)
    iRandom=Random(4)+1;
else
    iRandom=Random(4)+2;

if (iRandom==1)
    GetOutsiders(iLevel);
if (iRandom==2)
    GetFeyri(iLevel);
if (iRandom==3)
    GetCultist(iLevel);
if (iRandom==4)
    GetTiefling(iLevel);
if (iRandom==5)
    GetRakasha(iLevel);

}


