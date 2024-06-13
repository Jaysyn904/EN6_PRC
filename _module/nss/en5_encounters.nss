#include "en5_monsters"
#include "en5_singlespawns"

object SpawnCamp(string sZone,int iLevel,int iSpawnType,int iCamp, int iBoss=0);
object GetSingleSpawnMob(string sCamp,int iCamp,int iLevel);
int GetQuestRepeatCamp(int iLevel);
object SpawnOutside(int iLevel);
object SpawnInside(int iLevel);
object GetQuestCamp(int iCamp,int iLevel,int iDisplay=0);
object GetRandomQuestCamp(int iQuestLevel);
object GetThemeQuestMobs(int iLevel);
int GetTotalCamps();
int GetMobTheme(int iTheme,int iLevel=1);

int GetTotalCamps()
{
int iResult;

iResult=44;

return iResult;
}

object GetQuestCamp(int iCamp,int iLevel,int iDisplay=0)
{
object oBoss;
string sCamp;

switch (iCamp)
    {
    case 0: if (iDisplay==0) oBoss = GetRandomQuestCamp(iLevel); else sCamp="Random"; break;
    case 1: if (iDisplay==0) oBoss = GetThemeQuestMobs(iLevel); else sCamp="Theme"; break;
    case 2: if (iDisplay==0) oBoss = GetGoblins(iLevel); else sCamp="Goblins"; break;
    case 3: if (iDisplay==0) oBoss = GetOrcs(iLevel); else  sCamp="Orcs"; break;
    case 4: if (iDisplay==0) oBoss = GetBugBear(iLevel); else sCamp="Bugbears"; break;
    case 5: if (iDisplay==0) oBoss = GetLizardfolk(iLevel); else sCamp="Lizardfolk"; break;
    case 6: if (iDisplay==0) oBoss = GetMonstrous(iLevel); else sCamp="Monstrous"; break;
    case 7: if (iDisplay==0) oBoss = GetUndead(iLevel); else sCamp="Undead"; break;
    case 8: if (iDisplay==0) oBoss = GetCultist(iLevel); else sCamp="Cultist"; break;
    case 9: if (iDisplay==0) oBoss = GetNecromancers(iLevel); else sCamp="Necromancers"; break;
    case 10: if (iDisplay==0) oBoss = GetConjurers(iLevel); else sCamp="Conjuerers"; break;
    case 11: if (iDisplay==0) oBoss = GetMercenaries(iLevel); else sCamp="Mercenaries"; break;
    case 12: if (iDisplay==0) oBoss = GetAssassins(iLevel); else sCamp="Assassins"; break;
    case 13: if (iDisplay==0) oBoss = GetDrow(iLevel); else sCamp="Drow"; break;
    case 14: if (iDisplay==0) oBoss = GetGolems(iLevel); else sCamp="Golems"; break;
    case 15: if (iDisplay==0) oBoss = GetTiefling(iLevel); else sCamp="Tieflings"; break;
    case 16: if (iDisplay==0) oBoss = GetShade(iLevel); else sCamp="Shade"; break;
    case 17: if (iDisplay==0) oBoss = GetGiants(iLevel); else sCamp="Giants"; break;
    case 18: if (iDisplay==0) oBoss = GetFeyri(iLevel); else sCamp="Feyri"; break;
    case 19: if (iDisplay==0) oBoss = GetDrider(iLevel); else sCamp="Drider"; break;
    case 20: if (iDisplay==0) oBoss = GetRakasha(iLevel); else sCamp="Rakasha"; break;
    case 21: if (iDisplay==0) oBoss = GetEvilMen(iLevel); else sCamp="Evil Men"; break;
    case 22: if (iDisplay==0) oBoss = GetDuergar(iLevel); else sCamp="Duergar"; break;
    case 23: if (iDisplay==0) oBoss = GetLich(iLevel); else sCamp="Lich"; break;
    case 24: if (iDisplay==0) oBoss = GetLichLord(iLevel); else sCamp="LichLord"; break;
    case 25: if (iDisplay==0) oBoss = GetGnolls(iLevel); else sCamp="Gnolls"; break;
    case 26: if (iDisplay==0) oBoss = GetShapeshifters(iLevel); else sCamp="Shapeshifters"; break;
    case 27: if (iDisplay==0) oBoss = GetFlyers(iLevel); else sCamp="Flyers"; break;
    case 28: if (iDisplay==0) oBoss = GetInsects(iLevel); else sCamp="Insects"; break;
    case 29: if (iDisplay==0) oBoss = GetWolves(iLevel); else sCamp="Wolves"; break;
    case 30: if (iDisplay==0) oBoss = GetAnts(iLevel); else sCamp="Ants"; break;
    case 31: if (iDisplay==0) oBoss = GetRats(iLevel); else sCamp="Rats"; break;
    case 32: if (iDisplay==0) oBoss = GetBlighted(iLevel); else sCamp="Blighted"; break;
    case 33: if (iDisplay==0) oBoss = GetUnkempt(iLevel); else sCamp="Unkempt"; break;
    case 34: if (iDisplay==0) oBoss = GetHalfDragons(iLevel); else sCamp="Half-Dragons"; break;
    case 35: if (iDisplay==0) oBoss = GetUndeadTheme(iLevel); else sCamp="Undead Theme"; break;
    case 36: if (iDisplay==0) oBoss = GetRandomQuestCamp(iLevel); else sCamp="Random"; break;
    case 37: if (iDisplay==0) oBoss = GetSpiders(iLevel); else sCamp="Spiders"; break;
    case 38: if (iDisplay==0) oBoss = GetTrolls(iLevel); else sCamp="Trolls"; break;
    case 39: if (iDisplay==0) oBoss = GetFiendish(iLevel); else sCamp="Half-Fiends"; break;
    case 40: if (iDisplay==0) oBoss = GetOutsiders(iLevel); else sCamp="Outsiders"; break;
    case 41: if (iDisplay==0) oBoss = GetSlavers(iLevel); else sCamp="Slavers"; break;
    case 42: if (iDisplay==0) oBoss = GetADragon(iLevel); else sCamp="One Dragon"; break;
    case 43: if (iDisplay==0) oBoss = GetDragons(iLevel); else sCamp="Dragons"; break;
    case 44: if (iDisplay==0) oBoss = GetRitualists(iLevel); else sCamp="Ritualists"; break;
    }

if (iDisplay==1)
    SendMessageToPC(GetFirstPC(),IntToString(iCamp) + " = " + sCamp);

return oBoss;
}

