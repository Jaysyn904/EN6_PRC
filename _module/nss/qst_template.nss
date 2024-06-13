//#include "en5_misc"
#include "en5_spawnzone"

void SetupTemplate();
void SetupGoblinTheme(string sZone);
void SetupOrcTheme(string sZone);
void SetupMiscTheme(string sZone);
void CheckLair(string sZone);

void SetupTemplate()
{
string sZone;
int iRandom;
int iMaxLevel;
int iSACheck;

iSACheck = GetLocalInt(GetModule(),sZone + "_SPECIAL_1");

if (iSACheck == 0)
    {
    sZone=GetLocalString(OBJECT_SELF,"Zone");
    iMaxLevel = GetMaxLevel(sZone);

    iRandom=Random(3);
    if (iRandom<1 && GetLocalInt(GetModule(),"Theme1Used") == 0 && iMaxLevel<15)
        SetupGoblinTheme(sZone);
    else if (iRandom<2 & GetLocalInt(GetModule(),"Theme2Used") == 0 && iMaxLevel<15)
        SetupOrcTheme(sZone);
    else if (iRandom<3 & GetLocalInt(GetModule(),"Theme3Used") == 0 && iMaxLevel<21)
        SetupMiscTheme(sZone);
    }
}

void CheckLair(string sZone)
{
object oTransfer;
object oMob;
object oNPC;
string sTag;
string sWP;
string sMob;
string sFirstName;
string sLastName;
string sName;
string sMobName;
int iMinLevel;
int iMaxLevel;
int iMinMagicLevel;
int iSACheck;
int iLairs;
int iRandom;
int iHorde;

iSACheck = GetLocalInt(GetModule(),sZone + "_SPECIAL_1");
iLairs =GetLocalInt(GetModule(),"Lairs");
iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

if (iSACheck == 0 && iLairs < 4 && iMaxLevel < 30)
    {
    iLairs++;

    sTag = "LAIR" + IntToString(iLairs);
    oTransfer=GetObjectByTag(sZone + "_SPECIAL_1");
    SetLocalString(oTransfer,"Area",sTag + "_Enter");
    oTransfer=GetObjectByTag(sTag + "_Exit");
    SetLocalString(oTransfer,"Area",sZone + "_1_Enter");
    SetLocalInt(GetModule(),sTag,1);
    SetLocalInt(GetObjectByTag(sZone + "_INFO"),"SA",1);
    SetLocalInt(GetModule(),sZone + "_SPECIAL_1",1);
    SetLocalInt(GetModule(),"Lairs",iLairs);

    oTransfer=GetObjectByTag(sTag + "_INFO");
    SetLocalInt(oTransfer,"MinLevel",iMinLevel);
    SetLocalInt(oTransfer,"MaxLevel",iMaxLevel);

    sWP=sTag + "_Q_1";
    iMinMagicLevel = iMaxLevel + 3;
    iHorde=0;
    sMob="EN5_TROLL";
    if (iMaxLevel<2)
        {
        iRandom=Random(4);
        if (iRandom<1)
            sMob="EN5_TROLL";
        else if (iRandom<2)
            sMob="EN5_ETTERCAP";
        else if (iRandom<3)
            sMob="EN5_FLYEYE";
        else
            sMob="EN5_HORROR";
        }
    else if (iMaxLevel<5)
        {
        iRandom=Random(3);
        if (iRandom<1)
            sMob="EN5_WERECAT";
        else if (iRandom<2)
            sMob="EN5_SHFIEND";
        else
            sMob="EN5_MUMMY";

        }
    else if (iMaxLevel<9)
        {
        iRandom=Random(5);
        if (iRandom<1)
            sMob="en5_bulette2";
        else if (iRandom<2)
            sMob="EN5_DMSUCUBUS";
        else if (iRandom<3)
            sMob="EN5_SLAADGRN";
        else if (iRandom<4)
            sMob="EN5_GolClay";
        else
            sMob="EN4_GHOULBOSS";
        }
    else if (iMaxLevel<12)
        {
        iRandom=Random(4);
        if (iRandom<1)
            {
            sMob="EN6_ADDRGWHITE";
            iHorde=1;
            }
        else if (iRandom<2)
            {
            sMob="EN6_ADDRGBLACK";
            iHorde=1;
            }
        else if (iRandom<3)
            {
            sMob="EN5_GELUGON";
            sMobName = "powerful Demon";
            }
        else
            sMob="en5_spectre";
        }
    else if (iMaxLevel<16)
        {
        iRandom=Random(4);
        if (iRandom<1)
            {
            sMob="EN6_ODRGGREEN";
            iHorde=1;
            }
        else if (iRandom<2)
            {
            sMob="EN6_ODRGBLUE";
            iHorde=1;
            }
        else if (iRandom<3)
            {
            sMob="EN6_GFROST";
            sMobName = "powerful lich";
            }
        else
            sMob="en4_daemon";
        }
    else if (iMaxLevel<22)
        {
        iRandom=Random(4);
        if (iRandom<1)
            {
            sMob="EN5_Flame";
            iHorde=1;
            sMobName = "ancient red dragon";
            }
        else if (iRandom<2)
            {
            sMob="en6_ebony";
            iHorde=1;
            sMobName = "powerful shadow dragon";
            }
        else if (iRandom<3)
            {
            sMob="EN6_ABALOR_L";
            sMobName = "ancient balor demon";
            iHorde=1;
            }
        else
            {
            sMob="en6_dknight_l";
            sMobName = "powerful death knight";
            iHorde=1;
            }
        }
    else if (iMaxLevel<33)
        {
        iRandom=Random(4);
        if (iRandom<1)
            {
            sMob="EN5_MARILITHBG_L";
            iHorde=1;
            sMobName = "powerful marlith demon";
            }
        else if (iRandom<2)
            {
            sMob="EN6_FTITAN_L";
            iHorde=1;
            sMobName = "fire titan";
            }
        else if (iRandom<3)
            {
            sMob="en6_demilich_l";
            sMobName = "powerful demi-lich";
            iHorde=1;
            }
        else
            {
            sMob="en6_vamp_l";
            sMobName = "powerful vampire";
            iHorde=1;
            }
        }
    else
        sMob="en6_dracolich";

    oMob=GetMob(sMob,sWP);
    SetLocalInt(oMob,"MagicItemLevel",iMinMagicLevel);
    if (iHorde >0)
        CreateItemOnObject("NW_IT_GOLD001", oMob, Random(4000)+1000);
    if (GetIsObjectValid(GetObjectByTag(sZone + "_Town")))
        oNPC=GetMob("en6_lair_bard" + IntToString(Random(3)+1),sZone + "_Town");
    else
        oNPC=GetMob("en6_lair_bard" + IntToString(Random(3)+1),sZone + "_QUESTNPC1");
    if (iMaxLevel>1)
        {
        LevelMob(oNPC,iMinLevel,EN5_CLASS_BARD);
        EquipMob(oNPC);
        }
    if (sMobName == "")
        sMobName = GetName(oMob);
    SetLocalString(oNPC,"Mob",sMobName);

    sFirstName=RandomName(NAME_FIRST_GENERIC_MALE);
    sLastName=RandomName(NAME_LAST_HUMAN);

    iRandom=Random(6);
    if (iRandom<1)
        sName="Minstrel " + sFirstName;
    else if (iRandom<2)
        sName="Bard " + sFirstName;
    else if (iRandom<3)
        sName="Troubador " + sFirstName;
    else if (iRandom<4)
        sName=sFirstName + " the Minstrel";
    else if (iRandom<5)
        sName=sFirstName + " the Bard";
    else
        sName=sFirstName + " " + sLastName;
    SetName(oNPC,sName);
    }
}

