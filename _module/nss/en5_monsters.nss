#include "en5_misc"
#include "en5_equipment"

object GetClassTest(int iLevel);
object GetMobCamp(int iLevel=0);
void SpawnMob(string sTag,string sEncounter,int iEquip, int iMobLevel,int iClass);
object GetSpawnMob(string sTag,string sEncounter,int iEquip, int iMobLevel,int iClass);
void LevelupBoss(object oBoss,int iMobLevel,int iBossClass, int iBossEquip);
object GetSingleSpawn(int iLevel=0);
void CheckCamp();
void ClearCamp();
void SetCampNPC(string sTag,int iChance,int iClass, int iMultiple=0, int iEquip=2,int iPriority=0);
void SetCampMob(string sTag,int iChance,int iMultiple=10, int iEquip=0,int iPriority=0);
object GetLizardfolk(int iLevel);
object GetUndead(int iLevel);
object GetFlyers(int iLevel);
object GetGoblins(int iLevel);
object GetOrcs(int iLevel);
object GetMercenaries(int iLevel);
object GetHumans(int iLevel);
object GetShapeshifters(int iLevel);
object GetWerewolves(int iLevel);
object GetBeetles(int iLevel);
object GetSpiders(int iLevel);
object GetAnts(int iLevel);
object GetWolves(int iLevel);
object GetGiants(int iLevel);
object GetOgreBoss(int iLevel);
object GetTrolls(int iLevel);
object GetBugBear(int iLevel);
object GetMonstrous(int iLevel);
object GetCelestial(int iLevel);
object GetCultist(int iLevel);
object GetOutsiders(int iLevel);
object GetAnimators(int iLevel);
object GetHalflings(int iLevel);
object GetElves(int iLevel);
object GetDwarves(int iLevel);
object GetGood(int iLevel);
object GetGoodOutside(int iLevel);
object GetGoodInside(int iLevel);
object GetDrow(int iLevel);
object GetDuergar(int iLevel);
object GetDrider(int iLevel);
object GetUnderdark(int iLevel);
object GetPlanar(int iLevel);
object GetRakasha(int iLevel);
object GetTiefling(int iLevel);
object GetShade(int iLevel);
object GetFeyri(int iLevel);
object GetRats(int iLevel);
object GetExtraPlanar(int iLevel);
object GetInsects(int iLevel);
object GetEvilMen(int iLevel);
object GetMonsterCamp(string sMob,int iLevel=1,int iMultiple=10);
object GetSnowCreatures(int iLevel);
object GetNecromancers(int iLevel);
object GetLevelupMobs(string sTag, int iLevel, string sDescription, int iFighter=35, int iThief=25, int iCleric=25, int iMage=15, string sBoss="", int iBossClass=EN5_CLASS_FIGHTER);
object GetGolems(int iLevel);
object GetConjurers(int iLevel);
object GetMinotaur(int iLevel);
object GetAssassins(int iLevel);
object GetSewer(int iLevel);
object GetBlighted(int iLevel);
object GetUnkempt(int iLevel);
object GetHalfDragons(int iLevel, string sBoss="EN5_HALFDRAFTR",int iWyrmling = 0);
object GetLichLord(int iLevel);
object GetLich(int iLevel);
object GetVampire(int iLevel);
object GetUndeadTheme(int iLevel);
object GetFiendish(int iLevel);
object GetADragon(int iLevel,string sColor="");
object GetDragons(int iLevel);
object GetRitualists(int iLevel);

object GetMonsterCamp(string sMob,int iLevel=1,int iMultiple=10)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",1 + iLevel/6);

SetLocalString(GetModule(),"EN5_CampDescription","monsters");

SetLocalString(GetModule(),"CAMP_Boss",sMob);
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt",sMob);
SetCampMob(sMob,100,iMultiple);

oBoss = GetMobCamp(iLevel);

return oBoss;
}



object GetMobCamp(int iLevel=0)
{
int iIndex;
int iCamp;
int iBoss;
int iRandom;
int iMultiple;
int iBoss1Treasure;
int iBoss2Treasure;
int iBossCount;
int iCampCount;
int iCount;
int iChance;
int iMobChance;
int iEquip;
int iLevelup;
int iMobLevel;
int iClass;
int iBossLevelup;
int iBossClass;
int iBossEquip;
int iOldMultiple;
int iClear;
int iMobCount;
string sZone;
string sCamp;
string sEncounter;
string sTag;
string sCampType;
string sBoss;
string sBossAlt;
object oBoss;
object oMob;

if (GetLocalInt(GetModule(),"SPAWN_SingleSpawn")==1)
    {
    oMob=GetSingleSpawn(iLevel);
    return oMob;
    }

sZone = GetLocalString(GetModule(),"SPAWN_Zone");
iCamp = GetLocalInt(GetModule(),"SPAWN_Camp");
iBoss = GetLocalInt(GetModule(),"SPAWN_Boss");
sCampType = GetLocalString(GetModule(),"SPAWN_CampType");
//GetError("CampType = " + sCampType);
CheckCamp();

sBoss = GetLocalString(GetModule(),"CAMP_Boss");
iBossCount = GetLocalInt(GetModule(),"CAMP_BossCount");
sBossAlt = GetLocalString(GetModule(),"CAMP_BossAlt");
iBossLevelup = GetLocalInt(GetModule(),"CAMP_BossLevelup");
iBossClass = GetLocalInt(GetModule(),"CAMP_BossClass");
iBossEquip = GetLocalInt(GetModule(),"CAMP_BossEquip");

iCampCount = GetLocalInt(GetModule(),"CAMP_CampCount");
//GetError("CampCount=" + IntToString(iCampCount));

iIndex = 1;
sCamp = sZone + "_" + sCampType + IntToString(iCamp) + "_";
sEncounter = sCamp + IntToString(iIndex);

//GetError(sEncounter);

SetLocalInt(GetModule(),"EN5_BossNamed",0);

if (iBoss==2 && Random(2)==0)
    iBoss=3;
else if (iBoss==2)
    iBoss=1;

if (iBoss == 0)
    sTag = sBossAlt;
if (iBoss == 1 || (iBoss == 3 && iBossCount == 0))
    sTag = sBoss;
if (iBoss == 3 && iBossCount>0)
    sTag=GetBoss(sBoss,iBossCount);

if (iBossLevelup>0)
    {
    if (iLevel>5)
        iMobLevel = iLevel + Random(3)+1;
    else
        iMobLevel = iLevel + Random(2)+1;
    } else {
    iMobLevel = 0;
    }

oBoss = GetMob(sTag,sEncounter,iMobLevel,iBoss);
SetLocalString(oBoss,"WP",sEncounter);
SetLocalInt(oBoss,"iBoss",iBoss);

if (iBossLevelup>0)
    {
    DelayCommand(0.1,LevelupBoss(oBoss,iMobLevel,iBossClass,iBossEquip));
    } else {
    if (iBossEquip == 1)
        DelayCommand(0.1,EquipWeapon(oBoss));
    if (iBossEquip == 2)
        DelayCommand(0.1,EquipMob(oBoss));
    }

iIndex++;
sEncounter = sCamp + IntToString(iIndex);
iMobCount=0;
while (GetIsObjectValid(GetObjectByTag(sEncounter)))
    {
    sTag = "";
    iCount = 1;
    iChance = 0;
    iOldMultiple=iMultiple;
    iRandom = Random(100);
    iMobCount++;
    while (sTag == "")
        {
        iMobChance = GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Chance");
        iChance = iChance + iMobChance;
        //GetError("Check " + IntToString(iCount) + " : Checking " + IntToString(iRandom) + " against " + IntToString(iChance) + " for " + GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag") + ".");
        if (iRandom<iChance)
            {
            sTag=GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag");
            iMultiple=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Multiple");
            iEquip=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Equip");
            iLevelup=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Levelup");
            iClass=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Class");
            if (sTag == "")
                {
                GetError("ERROR: Monster Camp Tag Error.  (BossTag=" + GetTag(oBoss) + ")");
                sTag = "en5_kobold";
                }
            } else {
                if (iCount == iCampCount)
                    {
                    sTag=GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag");
                    iMultiple=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Multiple");
                    iEquip=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Equip");
                    iLevelup=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Levelup");
                    GetError("ERROR: Monster Camp Error. Out of Tags! Spawning " + sTag + " as replacement.");
                    } else {
                    //GetError("(Advancing)");
                    iCount++;
                    }
            }
        }

    iMobLevel=0;

    if (iLevelup>0)
        {
        iRandom=Random(10);
        if (iRandom < 1)
            iMobLevel = iLevel + Random(2)+1;
        else if (iRandom < 4)
            iMobLevel = iLevel - 2 + Random(2)+1;
        else if (iRandom <8)
            iMobLevel = iLevel - (Random(2)+2);
        else
            {
            if (iLevel>5)
                {
                iMobLevel = iLevel/2;
                iOldMultiple = iMultiple;
                iMultiple = 100;
                }
            else
                iMobLevel = iLevel - 1;
            }
        if (iMobLevel<1)
            iMobLevel=1;
        }

    if (GetAdjustedNumberPCs()>1 && iClear==0 && iMultiple<25)
        {
        if (GetAdjustedNumberPCs()<3)
            {
            iOldMultiple = iMultiple;
            iMultiple=iMultiple + 25;
            iClear=1;
            } else {
            iOldMultiple = iMultiple;
            iMultiple=iMultiple + 50;
            iClear=1;
            }
        }

    if (GetCampaignInt("Endless Nights VI","GameMode") == 1 && iMultiple<50)
        iMultiple=iMultiple+20;

    if (GetIsObjectValid(GetObjectByTag(sEncounter + "a")))
        if (Random(2)==0)
            sEncounter = sEncounter + "a";
    DelayCommand(0.1,SpawnMob(sTag,sEncounter,iEquip,iMobLevel,iClass));

    if (iMobCount>4)
        iMultiple=-1;

    if (Random(100)+1>iMultiple)
        {
        iIndex++;
        iClear=0;
        iMobCount=0;
        }

    iMultiple=iOldMultiple;

    sEncounter = sCamp + IntToString(iIndex);
    }

iBoss1Treasure = GetLocalInt(GetModule(),"CAMP_Boss1Treasure");
iBoss2Treasure = GetLocalInt(GetModule(),"CAMP_Boss2Treasure");

if (iBoss==1 && Random(100)<iBoss1Treasure)
    ExecuteScript("en5_giveitem",oBoss);
if (iBoss==3 && Random(100)<iBoss2Treasure)
    ExecuteScript("en5_giveitem",oBoss);

if (!GetIsObjectValid(oBoss))
    SendMessageToPC(GetFirstPC(),"ERROR: Could not spawn " + GetLocalString(GetModule(),"EN5_CampDescription") + " at " + sCamp);

return oBoss;
}

void LevelupBoss(object oBoss,int iMobLevel,int iBossClass, int iBossEquip)
{

LevelMob(oBoss,iMobLevel,iBossClass);

if (iBossEquip == 1)
    EquipWeapon(oBoss);
if (iBossEquip == 2)
    EquipMob(oBoss);
}

object GetSingleSpawn(int iLevel=0)
{
int iIndex;
int iCamp;
int iBoss;
int iRandom;
int iMultiple;
int iCampCount;
int iCount;
int iChance;
int iMobChance;
int iEquip;
int iLevelup;
int iMobLevel;
int iClass;
int iOldMultiple;
int iFlag;
int iPriorityCount;
int iPriorityChance;
int iPriority;
string sZone;
string sCamp;
string sEncounter;
string sTag;
string sCampType;
object oMob;

sEncounter=GetLocalString(GetModule(),"SPAWN_SS_Spot");

sZone = GetLocalString(GetModule(),"SPAWN_Zone");
iCamp = GetLocalInt(GetModule(),"SPAWN_Camp");
sCampType = GetLocalString(GetModule(),"SPAWN_CampType");

iCampCount = GetLocalInt(GetModule(),"CAMP_CampCount");

sTag = "";
iCount = 1;
iChance = 0;
iOldMultiple=iMultiple;
iRandom = Random(100);
iFlag=TRUE;

iCount=1;
while (iCount<= iCampCount)
    {
    iPriority=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Priority");

    if (iPriority>0)
        {
        iPriorityCount++;
        iPriorityChance = 60 - (iPriorityCount *10);
        if (iPriorityChance < 15)
            iPriorityChance=15;

        if (iPriorityCount == 1 || Random(100)<iPriorityChance)
            {
            sTag=GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag");
            iEquip=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Equip");
            iLevelup=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Levelup");
            iClass=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Class");
            }
        }
    iCount++;
    }

if (sTag != "")
    {
    if (iLevelup>0)
        iMobLevel=iLevel;
    oMob=GetSpawnMob(sTag,sEncounter,iEquip,iMobLevel,iClass);
    iFlag=FALSE;
    }

iCount=1;

while (iFlag)
    {
    while (sTag == "")
        {
        iMobChance = GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Chance");
        iChance = iChance + iMobChance;
        //GetError("Check " + IntToString(iCount) + " : Checking " + IntToString(iRandom) + " against " + IntToString(iChance) + " for " + GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag") + ".");
        if (iRandom<iChance)
            {
            sTag=GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag");
            iMultiple=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Multiple");
            iEquip=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Equip");
            iLevelup=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Levelup");
            iClass=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Class");
            if (sTag == "")
                {
                GetError("ERROR: SingleSpawn Camp Tag Error.");
                sTag = "en5_kobold";
                }
            } else {
                if (iCount == iCampCount)
                    {
                    sTag=GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag");
                    iMultiple=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Multiple");
                    iEquip=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Equip");
                    iLevelup=GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Levelup");
                    GetError("ERROR: Monster Camp Error. Out of Tags! Spawning " + sTag + " as replacement.");
                    } else {
                    //GetError("(Advancing)");
                    iCount++;
                    }
            }
        }

    iMobLevel=0;

    if (iLevelup>0)
        {
        iRandom=Random(10);
        if (iRandom < 1)
            iMobLevel = iLevel + Random(2)+1;
        else if (iRandom < 4)
            iMobLevel = iLevel - 2 + Random(2)+1;
        else if (iRandom <8)
            iMobLevel = iLevel - (Random(2)+2);
        else
            {
            if (iLevel>5)
                {
                iMobLevel = iLevel/2;
                iOldMultiple = iMultiple;
                iMultiple = 100;
                }
            else
                iMobLevel = iLevel - 1;
            }
        if (iMobLevel<1)
            iMobLevel=1;
        }

    if (Random(100)+1>iMultiple)
        {
        oMob=GetSpawnMob(sTag,sEncounter,iEquip,iMobLevel,iClass);
        iFlag=FALSE;
        } else {
        DelayCommand(0.1,SpawnMob(sTag,sEncounter,iEquip,iMobLevel,iClass));
        }

    iMultiple=iOldMultiple;
    }

return oMob;

}