object GetSingleSpawnMob(string sCamp,int iCamp,int iLevel)
{
object oMob;

SetLocalInt(GetModule(),"SPAWN_SingleSpawn",1);
SetLocalString(GetModule(),"SPAWN_SS_Spot",sCamp);
oMob=GetQuestCamp(iCamp,iLevel);
SetLocalInt(GetModule(),"SPAWN_SingleSpawn",0);

return oMob;
}

int GetQuestRepeatCamp(int iLevel)
{
int iRandom;
int iRandom2;
int iCamp;

iCamp=11;

if (iLevel<6)
    {
    iRandom=Random(10)+1;
    switch (iRandom)
        {
        case 1: iCamp=2; break;
        case 2: iCamp=3; break;
        case 3: iCamp=4; break;
        case 4: iCamp=8; break;
        case 5: iCamp=9; break;
        case 6: iCamp=10; break;
        case 7: iCamp=11; break;
        case 8: iCamp=25; break;
        case 9: iCamp=5; break;
        case 10: iCamp=14; break;
        }
    }
else if (iLevel<15)
    {
    iRandom=Random(12)+1;
    switch (iRandom)
        {
        case 1: iCamp=2; break;
        case 2: iCamp=3; break;
        case 3: iCamp=4; break;
        case 4: iCamp=8; break;
        case 5: iCamp=9; break;
        case 6: iCamp=10; break;
        case 7: iCamp=11; break;
        case 8: iCamp=13; break;
        case 9: iCamp=22; break;
        case 10: iCamp=17; break;
        case 11: iCamp=14; break;
        case 12: if (Random(3)==0)
                    {
                    iRandom2=Random(3)+1;
                    if (iRandom2==1)
                        iCamp=19;
                    else if (iRandom2==1)
                        iCamp=16;
                    else
                        iCamp=18;
                    } else {
                    if (Random(2)==0)
                        iCamp=2;
                    else
                        iCamp=3;
                    }
                 break;
        }
    }
else if (iLevel<25)
    {
    iRandom=Random(14)+1;
    switch (iRandom)
        {
        case 1: iCamp=8; break;
        case 2: iCamp=9; break;
        case 3: iCamp=10; break;
        case 4: iCamp=11; break;
        case 5: iCamp=13; break;
        case 6: iCamp=22; break;
        case 7: iCamp=17; break;
        case 8: iCamp=14; break;
        case 9: iCamp=7; break;
        case 10: iCamp=18; break;
        case 11: iCamp=19; break;
        case 12: iCamp=20; break;
        case 13: iCamp=15; break;
        case 14: iCamp=16; break;
        }
    }
else
    {
    iRandom=Random(10)+1;
    switch (iRandom)
        {
        case 1: iCamp=13; break;
        case 2: iCamp=22; break;
        case 3: iCamp=14; break;
        case 4: iCamp=18; break;
        case 5: iCamp=19; break;
        case 6: iCamp=20; break;
        case 7: iCamp=15; break;
        case 8: iCamp=16; break;
        case 9: iCamp=39; break;
        case 10: iCamp=17; break;
        }
    }

return iCamp;
}

