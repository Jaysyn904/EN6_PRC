#include "qst_include"
#include "qdb_include"

void BuildMQIndex();
int GetMQBoss();
void GetFinalMQNPC(int iMQ);
void MainQuest1();
int GetMaxNPCQuests(int iMainQuest,int iNPC);
string GetMainQuestZone(int iMainQuest,int iNPC);
int GetMaxNPCs(int iMainQuest);
string GetMainQuestTag(int iMainQuest,int iNPC);
void SetupMQ(string sZone, string sTag);
void SetupMainQuest();
void GrabAndSetup(int iQuest,int iMQ, int iNPC);
void GetExtraStuff(int iMQ);

void SetupMainQuest()
{
int iRandom;
int iBoss;
int iMQMax;
int iNPCs;
int iIndex;
int iMaxNPCQuests;
int iNPCQuest;
int iQuest;
string sZone;

iBoss=GetMQBoss();

BuildMQIndex();
iMQMax=GetLocalInt(GetModule(),"MQ_MAX");

iRandom=Random(iMQMax+1);
if (iRandom==0)
    iRandom=1;
if (iRandom==6 && Random(3)==1)
    iRandom=Random(2)+1;

iNPCs=GetMaxNPCs(iRandom);
SetLocalInt(GetModule(),"MQ_MaxNPCs",iNPCs);
SetLocalInt(GetModule(),"MQNumber",iRandom);
iIndex=1;


while (iIndex <= iNPCs)
    {
    iMaxNPCQuests=GetMaxNPCQuests(iRandom,iIndex);
    iNPCQuest=Random(iMaxNPCQuests)+1;
    iQuest = GetLocalInt(GetModule(),"Q_NPC" + IntToString(iNPCQuest));

    DelayCommand(0.1,GrabAndSetup(iQuest,iRandom,iIndex));
    iIndex++;
    }

GetFinalMQNPC(iRandom);
DelayCommand(1.0,GetExtraStuff(iRandom));
}

void GetExtraStuff(int iMQ)
{
location lLoc;
object oMob;
int iMax;
int iIndex;
int iMaxLevel;
string sTag;

if (iMQ==3)
    {
    lLoc=GetLocation(GetObjectByTag("WP_MQ3_S"));
    oMob=CreateObject(OBJECT_TYPE_CREATURE,"en6_mq3_s",lLoc);

    iMax=MaxObject("MQ3_S_");
    iIndex=1;
    while (iIndex <= iMax)
        {
        sTag = "MQ3_S_" + ItS(iIndex);
        iMaxLevel=GetMaxLevel(GetLocalString(GetArea(GetObjectByTag(sTag)),"Zone"));
        lLoc=GetLocation(GetObjectByTag(sTag));
        if (iMaxLevel<2)
            if (Random(2)==0)
                sTag="EN6_PCOUGAR";
            else
                sTag="EN5_PSTIRGE";
        else if (iMaxLevel<4)
            if (Random(2)==0)
                sTag="EN6_PCRAGCAT";
            else
                sTag="en6_pbear";
        else if (iMaxLevel<9)
            if (Random(2)==0)
                sTag="EN6_PTIGER";
            else
                sTag="EN6_PDIREWOLF";
        else if (iMaxLevel<12)
            if (Random(2)==0)
                sTag="EN5_PBEARDIRE";
            else
                sTag="EN6_PDIREWOLF";
        else if (iMaxLevel<16)
            if (Random(2)==0)
                sTag="EN5_PBEARDIRE";
            else
                sTag="EN6_PDIRETIGER";
        else if (iMaxLevel<22)
            sTag="en5_pbeardirebos";
        else
            sTag="en3_pancientbear";

        if (Random(3)==1)
            CreateObject(OBJECT_TYPE_CREATURE,sTag,lLoc);
        iIndex++;
        }

    }

if (iMQ==4)
    {
    iMax=MaxObject("MQ4_S_");
    iIndex=1;
    while (iIndex <= iMax)
        {
        sTag = "MQ4_S_" + ItS(iIndex);
        iMaxLevel=GetMaxLevel(GetLocalString(GetArea(GetObjectByTag(sTag)),"Zone"));
        lLoc=GetLocation(GetObjectByTag(sTag));
        if (iMaxLevel<6)
            sTag="en6_lelement_1";
        else if (iMaxLevel<11)
            sTag="en6_lelement_2";
        else
            sTag="en6_lelement_3";
        if (Random(3)==1)
            CreateObject(OBJECT_TYPE_CREATURE,sTag,lLoc);
        iIndex++;
        }
    }
if (iMQ==5)
    {
    CreateObject(OBJECT_TYPE_CREATURE,"mq5_special",GetLocation(GetObjectByTag("MQ5_S")));
    }
if (iMQ==6)
    {
    CreateObject(OBJECT_TYPE_CREATURE,"mq6_special",GetLocation(GetObjectByTag("MQ6_S")));
    }
}

