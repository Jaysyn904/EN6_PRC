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

sZone=GetLocalString(GetModule(),"QuestZone");
//SendMessageToPC(GetFirstPC(),"Check Zone = " + sZone);
sNPCTag="t2_npc2";

oQuestWP=GetObjectByTag("EN6_QUESTWP");
oQuestZone=GetObjectByTag(sZone + "_INFO");
iMinLevel = GetMinLevel(sZone);
iMaxLevel = GetMaxLevel(sZone);

iQuestLevel = iMinLevel + 2;
if (iQuestLevel>iMaxLevel)
    iQuestLevel--;
if (iQuestLevel>iMaxLevel)
    iQuestLevel--;

iSpot=MaxObject(sZone + "_Q_NPC");
if (iSpot<4)
    iSpot=4;
if (sZone == "MP1")
    iSpot=3;
lLoc=GetLocation(GetObjectByTag(sZone + "_Q_NPC" + IntToString(iSpot)));
oQuestNPC=CreateObject(OBJECT_TYPE_CREATURE,sNPCTag,lLoc);
SetLocalString(oQuestNPC,"Location",GetLocalString(GetObjectByTag(sZone + "_Q_NPC" + IntToString(iSpot)),"Location"));

sArea=GetLocalString(oQuestZone,"Area");
SetLocalString(oQuestNPC,"Area",sArea);

iCampSpot=GetCampSpot(sZone,2,0,sZone);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iCampSpot);
SetLocalInt(GetObjectByTag(sZone + "_S_" + IntToString(iCampSpot)),"Quest",1);

sMobTag="";
iCamp=3;

sQS="QuestStep1";
SetLocalInt(oQuestNPC,sQS + "Type",2);
SetLocalInt(oQuestNPC,sQS + "CampSpot",iCampSpot);
SetLocalInt(oQuestNPC,sQS + "Camp",iCamp);
SetLocalString(oQuestNPC,sQS + "Zone",sZone);
SetLocalString(oQuestNPC,"QuestZone",sZone);
SetLocalInt(oQuestNPC,"QuestLevel",iQuestLevel);
SetLocalString(oQuestNPC,sQS + "MobTag",sMobTag);
SetLocalInt(oQuestNPC,"QuestSteps",1);
SetLocalInt(oQuestNPC,"QuestStep",1);

GetCampQuest(oQuestNPC);

AssignCommand(oQuestNPC,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS));
}