//object SpawnEncounter(string sZone,int iLevel,int iSpawnType,int iEncounter);

object SpawnCamp(string sZone,int iLevel,int iSpawnType,int iCamp, int iBoss=0)
{
object oBoss;
object oWP;

SetLocalString(GetModule(),"SPAWN_Zone",sZone);
SetLocalInt(GetModule(),"SPAWN_Camp",iCamp);
SetLocalInt(GetModule(),"SPAWN_Boss",iBoss);

oWP=GetObjectByTag(sZone + "_C" + IntToString(iCamp) + "_1");

switch (iSpawnType)
    {
    case 0: if (GetIsAreaAboveGround(GetArea(oWP)) && !(GetIsAreaInterior(GetArea(oWP))))
                oBoss=SpawnOutside(iLevel);
            else
                oBoss=SpawnInside(iLevel);
            break;
    case 1: oBoss=GetSnowCreatures(iLevel); break;
    case 2: oBoss=GetThemeQuestMobs(iLevel); break;
    }

return oBoss;
}

object SpawnOutside(int iLevel)
{
int iRandom;
int iAdjustedLevel;
object oBoss;

iAdjustedLevel = iLevel;

if (iAdjustedLevel<5)
    {
    iRandom = Random(15);

    switch (iRandom)
        {
        case 0: oBoss=GetLizardfolk(iLevel); break; //4
        case 1: oBoss=GetUndead(iLevel); break;
        case 2: oBoss=GetEvilMen(iLevel); break;
        case 3: oBoss=GetFlyers(iLevel); break; //1
        case 4: oBoss=GetGoblins(iLevel); break; //10
        case 5: oBoss=GetOrcs(iLevel); break; //12
        case 6: oBoss=GetInsects(iLevel); break; //16
        case 7: oBoss=GetShapeshifters(iLevel); break; //1-3 (7sh)
        case 8: oBoss=GetBugBear(iLevel); break; //1-10
        case 9: oBoss=GetWolves(iLevel); break; //11
        case 10: oBoss=GetExtraPlanar(iLevel); break; //1-40
        case 11: oBoss=GetGiants(iLevel); break; //2-18
        case 12: oBoss=GetMonstrous(iLevel); break; //2-13
        case 13: oBoss=GetGoodOutside(iLevel); break; //3-40
        case 14: oBoss=GetThemeQuestMobs(iLevel); break; //3-40
        }
    }
else if (iAdjustedLevel<15)
    {
    iRandom = Random(13);

    switch (iRandom)
        {
        case 0: oBoss=GetUndead(iLevel); break;
        case 1: oBoss=GetEvilMen(iLevel); break;
        case 2: oBoss=GetGoblins(iLevel); break; //10
        case 3: oBoss=GetOrcs(iLevel); break; //12
        case 4: oBoss=GetInsects(iLevel); break; //16
        case 5: oBoss=GetBugBear(iLevel); break; //1-10
        case 6: oBoss=GetWolves(iLevel); break; //11
        case 7: oBoss=GetExtraPlanar(iLevel); break; //1-40
        case 8: oBoss=GetGiants(iLevel); break; //2-18
        case 9: oBoss=GetMonstrous(iLevel); break; //2-13
        case 10: oBoss=GetGoodOutside(iLevel); break; //3-40
        case 11: oBoss=GetTrolls(iLevel); break; //5-9
        case 12:
                if (iAdjustedLevel >7 && iAdjustedLevel <12 && Random(4)==0)
                    oBoss=GetHalfDragons(iLevel);
                else
                    oBoss=GetThemeQuestMobs(iLevel);
                break; //3-40
        }
    }
else if (iAdjustedLevel<25)
    {
    iRandom = Random(7);

    switch (iRandom)
        {
        case 0: oBoss=GetUndead(iLevel); break;
        case 1: oBoss=GetEvilMen(iLevel); break;
        case 2: oBoss=GetInsects(iLevel); break; //16
        case 3: oBoss=GetExtraPlanar(iLevel); break; //1-40
        case 4: oBoss=GetGiants(iLevel); break; //2-18
        case 5: oBoss=GetGoodOutside(iLevel); break; //3-40
        case 6: oBoss=GetThemeQuestMobs(iLevel); break; //3-40
        }
    }
else
    {
    iRandom = Random(6);

    switch (iRandom)
        {
        case 0: oBoss=GetUndead(iLevel); break;
        case 1: oBoss=GetExtraPlanar(iLevel); break; //1-40
        case 2: oBoss=GetEvilMen(iLevel); break; //3-40
        case 3: oBoss=GetGoodOutside(iLevel); break; //3-40
        case 4: oBoss=GetGiants(iLevel); break; //2-18
        case 5: oBoss=GetThemeQuestMobs(iLevel); break; //3-40
        }
    }

return oBoss;
}