void SpawnMob(string sTag,string sEncounter,int iEquip, int iMobLevel,int iClass)
{
object oMob;

oMob=GetMob(sTag,sEncounter,iMobLevel,0);
SetLocalString(oMob,"WP",sEncounter);

if (iMobLevel>0)
    LevelMob(oMob,iMobLevel,iClass);
else
    if (GetSkillRank(SKILL_HIDE)>7)
        {
        AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_STEALTH));
        DelayCommand(0.1,AssignCommand(oMob,UseStealthMode()));
        }

//GetError(GetName(oMob) + " Level = " + IntToString(GetHitDice(oMob)) + " Class = " + GetClass(oMob));

if (iEquip == 1)
    EquipWeapon(oMob);
if (iEquip == 2)
    EquipMob(oMob);
}

object GetSpawnMob(string sTag,string sEncounter,int iEquip, int iMobLevel,int iClass)
{
object oMob;

oMob=GetMob(sTag,sEncounter,iMobLevel,0);
SetLocalString(oMob,"WP",sEncounter);

if (iMobLevel>0)
    LevelMob(oMob,iMobLevel,iClass);
else
    if (GetSkillRank(SKILL_HIDE)>7)
        {
        AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_STEALTH));
        DelayCommand(0.1,AssignCommand(oMob,UseStealthMode()));
        }

//GetError(GetName(oMob) + " Level = " + IntToString(GetHitDice(oMob)) + " Class = " + GetClass(oMob));

if (iEquip == 1)
    EquipWeapon(oMob);
if (iEquip == 2)
    EquipMob(oMob);

return oMob;
}


void ClearCamp()
{
int iCount;
int iIndex;

iCount = GetLocalInt(GetModule(),"CAMP_CampCount");

SetLocalInt(GetModule(),"CAMP_CampCount",0);
SetLocalString(GetModule(),"CAMP_Boss","");
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt","");
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",2);
SetLocalInt(GetModule(),"CAMP_BossLevelup",0);
SetLocalInt(GetModule(),"CAMP_BossClass",0);
SetLocalInt(GetModule(),"CAMP_BossEquip",0);

iIndex=1;
while (iIndex <= iCount)
    {
    SetLocalString(GetModule(),"CAMP_MOB" + IntToString(iIndex) + "_Tag","");
    SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iIndex) + "_Multiple",0);
    SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iIndex) + "_Equip",0);
    SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iIndex) + "_Levelup",0);
    SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iIndex) + "_Class",0);
    iIndex++;
    }
}

void CheckCamp()
{
int iIndex;
int iCount;
int iChance;
int iMobChance;
string sTag;

iCount = GetLocalInt(GetModule(),"CAMP_CampCount");

iIndex=1;
iChance = 0;
while (iIndex <= iCount)
    {
    iMobChance = GetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iIndex) + "_Chance");
    iChance = iChance + iMobChance;
    iIndex++;
    }

if (iChance <100)
    {
    iMobChance = iMobChance + (100-iChance);
    SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Chance",iMobChance);
    sTag =GetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag");
    GetError("ERROR: Mob Camp Setup Error -- Correcting chance for " + sTag);
    }
}

void SetCampMob(string sTag,int iChance,int iMultiple=10, int iEquip=0,int iPriority=0)
{
int iCount;

iCount = GetLocalInt(GetModule(),"CAMP_CampCount");
iCount++;

SetLocalInt(GetModule(),"CAMP_CampCount",iCount);
SetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag",sTag);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Multiple",iMultiple);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Equip",iEquip);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Chance",iChance);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Levelup",0);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Class",0);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Priority",iPriority);

}

void SetCampNPC(string sTag,int iChance,int iClass, int iMultiple=0, int iEquip=2,int iPriority=0)
{
int iCount;

if (iMultiple == 0)
    iMultiple = GetNumberPCs() * 3;

iCount = GetLocalInt(GetModule(),"CAMP_CampCount");
iCount++;

SetLocalInt(GetModule(),"CAMP_CampCount",iCount);
SetLocalString(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Tag",sTag);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Multiple",iMultiple);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Equip",iEquip);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Chance",iChance);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Levelup",1);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Class",iClass);
SetLocalInt(GetModule(),"CAMP_MOB" + IntToString(iCount) + "_Priority",iPriority);

}

object GetInsects(int iLevel)
{
object oBoss;
int iRandom;

if (iLevel<3)
    iRandom=Random(2)+1;
else if (iLevel<6)
    iRandom=Random(3)+1;
else
    iRandom=Random(2)+2;

if (iRandom==1)
    oBoss=GetAnts(iLevel);
else if (iRandom==2)
    oBoss=GetBeetles(iLevel);
else
    oBoss=GetSpiders(iLevel);

return oBoss;
}

object GetLizardfolk(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
int iRandom = Random(4)+1;

if (iLevel<2)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","kobolds");
    SetLocalString(GetModule(),"CAMP_Boss","en5_kobold1_b");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_kobold1");
    SetCampMob("en5_kobold1",33);
    SetCampMob("en5_kobold2",33);
    SetCampMob("en5_kobold3",34);
    }
else if (iLevel<4)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","kobolds");
    SetLocalString(GetModule(),"CAMP_Boss","en5_kobold_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_kobold4");
    SetCampMob("en5_kobold1",20);
    SetCampMob("en5_kobold2",20);
    SetCampMob("en5_kobold3",20);
    SetCampMob("en5_kobold4",10,1);
    SetCampMob("en5_kobold5",10,1);
    SetCampMob("en5_kobold6",10,1);
    SetCampMob("en5_kobold7",10,1);
    }
else if (iLevel<5)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","lizardmen");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_OLDCHIEFA");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_OLDCHIEFA");
    SetCampMob("EN5_OLDWARB",30,25,1);
    SetCampMob("EN5_OLDWARRA",30,25,1);
    SetCampMob("EN5_OLDMAGEB",20);
    SetCampMob("EN5_OLDMAGEA",20);
    }
else if (iLevel<6)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","troglodytes");
    SetLocalString(GetModule(),"CAMP_Boss","en5_trog_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_trog003");
    SetCampMob("en5_trog001",75,40);
    SetCampMob("en5_trog002",25,25,1);
    }
else if (iLevel<7)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","asabi");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_ASABI_CHIEF");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_ASABI_CHIEF");
    SetCampMob("en5_asabi",75,40,1);
    SetCampMob("EN5_ASABI2",25,10);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","yuan ti");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_YUAN_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_YUAN_TI003");
    SetCampMob("EN5_YUAN_TI001",40,20);
    SetCampMob("EN5_YUAN_TI002",40);
    SetCampMob("EN5_YUAN_TI003",20);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetTrolls(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<8)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","trolls");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_TROLL");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_TROLL");
    SetCampMob("EN5_TROLL",100);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","trolls");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_TROLLBOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_TROLLBOSS");
    SetCampMob("EN5_TROLL",50,80);
    SetCampMob("EN5_TROLLWIZ",20);
    SetCampMob("EN5_TROLLCHIEF",30);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetGoblins(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<4)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","goblins");
    SetLocalString(GetModule(),"CAMP_Boss","en5_hgob_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_goblin1");
    SetCampMob("en5_goblin1",45,1);
    SetCampMob("en5_goblin2",45);
    SetCampMob("en5_hobgoblin1",10);
    }
else if (iLevel < 6)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","goblins");
    SetLocalString(GetModule(),"CAMP_Boss","en5_sgob_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_goblin3");
    SetCampMob("en5_goblin1",10,50,1);
    SetCampMob("en5_goblin2",10,50);
    SetCampMob("en5_hobgoblin1",5,50);
    SetCampMob("en5_hobgoblin2",5,50);
    SetCampMob("en5_goblin3",20,1,1);
    SetCampMob("en5_goblin4",20,1,1);
    SetCampMob("en5_goblin5",20,1,1);
    SetCampMob("en5_goblin6",10,1,1);
    }
else if (iLevel < 10)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","goblins");
    SetLocalString(GetModule(),"CAMP_Boss","en5_wgob_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_goblin3");
    SetCampMob("en5_goblin1",10,90,1);
    SetCampMob("en5_goblin2",10,90);
    SetCampMob("en5_hobgoblin1",5,90);
    SetCampMob("en5_hobgoblin2",5,90);
    SetCampMob("en5_goblin3",10,25,1);
    SetCampMob("en5_goblin4",10,25,1);
    SetCampMob("en5_goblin5",10,25,1);
    SetCampMob("en5_goblin6",10,25,1);
    SetCampMob("en5_goblin7",15,10,1,1);
    SetCampMob("en5_goblin8",15,10,1,1);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","goblins");
    SetLocalString(GetModule(),"CAMP_Boss","en5_goblin_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_GOBLIN_ELITE");
    SetCampMob("en5_goblin1",10,90,1);
    SetCampMob("en5_goblin2",10,90);
    SetCampMob("en5_hobgoblin1",5,90);
    SetCampMob("en5_hobgoblin2",5,90);
    SetCampMob("en5_goblin3",10,75,1);
    SetCampMob("en5_goblin4",10,75,1);
    SetCampMob("en5_goblin5",10,75,1);
    SetCampMob("en5_goblin6",10,75,1);
    SetCampMob("en5_goblin7",15,75,1,1);
    SetCampMob("en5_goblin8",15,75,1,1);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}


object GetOrcs(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","orcs");

if (iLevel<2)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_borc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_orc4");
    SetCampMob("en5_orc1",25,10,1);
    SetCampMob("en5_orc2",25,10,1);
    SetCampMob("en5_orc3",25,10,1);
    SetCampMob("en5_orc4",25,10,1);
    }
else if (iLevel < 4)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_uorcs_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_uorc1");
    SetCampMob("en5_uorc1",48,10,1,1);
    SetCampMob("en5_uorc2",48,10,1,1);
    SetCampMob("EN6_WORG_E",4,10);
    }
else if (iLevel < 6)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_eorc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_orc6");
    SetCampMob("en5_orc1",5,90,1);
    SetCampMob("en5_orc2",5,90,1);
    SetCampMob("en5_orc3",5,90,1);
    SetCampMob("en5_orc4",5,90,1);
    SetCampMob("en5_orc5",19,10,1,1);
    SetCampMob("en5_orc6",19,10,1,1);
    SetCampMob("en5_orc7",19,10,1,1);
    SetCampMob("en5_orc8",19,10,1,1);
    SetCampMob("EN6_WORG_E",4,50);
    }
else if (iLevel < 8)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_buorc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_uorc4");
    SetCampMob("en5_uorc1",24,99,1);
    SetCampMob("en5_uorc2",24,99,1);
    SetCampMob("en5_uorc3",24);
    SetCampMob("en5_uorc4",24,10,1,1);
    SetCampMob("EN6_WORG_E",4,50);
    }
else if (iLevel < 9)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_eorc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_orc6");
    SetCampMob("en5_orc1",5,90,1);
    SetCampMob("en5_orc2",5,90,1);
    SetCampMob("en5_orc3",5,90,1);
    SetCampMob("en5_orc4",5,90,1);
    SetCampMob("en5_orc5",19,10,1,1);
    SetCampMob("en5_orc6",19,10,1,1);
    SetCampMob("en5_orc7",19,10,1,1);
    SetCampMob("en5_orc8",19,10,1,1);
    SetCampMob("EN6_WORG_E",4,50);
    }
else if (iLevel < 10)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_buorc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_uorc4");
    SetCampMob("en5_uorc1",24,99,1);
    SetCampMob("en5_uorc2",24,99,1);
    SetCampMob("en5_uorc3",24);
    SetCampMob("en5_uorc4",24,10,1,1);
    SetCampMob("EN6_WORG_E",4,50);
    }
else if (iLevel < 12)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_orc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_orc_elite");
    SetCampMob("en5_orc1",10,90,1);
    SetCampMob("en5_orc2",10,90,1);
    SetCampMob("en5_orc3",10,90,1);
    SetCampMob("en5_orc4",10,90,1);
    SetCampMob("en5_orc5",14,10,1,1);
    SetCampMob("en5_orc6",14,10,1,1);
    SetCampMob("en5_orc7",14,10,1,1);
    SetCampMob("en5_orc8",14,10,1,1);
    SetCampMob("EN6_WORG_E",4,50);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_uorc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_uorc_elite");
    SetCampMob("en5_uorc1",34,99,1);
    SetCampMob("en5_uorc2",34,99,1);
    SetCampMob("en5_uorc3",14,25);
    SetCampMob("en5_uorc4",14,25,1,1);
    SetCampMob("EN6_WORG_E",4,25);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}


object GetWolves(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",0);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",0);

SetLocalString(GetModule(),"EN5_CampDescription","wolves");

if (iLevel<4)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_WOLF");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_WOLF");
    SetCampMob("EN5_WOLF",100,25);
    }
else if (iLevel<10)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_WOLFL");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_WOLFL");
    SetCampMob("EN5_WOLF",95,35);
    SetCampMob("EN5_WEREWOLF2",5,10);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_WOLFDIREBOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_WOLFDIREBOSS");
    SetCampMob("EN5_DIREWOLF",80,40);
    SetCampMob("EN5_WEREWOLF2",20,10);
    }


oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetOgreBoss(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","ogres");

SetLocalString(GetModule(),"CAMP_Boss","en5_ogreboss");
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_ogreboss");
SetCampMob("EN5_OGRILLON",10,70,1);
SetCampMob("en5_ogre01",20,70);
SetCampMob("en5_ogre02",20,70);
SetCampMob("EN5_OGREMAGE01",10);
SetCampMob("EN5_OGREMAGE02",10);
SetCampMob("EN5_OGRECHIEF01",15);
SetCampMob("EN5_OGRECHIEF02",15);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetGiants(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

int iRandom=Random(3)+1;

if (iLevel<3)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","ogrillons");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_OGR_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_OGRILLON");
    SetCampMob("EN5_OGRILLON",100,10,1);
    }
else if (iLevel<6)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","ogres");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_OGRE1_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_ogre01");
    SetCampMob("EN5_OGRILLON",20,10,1);
    SetCampMob("en5_ogre01",40,10,0,1);
    SetCampMob("en5_ogre02",40,10,0,1);
    }
else if (iLevel<8)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","ogres");
    SetLocalString(GetModule(),"CAMP_Boss","en5_ogre_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_OGRECHIEF01");
    SetCampMob("EN5_OGRILLON",10,70,1);
    SetCampMob("en5_ogre01",20,70);
    SetCampMob("en5_ogre02",20,70);
    SetCampMob("EN5_OGREMAGE01",10,10,0,1);
    SetCampMob("EN5_OGREMAGE02",10,10,0,1);
    SetCampMob("EN5_OGRECHIEF01",15,10,0,1);
    SetCampMob("EN5_OGRECHIEF02",15,10,0,1);
    }
else if (iLevel<9)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","ettin");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_ETTIN_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_ETTIN");
    SetCampMob("EN5_ETTIN",100);
    }
else if (iLevel<10)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","ogres");
    SetLocalString(GetModule(),"CAMP_Boss","en5_ogreboss");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_ogreboss");
    SetCampMob("EN5_OGRILLON",10,70,1);
    SetCampMob("en5_ogre01",20,70);
    SetCampMob("en5_ogre02",20,70);
    SetCampMob("EN5_OGREMAGE01",10,1);
    SetCampMob("EN5_OGREMAGE02",10,1);
    SetCampMob("EN5_OGRECHIEF01",15,1);
    SetCampMob("EN5_OGRECHIEF02",15,1);
    }
else if (iLevel<11)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","cyclops");
    SetLocalString(GetModule(),"CAMP_Boss","en5_cyclop_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_CYCLOPSA");
    SetCampMob("EN5_CYCLOPS",100);
    }
else if (iLevel<13)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","giants");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_MGIANT_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gnthill");
    SetCampMob("en5_gnthill",80);
    SetCampMob("EN5_GNTMOUNT",20);
    }
else if (iLevel<15)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","giants");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_FGIANT_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_FGIANT_BOSS");
    SetCampMob("EN5_GNTFROST",70);
    SetCampMob("EN5_GNTFROSTFEM",30);
    }
else if (iLevel<17)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","giants");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_GIANT_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_GIANT_BOSS");
    SetCampMob("EN5_GNTFIRE",70);
    SetCampMob("EN5_GNTFIREFEM",30);
    }
else if (iLevel<20)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","ogres");
    SetLocalString(GetModule(),"CAMP_Boss","en5_ogremgboss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_ogremgboss");
    SetCampMob("EN5_OGREELITE",80);
    SetCampMob("EN5_OGREMAGEE",20);
    }
else if (iLevel<23)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","titans");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_TITANBOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_TITANBOSS");
    SetCampMob("EN6_TITAN",100);
    }
else if (iLevel<25)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","giants");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_GNTSTONE_C");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_GNTSTONE_C");
    SetCampMob("EN6_GNTSTONE",100);
    }
else if (iLevel<30)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","titans");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_ITITAN_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_ITITAN_BOSS");
    SetCampMob("EN6_ITITAN1",20);
    SetCampMob("EN6_ITITAN2",20);
    SetCampMob("EN6_ITITAN3",20);
    SetCampMob("EN6_ITITAN4",20);
    SetCampMob("EN6_ITITAN5",20);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","titans");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_FTITAN_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_FTITAN_BOSS");
    SetCampMob("EN6_FTITAN1",20);
    SetCampMob("EN6_FTITAN2",20);
    SetCampMob("EN6_FTITAN3",20);
    SetCampMob("EN6_FTITAN4",20);
    SetCampMob("EN6_FTITAN5",20);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}


object GetGnolls(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","gnolls");

if (iLevel<3)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_GNOLL1_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gnoll");
    SetCampMob("en5_gnoll",100,10,1);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_GNOLL2_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gnoll2");
    SetCampMob("en5_gnoll",80,70,1);
    SetCampMob("en5_gnoll2",20,10,1,1);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

//Should be used for lvl 12-15sh
object GetMinotaur(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

SetLocalString(GetModule(),"EN5_CampDescription","minotaur");
SetLocalString(GetModule(),"CAMP_Boss","en5_minoboss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_minoboss");
SetCampMob("EN5_MINOTAUR",40,95,1);
SetCampMob("EN5_MinChief",30,10,0,1);
SetCampMob("EN5_MINWIZ",30,10,0,1);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetMonstrous(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<2)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","gibberlings");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_GIBBER_001");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_GIBBER_001");
    SetCampMob("EN6_GIBBER_001",50,20);
    SetCampMob("EN6_GIBBER_002",50,20);
    }
else if (iLevel<3)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","beastmen");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_TROLLOCG");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_TROLLOCG");
    SetCampMob("EN5_TROLLOCB",33,10,1);
    SetCampMob("EN5_TROLLOCG",33,10,1);
    SetCampMob("EN5_TROLLOCH",34,10,1);
    }
else if (iLevel<4)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","stingers");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_STINGER");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_STINGER");
    SetCampMob("EN5_STINGER",100);
    }
else if (iLevel<5)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","meenlocks");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_MEENLOCK4");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_MEENLOCK4");
    SetCampMob("EN5_MEENLOCK1",25);
    SetCampMob("EN5_MEENLOCK2",25);
    SetCampMob("EN5_MEENLOCK3",25);
    SetCampMob("EN5_MEENLOCK4",25);
    }
else if (iLevel<6)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","dragonkin");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_DRGNKIN_C");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_DRGNKIN_C");
    SetCampMob("EN6_DRGNKIN_004",20);
    SetCampMob("EN6_DRGNKIN_002",20);
    SetCampMob("EN6_DRGNKIN_014",20);
    SetCampMob("EN6_DRGNKIN_024",20);
    SetCampMob("EN6_DRGNKIN_018",20);
    }
else if (iLevel<7)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","minotaur");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_MINOTAUR");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_MINOTAUR");
    SetCampMob("EN5_MINOTAUR",100,10,1);
    }
else if (iLevel<12)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","stingers");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_STINGCHIEF");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_STINGCHIEF");
    SetCampMob("EN5_STINGER",40,95);
    SetCampMob("EN5_STINGER_MAGE",30,10,1);
    SetCampMob("EN5_STINGER_WAR",30,10,1);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","minotaur");
    SetLocalString(GetModule(),"CAMP_Boss","en5_minoboss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_Min_Elite");
    SetCampMob("EN5_MINOTAUR",40,95,1);
    SetCampMob("EN5_MinChief",30);
    SetCampMob("EN5_MINWIZ",30);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetBugBear(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<2)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","gnolls");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_GNOLL1_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gnoll");
    SetCampMob("en5_gnoll",100,10,1);
    }
else if (iLevel<3)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","gnolls");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_GNOLL2_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gnoll2");
    SetCampMob("en5_gnoll",80,70,1);
    SetCampMob("en5_gnoll2",20,10,1);
    }
else if (iLevel<4)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","bugbears");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_BBEAR1_BOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_BUGBEARA");
    SetCampMob("EN5_BUGBEARA",50,10,1);
    SetCampMob("EN5_BUGBEARB",50,10,1);
    }
else if (iLevel<7)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","bugbears");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_BUGCHIEFA");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_BUGCHIEFA");
    SetCampMob("EN5_BUGBEARA",20,50,1);
    SetCampMob("EN5_BUGBEARB",20,50,1);
    SetCampMob("EN5_BUGWIZA",15);
    SetCampMob("EN5_BUGWIZB",15);
    SetCampMob("EN5_BUGCHIEFA",15,10,1,1);
    SetCampMob("EN5_BUGCHIEFB",15,10,1,1);
    }
else if (iLevel<10)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","bugbears");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_BUGCHIEFA");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_BUGCHIEFA");
    SetCampMob("EN5_BUGBEARA",20,95,1);
    SetCampMob("EN5_BUGBEARB",20,95,1);
    SetCampMob("EN5_BUGWIZA",15,25);
    SetCampMob("EN5_BUGWIZB",15,25);
    SetCampMob("EN5_BUGCHIEFA",15,25,1,1);
    SetCampMob("EN5_BUGCHIEFB",15,25,1,1);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","bugbears");
    SetLocalString(GetModule(),"CAMP_Boss","en5_bugbearboss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_bugbearboss");
    SetCampMob("EN5_BUGBEARA",20,95,1);
    SetCampMob("EN5_BUGBEARB",20,95,1);
    SetCampMob("EN5_BUGWIZA",15,25);
    SetCampMob("EN5_BUGWIZB",15,25);
    SetCampMob("EN5_BUGCHIEFA",15,25,1,1);
    SetCampMob("EN5_BUGCHIEFB",15,25,1,1);
    }
oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetRats(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",0);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",0);

SetLocalString(GetModule(),"EN5_CampDescription","giant rats");

SetLocalString(GetModule(),"CAMP_Boss","en5_rat2");
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_rat2");
SetCampMob("en5_rat1",60,70);
SetCampMob("en5_rat2",40,5);

oBoss = GetMobCamp(iLevel);
return oBoss;
}

object GetSewer(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",0);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",0);

SetLocalString(GetModule(),"EN5_CampDescription","sewer creatures");

SetLocalString(GetModule(),"CAMP_Boss","en5_rat2");
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_rat2");
SetCampMob("en5_rat2",6,1);
SetCampMob("EN5_GELCUBE",11,1);
SetCampMob("en5_gsnake",6,1);
SetCampMob("EN5_SCORPG002",6,1);
SetCampMob("EN5_BUGCLOUD",6,1);
SetCampMob("EN5_SPIDGIANT",6,1);
SetCampMob("EN5_YUAN_TI001",6,1);
SetCampMob("EN5_TROLL",6,1);
SetCampMob("EN5_ETTERCAP",6,1);
SetCampMob("EN5_BTLSTAG",6,1);
SetCampMob("EN5_SPIDDIRE",6,1);
SetCampMob("EN5_COCKATRICE",6,1);
SetCampMob("en5_greenslime",11,1);
SetCampMob("EN5_WIGHT",6,1);
SetCampMob("en4_seahag",6,1);

oBoss = GetMobCamp(iLevel);
return oBoss;
}


object GetFlyers(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",5 + iLevel/4);

if (iLevel<2)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","stirges");
    SetLocalString(GetModule(),"CAMP_Boss","en5_stirge");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_stirge");
    SetCampMob("en5_stirge",100,25);
    }
else if (iLevel<5)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","wasps");
    SetLocalString(GetModule(),"CAMP_Boss","en5_gwasp");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gwasp");
    SetCampMob("en5_gwasp",100,25);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","harpies");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_HARPY001");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_HARPY001");
    SetCampMob("EN5_HARPY001",100,25);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetConjurers(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<2)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","conjurers");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_conjurer");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_conjurer");
    SetCampMob("en5_elemsmokes",50);
    SetCampNPC("en5_conjurer",50,EN5_CLASS_WIZARD,10,2,1);
    }
else if (iLevel<8)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","conjurers");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_conjurer");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_conjurer");
    SetCampMob("EN5_FIRE",15);
    SetCampMob("EN5_AIR",15);
    SetCampMob("EN5_EARTH",15);
    SetCampMob("EN5_WATER",15);
    SetCampNPC("en5_conjurer",40,EN5_CLASS_WIZARD,10,2,1);
    }
else if (iLevel<13)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","conjurers");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_conjurer");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_conjurer");
    SetCampMob("EN5_FIRE",15,33);
    SetCampMob("EN5_AIR",15,33);
    SetCampMob("EN5_EARTH",15,33);
    SetCampMob("EN5_WATER",15,33);
    SetCampNPC("en5_conjurer",40,EN5_CLASS_WIZARD,10,2,1);
    }
else if (iLevel<17)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","conjurers");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_conjurer");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_conjurer");
    SetCampMob("EN5_EARTHHUGE",15);
    SetCampMob("EN5_WATERHUGE",15);
    SetCampMob("EN5_FIREHUGE",15);
    SetCampMob("EN5_AIRHUGE",8);
    SetCampMob("EN5_INVSTALK",7);
    SetCampNPC("en5_conjurer",40,EN5_CLASS_WIZARD,10,2,1);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","conjurers");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_conjurer");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_conjurer");
    SetCampMob("EN5_AIRELDER",15);
    SetCampMob("EN5_EARTHELD",15);
    SetCampMob("EN5_FIREELDER",15);
    SetCampMob("EN5_WATELDER",15);
    SetCampNPC("en5_conjurer",40,EN5_CLASS_WIZARD,10,2,1);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetAnimators(int iLevel)
{
object oBoss;

if (iLevel <25)
    if (iLevel % 2 == 0)
        oBoss=GetConjurers(iLevel);
    else
        oBoss=GetGolems(iLevel);
else
    oBoss=GetGolems(iLevel);

return oBoss;
}

object GetGolems(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<5)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","animators");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_animator");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_animator");
    SetCampMob("EN5_ANIMCUTTER",40);
    SetCampNPC("en5_animator",30,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_animator",30,EN5_CLASS_WIZARD,10,2,1);
    }