void GrabAndSetup(int iQuest,int iMQ, int iNPC)
{
string sZone;

SetLocalInt(GetModule(),"QDB_Quest",iQuest);
sZone=GetMainQuestZone(iMQ,iNPC);
GrabQuest(sZone);
SetupMQ(sZone,GetMainQuestTag(iMQ,iNPC));
}

string GetMainQuestZone(int iMainQuest,int iNPC)
{
string sTag;
string sZone;
object oWP;

sTag="WP_MQ" + IntToString(iMainQuest) + "_" + IntToString(iNPC);
oWP = GetObjectByTag(sTag);
if (!GetIsObjectValid(oWP))
    {
    if (iNPC>4)
        iNPC=4;
    sTag="WP_MQ_" + IntToString(iNPC);
    oWP = GetObjectByTag(sTag);
    if (!GetIsObjectValid(oWP))
        DelayCommand(2.0,SendMessageToPC(GetFirstPC(),"ERROR: Could Not Spawn MQNPC " + IntToString(iNPC) + " for MQ " + IntToString(iMainQuest)));
    }

sZone=GetLocalString(GetArea(oWP),"Zone");

return sZone;
}

string GetMainQuestTag(int iMainQuest,int iNPC)
{
string sTag;
string sZone;
object oWP;

sTag="WP_MQ" + IntToString(iMainQuest) + "_" + IntToString(iNPC);
oWP = GetObjectByTag(sTag);
if (!GetIsObjectValid(oWP))
    {
    if (iNPC>4)
        iNPC=4;
    sTag="WP_MQ_" + IntToString(iNPC);
    oWP = GetObjectByTag(sTag);
    if (!GetIsObjectValid(oWP))
        DelayCommand(2.0,SendMessageToPC(GetFirstPC(),"ERROR: Could Not Spawn MQNPC " + IntToString(iNPC) + " for MQ " + IntToString(iMainQuest)));
    }

return sTag;
}

int GetMaxNPCQuests(int iMainQuest,int iNPC)
{
int iIndex;
int iMaxQuest;
int iMaxNPC;
//int iNPCNumber;
int iQuest;

iMaxNPC=0;
//iMaxQuest=GetLocalInt(GetModule(),"QUEST_MAX");
iMaxQuest=GetLocalInt(GetModule(),"MQ_QUESTMAX");
iIndex=1;
while (iIndex<=iMaxQuest)
    {
    //iQuest=GetLocalInt(GetModule(),"QUEST_" + IntToString(iIndex));
    iQuest=GetLocalInt(GetModule(),"MQ_" + IntToString(iIndex));
    SetLocalInt(GetModule(),"QDB_Quest",iQuest);

    //iNPCNumber = GetQuestInt("NPCNumber");

    if (GetQuestInt("NPCNumber")==iNPC && GetQuestInt("MQNumber") == iMainQuest)
        {
        iMaxNPC++;
        SetLocalInt(GetModule(),"Q_NPC" + IntToString(iMaxNPC),iQuest);
        }
    iIndex++;
    }
return iMaxNPC;
}