object SpawnInside(int iLevel)
{
int iRandom;
int iAdjustedLevel;
object oBoss;

iAdjustedLevel = iLevel;

if (iAdjustedLevel<5)
    {
    iRandom = Random(13);

    switch (iRandom)
        {
        case 0: oBoss=GetLizardfolk(iLevel); break; //4
        case 1: oBoss=GetUndead(iLevel); break;
        case 2: oBoss=GetEvilMen(iLevel); break;
        case 3: oBoss=GetGoblins(iLevel); break; //10
        case 4: oBoss=GetOrcs(iLevel); break; //12
        case 5: oBoss=GetInsects(iLevel); break; //16
        case 6: oBoss=GetShapeshifters(iLevel); break; //1-3 (7sh)
        case 7: oBoss=GetBugBear(iLevel); break; //1-10
        case 8: oBoss=GetExtraPlanar(iLevel); break; //1-40
        case 9: oBoss=GetGiants(iLevel); break; //2-18
        case 10: oBoss=GetMonstrous(iLevel); break; //2-13
        case 11: oBoss=GetThemeQuestMobs(iLevel); break; //1-16
        case 12: oBoss=GetUnderdark(iLevel); break; //3-40

        }
    }
else if (iAdjustedLevel<15)
    {
    iRandom = Random(12);

    switch (iRandom)
        {
        case 0: oBoss=GetUndead(iLevel); break;
        case 1: oBoss=GetEvilMen(iLevel); break;
        case 2: oBoss=GetGoblins(iLevel); break; //10
        case 3: oBoss=GetOrcs(iLevel); break; //12
        case 4: oBoss=GetInsects(iLevel); break; //16
        case 5: oBoss=GetExtraPlanar(iLevel); break; //14
        case 6: oBoss=GetBugBear(iLevel); break; //1-10
        case 7: oBoss=GetThemeQuestMobs(iLevel); break; //1-40
        case 8: oBoss=GetGiants(iLevel); break; //2-18
        case 9: oBoss=GetMonstrous(iLevel); break; //2-13
        case 10: oBoss=GetUnderdark(iLevel); break; //3-40
        case 11: oBoss=GetTrolls(iLevel); break; //5-9
        }
    }
else if (iAdjustedLevel<25)
    {
    iRandom = Random(7);

    switch (iRandom)
        {
        case 0: oBoss=GetUndead(iLevel); break;
        case 1: oBoss=GetEvilMen(iLevel); break;
        case 2: oBoss=GetInsects(iLevel); break; //16
        case 3: oBoss=GetExtraPlanar(iLevel); break; //14
        case 4: oBoss=GetThemeQuestMobs(iLevel); break; //1-40
        case 5: oBoss=GetGiants(iLevel); break; //2-18
        case 6: oBoss=GetUnderdark(iLevel); break; //3-40
        }
    }
else
    {
    iRandom = Random(6);

    switch (iRandom)
        {
        case 0: oBoss=GetUndead(iLevel); break;
        case 1: oBoss=GetExtraPlanar(iLevel); break; //1-40
        case 2: oBoss=GetThemeQuestMobs(iLevel); break; //1-40
        case 3: oBoss=GetEvilMen(iLevel); break; //3-40
        case 4: oBoss=GetUnderdark(iLevel); break; //3-40
        case 5: oBoss=GetGiants(iLevel); break; //2-18
        }
    }

return oBoss;
}

