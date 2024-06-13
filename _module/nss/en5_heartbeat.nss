#include "nw_i0_tool"
#include "qst_include"
#include "en5_singlespawns"
#include "en5_misc"

void CheckPCQuest();
void CheckMQSpecial(object oPC);
void NearStrike(object oPC);
void CheckLightning(object oPC);
void GetPlanarAssassin(object oPC,int iLevel);
void GetAssassin(object oPC,object oSpot, int iLevel);
void GetMQ6Assassins(object oPC);

void RespawnCamps();

void main()
{
int iHeartbeat;
int iHeartbeatCheck;

iHeartbeat = GetLocalInt(GetModule(),"Heartbeat");
iHeartbeat++;
SetLocalInt(GetModule(),"Heartbeat",iHeartbeat);

iHeartbeatCheck = iHeartbeat%2;
if (iHeartbeatCheck == 1)
    GetWanderingMonster(GetRandomPC(),50);

iHeartbeatCheck = iHeartbeat%2;
if (iHeartbeatCheck == 1)
    CheckMQSpecial(GetRandomPC());

iHeartbeatCheck = iHeartbeat%3;
if (iHeartbeatCheck == 1)
    CheckLightning(GetRandomPC());

CheckPCQuest();
}

void CheckMQSpecial(object oPC)
{
int iMaxLevel;
int i;
int iMQ;
int iMQNumber;
int iChance;
location lLoc;
object oArea;

oArea=GetArea(oPC);
iMaxLevel=GetMaxLevel(GetLocalString(oArea,"Zone"));
iMQNumber=GetLocalInt(GetModule(),"MQNumber");
iMQ=GetLocalInt(GetModule(),"MainQuest");

if (iMQNumber == 3 && iMQ<4 && GetLocalInt(oArea,"MQ_Fog") == 1)
    {
    if (Random(12)==1)
        {
        DelayCommand(0.5,ExecuteScript("en6_wind",oPC));
        i=2;
        while (i<31)
            {
            DelayCommand(1.0 + IntToFloat(i)/20.0,SetFogAmount(FOG_TYPE_ALL,i,oArea));
            i=i+2;
            }
        i=30;
        while (i>3)
            {
            DelayCommand(4.0 + IntToFloat(30-i)/20.0,SetFogAmount(FOG_TYPE_ALL,i,oArea));
            i=i-2;
            }
        i=GetMaxLevel(GetLocalString(OBJECT_SELF,"Zone"))/4;
        if (i>10)
            i=10;
        DelayCommand(4.4,SetFogAmount(FOG_TYPE_ALL,i,oArea));
        }
    }
if (iMQNumber == 4 && iMQ<99 && !GetIsAreaInterior(oArea))
    {
    iChance=6;
    if (iMaxLevel>9)
        iChance=4;
    if (iMaxLevel>19)
        iChance=3;
    if (iMaxLevel>29)
        iChance=2;

    if (Random(iChance)==1)
        {
        if (iMaxLevel>19 && Random(6)==1)
            {
            effect eDam = EffectDamage(d6(2), DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_LIGHTNING_M),GetLocation(oPC),3.0);
            } else {
            NearStrike(oPC);
            if (Random(iChance * 2)==1)
                DelayCommand(IntToFloat(Random(7)+3),NearStrike(oPC));
            }
        }
    }
if (iMQNumber==6 && GetLocalInt(oPC,"MQ6ItemMade")>0 && !GetIsDead(GetObjectByTag(GetOverallBossTag())))
    {
    if (Random(25)==2)
        GetMQ6Assassins(oPC);
    }
}