int GetMaxNPCs(int iMainQuest)
{
int iIndex;
int iMaxQuest;
int iMaxNPC;
int iNPCNumber;
int iQuest;

iMaxNPC=0;
iMaxQuest=GetLocalInt(GetModule(),"MQ_QUESTMAX");

iIndex=1;
while (iIndex<=iMaxQuest)
    {
    iQuest=GetLocalInt(GetModule(),"MQ_" + IntToString(iIndex));
    SetLocalInt(GetModule(),"QDB_Quest",iQuest);
    //iQuest=GetLocalInt(GetModule(),"QUEST_" + IntToString(iIndex));
    iNPCNumber = GetQuestInt("NPCNumber");
    if (iNPCNumber>iMaxNPC && GetQuestInt("MQNumber") == iMainQuest)
        iMaxNPC=iNPCNumber;
    iIndex++;
    }

return iMaxNPC;
}
/*
int BuildMQQuests(int iMainQuest)
{
int iMaxQuest;
int iIndex;
int iFlag;
int iMaxType;
int iQuest;
int iUseQuest;
string sQuest;

iMaxType=0;
iMaxQuest=GetLocalInt(GetModule(),"MQ_QUESTMAX");
DelayCommand(1.0,SendMessageToPC(GetFirstPC(),"MQ_QUESTMAX=" +IntToString(iMaxQuest)));
iIndex=1;
while (iIndex<=iMaxQuest)
    {
    iQuest=GetLocalInt(GetModule(),"MQ_" + IntToString(iIndex));
    SetLocalInt(GetModule(),"QDB_Quest",iQuest);
    sQuest=GetQuestString("Name");
    iUseQuest=TRUE;
    DelayCommand(1.0,SendMessageToPC(GetFirstPC(),"NPC=" +IntToString(GetQuestInt("NPC")) + " | MQNumber=" + IntToString(GetQuestInt("MQNumber"))));
    if (GetQuestInt("NPC") != iNPC)
        iUseQuest=FALSE;
    if (GetQuestInt("MQNumber") != iMainQuest)
        iUseQuest=FALSE;
    if (iUseQuest)
        {
        iMaxType++;
        SetLocalInt(GetModule(),"QUEST_" + IntToString(iMaxQuest),iIndex);
        }
    iIndex++;
    }

SetLocalInt(GetModule(),"QUEST_MAX",iMaxType);
return iMaxType;
}

int BuildNPCQuests(int iMainQuest, int iNPC)
{
int iMaxQuest;
int iIndex;
int iFlag;
int iMaxType;
int iQuest;
int iUseQuest;
string sQuest;

iMaxType=0;
iMaxQuest=GetLocalInt(GetModule(),"MQ_QUESTMAX");
DelayCommand(1.0,SendMessageToPC(GetFirstPC(),"MQ_QUESTMAX=" +IntToString(iMaxQuest)));
iIndex=1;
while (iIndex<=iMaxQuest)
    {
    iQuest=GetLocalInt(GetModule(),"MQ_" + IntToString(iIndex));
    SetLocalInt(GetModule(),"QDB_Quest",iQuest);
    sQuest=GetQuestString("Name");
    iUseQuest=TRUE;
    DelayCommand(1.0,SendMessageToPC(GetFirstPC(),"NPC=" +IntToString(GetQuestInt("NPC")) + " | MQNumber=" + IntToString(GetQuestInt("MQNumber"))));
    if (GetQuestInt("NPC") != iNPC)
        iUseQuest=FALSE;
    if (GetQuestInt("MQNumber") != iMainQuest)
        iUseQuest=FALSE;
    if (iUseQuest)
        {
        SetLocalInt(GetModule(),"QUEST_" + IntToString(iIndex),iMaxQuest);
        }
    iIndex++;
    }

SetLocalInt(GetModule(),"QUEST_MAX",iMaxType);
return iMaxType;
}
*/

void BuildMQIndex()
{
int iMaxQuest;
int iIndex;
int iFlag;
int iQuest;
string sQuest;

iMaxQuest=0;
iIndex=1;
iFlag=TRUE;
while (iFlag && iIndex<5000)
    {
    SetLocalInt(GetModule(),"QDB_Quest",iIndex);
    sQuest=GetQuestString("Name");
    if (sQuest=="")
        iFlag=FALSE;
    else
        {
        if (sQuest!="DELETE")
            {
            if (GetQuestInt("Type") == 1)
                {
                iQuest++;
                SetLocalInt(GetModule(),"MQ_" + IntToString(iQuest),iIndex);
                if (GetQuestInt("MQNumber")>iMaxQuest)
                    iMaxQuest = GetQuestInt("MQNumber");
                }
            }
        iIndex++;
        }
    }
SetLocalInt(GetModule(),"MQ_MAX",iMaxQuest);
SetLocalInt(GetModule(),"MQ_QUESTMAX",iQuest);
}