object GetRandomQuestCamp(int iQuestLevel)
{
int iRandom;
object oBoss;

iRandom=Random(100);
//SendMessageToPC(GetFirstPC(),IntToString(iQuestLevel) + " : " + IntToString(iRandom));

if (iQuestLevel < 15)
    {
    if (iRandom<10)
        {
        if (iQuestLevel<6)
            oBoss=GetLizardfolk(iQuestLevel);
        else if (iQuestLevel<6)
            {
            if (Random(3)==0)
                oBoss=GetTrolls(iQuestLevel);
            else
                oBoss=GetLizardfolk(iQuestLevel);
            }
        else if (iQuestLevel<12)
            {
            if (Random(3)==0)
                oBoss=GetHalfDragons(iQuestLevel);
            else
                oBoss=GetTrolls(iQuestLevel);
            }
        else
            oBoss=GetGiants(iQuestLevel);
        }
    else if (iRandom<25)
        oBoss=GetGoblins(iQuestLevel);
    else if (iRandom<40)
        oBoss=GetOrcs(iQuestLevel);
    else if (iRandom<50)
        oBoss=GetBugBear(iQuestLevel);
    else if (iRandom<65)
        oBoss=GetEvilMen(iQuestLevel);
    else if (iRandom<75)
        oBoss=GetThemeQuestMobs(iQuestLevel);
    else if (iRandom<85)
        oBoss=GetGiants(iQuestLevel);
    else if (iRandom<95)
        oBoss=GetUndead(iQuestLevel);
    else
        oBoss=GetExtraPlanar(iQuestLevel);
    } else {
    if (iRandom<40)
        oBoss=GetEvilMen(iQuestLevel);
    else if (iRandom<70)
        oBoss=GetThemeQuestMobs(iQuestLevel);
    else if (iRandom<90)
        oBoss=GetUndead(iQuestLevel);
    else
        oBoss=GetExtraPlanar(iQuestLevel);
    }

return oBoss;
}