else if (iLevel<14)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","animators");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_animator");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_animator");
    SetCampMob("EN5_MAUG",20,50);
    SetCampMob("EN5_MAUGHSERG",5);
    SetCampMob("EN5_MECHSPIDER",15,50);
    SetCampMob("EN5_ANIMCUTTER",10,50);
    SetCampNPC("en5_animator",25,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_animator",25,EN5_CLASS_WIZARD,10,2,1);
    }
else if (iLevel<16)
    {
    if (Random(2)==0)
        {
        SetLocalString(GetModule(),"EN5_CampDescription","animators");
        SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
        SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
        SetLocalInt(GetModule(),"CAMP_BossEquip",2);
        SetLocalString(GetModule(),"CAMP_Boss","en5_animator");
        SetLocalInt(GetModule(),"CAMP_BossCount",5);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_animator");
        SetCampMob("EN5_GolClay",15);
        SetCampMob("EN5_GOLFLESH",15);
        SetCampMob("EN5_MINOGON",15);
        SetCampMob("EN5_MECHSPIDER",15,80);
        SetCampNPC("en5_animator",20,EN5_CLASS_CLERIC,10,2,1);
        SetCampNPC("en5_animator",20,EN5_CLASS_WIZARD,10,2,1);
        } else {
        SetLocalString(GetModule(),"EN5_CampDescription","animators");
        SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
        SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
        SetLocalInt(GetModule(),"CAMP_BossEquip",2);
        SetLocalString(GetModule(),"CAMP_Boss","en5_animator");
        SetLocalInt(GetModule(),"CAMP_BossCount",5);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_animator");
        SetCampMob("EN6_SHGUARD_002",8);
        SetCampMob("EN6_SHGUARD_003",8);
        SetCampMob("EN6_SHGUARD_004",8);
        SetCampMob("EN6_SHGUARD_005",8);
        SetCampMob("EN6_SHGUARD_006",8);
        SetCampMob("EN6_SHGUARD_007",8);
        SetCampMob("EN6_SHGUARD_008",8);
        SetCampMob("EN6_SHGUARD_009",8);
        SetCampMob("EN6_SHGUARD_010",8);
        SetCampMob("EN6_SHGUARD_011",8);
        SetCampMob("EN6_SHGUARD_012",8);
        SetCampNPC("en5_animator",6,EN5_CLASS_CLERIC,10,2,1);
        SetCampNPC("en5_animator",6,EN5_CLASS_WIZARD,10,2,1);
        }
    }
else if (iLevel<20)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","animators");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_animator");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_animator");
    SetCampMob("EN5_GolClay",5);
    SetCampMob("EN5_GOLFLESH",5);
    SetCampMob("EN5_MINOGON",5);
    SetCampMob("EN5_GolBone",5);
    SetCampMob("EN5_HELMHORR",5);
    SetCampMob("EN5_GOLSTONE",10);
    SetCampMob("EN5_BATHORROR",5);
    SetCampMob("EN5_GOLIRON",10);
    SetCampMob("EN5_SHGUARD",10);
    SetCampNPC("en5_animator",20,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_animator",20,EN5_CLASS_WIZARD,10,2,1);
    }
else if (iLevel<30)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","maug");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_MAUGCOM");
    SetLocalInt(GetModule(),"CAMP_BossCount",4);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_MAUGCOM");
    SetCampMob("EN5_MAUG",20,99);
    SetCampMob("EN5_MAUGHSERG",20,75);
    SetCampMob("EN5_MAUGLIEU",20,50);
    SetCampMob("EN5_MAUGCAP",20,25);
    SetCampNPC("en5_animator",10,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_animator",10,EN5_CLASS_WIZARD,10,2,1);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","animators");
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_animator");
    SetLocalInt(GetModule(),"CAMP_BossCount",5);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_animator");
    SetCampMob("EN5_GOLIRON",10,90);
    SetCampMob("EN5_GOLIRON_HUGE",10,50);
    SetCampMob("en5_goldmflesh",10);
    SetCampMob("EN5_GOLEM002",15);
    SetCampMob("EN5_MITHGOLEM",15);
    SetCampNPC("en5_animator",20,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_animator",20,EN5_CLASS_WIZARD,10,2,1);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}


object GetCultist(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","cultists");

if (iLevel<2)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_mdemon");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_mdemon");
    SetCampNPC("en5_cultist",30,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",30,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",20,EN5_CLASS_ROGUE);
    SetCampNPC("en5_cultist",20,EN5_CLASS_FIGHTER);
    }
else if (iLevel<3)
    {
    if (Random(2)==0)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_imp");
        SetLocalInt(GetModule(),"CAMP_BossCount",1);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_imp");
        } else {
        SetLocalString(GetModule(),"CAMP_Boss","en5_quasit");
        SetLocalInt(GetModule(),"CAMP_BossCount",1);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_quasit");
        }
    SetCampNPC("en5_cultist",25,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",25,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",20,EN5_CLASS_ROGUE);
    SetCampNPC("en5_cultist",20,EN5_CLASS_FIGHTER);
    SetCampMob("en5_mdemon",10);
    }
else if (iLevel<7)
    {
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_CLERIC);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_cultist");
    SetLocalInt(GetModule(),"CAMP_BossCount",4);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_cultist");
    SetCampNPC("en5_cultist",25,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",20,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",15,EN5_CLASS_ROGUE);
    SetCampNPC("en5_cultist",10,EN5_CLASS_FIGHTER);
    SetCampMob("en5_quasit",5);
    SetCampMob("en5_imp",5);
    SetCampMob("EN5_HELLHOUND",10);
    SetCampMob("EN5_SHMASTIF",5);
    SetCampMob("EN5_BEASTXVIM",5);
    }
else if (iLevel<10)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_SUCBOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_DMSUCUBUS");
    SetCampNPC("en5_cultist",20,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",20,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",10,EN5_CLASS_ROGUE);
    SetCampNPC("en5_cultist",6,EN5_CLASS_FIGHTER);
    SetCampMob("en5_quasit",2,50);
    SetCampMob("en5_imp",2,50);
    SetCampMob("EN5_HELLHOUND",10,50);
    SetCampMob("EN5_SHMASTIF",15,50);
    SetCampMob("EN5_BEASTXVIM",15,50);
    }
else if (iLevel<13)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_VROCKBOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_DMVROCK");
    SetCampNPC("en5_cultist",20,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",20,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",5,EN5_CLASS_ASSASSIN);
    SetCampNPC("en5_cultist",10,EN5_CLASS_BLACKGUARD);
    SetCampMob("EN5_DMSUCUBUS",5);
    SetCampMob("EN5_erinyes",5);
    SetCampMob("EN5_HELLHOUND",5,95);
    SetCampMob("EN5_HALFFND001",10);
    SetCampMob("EN5_HAMATULA",5);
    SetCampMob("EN5_OSYLUTH1",5);
    SetCampMob("EN5_SPIDFIEND" + IntToString(Random(5)+1),5);
    SetCampMob("EN6_MEZZOLOTH",5);
    }
else if (iLevel<16)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_GELUGON");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_GELUGON");
    SetCampNPC("en5_cultist",15,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",15,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",10,EN5_CLASS_ASSASSIN);
    SetCampNPC("en5_cultist",10,EN5_CLASS_BLACKGUARD);
    SetCampMob("EN5_DMSUCUBUS",3);
    SetCampMob("EN5_erinyes",3);
    SetCampMob("EN5_BEASTXVIM",4,95);
    SetCampMob("EN5_HALFFND001",5);
    SetCampMob("EN5_DMVROCK",5);
    SetCampMob("EN5_HAMATULA",5);
    SetCampMob("EN5_OSYLUTH1",5);
    SetCampMob("EN5_SPIDFIEND" + IntToString(Random(5)+1),5);
    SetCampMob("EN5_CORNUGON",5);
    SetCampMob("EN5_HAMATULA_35E",5);
    SetCampMob("EN5_DEMONVORLAN",5);
    }
else if (iLevel<23)
    {
    int iRandom = Random(3)+1;
    if (iRandom==1)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_PFIEND");
        SetLocalInt(GetModule(),"CAMP_BossCount",2);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_DEVIL001");
        }
    if (iRandom==2)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_DEMONL");
        SetLocalInt(GetModule(),"CAMP_BossCount",2);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_DEMONL");
        }
    if (iRandom==3)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_BALROG");
        SetLocalInt(GetModule(),"CAMP_BossCount",2);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_BALROG");
        }
    SetCampNPC("en5_cultist",15,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",15,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",5,EN5_CLASS_ASSASSIN);
    SetCampNPC("en5_cultist",10,EN5_CLASS_BLACKGUARD);
    SetCampMob("EN5_DMVROCK",5);
    SetCampMob("EN5_HAMATULA",5);
    SetCampMob("EN5_OSYLUTH1",5);
    SetCampMob("EN5_CORNUGON",5);
    SetCampMob("EN5_HAMATULA_35E",5);
    SetCampMob("EN5_DEMONVORLAN",5);
    SetCampMob("EN5_GELUGON",5);
    SetCampMob("EN5_GLABREZU",5);
    SetCampMob("EN5_CORNUGONGR",5);
    SetCampMob("EN5_DEMON",5);
    SetCampMob("EN6_BALOR_LIGHT",3);
    SetCampMob("EN6_BALOR_ICE",2);

    }
else if (iLevel<25)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en6_apfiend");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","en6_apfiend");
    SetCampNPC("en5_cultist",15,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",15,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",10,EN5_CLASS_ASSASSIN);
    SetCampNPC("en5_cultist",10,EN5_CLASS_BLACKGUARD);
    SetCampMob("EN5_DEVIL001",20);
    SetCampMob("EN6_NABASSU",5,20);
    SetCampMob("EN5_HAMATULA_35E",5,50);
    SetCampMob("EN5_DEMONVORLAN",5,50);
    SetCampMob("EN5_GLABREZU",5,50);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_FIGHTER);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_BARD);
    }
else if (iLevel<28)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en6_abalor");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","en6_abalor");
    SetCampNPC("en5_cultist",15,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",15,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",10,EN5_CLASS_ASSASSIN);
    SetCampNPC("en5_cultist",10,EN5_CLASS_BLACKGUARD);
    SetCampMob("EN5_DEMON",15,25);
    SetCampMob("EN6_BALOR_LIGHT",5,25);
    SetCampMob("EN6_BALOR_ICE",5,25);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_FIGHTER);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_BARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_CLERIC);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_WIZARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_ASSASSIN);
    }
else if (iLevel<33)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en6_abalorm");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","en6_abalorm");
    SetCampNPC("en5_cultist",15,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",15,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",10,EN5_CLASS_ASSASSIN);
    SetCampNPC("en5_cultist",10,EN5_CLASS_BLACKGUARD);
    SetCampMob("EN5_DEMON",25,50);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_FIGHTER);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_BARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_CLERIC);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_WIZARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_ASSASSIN);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN6_ABALROG");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_ABALROG");
    SetCampNPC("en5_cultist",15,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_cultist",15,EN5_CLASS_WIZARD,10,2,1);
    SetCampNPC("en5_cultist",10,EN5_CLASS_ASSASSIN);
    SetCampNPC("en5_cultist",10,EN5_CLASS_BLACKGUARD);
    SetCampMob("EN5_BALROG",25,50);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_FIGHTER);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_BARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_CLERIC);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_WIZARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_ASSASSIN);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetFiendish(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","half-fiends");

SetLocalInt(GetModule(),"CAMP_BossLevelup",1);

if (Random(2)==0)
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_BLACKGUARD);
else if (Random(2)==0)
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_MONK);
else
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_SHADOWDANCER);

SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetLocalString(GetModule(),"CAMP_Boss","en6_fiend_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en6_fiend_boss");

SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_MONK,10,2,1);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_BLACKGUARD);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_FIGHTERROGUE,10,2,1);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_FIGHTERCLERIC);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_BARD);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_CLERIC);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_WIZARD);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_MONKSORCERER);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_SHADOWDANCER);
if (iLevel<15)
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_CLERIC);
else if (iLevel<20)
    SetCampMob("EN5_DEMON",10,10);
else if (iLevel<28)
    SetCampMob("EN5_MERILITH2",10,10);
else
    {
    SetCampMob("en6_abalor",4,10);
    SetCampMob("en6_abalor2",3,10);
    SetCampMob("EN5_MERILITH2",3,10);
    }


oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetCelestial(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","celestial beings");

if (iLevel<3)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_CLANTERN");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_CLANTERN");
    SetCampNPC("en5_human",50,EN5_CLASS_CLERIC);
    SetCampNPC("en5_elf",50,EN5_CLASS_CLERIC);
    }
else if (iLevel<6)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_LUPINAL5");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_LUPINAL5");
    SetCampMob("EN5_CLANTERN",30,10);
    SetCampMob("EN5_LUPINAL1",30,10);
    SetCampMob("EN5_LUPINAL5",30,10);
    SetCampNPC("en5_human",5,EN5_CLASS_CLERIC);
    SetCampNPC("en5_elf",5,EN5_CLASS_CLERIC);
    }
else if (iLevel<11)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_HALFCEL001");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_HALFCEL001");
    SetCampMob("EN5_CLANTERN",15,80);
    SetCampMob("EN5_LUPINAL1",15,50);
    SetCampMob("EN5_LUPINAL5",15,50);
    SetCampMob("EN5_CHOUND01",30,10);
    SetCampMob("EN5_HALFCEL001",15,10);
    SetCampNPC("en5_human",5,EN5_CLASS_CLERIC);
    SetCampNPC("en5_elf",5,EN5_CLASS_CLERIC);
    }