void SetupGoblinTheme(string sZone)
{
int iMinLevel;
int iMaxLevel;
object oTransfer;
object oInfo;
object oMob;

oInfo=GetObjectByTag("T1_INFO");

iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

SetLocalInt(oInfo,"MinLevel",iMinLevel);
SetLocalInt(oInfo,"MaxLevel",iMaxLevel);

oTransfer=GetObjectByTag(sZone + "_SPECIAL_1");
SetLocalString(oTransfer,"Area","T1_Enter");
oTransfer=GetObjectByTag("T1_Exit");
SetLocalString(oTransfer,"Area",sZone + "_1_Enter");
SetLocalInt(GetModule(),"T1",1);
SetLocalInt(GetObjectByTag(sZone + "_INFO"),"SA",1);
SetLocalInt(GetModule(),sZone + "_SPECIAL_1",1);

SetLocalString(GetModule(),"SPAWN_Zone","T1");
SetLocalString(GetModule(),"SPAWN_CampType","C");
SetLocalInt(GetModule(),"SPAWN_Boss",0);
SetLocalInt(GetModule(),"SPAWN_Camp",1);

SetLocalInt(GetModule(),"MobWander",50);
oMob=GetGoblins(iMinLevel);
SetLocalInt(GetModule(),"SPAWN_Camp",2);
oMob=GetGoblins(iMaxLevel);
SetLocalInt(GetModule(),"MobWander",0);

oMob=GetMob("en6_goblin_c","T1_S_1",iMaxLevel+1,TRUE);
DelayCommand(0.1,LevelupBoss(oMob,iMaxLevel+1,EN5_CLASS_FIGHTER,2));

if (Random(2)==0)
    {
    oMob=GetMob("en6_goblin_w","T1_S_2",iMaxLevel,FALSE);
    DelayCommand(0.1,LevelupBoss(oMob,iMaxLevel+1,EN5_CLASS_WIZARD,1));
    DelayCommand(0.1,AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY)));
    CreateItemOnObject("T1_key",oMob);
    oMob=GetMob("en6_goblin_p","T1_S_3",iMaxLevel,FALSE);
    DelayCommand(0.1,LevelupBoss(oMob,iMaxLevel+1,EN5_CLASS_CLERIC,2));
    DelayCommand(0.1,AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY)));
    } else {
    oMob=GetMob("en6_goblin_w","T1_S_2",iMaxLevel,FALSE);
    DelayCommand(0.1,LevelupBoss(oMob,iMaxLevel+1,EN5_CLASS_WIZARD,1));
    DelayCommand(0.1,AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY)));
    oMob=GetMob("en6_goblin_p","T1_S_3",iMaxLevel,FALSE);
    DelayCommand(0.1,LevelupBoss(oMob,iMaxLevel+1,EN5_CLASS_CLERIC,2));
    DelayCommand(0.1,AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY)));
    CreateItemOnObject("T1_key",oMob);
    }