object GetThemeQuestMobs(int iLevel)
{
int iBoss;
int iRandom;
object oBoss;

iBoss=GetLocalInt(GetModule(),"OverallQuestBoss");

/*
1 Lich King (Undead,Necromancers)
2 Demi-Lich (Undead,Necromancers)
3 Lolth (Drow, Driders, Shades)
4 Randal Kross (Dueger, Animators, Cultists,Necromancers,Shades)
5 Rakasha (Rakasha,Tieflings,Fey'ri)
6 Demon (Cultists,Rakasha,Tiefling,Fey'ri)
7 Half Dragon Man  (Cultists, Rakasha, Shades)
8 Prismatic Dragon (Conjurers, Dragonmen, Tiefling, Shades)
*/

if (iBoss==1 || iBoss == 2)
    {
    if (GetLocalString(GetModule(),"SPAWN_Zone") == "BC1" && GetLocalInt(GetModule(),"SPAWN_Camp") == 4)
        oBoss=GetVampire(iLevel);
    else
        if (Random(2)==0)
            oBoss=GetUndead(iLevel);
        else
            oBoss=GetNecromancers(iLevel);
    }
if (iBoss==3)
    {
    iRandom=Random(3)+1;
    if (iRandom==1)
        oBoss=GetDrow(iLevel);
    if (iRandom==2)
        oBoss=GetDrider(iLevel);
    if (iRandom==3)
        if (Random(2)==0)
            oBoss=GetShade(iLevel);
        else
            oBoss=GetDuergar(iLevel);
    }
if (iBoss==4)
    {
    iRandom=Random(5)+1;
    if (iRandom==1)
        oBoss=GetCultist(iLevel);
    if (iRandom==2)
        oBoss=GetAnimators(iLevel);
    if (iRandom==3)
        oBoss=GetCultist(iLevel);
    if (iRandom==4)
        oBoss=GetDuergar(iLevel);
    if (iRandom==5)
        oBoss=GetShade(iLevel);
    }
if (iBoss==5)
    {
    iRandom=Random(3)+1;
    if (iRandom==1)
        if (iLevel>19)
            oBoss=GetRakasha(iLevel);
        else
            oBoss=GetTiefling(iLevel);
    if (iRandom==2)
        oBoss=GetTiefling(iLevel);
    if (iRandom==3)
        if (iLevel>9)
            oBoss=GetFeyri(iLevel);
        else
            oBoss=GetTiefling(iLevel);
    }
if (iBoss==6)
    {
    iRandom=Random(4)+1;
    if (iRandom==1)
        if (iLevel>19)
            oBoss=GetRakasha(iLevel);
        else
            oBoss=GetCultist(iLevel);
    if (iRandom==2)
        oBoss=GetTiefling(iLevel);
    if (iRandom==3)
        if (iLevel>9)
            oBoss=GetFeyri(iLevel);
        else
            oBoss=GetTiefling(iLevel);
    if (iRandom==4)
        oBoss=GetCultist(iLevel);
    }
if (iBoss==7)
    {
    iRandom=Random(3)+1;
    if (iRandom==1)
        if (iLevel>19)
            oBoss=GetRakasha(iLevel);
        else
            oBoss=GetCultist(iLevel);
    if (iRandom==2)
        oBoss=GetShade(iLevel);
    if (iRandom==3)
        oBoss=GetCultist(iLevel);
    }
if (iBoss==8)
    {
    iRandom=Random(3)+1;
    if (iRandom==1)
        oBoss=GetConjurers(iLevel);
    if (iRandom==2)
        oBoss=GetShade(iLevel);
    if (iRandom==3)
        oBoss=GetTiefling(iLevel);
    }

if (!GetIsObjectValid(oBoss))
    oBoss=GetRandomQuestCamp(iLevel);

if (!GetIsObjectValid(oBoss))
    oBoss=GetMercenaries(iLevel);

return oBoss;
}

