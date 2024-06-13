#include "qst_include"
//#include "x0_i0_anims"
//#include "x2_inc_switches"
//#include "x0_i0_treasure"

void main()
{
int iCamp;
string sMob;
string sZone;
object oQuestWP;
object oQuestNPC;
int iQuestStepType;
int iSA;

oQuestNPC=OBJECT_SELF;
oQuestWP=GetObjectByTag("EN6_QUESTWP");

TransferQuest(oQuestWP,oQuestNPC);

SetLocalInt(OBJECT_SELF,"Quest",1);
SetLocalInt(OBJECT_SELF,"QuestStep",1);
SetLocalInt(OBJECT_SELF,"QuestLine",1);
SetLocalInt(OBJECT_SELF,"QuestLineStart",1);


sZone = GetLocalString(oQuestNPC,"QuestZone");
SetLocalString(GetModule(),"SPAWN_Zone",sZone);


iQuestStepType=GetLocalInt(oQuestNPC,"QuestStep1Type");
iSA=GetLocalInt(oQuestNPC,"QuestStep1SpecialArea");

if (iQuestStepType==1)
    DelayCommand(1.0,GetMobQuest(oQuestNPC));
if (iQuestStepType==2 || iQuestStepType==4 || iQuestStepType==5 || iQuestStepType==6 || (iQuestStepType==7 && iSA != 9))
    DelayCommand(1.0,GetCampQuest(oQuestNPC));
if (iQuestStepType==3)
    DelayCommand(1.0,GetNPCQuest(oQuestNPC));
if (iQuestStepType==7 && iSA == 9)
    DelayCommand(1.0,GetTRQuest(oQuestNPC));

SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
//SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS,FALSE);
}