else if (iLevel<15)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_CTRUMPET");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_CTRUMPET");
    SetCampMob("EN5_CLANTERN",15,80);
    SetCampMob("EN5_LUPINAL1",15,50);
    SetCampMob("EN5_LUPINAL5",15,50);
    SetCampMob("EN5_CHOUND01",30,10);
    SetCampMob("EN5_HALFCEL001",10,10);
    SetCampMob("EN5_CTRUMPET",5,10);
    SetCampNPC("en5_human",5,EN5_CLASS_CLERIC);
    SetCampNPC("en5_elf",5,EN5_CLASS_CLERIC);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_PLANETARM");
    SetLocalInt(GetModule(),"CAMP_BossCount",1);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_PLANETARM");
    SetCampMob("EN5_CLANTERN",5,80);
    SetCampMob("EN5_LUPINAL1",5,50);
    SetCampMob("EN5_LUPINAL5",5,50);
    SetCampMob("EN5_CHOUND01",5,50);
    SetCampMob("EN5_HALFCEL001",35,10);
    SetCampMob("EN5_CTRUMPET",35,10);
    SetCampNPC("en5_human",5,EN5_CLASS_CLERIC);
    SetCampNPC("en5_elf",5,EN5_CLASS_CLERIC);
    }
oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetSnowCreatures(int iLevel)
{
object oBoss;
int iRandom;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","snow creatures");

if (iLevel<7)
    {
    iRandom = Random(3)+1;
    if (iRandom==1)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_ICEKOBOLDSHA");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_ICEKOBOLDSHA");
        SetLocalString(GetModule(),"EN5_CampDescription","ice kobolds");
        SetCampMob("en5_ICEKOBOLD",75);
        SetCampMob("en5_IKOBOLDNOB",25);
        }
    if (iRandom==2)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_sorc1");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_sorc1");
        SetLocalString(GetModule(),"EN5_CampDescription","snow orcs");
        SetCampMob("en5_sorc1",100,10,1);
        }
    if (iRandom==3)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_sgob_wiz");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_sgob_wiz");
        SetLocalString(GetModule(),"EN5_CampDescription","frost goblins");
        SetCampMob("en5_sgoblin",100);
        }
    }
else if (iLevel<12)
    {
    if (Random(2)==0)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_ARCTICBUGBSH");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_ARCTICBUGBSH");
        SetLocalString(GetModule(),"EN5_CampDescription","artic bugbears");
        SetCampMob("en5_ARCTICBUGB",100);
        } else {
        SetLocalString(GetModule(),"CAMP_Boss","en5_sorc_sh");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_sorc_sh");
        SetLocalString(GetModule(),"EN5_CampDescription","snow orcs");
        SetCampMob("en5_sorc1",70,40,1);
        SetCampMob("en5_sorc_ch",30,10,1);
        }
    }
else
    {
    if (Random(2)==0)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_BUGBCH");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_BUGBCH");
        SetLocalString(GetModule(),"EN5_CampDescription","artic bugbears");
        SetCampMob("en5_ARCTICBUGB",50,50);
        SetCampMob("en5_ARCTICBUGBSH",50);
        } else {
        SetLocalString(GetModule(),"CAMP_Boss","en5_sgob_chief");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_sgob_chief");
        SetLocalString(GetModule(),"EN5_CampDescription","frost goblins");
        SetCampMob("en5_sgoblin",70,40);
        SetCampMob("en5_sgob_wiz",30,20);
        }
    }

oBoss = GetMobCamp(iLevel);
//GetError("Snow Test");

return oBoss;
}

object GetExtraPlanar(int iLevel)
{
int iRandom;
object oBoss;


if (iLevel<30)
    {
    iRandom=Random(8)+1;
    if (iRandom<3)
        oBoss=GetPlanar(iLevel);
    else if (iRandom<5)
        oBoss=GetOutsiders(iLevel);
    else if (iRandom<6)
        if (iLevel>15)
            oBoss=GetFiendish(iLevel);
        else
            oBoss=GetPlanar(iLevel);
    else
        oBoss=GetCultist(iLevel);
    } else {
    iRandom=Random(8)+1;
    if (iRandom<3)
        oBoss=GetPlanar(iLevel);
    else if (iRandom<5)
        oBoss=GetOutsiders(iLevel);
    else if (iRandom<7)
        oBoss=GetFiendish(iLevel);
    else
        oBoss=GetCultist(iLevel);
    }

return oBoss;
}

object GetOutsiders(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<3)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","formians");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_FORM_WORKER");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_FORM_WORKER");
    SetCampMob("EN5_FORM_WORKER",100);
    }
else if (iLevel<5)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","formians");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_FORM_WARRIOR");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_FORM_WARRIOR");
    SetCampMob("EN5_FORM_WORKER",100,50);
    }
else if (iLevel<7)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","salamanders");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_SALA");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SALA");
    SetCampMob("EN5_SALAFLAMEBRO",100,50);
    }
else if (iLevel<9)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","abishai");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_ABISHAIB_003");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_ABISHAIB_003");
    SetCampMob("EN6_ABISHAIB_003",60);
    SetCampMob("EN6_ABISHAIW_002",40);
    }
else if (iLevel<11)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","formians");
    SetLocalString(GetModule(),"CAMP_Boss","en5_form_taskmas");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_form_taskmas");
    SetCampMob("EN5_FORM_WORKER",50,99);
    SetCampMob("EN5_FORM_WARRIOR",50,50,0,1);
    }
else if (iLevel<12)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","formians");
    SetLocalString(GetModule(),"CAMP_Boss","en5_form_myrmarc");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_form_myrmarc");
    SetCampMob("EN5_FORM_WORKER",30,99);
    SetCampMob("EN5_FORM_WARRIOR",30,75);
    SetCampMob("en5_form_taskmas",40,50,0,1);
    }
else if (iLevel<13)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","salamanders");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_SALANOB");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SALANOB");
    SetCampMob("EN5_SALAFLAMEBRO",50,99);
    SetCampMob("EN5_SALA",50,50,0,1);
    }
else if (iLevel<14)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","slaad");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_SLAADGRYBOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SLAADGRYBOSS");
    SetCampMob("EN5_SLAADRED",33);
    SetCampMob("EN5_SLAADBL",33);
    SetCampMob("EN5_SLAADGRN",34);
    }
else if (iLevel<15)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","abishai");
    SetLocalString(GetModule(),"CAMP_Boss","EN6_ABISHAIR_002");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN6_ABISHAIR_002");
    SetCampMob("EN6_ABISHAIW_002",20,90);
    SetCampMob("EN6_ABISHAIB_003",20,75);
    SetCampMob("EN6_ABISHAIG_002",30,25);
    SetCampMob("EN6_ABISHAIB_004",30);
    }
else if (iLevel<20)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","slaad");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_SLAADDTHBOSS");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SLAADDTHBOSS");
    SetCampMob("EN5_SLAADRED",20);
    SetCampMob("EN5_SLAADBL",20);
    SetCampMob("EN5_SLAADGRN",30);
    SetCampMob("EN5_SLAADGRAY",30);
    }
else if (iLevel<25)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","formians");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_FORM_QUEEN");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_FORM_QUEEN");
    SetCampMob("en5_form_myrmarc",50,15,0,1);
    SetCampMob("EN5_FORM_WARRIOR",25,99);
    SetCampMob("en5_form_taskmas",25,75);
    }
else if (iLevel<30)
    {
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_BLACKGUARD);
    SetLocalString(GetModule(),"EN5_CampDescription","half-fiends");
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en6_fiend_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en6_fiend_boss");

    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_FIGHTER,10,2,1);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_MONK,10,2,1);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_BLACKGUARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_WEAPON_MASTER);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_FIGHTERROGUE,10,2,1);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_FIGHTERCLERIC);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_BARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_CLERIC);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),5,EN5_CLASS_WIZARD);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_MONKSORCERER);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_ASSASSIN,10,2,1);
    SetCampNPC("en6_fiend" + IntToString(Random(6)+1),10,EN5_CLASS_SHADOWDANCER);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","slaad");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_SLAADBLACK");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SLAADBLACK");
    SetCampMob("EN5_SLAADWHITE",75);
    SetCampMob("EN5_SLAADDETH",25,25);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetUnkempt(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","unkempt druids");

SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_SHIFTER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetLocalString(GetModule(),"CAMP_Boss","en5_unkemp_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",1);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_unkempt");
SetCampNPC("en5_unkempt",35,EN5_CLASS_DRUID,10,2,1);
SetCampNPC("en5_unkempt",30,EN5_CLASS_SHIFTER,10,2,1);
SetCampNPC("en5_unkempt",15,EN5_CLASS_RANGER,10,2,1);

if (iLevel<3)
    SetCampMob("EN5_WOLF2",20);
else if (iLevel<5)
    SetCampMob("EN5_LION2",20);
else if (iLevel<9)
    {
    SetCampMob("EN5_WOLFWINT2",5);
    SetCampMob("EN5_BEARBRWN2",15);
    }
else if (iLevel<15)
    SetCampMob("EN5_BEARDIRE2",20);
else
    SetCampMob("EN5_ADBEAR",20);



oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetBlighted(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","blight followers");

SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_SHIFTER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetLocalString(GetModule(),"CAMP_Boss","en5_blight_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",1);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_blight");
SetCampNPC("en5_blight",30,EN5_CLASS_DRUID,10,2,1);
SetCampNPC("en5_blight",30,EN5_CLASS_SHIFTER,10,2,1);
SetCampNPC("en5_blight",20,EN5_CLASS_RANGER,10,2,1);

if (iLevel<5)
    SetCampMob("EN5_DPANTHER",20);
else if (iLevel<7)
    SetCampMob("EN5_DBRBEAR",20);
else if (iLevel<9)
    {
    SetCampMob("EN5_BEASTMALAR2",5);
    SetCampMob("EN5_DBRBEAR",15);
    }
else if (iLevel<11)
    SetCampMob("EN5_DBEAR2",20);
else if (iLevel<15)
    SetCampMob("EN5_DTIGER2",20);
else
    SetCampMob("EN5_DADBEAR",20);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetNecromancers(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","necromancers");

if (iLevel<4)
    {
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_PALEMASTER);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_necro_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_necro_boss");
    SetCampNPC("en5_necro3",30,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_necro",30,EN5_CLASS_WIZARD,10,2,1);
    SetCampMob("en5_skeleton",20);
    SetCampMob("en5_zombie1",20);
    }
else if (iLevel<7)
    {
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_PALEMASTER);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_necro_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_necro_boss");
    SetCampNPC("en5_necro3",30,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_necro",30,EN5_CLASS_WIZARD,10,2,1);
    SetCampMob("EN5_ZOMBWARR",15);
    SetCampMob("EN6_GSKELETON",10);
    SetCampMob("EN6_GHOST1",2);
    SetCampMob("EN6_GHOST2",1);
    SetCampMob("EN6_GHOST3",1);
    SetCampMob("EN6_GHOST4",1);
    SetCampMob("EN5_WIGHT",10);
    }
else if (iLevel<11)
    {
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_PALEMASTER);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_necro_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_necro_boss");
    SetCampNPC("en5_necro3",30,EN5_CLASS_CLERIC);
    SetCampNPC("en5_necro",30,EN5_CLASS_WIZARD);
    SetCampMob("EN5_SKELWARR",20);
    SetCampMob("EN6_GHOST4",10);
    SetCampMob("EN5_SKELMAGE",10);
    }
else if (iLevel<16)
    {
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_PALEMASTER);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_necro_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_necro_boss");
    SetCampNPC("en5_necro3",25,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_necro",25,EN5_CLASS_WIZARD,10,2,1);
    SetCampMob("EN5_MUMMY",20,75);
    SetCampMob("EN5_MUMCLERIC",15);
    SetCampMob("EN5_MUMFIGHT",15);
    }
else
    {
    SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
    SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_PALEMASTER);
    SetLocalInt(GetModule(),"CAMP_BossEquip",2);
    SetLocalString(GetModule(),"CAMP_Boss","en5_necro_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_necro_boss");
    SetCampNPC("en5_necro3",25,EN5_CLASS_CLERIC,10,2,1);
    SetCampNPC("en5_necro",25,EN5_CLASS_WIZARD,10,2,1);
    SetCampMob("en5_wraith",10);
    SetCampMob("en5_spectre",10);
    SetCampMob("EN5_DOOMKGHT",10);
    SetCampMob("EN5_MOHRG",10);
    SetCampMob("EN5_MUMFIGHT",5);
    SetCampMob("EN6_REAVER_001",5);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetDragons(int iLevel)
{
object oBoss;
string sTag;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",10 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",25 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","dragons");

SetLocalString(GetModule(),"CAMP_Boss","EN6_SDRAGON");
SetLocalInt(GetModule(),"CAMP_BossCount",2);
SetLocalString(GetModule(),"CAMP_BossAlt","EN6_SDRAGON");
SetCampMob("NW_DRGBLACK001",3);
SetCampMob("NW_DRGBLACK002",5);
SetCampMob("NW_DRGBLACK003",12);
SetCampMob("NW_DRGWHITE001",3);
SetCampMob("NW_DRGWHITE002",5);
SetCampMob("NW_DRGWHITE003",12);
SetCampMob("NW_DRGBLUE001",3);
SetCampMob("NW_DRGBLUE002",5);
SetCampMob("NW_DRGBLUE003",12);
SetCampMob("NW_DRGRED001",3);
SetCampMob("NW_DRGRED002",5);
SetCampMob("NW_DRGRED003",12);
SetCampMob("NW_DRGGREEN001",3);
SetCampMob("NW_DRGGREEN002",5);
SetCampMob("NW_DRGGREEN003",12);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetADragon(int iLevel,string sColor="")
{
int iRandom;
object oBoss;
string sWColor;
string sBoss;

if (sColor=="")
    {
    sColor="BLACK";
    iRandom=Random(5)+1;
    switch (iRandom)
        {
        case 1: sColor="WHITE"; break;
        case 2: sColor="BLACK"; break;
        case 3: sColor="BLUE"; break;
        case 4: sColor="GREEN"; break;
        case 5: sColor="RED"; break;
        }
    }

if (sColor=="SHADOW")
    sWColor="BLK";
if (sColor=="BLACK")
    sWColor="BLK";
if (sColor=="WHITE")
    sWColor="WHT";
if (sColor=="BLUE")
    sWColor="BLU";
if (sColor=="GREEN")
    sWColor="GRN";
if (sColor=="RED")
    sWColor="RED";


if (iLevel<16)
    sBoss="NW_DRG" + sColor + "001";
else if (iLevel<21)
    sBoss="NW_DRG" + sColor + "002";
else
    if (Random(6)==1)
        sBoss="EN6_SDRAGON";
    else
        sBoss="NW_DRG" + sColor + "003";

if (sColor=="SHADOW")
    sBoss="EN6_SDRAGON";

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",10 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",25 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","a dragon");

SetLocalString(GetModule(),"CAMP_Boss",sBoss);
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt",sBoss);
SetCampMob("EN5_HALFDRACLR",30);
SetCampMob("EN5_HALFDRAFTR",20);
SetCampMob("EN5_HALFDRASOR",30);
SetCampMob("EN5_WYRMLING_" + sWColor,20,50);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetHalfDragons(int iLevel, string sBoss="EN5_HALFDRAFTR",int iWyrmling = 0)
{
object oBoss;
string sTag;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","half-dragons");

SetLocalString(GetModule(),"CAMP_Boss",sBoss);
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt",sBoss);
SetCampMob("EN5_HALFDRACLR",30);
SetCampMob("EN5_HALFDRAFTR",20);
SetCampMob("EN5_HALFDRASOR",30);
if (iWyrmling == 0)
    {
    SetCampMob("EN5_WYRMLING_BLK",4,50);
    SetCampMob("EN5_WYRMLING_BLU",4,50);
    SetCampMob("EN5_WYRMLING_GRN",4,50);
    SetCampMob("EN5_WYRMLING_RED",4,50);
    SetCampMob("EN5_WYRMLING_WHT",4,50);
    } else {
    switch (iWyrmling)
        {
        case 1: sTag="EN5_WYRMLING_BLK"; break;
        case 2: sTag="EN5_WYRMLING_BLU"; break;
        case 3: sTag="EN5_WYRMLING_GRN"; break;
        case 4: sTag="EN5_WYRMLING_RED"; break;
        case 5: sTag="EN5_WYRMLING_WHT"; break;
        }
    SetCampMob(sTag,20,50);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetUndead(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","undead");

if (iLevel<3)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_zombie1");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_skeleton");
    SetCampMob("en5_skeleton",60,10,1);
    SetCampMob("en5_zombie1",30);
    SetCampMob("en5_zombie2",10);
    }
else if (iLevel<4)
    {
    SetLocalString(GetModule(),"CAMP_Boss","EN5_SKELOGRE");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SKELOGRE");
    SetCampMob("en5_skeleton",80,10,1);
    SetCampMob("EN5_SKELDWARF",20,10,1);
    }
else if (iLevel<7)
    {
    int iRandom=Random(4)+1;
    if (iRandom==1)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_GHOULLORD");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_GHOULLORD");
        SetCampMob("EN5_GHOUL",50,25);
        SetCampMob("EN5_GHAST",30);
        SetCampMob("EN5_WIGHT",10);
        SetCampMob("EN6_GHOST1",3);
        SetCampMob("EN6_GHOST2",3);
        SetCampMob("EN6_GHOST3",2);
        SetCampMob("EN6_GHOST4",2);
        }
    if (iRandom==2)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_rdead");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_rdead");
        SetCampMob("en5_skeleton",40,95,1);
        SetCampMob("EN5_SKELDWARF",5,50,1);
        SetCampMob("EN5_SKELMAGE",20);
        SetCampMob("EN5_SKELPRIEST",20,10,0,1);
        SetCampMob("EN5_BATBONE",5);
        SetCampMob("EN6_GSKELETON",10);
        }
    if (iRandom==3)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_ZOMBWARR2");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_ZOMBWARR2");
        SetCampMob("en5_zombie",30,50);
        SetCampMob("en5_zombie2",30,50);
        SetCampMob("EN5_ZOMBWARR",40,10,0,1);
        }
    if (iRandom==4)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_CURST001");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_CURST001");
        SetCampMob("EN5_CURST001",25,10);
        SetCampMob("EN5_CURST002",25,10);
        SetCampMob("EN5_CURST003",25,10);
        SetCampMob("EN5_CURST004",25,10);
        }
    }