void GetFinalMQNPC(int iMQ)
{
location lLoc;
object oNPC;
string sMsg;

lLoc=GetLocation(GetObjectByTag("MainQuest_F"));
oNPC=CreateObject(OBJECT_TYPE_CREATURE,"en6_mq_final_npc",lLoc);
if (iMQ<2)
    sMsg="It was no minor feat for you to recover the Orb of Attraction, but I am afraid your work is not done.";
if (iMQ<2)
    sMsg="It was no minor feat for you to recover the Orb of Dragonkind, but I am afraid your work is not done.";
if (iMQ<2)
    sMsg="It was no minor feat for you to banish the poisonous fog from the land, but I am afraid your work is not done.";
if (iMQ<2)
    sMsg="It was no minor feat for you to make it here through this magical storm, but I am afraid your work is not done.";
if (iMQ<2)
    sMsg="It was no minor feat for you to recover two of the runes, but I am afraid your work is not done.";
if (iMQ<2)
    sMsg="It was no minor feat for you to make it here with assassins after you, but I am afraid your work is not done.";
else
    sMsg="It was no minor feat for you to make it this far, but I am afraid your work is not done.";

SetLocalString(oNPC,"Tie-In",sMsg);
}

int GetMQBoss()
{
int iBoss;
object oTransfer;
object oBoss;
location lLoc;

/*
1=Lich King
2=Demi-Lich
3=Lolth
4=Randal Kross
5=Rakasha
6=Demon
7=Half Dragon Man
8=Prismatic Dragon
*/


iBoss=Random(8)+1;
SetLocalInt(GetModule(),"OverallQuestBoss",iBoss);

if (iBoss<5)
    {
    oTransfer=GetObjectByTag("RD1_SPECIAL_1");
    SetLocalString(oTransfer,"Area","BOSS1_Enter");

    oTransfer=GetObjectByTag("BOSS1_Exit");
    SetLocalString(oTransfer,"Area","RD1_1_Enter");

    lLoc=GetLocation(GetObjectByTag("BOSS1_Q_1"));
    oBoss=CreateObject(OBJECT_TYPE_CREATURE,GetOverallBossTag(),lLoc);
    GetArtifact(oBoss);
    } else {
    oTransfer=GetObjectByTag("RD1_SPECIAL_1");
    SetLocalString(oTransfer,"Area","BOSS2_Enter");

    oTransfer=GetObjectByTag("BOSS2_Exit");
    SetLocalString(oTransfer,"Area","RD1_1_Enter");

    lLoc=GetLocation(GetObjectByTag("BOSS2_Q_1"));
    oBoss=CreateObject(OBJECT_TYPE_CREATURE,GetOverallBossTag(),lLoc);
    GetArtifact(oBoss);
    }

DelayCommand(0.1,AssignCommand(oBoss,SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY)));
SetLocalInt(GetObjectByTag("RD1_INFO"),"SA",1);
SetLocalInt(GetModule(),"RD1_SPECIAL_1",1);
SetLocalInt(oBoss,"MainBoss",1);
return iBoss;
}