void GetMQ6Assassins(object oPC)
{
string sTag;
int iLevel;
int iSpots;
int iIndex;
int iFlag;
object oSpot;
string sMob;
object oMob;

sTag = GetZone(GetArea(oPC)) + "_W_";
iLevel = ZoneLevel(GetArea(oPC));
iSpots = MaxObject(sTag);
iIndex=1;
sTag = sTag + IntToString(iIndex);
oSpot = GetObjectByTag(sTag);
while (GetIsObjectValid(oSpot) && iFlag==FALSE)
    {
    if (GetArea(oPC) == GetArea(oSpot))
        iFlag=TRUE;
    else
        {
        iIndex++;
        sTag = sTag + IntToString(iIndex);
        oSpot = GetObjectByTag(sTag);
        }
    }
if (GetIsObjectValid(oSpot))
    {
    iLevel=GetHitDice(oPC);
    if (iLevel<12)
        {
        GetAssassin(oPC,oSpot,iLevel);
        }
    else if (iLevel<21 && Random(2)==0)
        {
        GetAssassin(oPC,oSpot,iLevel-Random(4)-2);
        GetAssassin(oPC,oSpot,iLevel-Random(4)-2);
        }
    else if (iLevel<21)
        {
        GetAssassin(oPC,oSpot,iLevel);
        }
    else if (Random(3)==1)
        {
        GetPlanarAssassin(oPC,iLevel-2);
        GetPlanarAssassin(oPC,iLevel-2);
        }
    else
        GetPlanarAssassin(oPC,iLevel);
    }
}

void GetAssassin(object oPC,object oSpot, int iLevel)
{
object oMob;

oMob=CreateObject(OBJECT_TYPE_CREATURE,"en5_assassin",GetLocation(oSpot));
if (Random(6)>0)
    LevelMob(oMob,iLevel,EN5_CLASS_ASSASSIN);
else
    LevelMob(oMob,iLevel,EN5_CLASS_SHADOWDANCER);

EquipMob(oMob);
GetTreasureOnMob(oMob,GetHitDice(oMob),0);

DelayCommand(0.5,AssignCommand(oMob,ActionAttack(oPC)));
}

void GetPlanarAssassin(object oPC,int iLevel)
{
object oMob;
effect eVis;
vector vPC;
int iRndX;
int iRndY;
vector vNew;
location lLoc;

vPC = GetPosition(oPC);
iRndX = Random(4) + 4;
iRndY = Random(4) + 4;
if (Random(2) == 1) iRndX=iRndX * -1;
if (Random(2) == 1) iRndY=iRndY * -1;
vNew = vPC + Vector( iRndX/1.0, iRndY/1.0, 0.0 );
lLoc = Location(GetArea(oPC), vNew, VectorToAngle( -1.0 * vNew ) );


oMob=CreateObject(OBJECT_TYPE_CREATURE,"en5_passassin",lLoc);
if (Random(6)>0)
    LevelMob(oMob,iLevel,EN5_CLASS_ASSASSIN);
else
    LevelMob(oMob,iLevel,EN5_CLASS_SHADOWDANCER);

AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY));
EquipWeapon(oMob);
GetTreasureOnMob(oMob,GetHitDice(oMob),0);
eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
DelayCommand(0.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oMob),3.0));
}

void NearStrike(object oPC)
{
vector vPC;
int iRndX;
int iRndY;
vector vNew;
location lLoc;
object oMob;
effect eDam;

vPC = GetPosition(oPC);
iRndX = Random(8) + 4;
iRndY = Random(8) + 4;
if (Random(2) == 1) iRndX=iRndX * -1;
if (Random(2) == 1) iRndY=iRndY * -1;
vNew = vPC + Vector( iRndX/1.0, iRndY/1.0, 0.0 );
lLoc = Location(GetArea(oPC), vNew, VectorToAngle( -1.0 * vNew ) );
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_LIGHTNING_M),lLoc,3.0);
if (Random(8)==1)
    DelayCommand(0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_LIGHTNING_S),lLoc,3.0));

oMob=GetNearestCreatureToLocation(CREATURE_TYPE_IS_ALIVE,TRUE,lLoc);

if (GetIsObjectValid(oMob) && GetDistanceBetweenLocations(lLoc,GetLocation(oMob)) < 2.0)
    {
    if (GetIsEnemy(oPC,oMob))
        {
        eDam = EffectDamage(d6(2), DAMAGE_TYPE_ELECTRICAL);
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oMob));
        }
    }
}

