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
sNPCTag="t2_npc3";

oQuestWP=GetObjectByTag("EN6_QUESTWP");
oQuestZone=GetObjectByTag(sZone + "_INFO");
iMinLevel = GetMinLevel(sZone);
iMaxLevel = GetMaxLevel(sZone);


iQuestLevel = iMaxLevel;

iSpot=2;
lLoc=GetLocation(GetObjectByTag(sZone + "_Q_NPC" + IntToString(iSpot)));
oQuestNPC=CreateObject(OBJECT_TYPE_CREATURE,sNPCTag,lLoc);
SetLocalString(oQuestNPC,"Location",GetLocalString(GetObjectByTag(sZone + "_Q_NPC" + IntToString(iSpot)),"Location"));

sArea=GetLocalString(oQuestZone,"Area");
SetLocalString(oQuestNPC,"Area",sArea);

iCampSpot=GetCampSpot(sZone,1,0,sZone);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iCampSpot);
SetLocalInt(GetObjectByTag(sZone + "_S_" + IntToString(iCampSpot)),"Quest",1);

sMobTag="T2_S_1_S";
//iCamp=2;

sQS="QuestStep1";
SetLocalInt(oQuestNPC,sQS + "Type",1);
SetLocalInt(oQuestNPC,sQS + "CampSpot",iCampSpot);
//SetLocalInt(oQuestNPC,sQS + "Camp",iCamp);
SetLocalString(oQuestNPC,sQS + "Zone",sZone);
SetLocalString(oQuestNPC,"QuestZone",sZone);
SetLocalInt(oQuestNPC,"QuestLevel",iQuestLevel);
SetLocalString(oQuestNPC,sQS + "MobTag",sMobTag);
SetLocalInt(oQuestNPC,"QuestSteps",1);
SetLocalInt(oQuestNPC,"QuestStep",1);

//GetMobQuest(oQuestNPC);

AssignCommand(oQuestNPC,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS));
}