void SetupMQ(string sZone, string sTag)
{
int iQuestNPC;
int iNPCSpawn;
int iNPCType;
int iSpot;
int iQuestLevel;
int iMinLevel;
int iMaxLevel;
int iCampSpot;
int iQuestStepType;
int iIndex;
int iSteps;
int iNPC;
int iCampTheme;
int iCamp;
int iSAType;
int iNPCNumber;
string sLocation;
string sSAZone;
string sName;
string sArea;
string sZoneCheck;
string sNPCTag;
object oQuestWP;
location lLoc;
object oQuestNPC;
object oQuestZone;

oQuestWP=GetObjectByTag("EN6_QUESTWP");

if (GetLocalString(oQuestWP,"QuestScript") != "")
    {
    SetLocalString(GetModule(),"QuestZone",sZone);
    ExecuteScript(GetLocalString(oQuestWP,"QuestScript"),OBJECT_SELF);
    }

if (GetLocalInt(oQuestWP,"QuestExecute") == 3)
    return;

oQuestZone=GetObjectByTag(sZone + "_INFO");
iMinLevel = GetLocalInt(oQuestZone,"MinLevel");
iMaxLevel = GetLocalInt(oQuestZone,"MaxLevel");

if (iMinLevel<1)
    iMinLevel=1;
if (iMaxLevel<iMinLevel)
    iMaxLevel=iMinLevel;
if (iMaxLevel>40)
    iMaxLevel=40;

iQuestLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;
if (GetLocalInt(oQuestZone,"MinLevelQuest") == 0)
    {
    iQuestLevel = iMinLevel;
    SetLocalInt(oQuestZone,"MinLevelQuest",1);
    }
SetLocalInt(oQuestWP,"QuestLevel",iQuestLevel);

iNPCSpawn=GetLocalInt(oQuestWP,"QuestNPCSpawn");
iNPCType=GetLocalInt(oQuestWP,"QuestNPCType");
iSpot=GetQuestNPCLoc(oQuestWP,sZone,iNPCSpawn,iNPCType);

lLoc=GetLocation(GetObjectByTag(sTag));
sZoneCheck=GetLocalString(GetArea(GetObjectByTag(sTag)),"Zone");

iIndex=1;
iSteps=GetLocalInt(oQuestWP,"QuestSteps");
while (iIndex <= iSteps)
    {
    iQuestStepType=GetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "Type");
    iNPC=GetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "NPC");
    if (iQuestStepType==1)
        {
        iCampSpot=GetCampSpot(sZone,iQuestStepType,iNPC,sZoneCheck);
        SetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "CampSpot",iCampSpot);
        SetLocalInt(GetObjectByTag(sZone + "_S_" + IntToString(iCampSpot)),"Quest",1);
        }
    if (iQuestStepType==4 && iIndex==1)
        {
        SetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "CampSpot",iSpot);
        }
    if (iQuestStepType==2 || iQuestStepType==5 || iQuestStepType==6 || (iQuestStepType==4 && iIndex>1))
        {
        iCampSpot=GetCampSpot(sZone,iQuestStepType,iNPC,sZoneCheck);
        SetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "CampSpot",iCampSpot);
        SetLocalInt(GetObjectByTag(sZone + "_C" + IntToString(iCampSpot) + "_1"),"Quest",1);
        }
    if (iQuestStepType==7)
        {
        iCampSpot=1;
        SetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "CampSpot",iCampSpot);
        SetLocalInt(oQuestZone,"SA",1);

        iSAType=GetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "SpecialArea");
        sSAZone=SetupSpecialZone(sZone,1,iSAType);
        SetLocalString(oQuestWP,"QuestStep" + IntToString(iIndex) + "Zone",sSAZone);

        }
    iIndex++;
    }


iNPCType = GetLocalInt(oQuestWP,"QuestNPCType");

WriteTimestampedLogEntry("Spawn NPC at " + sTag);

sNPCTag= GetLocalString(oQuestWP,"QuestNPCTag");

oQuestNPC=CreateObject(OBJECT_TYPE_CREATURE,sNPCTag,lLoc);

iNPCNumber=GetLocalInt(oQuestWP,"QuestNPCNumber");
sLocation=GetLocalString(GetObjectByTag(sTag),"Location");
SetLocalString(GetModule(),"MQ_NPC" + IntToString(iNPCNumber) + "Name",GetName(oQuestNPC));
SetLocalString(GetModule(),"MQ_NPC" + IntToString(iNPCNumber) + "Location",sLocation);

if (iNPCType>1 && iNPCType <6)
    ChangeFaction(oQuestNPC,GetObjectByTag("en6_defender"));

sLocation=GetLocalString(GetObjectByTag(sTag),"Location");
SetLocalString(oQuestNPC,"Location",sLocation);
SetLocalString(oQuestNPC,"Zone",sZone);

sArea=GetLocalString(oQuestZone,"Area");
SetLocalString(oQuestNPC,"Area",sArea);

if (GetLocalInt(oQuestWP,"QuestExecute") == 0)
    ExecuteScript("qst_implement",oQuestNPC);
}