void CheckLightning(object oPC)
{
object oArea;

oArea=GetArea(oPC);
if (GetWeather(oArea) == WEATHER_RAIN && Random(20)==1)
    {
    NearStrike(oPC);
    }
}

void RespawnCamps()
{
object oPC;

oPC = GetFirstPC();
object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    if (GetLocalInt(GetArea(oPartyMember),"NoRespawn") == 0)
        SetLocalInt(GetArea(oPartyMember),"EN5_Respawn",1);
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

void CheckPCQuest()
{
int iResult;
int iQuestType;
int iIndex;
int iStep;
int iHideItem;
int iSA;
string sQuestItem;
string sQS;
string sTag;
string sWP;
string sDescription;
string sEncounter;
string sNPCName;
string sNPCLocation;
object oWP;
object oMob;
object oQuestNPC;

object oPC = GetFirstPC();
while (GetIsObjectValid(oPC) == TRUE)
    {
    oQuestNPC=GetObjectByTag(GetLocalString(oPC,"QuestNPC"));
//    SendMessageToPC(oPC,"Checking if on quest -- OnQuest=" + IntToString(GetLocalInt(oPC,"OnQuest")) + " -- QuestJournalUpdate=" + IntToString(GetLocalInt(oQuestNPC,"QuestJournalUpdate")));
    if (GetLocalInt(oPC,"OnQuest") > 0 && GetLocalInt(oQuestNPC,"QuestJournalUpdate")==0)
        {
        iResult=FALSE;
        iStep=GetLocalInt(oQuestNPC,"QuestStep");
        sQS="QuestStep" + IntToString(iStep);
        iQuestType = GetLocalInt(oQuestNPC,sQS + "Type");
        iSA=GetLocalInt(oQuestNPC,sQS + "SpecialArea");
        sNPCName=GetLocalString(oQuestNPC,sQS + "NPCName");
        sNPCLocation = GetLocalString(oQuestNPC,sQS + "NPCLocation");
        //GetError("Checking Quest Type " + IntToString(iQuestType));
        if (iQuestType == 1 || iQuestType == 2 || iQuestType == 4 || (iQuestType == 7 && iSA != 9))
            {
            sQuestItem=GetLocalString(oQuestNPC,sQS + "Item");
            iHideItem=GetLocalInt(oQuestNPC,sQS + "HideItem");

            //SendMessageToPC(oPC,"Checking Quest -- Item=" + sQuestItem + " -- iHideItem=" + IntToString(iHideItem));

            if (sQuestItem=="" || iHideItem>0)
                iResult=CheckMobs(oQuestNPC);
            else if (HasItem(oPC,sQuestItem))
                iResult=TRUE;
            else
                {
                if (CheckMobs(oQuestNPC) && GetLocalInt(oPC,"QItemUpdate")==0)
                    {
                    sDescription = GetLocalString(oQuestNPC,"QuestStepDone");
                    SetJournalEntry(oPC,sDescription);
                    SetLocalString(oQuestNPC,"QuestStepDone","I have found the " + GetName(GetObjectByTag(sQuestItem)) + " and should return to " + sNPCName + " " + sNPCLocation);
                    SetLocalInt(oPC,"QItemUpdate",1);
                    }
                }
            }
        if (iQuestType == 6 || iQuestType == 8 || (iQuestType == 7 && iSA == 9))
            {
            iResult = FALSE;
            sQuestItem=GetLocalString(oQuestNPC,sQS + "Item");
            if (HasItem(oPC,sQuestItem))
                iResult = TRUE;
            }

        if (iResult)
            {
            if (iQuestType < 3 || iQuestType == 6 || iQuestType == 7)
                {
                sEncounter =GetLocalString(oPC,"QuestEncounter");
                SetLocalInt(GetModule(),sEncounter,0);
                }
            SetLocalInt(oQuestNPC,"QuestJournalUpdate",1);
            SetLocalInt(oPC,"QItemUpdate",0);
            sDescription = GetLocalString(oQuestNPC,"QuestStepDone");
            SetJournalEntry(oPC,sDescription);
            //SetPartyString(oPC,"QuestDescription",sDescription);
            }
        }

    oPC = GetNextPC();
    }
}