int GetMobTheme(int iTheme,int iLevel=1)
{
int iCamp;
int iRandom;

iCamp=11;

if (iTheme==1) //regular stuff
    {
    iRandom=Random(11)+1;
    if (iRandom==1)
        iCamp=2;
    if (iRandom==2)
        iCamp=3;
    if (iRandom==3)
        iCamp=4;
    if (iRandom==4)
        iCamp=17;
    if (iRandom==5)
        iCamp=25;
    if (iRandom==6)
        iCamp=7;
    if (iRandom==7)
        iCamp=5;
    if (iRandom==8)
        iCamp=6;
    if (iRandom==9)
        {
        iCamp=33;
        if (Random(4)==0)
            iCamp=32;
        }
    if (iRandom==10)
        iCamp=34;
    if (iRandom==11)
        iCamp=34;


    if (iCamp==34 && (iLevel<8 || iLevel>12))
        iCamp=Random(3)+2;
    if (iLevel>5 && (iCamp==5 || iCamp == 25))
        iCamp=Random(3)+2;

    if (iLevel>14 && (iCamp == 2 || iCamp == 3 || iCamp == 4))
        if (Random(2)==0)
            iCamp=17;
        else
            iCamp=7;
    if (iLevel>15 && iCamp==6)
        if (Random(2)==0)
            iCamp=17;
        else
            iCamp=7;

    if (iLevel>22)
        {
        iRandom=Random(7)+1;
        if (iRandom==1)
            iCamp=7;
        if (iRandom==2)
            iCamp=14;
        if (iRandom==3)
            iCamp=13;
        if (iRandom==4)
            iCamp=22;
        if (iRandom==5)
            iCamp=16;
        if (iRandom==6)
            iCamp=18;
        if (iRandom==7)
            iCamp=17;
        }
    }
if (iTheme==2) //casters
    {
    iRandom=Random(4)+1;
    if (iRandom==1)
        iCamp=8;
    if (iRandom==2)
        iCamp=9;
    if (iRandom==3)
        iCamp=10;
    if (iRandom==4)
        iCamp=14;
    }
if (iTheme==3) //evil race
    {
    iRandom=Random(5)+1;
    if (iRandom<3)
        iCamp=13;
    if (iRandom<5)
        iCamp=22;
    if (iRandom==5)
        iCamp=19;
    }
if (iTheme==4) //planar race
    {
    iRandom=Random(4)+1;
    if (iRandom==1)
        iCamp=15;
    if (iRandom==2)
        iCamp=16;
    if (iRandom==3)
        iCamp=18;
    if (iRandom==4)
        iCamp=20;
    if (iLevel>20 && Random(6)==0)
        iCamp=39;
    }
if (iTheme==5) //Non-humanoid
    {
    iRandom=Random(5)+1;
    if (iRandom==1)
        iCamp=26;
    if (iRandom==2)
        iCamp=27;
    if (iRandom==3)
        iCamp=28;
    if (iRandom==4)
        iCamp=29;
    if (iRandom==5)
        iCamp=31;

    if (iCamp==31 && iLevel>2)
        iCamp=27;
    if (iCamp==26 && iLevel>5)
        iCamp=28;
    if (iCamp==27 && iLevel>7)
        iCamp=29;
    if (iCamp==29 && iLevel>12)
        iCamp=28;
    if (iCamp==28 && iLevel>18)
        iCamp=17;

    }

return iCamp;
}
/*
    case 2: if (iDisplay==0) oBoss = GetGoblins(iLevel); else sCamp="Goblins"; break;
    case 3: if (iDisplay==0) oBoss = GetOrcs(iLevel); else  sCamp="Orcs"; break;
    case 4: if (iDisplay==0) oBoss = GetBugBear(iLevel); else sCamp="Bugbears"; break;
    case 5: if (iDisplay==0) oBoss = GetLizardfolk(iLevel); else sCamp="Lizardfolk"; break;
    case 6: if (iDisplay==0) oBoss = GetMonstrous(iLevel); else sCamp="Monstrous"; break;
    case 7: if (iDisplay==0) oBoss = GetUndead(iLevel); else sCamp="Undead"; break;
    case 8: if (iDisplay==0) oBoss = GetCultist(iLevel); else sCamp="Cultist"; break;
    case 9: if (iDisplay==0) oBoss = GetNecromancers(iLevel); else sCamp="Necromancers"; break;
    case 10: if (iDisplay==0) oBoss = GetConjurers(iLevel); else sCamp="Conjuerers"; break;
    case 11: if (iDisplay==0) oBoss = GetMercenaries(iLevel); else sCamp="Mercenaries"; break;
    case 12: if (iDisplay==0) oBoss = GetAssassins(iLevel); else sCamp="Assassins"; break;
    case 13: if (iDisplay==0) oBoss = GetDrow(iLevel); else sCamp="Drow"; break;
    case 14: if (iDisplay==0) oBoss = GetGolems(iLevel); else sCamp="Golems"; break;
    case 15: if (iDisplay==0) oBoss = GetTiefling(iLevel); else sCamp="Tieflings"; break;
    case 16: if (iDisplay==0) oBoss = GetShade(iLevel); else sCamp="Shade"; break;
    case 17: if (iDisplay==0) oBoss = GetGiants(iLevel); else sCamp="Giants"; break;
    case 18: if (iDisplay==0) oBoss = GetFeyri(iLevel); else sCamp="Feyri"; break;
    case 19: if (iDisplay==0) oBoss = GetDrider(iLevel); else sCamp="Drider"; break;
    case 20: if (iDisplay==0) oBoss = GetRakasha(iLevel); else sCamp="Rakasha"; break;
    case 21: if (iDisplay==0) oBoss = GetEvilMen(iLevel); else sCamp="Evil Men"; break;
    case 22: if (iDisplay==0) oBoss = GetDuergar(iLevel); else sCamp="Duergar"; break;
    case 23: if (iDisplay==0) oBoss = GetLich(iLevel); else sCamp="Lich"; break;
    case 24: if (iDisplay==0) oBoss = GetLichLord(iLevel); else sCamp="LichLord"; break;
    case 25: if (iDisplay==0) oBoss = GetGnolls(iLevel); else sCamp="Gnolls"; break;
    case 26: if (iDisplay==0) oBoss = GetShapeshifters(iLevel); else sCamp="Shapeshifters"; break;
    case 27: if (iDisplay==0) oBoss = GetFlyers(iLevel); else sCamp="Flyers"; break;
    case 28: if (iDisplay==0) oBoss = GetInsects(iLevel); else sCamp="Insects"; break;
    case 29: if (iDisplay==0) oBoss = GetWolves(iLevel); else sCamp="Wolves"; break;
    case 30: if (iDisplay==0) oBoss = GetAnts(iLevel); else sCamp="Ants"; break;
    case 31: if (iDisplay==0) oBoss = GetRats(iLevel); else sCamp="Rats"; break;
    case 32: if (iDisplay==0) oBoss = GetBlighted(iLevel); else sCamp="Blighted"; break;
    case 33: if (iDisplay==0) oBoss = GetUnkempt(iLevel); else sCamp="Unkempt"; break;
    case 34: if (iDisplay==0) oBoss = GetHalfDragons(iLevel); else sCamp="Half-Dragons"; break;

*/
