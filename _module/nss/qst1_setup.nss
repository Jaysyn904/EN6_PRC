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
object oQuestWP;
object oQuestZone;
int iSpot;
string sNPCTag;
location lLoc;
string sArea;

sZone=GetLocalString(GetModule(),"QuestZone");
//SendMessageToPC(GetFirstPC(),"Check Zone = " + sZone);
sNPCTag="qst_npc1";

oQuestWP=GetObjectByTag("EN6_QUESTWP");
oQuestZone=GetObjectByTag(sZone + "_INFO");
iMinLevel = GetMinLevel(sZone);
iMaxLevel = GetMaxLevel(sZone);

iQuestLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;

if (GetLocalInt(oQuestZone,"MinLevelQuest") == 0)
    {
    iQuestLevel = iMinLevel;
    SetLocalInt(oQuestZone,"MinLevelQuest",1);
    }
iSpot=GetQuestNPCLoc(oQuestWP,sZone,0,0);
lLoc=GetLocation(GetObjectByTag(sZone + "_Q_NPC" + IntToString(iSpot)));
oQuestNPC=CreateObject(OBJECT_TYPE_CREATURE,sNPCTag,lLoc);
sArea=GetLocalString(oQuestZone,"Area");
SetLocalString(oQuestNPC,"Area",sArea);

iCampSpot=GetCampSpot(sZone,1,0,sZone);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iCampSpot);
SetLocalInt(GetObjectByTag(sZone + "_S_" + IntToString(iCampSpot)),"Quest",1);

if (iQuestLevel<2)
    {
    if (Random(2)==0)
        sMobTag="EN5_SHADOW";
    else
        sMobTag="EN5_WERERAT";
    }
else if (iQuestLevel<5)
    {
    if (Random(2)==0)
        sMobTag="EN5_SHADOW";
    else
        sMobTag="EN5_WEREWOLF";
    }
else if (iQuestLevel<7)
    {
        sMobTag="EN5_WERECAT";
    }
else if (iQuestLevel<9)
    {
        sMobTag="EN5_DMSUCUBUS";
    }
else
    {
        sMobTag="EN5_DMVROCK";
    }

sQS="QuestStep1";
SetLocalInt(oQuestNPC,sQS + "Type",1);
SetLocalInt(oQuestNPC,sQS + "CampSpot",iCampSpot);
SetLocalString(oQuestNPC,sQS + "Zone",sZone);
SetLocalString(oQuestNPC,"QuestZone",sZone);
SetLocalInt(oQuestNPC,"QuestLevel",iQuestLevel);
SetLocalString(oQuestNPC,sQS + "MobTag",sMobTag);
SetLocalInt(oQuestNPC,"QuestSteps",1);
SetLocalInt(oQuestNPC,"QuestStep",1);

GetMobQuest(oQuestNPC);

AssignCommand(oQuestNPC,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS));
}