else if (iLevel<11)
    {
    int iRandom=Random(4)+1;
    if (iRandom==1)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_SKELCHIEF");
        SetLocalInt(GetModule(),"CAMP_BossCount",1);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SKELCHIEF");
        SetCampMob("en5_skeleton",20,95,1);
        SetCampMob("EN5_SKELDWARF",5,50,1);
        SetCampMob("EN5_SKELMAGE",15);
        SetCampMob("EN5_SKELWARR",15,10,1);
        SetCampMob("EN5_SKELWARR2",15,10,1,1);
        SetCampMob("EN6_GSKELETON",10,10,1);
        SetCampMob("EN5_SKELPRIEST",15);
        SetCampMob("EN5_BATBONE",5);
        }
    if (iRandom==2)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_ZOMBIEBOSS");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_ZOMBIEBOSS");
        SetCampMob("en5_zombie",10,50);
        SetCampMob("en5_zombie2",10,50);
        SetCampMob("EN5_ZOMBWARR2",40,10,0,1);
        SetCampMob("EN5_ZOMBWARR",40,10);
        }
    if (iRandom==3)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_SHFIEND");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_SHFIEND");
        SetCampMob("EN5_SHADOW",100,50);
        }
    if (iRandom==4)
        {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_VISAGEGR");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_VISAGEGR");
        SetCampMob("EN5_ALLIP",50,50);
        SetCampMob("EN5_VISAGE",30,10,0,1);
        SetCampMob("EN6_GHOST1",5,40);
        SetCampMob("EN6_GHOST2",5,40);
        SetCampMob("EN6_GHOST3",5,40);
        SetCampMob("EN6_GHOST4",5,40);
        }
    }
else if (iLevel<15)
    {
        SetLocalString(GetModule(),"CAMP_Boss","EN5_MUMMYBOSS");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_MUMMYBOSS");
        SetCampMob("EN5_MUMMY",30,75);
        SetCampMob("EN5_MUMCLERIC",30);
        SetCampMob("EN5_MUMFIGHT",30,10,1,1);
        SetCampMob("EN4_GHOULBOSS",10);
    }
else if (iLevel<19)
    {
    int iRandom=Random(2)+1;
    if (iRandom==1)
        {
        SetLocalString(GetModule(),"CAMP_Boss","en5_doomktboss");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_doomktboss");
        SetCampMob("EN5_DOOMKGHT",100,10);
        }
    if (iRandom==2)
        {
        SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
        SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_PALEMASTER);
        SetLocalInt(GetModule(),"CAMP_BossEquip",2);
        SetLocalString(GetModule(),"CAMP_Boss","en5_necro");
        SetLocalInt(GetModule(),"CAMP_BossCount",2);
        SetLocalString(GetModule(),"CAMP_BossAlt","en5_necro");
        SetCampMob("en5_skeleton",30,99,1);
        SetCampMob("en5_zombie1",35,99);
        SetCampMob("en5_wraith",5,30);
        SetCampMob("en5_spectre",5,30);
        SetCampMob("EN6_REAVER_001",5);
        SetCampMob("EN5_DOOMKGHT",5);
        SetCampNPC("en5_necro",15,EN5_CLASS_PALEMASTER,10,2,1);
        }
    }
else if (iLevel<22)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_spctrmboss");
    SetLocalInt(GetModule(),"CAMP_BossCount",4);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_spectremg");
    SetCampMob("en5_wraith",40,30,0,1);
    SetCampMob("en5_spectre",40,30,0,1);
    SetCampMob("en6_blord",20,10);
    }
else if (iLevel<27)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en6_dknight");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en6_dknight");
    SetCampMob("en5_wraith",15,25);
    SetCampMob("en5_spectre",15,25);
    SetCampMob("EN5_MUMCLERIC",10,75);
    SetCampMob("en5_doomktboss",10,50);
    SetCampMob("en6_iskel",20,10,0,1);
    SetCampMob("en6_blord",10,10);
    SetCampNPC("en5_necro",10,EN5_CLASS_PALEMASTER,10,2,1);
    SetCampNPC("en5_necro",10,EN5_CLASS_BLACKGUARD,10,2,1);
    }
else if (iLevel<30)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_app_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_app_boss");
    SetCampMob("en5_wraith",5,30);
    SetCampMob("en5_spectre",5,30);
    SetCampMob("en5_spectremg",5,30);
    SetCampMob("en5_doomktboss",5,30);
    SetCampMob("en6_dknight",20,10);
    SetCampMob("en6_iskel",20,10);
    SetCampMob("en6_blord",20,10);
    SetCampMob("en6_awraith",20,30,0,1);
    }
else if (iLevel<36)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en6_adknight");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en6_adknight");
    SetCampMob("en6_aspectre",20,10);
    SetCampMob("en6_dknight",25,10);
    SetCampMob("en6_ablord",20,10);
    SetCampMob("en6_awraith",10,20);
    SetCampMob("en6_iskel",5,50);
    SetCampMob("en6_blord",5,50);
    SetCampMob("en5_app_boss",5,10);
    SetCampNPC("en5_necro",5,EN5_CLASS_PALEMASTER,10,2,1);
    SetCampNPC("en5_necro",5,EN5_CLASS_BLACKGUARD,10,2,1);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","en6_dracolich");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en6_dracolich");
    SetCampMob("en6_adknight",25,10);
    SetCampMob("en6_ablord",25,10);
    SetCampMob("en6_aspectre",10,25);
    SetCampMob("en6_dknight",10,25);
    SetCampMob("en6_awraith",10,25);
    SetCampMob("en6_iskel",5,50);
    SetCampMob("en6_blord",5,50);
    SetCampNPC("en5_necro",5,EN5_CLASS_PALEMASTER,10,2,1);
    SetCampNPC("en5_necro",5,EN5_CLASS_BLACKGUARD,10,2,1);
    }
oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetLich(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","undead");

SetLocalString(GetModule(),"CAMP_Boss","EN5_LICHBOSS");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","EN5_LICHBOSS");
SetCampMob("en5_wraith",30,30);
SetCampMob("en5_spectre",30,30);
SetCampMob("en5_spectremg",5,30);
SetCampMob("en5_doomktboss",15,30);
SetCampMob("EN5_MOHRG",20,30);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

//lichlord 3
object GetLichLord(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",25 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","undead");

SetLocalString(GetModule(),"CAMP_Boss","EN5_LICHLORD");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","EN5_LICHLORD");
SetCampMob("en5_wraith",15,25);
SetCampMob("en5_spectre",15,25);
SetCampMob("EN5_MUMCLERIC",10,75);
SetCampMob("en5_doomktboss",10,50);
SetCampMob("en6_iskel",20,10);
SetCampMob("en6_blord",10,10);
SetCampNPC("en5_necro",10,EN5_CLASS_PALEMASTER);
SetCampNPC("en5_necro",10,EN5_CLASS_BLACKGUARD);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetBeetles(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",5 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","beetles");

if (iLevel<3)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_fbeetle");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_fbeetle");
    SetCampMob("en5_fbeetle",100);
    }
else if (iLevel<7)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_btlstink");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_btlstink");
    SetCampMob("en5_fbeetle",25,50);
    SetCampMob("en5_fbeetle2",25);
    SetCampMob("en5_btlbomb",25);
    SetCampMob("en5_btlstink",25);
    }
else if (iLevel<13)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_btlstag");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_btlstag");
    SetCampMob("en5_fbeetle",20,90);
    SetCampMob("en5_fbeetle2",20,25);
    SetCampMob("en5_btlbomb",20,25);
    SetCampMob("en5_btlstink",20,25);
    SetCampMob("en5_btlstag",20);
    }
else if (iLevel<15)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_hbeetle");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_hbeetle");
    SetCampMob("en5_fbeetle",10,90);
    SetCampMob("en5_fbeetle2",10,50);
    SetCampMob("en5_btlbomb",10,50);
    SetCampMob("en5_btlstink",10,50);
    SetCampMob("en5_btlstag",30,25);
    SetCampMob("en5_hbeetle",30);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_beetleboss");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_beetleboss");
    SetCampMob("en5_fbeetle",10,99);
    SetCampMob("en5_fbeetle2",10,90);
    SetCampMob("en5_btlbomb",10,90);
    SetCampMob("en5_btlstink",10,90);
    SetCampMob("en5_btlstag",30,50);
    SetCampMob("en5_hbeetle",30,25);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetWerewolves(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",5 + iLevel/4);

SetLocalString(GetModule(),"EN5_CampDescription","werewolves");
SetLocalString(GetModule(),"CAMP_Boss","EN5_WEREWOLF");
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt","EN5_WEREWOLF");
SetCampMob("EN5_WEREWOLF",100,10);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetShapeshifters(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);

if (iLevel<3)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","wererats");
    SetLocalString(GetModule(),"CAMP_Boss","EN5_WERERAT");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","EN5_WERERAT");
    SetCampMob("EN5_WERERAT",100);
    }
else
    {
    int iRandom = Random(5)+1;
    int iMultiple;
    if (iLevel > 4)
        iMultiple=50;
    if (iRandom<4)
        {
        SetLocalString(GetModule(),"EN5_CampDescription","werewolves");
        SetLocalString(GetModule(),"CAMP_Boss","EN5_WEREWOLF");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_WEREWOLF");
        SetCampMob("EN5_WEREWOLF",100,iMultiple);
        }
     if (iRandom==4)
        {
        SetLocalString(GetModule(),"EN5_CampDescription","werebats");
        SetLocalString(GetModule(),"CAMP_Boss","EN5_WEREBAT");
        SetLocalInt(GetModule(),"CAMP_BossCount",0);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_WEREBAT");
        SetCampMob("EN5_WEREBAT",100,iMultiple);
        }
     if (iRandom==5)
        {
        SetLocalString(GetModule(),"EN5_CampDescription","spiders");
        SetLocalString(GetModule(),"CAMP_Boss","EN5_ARANEA");
        SetLocalInt(GetModule(),"CAMP_BossCount",1);
        SetLocalString(GetModule(),"CAMP_BossAlt","EN5_ARANEA");
        SetCampMob("EN5_SPIDGIANT2",100,iMultiple);
        }
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetAnts(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",5 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","giant ants");

if (iLevel<2)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_giantantwork");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_giantantwork");
    SetCampMob("en5_gantlarva",90,50);
    SetCampMob("en5_giantantwork",10);
    }
