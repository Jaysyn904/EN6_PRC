#include "en5_spawnzone"
#include "qst_include"
#include "qdb_include"
#include "qst_template"

void SetupQuests();
int FreeCamps(string sZone);
void QuestSetup(string sZone,int iQuest);
void MQEffects(object oArea);

void main()
{
int iLevel;
int iHeartbeat;
int iAdventure;
string sZone;
object oPC;
object oWP;

oPC = GetEnteringObject();
sZone=GetLocalString(OBJECT_SELF,"Zone");
oWP=GetObjectByTag(sZone+"_INFO");

if (GetIsPC(oPC) && GetIsObjectValid(oWP))
    {
    if (sZone != "")
        SetLocalInt(oPC,sZone,1);
    iHeartbeat=GetLocalInt(GetModule(),"Heartbeat");
    if (iHeartbeat<0)
        iHeartbeat=0;
    iAdventure=GetLocalInt(oWP,"AdventureZone");
    if (GetLocalInt(oWP,"EN5_SetupQuests") == 0 && iAdventure == 1)
        {
        SetLocalInt(oWP,"EN5_SetupQuests",1);
        if (Random(16)==0)
            SetupTemplate();

        //Delay on Nirra Hamlett to allow main quests to load.
        if (sZone == "NH1")
            DelayCommand(0.5,SetupQuests());
        else
            SetupQuests();

        if (GetLocalInt(oWP,"SA") ==0)
            if (Random(10)==0)
                DelayCommand(2.0,CheckLair(sZone));
        DelayCommand(2.0,ZoneSpecial(sZone));
        }
    if (GetLocalInt(oWP,"EN5_SpawnZone") == 0)
        {
        DelayCommand(1.0,SpawnZone(OBJECT_SELF));
        SetLocalInt(oWP,"EN5_SpawnZone",iHeartbeat+1);
        }
        /*else
        {
        if (iHeartbeat-GetLocalInt(oWP,"EN5_SpawnZone") > 150 && iAdventure < 2)
            if (Random(5)==0)
                {
                DelayCommand(1.0,SpawnZone(OBJECT_SELF));
                SetLocalInt(oWP,"EN5_SpawnZone",iHeartbeat);
                }
        } */

    ExecuteScript("en5_ae",OBJECT_SELF);
    //Run Second time to try and catch issues with PRC
    DelayCommand(3.0,ExecuteScript("en5_ae",OBJECT_SELF));
    DelayCommand(0.1,MQEffects(OBJECT_SELF));
    }
}

void MQEffects(object oArea)
{
int iMQ;
int iMQNumber;
int iFogAmount;
int iFA;
int iFC;

iMQNumber=GetLocalInt(GetModule(),"MQNumber");
iMQ=GetLocalInt(GetModule(),"MainQuest");

if (iMQNumber == 3)
    {
    iFogAmount=GetMaxLevel(GetLocalString(OBJECT_SELF,"Zone"))/4;
    if (iFogAmount>10)
        iFogAmount==10;
    if (iMQ<4 && !GetIsAreaInterior(oArea) && GetLocalInt(oArea,"MQ_Fog") == 0)
        {
        SetLocalInt(oArea,"MQ_Fog",1);

        iFA=GetFogAmount(FOG_TYPE_SUN,oArea);
        iFC=GetFogColor(FOG_TYPE_SUN,oArea);
        SetLocalInt(oArea,"SUN_FA",iFA);
        SetLocalInt(oArea,"SUN_FC",iFC);

        iFA=GetFogAmount(FOG_TYPE_MOON,oArea);
        iFC=GetFogColor(FOG_TYPE_MOON,oArea);
        SetLocalInt(oArea,"MOON_FA",iFA);
        SetLocalInt(oArea,"MOON_FC",iFC);

        SetFogColor(FOG_TYPE_ALL,FOG_COLOR_GREEN,oArea);
        SetFogAmount(FOG_TYPE_ALL,iFogAmount);
        }
    if (iMQ>3 && !GetIsAreaInterior(oArea) && GetLocalInt(oArea,"MQ_Fog") == 1)
        {
        SetLocalInt(oArea,"MQ_Fog",0);
        SetFogAmount(FOG_TYPE_SUN,GetLocalInt(oArea,"SUN_FA"));
        SetFogColor(FOG_TYPE_SUN,GetLocalInt(oArea,"SUN_FC"));
        SetFogAmount(FOG_TYPE_MOON,GetLocalInt(oArea,"MOON_FA"));
        SetFogColor(FOG_TYPE_MOON,GetLocalInt(oArea,"MOON_FC"));
        }
    }

if (iMQNumber == 4)
    {
    if (iMQ<99 && !GetIsAreaInterior(oArea) && GetLocalInt(oArea,"MQ4_DoWeather")==0)
        {
        SetLocalInt(oArea,"MQ4_DoWeather",1);
        SetWeather(oArea,WEATHER_RAIN);
        } else {
        if (GetWeather(oArea) == WEATHER_RAIN)
            SetWeather(oArea,WEATHER_USE_AREA_SETTINGS);
        }
    }

}