CreateTraps(sZone,iMinLevel,iMaxLevel);
LockDoorsAndChests(sZone,iMinLevel,iMaxLevel);

SetLocalString(GetModule(),"QuestZone",sZone);
ExecuteScript("t1_setup",OBJECT_SELF);
ExecuteScript("t1_2_setup",OBJECT_SELF);
ExecuteScript("t1_3_setup",OBJECT_SELF);
SetLocalString(GetModule(),"QuestZone","");
SetLocalInt(GetModule(),"Theme1Used",1);
SetLocalInt(GetObjectByTag(sZone+"INFO"),"Template",1);
}

void SetupOrcTheme(string sZone)
{
int iMinLevel;
int iMaxLevel;
object oTransfer;
object oInfo;
object oMob;

oInfo=GetObjectByTag("T2_INFO");

iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

SetLocalInt(oInfo,"MinLevel",iMinLevel);
SetLocalInt(oInfo,"MaxLevel",iMaxLevel);

oTransfer=GetObjectByTag(sZone + "_SPECIAL_1");
SetLocalString(oTransfer,"Area","T2_Enter");
oTransfer=GetObjectByTag("T2_Exit");
SetLocalString(oTransfer,"Area",sZone + "_1_Enter");
SetLocalInt(GetModule(),"T2",1);
SetLocalInt(GetObjectByTag(sZone + "_INFO"),"SA",1);
SetLocalInt(GetModule(),sZone + "_SPECIAL_1",1);

SetLocalString(GetModule(),"SPAWN_Zone","T2");
SetLocalString(GetModule(),"SPAWN_CampType","C");
SetLocalInt(GetModule(),"SPAWN_Boss",0);
SetLocalInt(GetModule(),"SPAWN_Camp",1);

SetLocalInt(GetModule(),"MobWander",50);
oMob=GetOrcs(iMaxLevel);
SetLocalInt(GetModule(),"SPAWN_Camp",2);
oMob=GetOrcs(iMaxLevel);
SetLocalInt(GetModule(),"MobWander",0);

oMob=GetMob("en6_orc_c","T2_S_1",iMaxLevel+1,TRUE);
DelayCommand(0.1,LevelupBoss(oMob,iMaxLevel+1,EN5_CLASS_BARBARIAN,2));

if (iMaxLevel>2)
    {
    oMob=GetMob("EN6_WORG_E","T2_S_2",iMaxLevel,FALSE);
    oMob=GetMob("EN6_WORG_E","T2_S_3",iMaxLevel,FALSE);
    }
CreateTraps(sZone,iMinLevel,iMaxLevel);
LockDoorsAndChests(sZone,iMinLevel,iMaxLevel);

SetLocalString(GetModule(),"QuestZone",sZone);
ExecuteScript("t2_setup",OBJECT_SELF);
ExecuteScript("t2_2_setup",OBJECT_SELF);
ExecuteScript("t2_3_setup",OBJECT_SELF);
SetLocalString(GetModule(),"QuestZone","");
SetLocalInt(GetModule(),"Theme2Used",1);
SetLocalInt(GetObjectByTag(sZone+"INFO"),"Template",2);
}