else if (iLevel<4)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_gantfire");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gantfire");
    SetCampMob("en5_gantfire",100);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_gantqueen");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_gantqueen");
    SetCampMob("en5_gantlarva",20,99);
    SetCampMob("en5_giantantwork",30,75);
    SetCampMob("en5_gantsoldier",50,25);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetSpiders(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",5 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","spiders");

if (iLevel<4)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_spidgiant");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_spidgiant");
    SetCampMob("en5_spidgiant",100);
    }
else if (iLevel<7)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_spidswrd");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_spidswrd");
    SetCampMob("en5_spidgiant",25);
    SetCampMob("en5_spidphase",25);
    SetCampMob("en5_spidswrd",25);
    SetCampMob("en5_spidwra",25);
    }
else if (iLevel<14)
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_spidredback");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_spidredback");
    SetCampMob("en5_spidgiant",10);
    SetCampMob("en5_spidphase",10);
    SetCampMob("en5_spidswrd",10);
    SetCampMob("en5_spidwra",10);
    SetCampMob("en5_spidbloodbak",20);
    SetCampMob("en5_spidice",20);
    SetCampMob("en5_spiddire",20);
    }
else
    {
    SetLocalString(GetModule(),"CAMP_Boss","en5_spiderboss");
    SetLocalInt(GetModule(),"CAMP_BossCount",0);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_spiderboss");
    SetCampMob("en5_spidgiant",10,90);
    SetCampMob("en5_spidphase",10,90);
    SetCampMob("en5_spidswrd",10,90);
    SetCampMob("en5_spidwra",10,90);
    SetCampMob("en5_spidbloodbak",10,90);
    SetCampMob("en5_spidice",10,90);
    SetCampMob("en5_spiddire",20);
    SetCampMob("en5_spidredback",20);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetHumans(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","humans");

SetLocalString(GetModule(),"CAMP_Boss","en5_human_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",1);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_human");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_FIGHTER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetCampNPC("en5_human",15,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_human",8,EN5_CLASS_ROGUE,10,2,1);
SetCampNPC("en5_human",12,EN5_CLASS_CLERIC);
SetCampNPC("en5_human2",9,EN5_CLASS_WIZARD);
SetCampNPC("en5_human",9,EN5_CLASS_MONK);
SetCampNPC("en5_human",4,EN5_CLASS_PALADIN);
SetCampNPC("en5_human",4,EN5_CLASS_RANGER);
SetCampNPC("en5_human",5,EN5_CLASS_DRUID);
SetCampNPC("en5_fhuman",5,EN5_CLASS_FIGHTER);
SetCampNPC("en5_fhuman",5,EN5_CLASS_CLERIC);
SetCampNPC("en5_fhuman",5,EN5_CLASS_WIZARD);
SetCampNPC("en5_human",7,EN5_CLASS_BARD);
SetCampNPC("en5_human",4,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_human",2,EN5_CLASS_FIGHTER);
SetCampNPC("en5_human",2,EN5_CLASS_SHIFTER);
SetCampNPC("en5_human",2,EN5_CLASS_SHADOWDANCER);
SetCampNPC("en5_human",2,EN5_CLASS_DIVINECHAMPION);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetSlavers(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_FIGHTER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetLocalString(GetModule(),"EN5_CampDescription","slavers");
SetLocalString(GetModule(),"CAMP_Boss","en6_slaver_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",2);
SetLocalString(GetModule(),"CAMP_BossAlt","en6_slaver");

SetCampNPC("en6_slaver",40,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en6_slaver",20,EN5_CLASS_ROGUE,10,2,1);
SetCampNPC("en6_slaver",10,EN5_CLASS_FIGHTERROGUE,10,2,1);
SetCampNPC("en6_slaver",15,EN5_CLASS_CLERIC);
SetCampNPC("en6_slaver",15,EN5_CLASS_WIZARD);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetMercenaries(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_FIGHTER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

if (iLevel<11)
    {
    SetLocalString(GetModule(),"EN5_CampDescription","bandits");
    SetLocalString(GetModule(),"CAMP_Boss","en5_bandit_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",2);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_bandit");

    SetCampNPC("en5_bandit",30,EN5_CLASS_FIGHTER,10,2,1);
    SetCampNPC("en5_bandit",20,EN5_CLASS_ROGUE,10,2,1);
    SetCampNPC("en5_bandit",5,EN5_CLASS_FIGHTERROGUE,10,2,1);
    SetCampNPC("en5_bandit",10,EN5_CLASS_CLERIC);
    SetCampNPC("en5_bandit",8,EN5_CLASS_WIZARD);
    SetCampNPC("en5_bandit",2,EN5_CLASS_MONK);
    SetCampNPC("en5_bandit",10,EN5_CLASS_BARD);
    SetCampNPC("en5_bandit2",2,EN5_CLASS_WIZARD);
    SetCampNPC("en5_bandit2",1,EN5_CLASS_MONK);
    SetCampNPC("en5_bandit2",2,EN5_CLASS_ROGUE,10,2,1);
    SetCampNPC("en5_bandit2",5,EN5_CLASS_FIGHTER,10,2,1);
    SetCampNPC("en5_bandit2",2,EN5_CLASS_CLERIC);
    SetCampNPC("en5_bandit2",3,EN5_CLASS_BARD);
    }
else
    {
    SetLocalString(GetModule(),"EN5_CampDescription","mercenaries");
    SetLocalString(GetModule(),"CAMP_Boss","en5_merc_boss");
    SetLocalInt(GetModule(),"CAMP_BossCount",3);
    SetLocalString(GetModule(),"CAMP_BossAlt","en5_merc");
    SetCampNPC("en5_merc",15,EN5_CLASS_FIGHTER,10,2,1);
    SetCampNPC("en5_merc3",5,EN5_CLASS_BARBARIAN,10,2,1);
    SetCampNPC("en5_merc4",5,EN5_CLASS_FIGHTER,10,2,1);
    SetCampNPC("en5_merc",15,EN5_CLASS_ROGUE,10,2,1);
    SetCampNPC("en5_merc",5,EN5_CLASS_FIGHTERROGUE,10,2,1);
    SetCampNPC("en5_merc",10,EN5_CLASS_CLERIC);
    SetCampNPC("en5_merc",8,EN5_CLASS_WIZARD);
    SetCampNPC("en5_merc",2,EN5_CLASS_MONK);
    SetCampNPC("en5_merc",10,EN5_CLASS_BARD);
    SetCampNPC("en5_merc2",2,EN5_CLASS_WIZARD);
    SetCampNPC("en5_merc2",1,EN5_CLASS_MONK);
    SetCampNPC("en5_merc2",2,EN5_CLASS_ROGUE,10,2,1);
    SetCampNPC("en5_merc2",5,EN5_CLASS_FIGHTER,10,2,1);
    SetCampNPC("en5_merc2",2,EN5_CLASS_CLERIC);
    SetCampNPC("en5_merc2",3,EN5_CLASS_BARD);
    SetCampNPC("en5_merc",4,EN5_CLASS_WEAPON_MASTER,10,2,1);
    SetCampNPC("en5_merc",2,EN5_CLASS_ASSASSIN,10,2,1);
    SetCampNPC("en5_merc",2,EN5_CLASS_BLACKGUARD,10,2,1);
    SetCampNPC("en5_merc",2,EN5_CLASS_PALEMASTER);
    }

oBoss = GetMobCamp(iLevel);

return oBoss;
}


object GetClassTest(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",5 + iLevel/4);

SetLocalString(GetModule(),"CAMP_Boss","en5_human_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_human");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_FIGHTER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_ARCANE_ARCHER); //NotWorking
//SetCampNPC("en5_elfaa",25,EN5_CLASS_ASSASSIN);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_FIGHTERROGUE);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_DRAGON_DISCIPLE);
//SetCampNPC("en5_elfaa",50,EN5_CLASS_BLACKGUARD);
//SetCampNPC("en5_elfaa",50,EN5_CLASS_DIVINECHAMPION);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_FIGHTERCLERIC);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_PALEMASTER);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_HARPER);  //NotWorking
//SetCampNPC("en5_dwarfdd",25,EN5_CLASS_DWARVENDEFENDER); //NotWorking
//SetCampNPC("en5_elfaa",25,EN5_CLASS_MONKSORCERER);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_SHADOWDANCER);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_SHIFTER);
//SetCampNPC("en5_elfaa",25,EN5_CLASS_WEAPON_MASTER);


oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetGoodOutside(int iLevel)
{
object oBoss;
int iRandom;

iRandom = Random(10)+1;
switch (iRandom)
    {
    case 1:
        oBoss=GetCelestial(iLevel); break;
    case 2: case 3: case 4: case 5:
        oBoss=GetHumans(iLevel); break;
    case 6: case 7:
        oBoss=GetElves(iLevel); break;
    case 8: case 9:
        if (iLevel<10)
            oBoss=GetHalflings(iLevel);
        else
            oBoss=GetElves(iLevel);
        break;
    case 10:
        oBoss=GetDwarves(iLevel); break;
    }
return oBoss;
}

object GetGoodInside(int iLevel)
{
object oBoss;
int iRandom;

iRandom = Random(9)+1;
switch (iRandom)
    {
    case 1:
        oBoss=GetCelestial(iLevel); break;
    case 2: case 3:
        oBoss=GetHumans(iLevel); break;
    case 4: case 5: case 6: case 7: case 8: case 9:
        oBoss=GetDwarves(iLevel); break;
    }
return oBoss;
}

object GetRitualists(int iLevel)
{
object oBoss;
object oMob;
vector vNew;
location lLoc;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","ritualists");

SetLocalString(GetModule(),"CAMP_Boss","en6_ritual_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",1);
SetLocalString(GetModule(),"CAMP_BossAlt","en6_ritual_boss");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WIZARD);
SetLocalInt(GetModule(),"CAMP_BossEquip",1);
SetCampNPC("en6_ritualist",75,EN5_CLASS_WIZARD,10,1,1);
SetCampNPC("en6_ritualist2",25,EN5_CLASS_BLACKGUARD,10,2,1);

oBoss = GetMobCamp(iLevel);
AssignCommand(oBoss,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS,FALSE));
AssignCommand(oBoss,SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS,FALSE));

CreateObject(OBJECT_TYPE_PLACEABLE,"en6_pentagram",GetLocation(oBoss),FALSE);
CreateObject(OBJECT_TYPE_PLACEABLE,"en6_gsparks",GetLocation(oBoss),FALSE);

vNew = GetPosition(oBoss) + Vector( 2.0, 0.0, 0.0 );
lLoc = Location(GetArea(oBoss), vNew, VectorToAngle( -1.0 * vNew ) );

oMob=CreateObject(OBJECT_TYPE_CREATURE,"en6_rit_w_boss",lLoc);
CreateItemOnObject("en6_ritrobe",oMob);

vNew = GetPosition(oBoss) + Vector( 0.0, 2.0, 0.0 );
lLoc = Location(GetArea(oBoss), vNew, VectorToAngle( -1.0 * vNew ) );
oMob=CreateObject(OBJECT_TYPE_CREATURE,"en6_rit_w_boss",lLoc);

vNew = GetPosition(oBoss) + Vector( 0.0, -2.0, 0.0 );
lLoc = Location(GetArea(oBoss), vNew, VectorToAngle( -1.0 * vNew ) );
oMob=CreateObject(OBJECT_TYPE_CREATURE,"en6_rit_w_boss",lLoc);


return oBoss;
}

object GetAssassins(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","assassins");

SetLocalString(GetModule(),"CAMP_Boss","en5_ass_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",2);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_assassin");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_ASSASSIN);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetCampNPC("en5_assassin",35,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("en5_assassin",20,EN5_CLASS_ROGUE,10,2,1);
SetCampNPC("en5_assassin",20,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_assassin",10,EN5_CLASS_SORCERER);
SetCampNPC("en5_assassin",15,EN5_CLASS_BLACKGUARD);

oBoss = GetMobCamp(iLevel);

return oBoss;
}


object GetElves(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","elves");

SetLocalString(GetModule(),"CAMP_Boss","en5_elf_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",1);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_elf");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_RANGER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetCampNPC("en5_elf",15,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_elf",5,EN5_CLASS_ROGUE,10,2,1);
SetCampNPC("en5_elf",10,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_elf",12,EN5_CLASS_SORCERER,10,2,1);
SetCampNPC("en5_elf",5,EN5_CLASS_MONK);
SetCampNPC("en5_elf",4,EN5_CLASS_PALADIN);
SetCampNPC("en5_elf",6,EN5_CLASS_RANGER);
SetCampNPC("en5_elf",9,EN5_CLASS_DRUID);
SetCampNPC("en5_elf2",5,EN5_CLASS_FIGHTER);
SetCampNPC("en5_elf2",5,EN5_CLASS_CLERIC);
SetCampNPC("en5_elf2",5,EN5_CLASS_WIZARD);
SetCampNPC("en5_elf",7,EN5_CLASS_BARD);
SetCampNPC("en5_elf",4,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_elf",2,EN5_CLASS_FIGHTER);
SetCampNPC("en5_elf",2,EN5_CLASS_SHIFTER);
SetCampNPC("en5_elf",2,EN5_CLASS_SHADOWDANCER);
SetCampNPC("en5_elf",2,EN5_CLASS_DIVINECHAMPION);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetDwarves(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","dwarves");

SetLocalString(GetModule(),"CAMP_Boss","en5_dwarf_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",1);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_dwarf");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_DIVINECHAMPION);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetCampNPC("en5_dwarf",15,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_dwarf",10,EN5_CLASS_BARBARIAN,10,2,1);
SetCampNPC("en5_dwarf",5,EN5_CLASS_ROGUE,10,2,1);
SetCampNPC("en5_dwarf",12,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_gnome",7,EN5_CLASS_WIZARD);
SetCampNPC("en5_dwarf",2,EN5_CLASS_MONK);
SetCampNPC("en5_dwarf",10,EN5_CLASS_PALADIN);
SetCampNPC("en5_dwarf",2,EN5_CLASS_RANGER);
SetCampNPC("en5_gnome",5,EN5_CLASS_DRUID);
SetCampNPC("en5_gnome",5,EN5_CLASS_FIGHTER);
SetCampNPC("en5_gnome",5,EN5_CLASS_CLERIC);
SetCampNPC("en5_gnome",5,EN5_CLASS_WIZARD);
SetCampNPC("en5_gnome",3,EN5_CLASS_BARD);
SetCampNPC("en5_dwarf",6,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_dwarf",2,EN5_CLASS_FIGHTER);
SetCampNPC("en5_gnome",2,EN5_CLASS_SHIFTER);
SetCampNPC("en5_dwarf",1,EN5_CLASS_SHADOWDANCER);
SetCampNPC("en5_dwarf",3,EN5_CLASS_DIVINECHAMPION);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetHalflings(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","halflings");

SetLocalString(GetModule(),"CAMP_Boss","en5_half_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",1);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_halfling");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_SHADOWDANCER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);
SetCampNPC("en5_halfling",15,EN5_CLASS_FIGHTER);
SetCampNPC("en5_halfling",15,EN5_CLASS_ROGUE,10,2,1);
SetCampNPC("en5_halfling",10,EN5_CLASS_CLERIC);
SetCampNPC("en5_halfling",7,EN5_CLASS_WIZARD);
SetCampNPC("en5_halfling",1,EN5_CLASS_MONK);
SetCampNPC("en5_halfling",5,EN5_CLASS_PALADIN);
SetCampNPC("en5_halfling",3,EN5_CLASS_RANGER);
SetCampNPC("en5_halfling",10,EN5_CLASS_DRUID);
SetCampNPC("en5_human",5,EN5_CLASS_FIGHTER);
SetCampNPC("en5_human",5,EN5_CLASS_CLERIC);
SetCampNPC("en5_human2",5,EN5_CLASS_WIZARD);
SetCampNPC("en5_halfling",4,EN5_CLASS_BARD);
SetCampNPC("en5_halfling",5,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_halfling",2,EN5_CLASS_SHIFTER);
SetCampNPC("en5_halfling",5,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_halfling",3,EN5_CLASS_DIVINECHAMPION);

oBoss = GetMobCamp(iLevel);

return oBoss;
}


object GetDrow(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","drow");

SetLocalString(GetModule(),"CAMP_Boss","en5_drow_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_fdrow2");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_CLERIC);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetCampNPC("en5_drow",5,EN5_CLASS_FIGHTER,10,2,1);
//SetCampNPC("en5_drow3",5,EN5_CLASS_ROGUE);
SetCampNPC("en5_drow2",5,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_drow4",10,EN5_CLASS_SORCERER);
SetCampNPC("en5_drow4",5,EN5_CLASS_WIZARD);
SetCampNPC("en5_drow3",5,EN5_CLASS_MONK);
SetCampNPC("en5_fdrow",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_fdrow2",10,EN5_CLASS_CLERIC);
SetCampNPC("en5_fdrow2",5,EN5_CLASS_BLACKGUARD);
SetCampNPC("en5_fdrow2",5,EN5_CLASS_BARD);
SetCampNPC("en5_drow",10,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_drow2",5,EN5_CLASS_BLACKGUARD,10,2,1);
SetCampNPC("en5_drow3",10,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_drow3",10,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("en5_drow4",5,EN5_CLASS_PALEMASTER);
SetCampNPC("en5_drow2",5,EN5_CLASS_DRAGON_DISCIPLE);


oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetVampire(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",25 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","vampires");

SetLocalString(GetModule(),"CAMP_Boss","en5_vamp_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_vamp1");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_MONKSORCERER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetCampNPC("en5_vamp1",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_vamp1",5,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_vamp1",5,EN5_CLASS_BLACKGUARD,10,2,1);
SetCampNPC("en5_vamp1",10,EN5_CLASS_MONK,10,2,1);
SetCampNPC("en5_vamp1",10,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("en5_vamp1",5,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_vamp1",10,EN5_CLASS_PALEMASTER);
SetCampNPC("en5_vamp1",5,EN5_CLASS_WIZARD);
SetCampNPC("en5_vamp1",10,EN5_CLASS_CLERIC,10,2,1);

SetCampNPC("en5_vamp2",10,EN5_CLASS_BARD);
SetCampNPC("en5_vamp2",5,EN5_CLASS_BLACKGUARD,10,2,1);
SetCampNPC("en5_vamp2",5,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_vamp2",5,EN5_CLASS_PALEMASTER);
SetCampNPC("en5_vamp2",10,EN5_CLASS_CLERIC,10,2,1);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetDuergar(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","duergar");

SetLocalString(GetModule(),"CAMP_Boss","en5_duergr_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_duergar");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_BLACKGUARD);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetCampNPC("en5_duergar",15,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_duergar",15,EN5_CLASS_BARBARIAN,10,2,1);
SetCampNPC("en5_duergar",15,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_duergar3",15,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_duergar",10,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_duergar",10,EN5_CLASS_BLACKGUARD);
SetCampNPC("en5_duergar2",5,EN5_CLASS_WIZARD);
SetCampNPC("en5_duergar",5,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_duergar",5,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("en5_duergar2",5,EN5_CLASS_PALEMASTER);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetDrider(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","drider");

SetLocalString(GetModule(),"CAMP_Boss","en5_drider_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_drider");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_CLERIC);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetCampNPC("en5_drider",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_drider2",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_drider",10,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_drider4",5,EN5_CLASS_SORCERER);
SetCampNPC("en5_fdrider",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_fdrider",10,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_fdrider",5,EN5_CLASS_SORCERER);
SetCampNPC("en5_drider",10,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_drider2",10,EN5_CLASS_BLACKGUARD,10,2,1);
SetCampNPC("en5_drider3",15,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_drider3",10,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("en5_drider3",10,EN5_CLASS_DRAGON_DISCIPLE);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetUnderdark(int iLevel)
{
object oBoss;
int iRandom;

iRandom = Random(5)+1;
switch (iRandom)
    {
    case 1: case 2:
        oBoss=GetDrow(iLevel); break;
    case 3: case 4:
        oBoss=GetDuergar(iLevel); break;
    case 5:
        oBoss=GetDrider(iLevel); break;
    }
return oBoss;
}

object GetRakasha(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",25 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","rakasha");

SetLocalString(GetModule(),"CAMP_Boss","en5_rak_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_rak1");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_SORCERER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetCampNPC("en5_rak1",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_rak2",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_rak3",5,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_rak3",15,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_rak2",15,EN5_CLASS_CLERIC,10,2,1);
SetCampNPC("en5_rak1",30,EN5_CLASS_SORCERER);
SetCampNPC("en5_rak1",5,EN5_CLASS_BLACKGUARD,10,2,1);
SetCampNPC("en5_rak1",10,EN5_CLASS_DRAGON_DISCIPLE);
SetCampNPC("en5_rak1",10,EN5_CLASS_PALEMASTER);


oBoss = GetMobCamp(iLevel-3);

return oBoss;
}

object GetFeyri(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","fey'ri");

SetLocalString(GetModule(),"CAMP_Boss","EN5_FEYRI_BOSS");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","EN5_FEYRI1");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_BLACKGUARD);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetCampNPC("EN5_FEYRI1",30,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("EN5_FEYRI1",10,EN5_CLASS_ROGUE,10,2,1);
SetCampNPC("EN5_FEYRI1",15,EN5_CLASS_CLERIC);
SetCampNPC("EN5_FEYRI1",15,EN5_CLASS_WIZARD);
SetCampNPC("EN5_FEYRI1",10,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("EN5_FEYRI1",10,EN5_CLASS_BLACKGUARD,10,2,1);
SetCampNPC("EN5_FEYRI1",10,EN5_CLASS_PALEMASTER);


oBoss = GetMobCamp(iLevel-2);

return oBoss;
}

object GetTiefling(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",15 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","tieflings");

SetLocalString(GetModule(),"CAMP_Boss","en5_tief_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_tiefling1");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_WEAPON_MASTER);
SetLocalInt(GetModule(),"CAMP_BossEquip",1);

SetCampNPC("en5_tiefling1",20,EN5_CLASS_FIGHTER,10,1,1);
SetCampNPC("en5_tiefling1",10,EN5_CLASS_ROGUE,10,1,1);
SetCampNPC("en5_tiefling1",15,EN5_CLASS_CLERIC,10,1);
SetCampNPC("en5_tiefling2",10,EN5_CLASS_WIZARD,10,1);
SetCampNPC("en5_tiefling1",10,EN5_CLASS_ASSASSIN,10,1,1);
SetCampNPC("en5_tiefling2",5,EN5_CLASS_BARD,10,1);
SetCampNPC("en5_tiefling1",10,EN5_CLASS_WEAPON_MASTER,10,1);
SetCampNPC("en5_tiefling1",10,EN5_CLASS_BLACKGUARD,10,1,1);
SetCampNPC("en5_tiefling2",5,EN5_CLASS_PALEMASTER,10,1);
SetCampNPC("en5_tiefling2",5,EN5_CLASS_DRAGON_DISCIPLE,10,1);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetShade(int iLevel)
{
object oBoss;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",20 + iLevel/4);
SetLocalString(GetModule(),"EN5_CampDescription","shades");

SetLocalString(GetModule(),"CAMP_Boss","en5_shade_boss");
SetLocalInt(GetModule(),"CAMP_BossCount",3);
SetLocalString(GetModule(),"CAMP_BossAlt","en5_shade1");
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",EN5_CLASS_SHADOWDANCER);
SetLocalInt(GetModule(),"CAMP_BossEquip",2);

SetCampNPC("en5_shade1",10,EN5_CLASS_FIGHTER,10,2,1);
SetCampNPC("en5_shade1",20,EN5_CLASS_CLERIC);
SetCampNPC("en5_shade1",10,EN5_CLASS_ASSASSIN,10,2,1);
SetCampNPC("en5_shade1",10,EN5_CLASS_SHADOWDANCER,10,2,1);
SetCampNPC("en5_shade1",10,EN5_CLASS_WEAPON_MASTER);
SetCampNPC("en5_shade1",10,EN5_CLASS_BLACKGUARD,10,2,1);
SetCampNPC("en5_shade1",20,EN5_CLASS_PALEMASTER);
SetCampNPC("en5_shade1",10,EN5_CLASS_DRAGON_DISCIPLE);


oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetLevelupMobs(string sTag, int iLevel, string sDescription, int iFighter=35, int iThief=25, int iCleric=25, int iMage=15, string sBoss="", int iBossClass=EN5_CLASS_FIGHTER)
{
object oBoss;

if (sBoss == "")
    sBoss = sTag;

ClearCamp();
SetLocalInt(GetModule(),"CAMP_Boss1Treasure",1 + iLevel/8);
SetLocalInt(GetModule(),"CAMP_Boss2Treasure",5 + iLevel/6);
SetLocalString(GetModule(),"EN5_CampDescription",sDescription);

SetLocalString(GetModule(),"CAMP_Boss",sBoss);
SetLocalInt(GetModule(),"CAMP_BossCount",0);
SetLocalString(GetModule(),"CAMP_BossAlt",sBoss);
SetLocalInt(GetModule(),"CAMP_BossLevelup",1);
SetLocalInt(GetModule(),"CAMP_BossClass",iBossClass);
SetLocalInt(GetModule(),"CAMP_BossEquip",1);

SetCampNPC(sTag,iFighter,EN5_CLASS_FIGHTER,10,1,1);
SetCampNPC(sTag,iThief,EN5_CLASS_ROGUE,10,1,1);
SetCampNPC(sTag,iCleric,EN5_CLASS_CLERIC,10,1);
SetCampNPC(sTag,iMage,EN5_CLASS_WIZARD,10,1);

oBoss = GetMobCamp(iLevel);

return oBoss;
}

object GetPlanar(int iLevel)
{
object oBoss;
int iRandom;

iRandom = Random(4)+1;
switch (iRandom)
    {
    case 1:
        if (iLevel < 15)
            oBoss=GetShade(iLevel);
        else
            oBoss=GetRakasha(iLevel);
        break;
    case 2:
        oBoss=GetShade(iLevel); break;
    case 3:
        oBoss=GetTiefling(iLevel); break;
    case 4:
        if (iLevel < 7)
            oBoss=GetTiefling(iLevel);
        else
            oBoss=GetFeyri(iLevel);
        break;
    }
return oBoss;
}

object GetEvilMen(int iLevel)
{
int iRandom;
object oBoss;

if (iLevel<10)
    {
    iRandom=Random(10)+1;
    if (iRandom==1)
        oBoss=GetAnimators(iLevel);
    else if (iRandom==2)
        oBoss=GetCultist(iLevel);
    else if (iRandom==3)
        oBoss=GetNecromancers(iLevel);
    else
        oBoss=GetMercenaries(iLevel);
    }
else if (iLevel<30)
    {
    iRandom=Random(6)+1;
    if (iRandom==1)
        oBoss=GetAnimators(iLevel);
    else if (iRandom==2)
        oBoss=GetCultist(iLevel);
    else if (iRandom==3)
        oBoss=GetNecromancers(iLevel);
    else
        oBoss=GetMercenaries(iLevel);
    }
else
    {
    iRandom=Random(3)+1;
    if (iRandom==1)
        oBoss=GetAnimators(iLevel);
    else if (iRandom==2)
        oBoss=GetCultist(iLevel);
    else if (iRandom==3)
        oBoss=GetNecromancers(iLevel);
    }

return oBoss;
}

object GetUndeadTheme(int iLevel)
{
object oBoss;

if (Random(2)==0)
    oBoss=GetUndead(iLevel);
else
    oBoss=GetNecromancers(iLevel);

return oBoss;
}