void SetupQuests()
{
string sZone;
string sDB;
string sQuest;
int iMinLevel;
int iMaxLevel;
int iQuestMinLevel;
int iQuestMaxLevel;
int iQuest;
int iIndex;
int iIndex2;
int iFlag;
int iFrequency;
int iDoOnce;
int iUseQuest;
int iNumQuests;
int iMaxQuest;
int iRandom;

sZone=GetLocalString(OBJECT_SELF,"Zone");

sDB=GetDBName();
iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);

if (iMinLevel<1)
    iMinLevel=1;
if (iMaxLevel<iMinLevel)
    iMaxLevel=iMinLevel;
if (iMaxLevel>40)
    iMaxLevel=40;

//SendMessageToPC(GetFirstPC(),sZone + "=" + IntToString(iMinLevel) + " - " + IntToString(iMaxLevel));
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
            iUseQuest=TRUE;
            iQuestMinLevel=GetQuestInt("MinLevel");
            if (iQuestMinLevel>iMaxLevel)
                iUseQuest=FALSE;
            iQuestMaxLevel=GetQuestInt("MaxLevel");
            if (iQuestMaxLevel<iMinLevel)
                iUseQuest=FALSE;
            iDoOnce=GetQuestInt("DoOnce");
            if (GetLocalInt(GetModule(),"RAN_QUEST_" + IntToString(iDoOnce))>0)
                iUseQuest=FALSE;
            if (GetQuestInt("Type") > 0)
                iUseQuest=FALSE;
            iFrequency=GetQuestInt("Frequency");
            //SendMessageToPC(GetFirstPC(),"Quest " + IntToString(iIndex) + "=" + IntToString(iQuestMinLevel) + " - " + IntToString(iQuestMaxLevel));
            if (iUseQuest)
                {
                iIndex2=1;
                while (iIndex2<=iFrequency)
                    {
                    iMaxQuest++;
                    SetLocalInt(GetModule(),"QUEST_" + IntToString(iMaxQuest),iIndex);
                    //SendMessageToPC(GetFirstPC(),"Setup Quest #" + IntToString(iIndex));
                    iIndex2++;
                    }
                }
            }
        iIndex++;
        }
    }

if (GetLocalInt(GetObjectByTag(sZone+"INFO"),"Template") == 0)
    {
    if (iMaxLevel<4)
        iNumQuests=Random(2)+2;
    else
        iNumQuests=Random(3)+3;
    } else {
    if (iMaxLevel<4)
        iNumQuests=Random(2)+1;
    else
        iNumQuests=Random(2)+2;
    }

iIndex=1;
WriteTimestampedLogEntry(sZone + " Quests=" + IntToString(iNumQuests));
while (iIndex<=iNumQuests)
    {
    iRandom=Random(iMaxQuest)+1;
    iQuest=GetLocalInt(GetModule(),"QUEST_" + IntToString(iRandom));
    if (GetLocalInt(GetModule(),sZone + "_QUEST_" + IntToString(iQuest)) == 1)
        iQuest=1;
    //SendMessageToPC(GetFirstPC(),"Grab Quest " + IntToString(iQuest));
    //ExecuteScript("qst_setupquests",OBJECT_SELF);
    DelayCommand(0.1,QuestSetup(sZone,iQuest));
    iIndex++;
    if (FreeCamps(sZone)<1)
        iIndex=iNumQuests+1;
    }
}

void QuestSetup(string sZone,int iQuest)
{

SetLocalInt(GetModule(),"QDB_Quest",iQuest);
GrabQuest(sZone);
if (CheckQuest(sZone))
    {
    SetupQuest(sZone);
    SetLocalInt(GetModule(),"RAN_QUEST_" + IntToString(iQuest),1);
    SetLocalInt(GetModule(),sZone + "_QUEST_" + IntToString(iQuest),1);
    } else {
    SetLocalInt(GetModule(),"QDB_Quest",1);
    GrabQuest(sZone);
    SetupQuest(sZone);
    }
}

int FreeCamps(string sZone)
{
int iFreeCamps;
int iIndex;
string sTag;
object oWP;

iFreeCamps=0;
iIndex=1;
sTag=sZone+"_C" + IntToString(iIndex) + "_1";
oWP=GetObjectByTag(sTag);

while (GetIsObjectValid(oWP))
    {
    if (GetLocalInt(oWP,"Quest")==0)
        iFreeCamps++;
    iIndex++;
    sTag=sZone+"_C" + IntToString(iIndex) + "_1";
    oWP=GetObjectByTag(sTag);
    }

return iFreeCamps;
}


