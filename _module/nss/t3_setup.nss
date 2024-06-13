#include "qst_include"

void main()
{
string sQS;
int iCampSpot;
string sZone;
int iQuestLevel;
string sMobTag;
object oQuestNPC;
int iMinLevel;
int iMaxLevel;
int iCamp;
object oQuestWP;
object oQuestZone;
int iSpot;
string sNPCTag;
location lLoc;
string sArea;
int iRandom;

sZone=GetLocalString(GetModule(),"QuestZone");
//SendMessageToPC(GetFirstPC(),"Check Zone = " + sZone);
sNPCTag="t3_npc1";

oQuestWP=GetObjectByTag("EN6_QUESTWP");
oQuestZone=GetObjectByTag(sZone + "_INFO");
iMinLevel = GetMinLevel(sZone);
iMaxLevel = GetMaxLevel(sZone);
iRandom=GetLocalInt(GetModule(),"iRandom");

if (iMaxLevel<3)
    {
    iQuestLevel=1;
    iCamp=5;
    }
else if (iMaxLevel<7 && iRandom==1)
    {
    iQuestLevel=2;
    iCamp=4;
    }
else if (iMaxLevel<7)
    {
    iQuestLevel=4;
    iCamp=5;
    }
else if (iMaxLevel<10)
    {
    iQuestLevel=6;
    iCamp=6;
    }
else if (iMaxLevel<14 && iRandom==1)
    {
    iQuestLevel=10;
    iCamp=4;
    }
else if (iMaxLevel<14)
    {
    iQuestLevel=10;
    iCamp=38;
    }
else if (iMaxLevel<19)
    {
    iQuestLevel=13;
    iCamp=6;
    }
else
    {
    iQuestLevel=20;
    iCamp=17;
    }


//iSpot=GetQuestNPCLoc(oQuestWP,sZone,0,0);
iSpot=1;
lLoc=GetLocation(GetObjectByTag(sZone + "_Q_NPC" + IntToString(iSpot)));
oQuestNPC=CreateObject(OBJECT_TYPE_CREATURE,sNPCTag,lLoc);
SetLocalString(oQuestNPC,"Location",GetLocalString(GetObjectByTag(sZone + "_Q_NPC" + IntToString(iSpot)),"Location"));

sArea=GetLocalString(oQuestZone,"Area");
SetLocalString(oQuestNPC,"Area",sArea);

iCampSpot=GetCampSpot(sZone,1,0,sZone);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iCampSpot);
SetLocalInt(GetObjectByTag(sZone + "_S_" + IntToString(iCampSpot)),"Quest",1);

sMobTag="CAMP";

sQS="QuestStep1";
SetLocalInt(oQuestNPC,sQS + "Type",1);
SetLocalInt(oQuestNPC,sQS + "CampSpot",iCampSpot);
SetLocalInt(oQuestNPC,sQS + "Camp",iCamp);
SetLocalString(oQuestNPC,sQS + "Zone",sZone);
SetLocalString(oQuestNPC,"QuestZone",sZone);
SetLocalInt(oQuestNPC,"QuestLevel",iQuestLevel);
SetLocalString(oQuestNPC,sQS + "MobTag",sMobTag);
SetLocalInt(oQuestNPC,"QuestSteps",1);
SetLocalInt(oQuestNPC,"QuestStep",1);

GetMobQuest(oQuestNPC);

AssignCommand(oQuestNPC,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS));
}