void SetupMiscTheme(string sZone)
{
int iMinLevel;
int iMaxLevel;
int iRandom;
object oTransfer;
object oInfo;
object oMob;

oInfo=GetObjectByTag("T3_INFO");

iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

SetLocalInt(oInfo,"MinLevel",iMinLevel);
SetLocalInt(oInfo,"MaxLevel",iMaxLevel);

oTransfer=GetObjectByTag(sZone + "_SPECIAL_1");
SetLocalString(oTransfer,"Area","T3_Enter");
oTransfer=GetObjectByTag("T3_Exit");
SetLocalString(oTransfer,"Area",sZone + "_1_Enter");
SetLocalInt(GetModule(),"T3",1);
SetLocalInt(GetObjectByTag(sZone + "_INFO"),"SA",1);
SetLocalInt(GetModule(),sZone + "_SPECIAL_1",1);

SetLocalString(GetModule(),"SPAWN_Zone","T3");
SetLocalString(GetModule(),"SPAWN_CampType","C");
SetLocalInt(GetModule(),"SPAWN_Boss",0);
SetLocalInt(GetModule(),"SPAWN_Camp",1);

iRandom=Random(2)+1;
SetLocalInt(GetModule(),"iRandom",iRandom);

SetLocalInt(GetModule(),"MobWander",50);
SetLocalInt(GetModule(),"SPAWN_Boss",1);
if (iMaxLevel<3)
    {
    oMob=GetLizardfolk(1);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetLizardfolk(1);
    }
else if (iMaxLevel<7 && iRandom==1)
    {
    oMob=GetBugBear(2);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetBugBear(2);
    }
else if (iMaxLevel<7)
    {
    oMob=GetLizardfolk(4);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetLizardfolk(4);
    }
else if (iMaxLevel<10)
    {
    oMob=GetMonstrous(6);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetMonstrous(6);
    }
else if (iMaxLevel<14 && iRandom==1)
    {
    oMob=GetBugBear(10);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetBugBear(10);
    }
else if (iMaxLevel<14)
    {
    oMob=GetTrolls(10);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetTrolls(10);
    }
else if (iMaxLevel<19)
    {
    oMob=GetMonstrous(13);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetMonstrous(13);
    }
else
    {
    oMob=GetGiants(20);
    SetLocalInt(GetModule(),"SPAWN_Camp",2);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    oMob=GetGiants(20);
    }
SetLocalInt(GetModule(),"MobWander",0);
SetLocalString(GetModule(),"T3Mobs",GetLocalString(GetModule(),"EN5_CampDescription"));
CreateTraps(sZone,iMinLevel,iMaxLevel);
LockDoorsAndChests(sZone,iMinLevel,iMaxLevel);

SetLocalString(GetModule(),"QuestZone",sZone);
ExecuteScript("t3_setup",OBJECT_SELF);
ExecuteScript("t3_2_setup",OBJECT_SELF);
ExecuteScript("t3_3_setup",OBJECT_SELF);
SetLocalString(GetModule(),"QuestZone","");
SetLocalInt(GetModule(),"Theme3Used",1);
SetLocalInt(GetObjectByTag(sZone+"INFO"),"Template",3);
}
