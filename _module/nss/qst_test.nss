#include "qst_include"

//void ImplementQuest(object oQuestNPC);

//int GetQuestSteps(object oQuestNPC);
//int GetQuestStepLines(object oQuestNPC,int iStep);
//void TransferQuest(object oQuestNPC,object oQuestNPC2);
//int GetQuestNPCLoc(string sTag);
//int GetQuestNPCHelperLoc(string sTag,object oCompare);
//int GetQuestLocation(string sTag,int iMaxLoc, string sTest="");

//void SetupQuest(string sZone);

void Quest1();
void Quest2();
void Quest3();
void Quest4();
void Quest5();
void Quest6();
void Quest7();
void Quest8();

void main()
{
//if (Random(3)==0)
//    Quest1();
//else
    Quest3();

SetupQuest("TST");

}



void Quest1()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=2;
sEN_QSItem="en5_amulet";
iEN_QSCreateItem=0;
iEN_QSMobType=2;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="Can you help me?";
sEN_QSLine1Response1="Yes, what do you need?";
iEN_QSLine1Response1Goto=2;
sEN_QSLine1Response1Script="tst_bumpxp";
iEN_QSLine1Response1Accept=0;
iEN_QSLine1Response1Check=0;

sEN_QSLine2="There is a pack of [camp] located [location].";
sEN_QSLine2Response1="Consider them dead.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="tst_bumpxp";
iEN_QSLine2Response1Accept=3;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",iEN_QNPCType);
SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1CreateItem", iEN_QSCreateItem);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 7);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);
SetLocalInt(oQuestNPC,"QuestStep1Boss",3);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);

SetLocalString(oQuestNPC,"QuestStep1Line2",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto", iEN_QSLine2Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Accept", iEN_QSLine2Response1Accept);

//Hardcoded
SetLocalString(oQuestNPC,"QuestStep1Line3","Are the [camp] dead?");
SetLocalString(oQuestNPC,"QuestStep1Line3Response1", "The [camp] are dead.");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto", 4);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Check", 1);
SetLocalString(oQuestNPC,"QuestStep1Line3Response2","I am still working on it.");

SetLocalString(oQuestNPC,"QuestStep1Line4","Did you find anything on the bodies?");
SetLocalString(oQuestNPC,"QuestStep1Line4Response1", "Yes, I found the [item].");
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto", 5);
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Check", 2);
SetLocalString(oQuestNPC,"QuestStep1Line4Response2","No, but I could go back and search.");

SetLocalString(oQuestNPC,"QuestStep1Line5","Excellent.");
SetLocalString(oQuestNPC,"QuestStep1Line5Response1","Done.");
SetLocalInt(oQuestNPC,"QuestStep1Line5Done",6);

SetLocalString(oQuestNPC,"QuestStep1Line6","How's it going?");
SetLocalString(oQuestNPC,"QuestStep1Line6Response1","Pretty good.");
}

void Quest2()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=1;
sEN_QSItem="en5_amulet";
iEN_QSCreateItem=0;
//iEN_QSMobType=2;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="Can you help me?";
sEN_QSLine1Response1="Yes, what do you need?";
iEN_QSLine1Response1Goto=2;
sEN_QSLine1Response1Script="";
iEN_QSLine1Response1Accept=0;
iEN_QSLine1Response1Check=0;

sEN_QSLine2="There is a [mob] located [location].";
sEN_QSLine2Response1="Consider them dead.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="";
iEN_QSLine2Response1Accept=3;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",iEN_QNPCType);
SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1HideItem", 1);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 0);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);

SetLocalString(oQuestNPC,"QuestStep1Line2",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto", iEN_QSLine2Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Accept", iEN_QSLine2Response1Accept);

//Hardcoded
SetLocalString(oQuestNPC,"QuestStep1Line3","Is the [mob] dead?");
SetLocalString(oQuestNPC,"QuestStep1Line3Response1", "The [mob] is dead.");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto", 5);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Check", 1);
SetLocalString(oQuestNPC,"QuestStep1Line3Response2", "The [mob] is dead and I found a [item].");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response2Goto", 4);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response2Check", 3);

SetLocalString(oQuestNPC,"QuestStep1Line3Response3","I am still working on it.");

SetLocalString(oQuestNPC,"QuestStep1Line4","This is very interesting.");
SetLocalString(oQuestNPC,"QuestStep1Line4Response1", "Yeah, ain't it?");
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto", 5);

SetLocalString(oQuestNPC,"QuestStep1Line5","Excellent.");
SetLocalString(oQuestNPC,"QuestStep1Line5Response1","Done.");
SetLocalInt(oQuestNPC,"QuestStep1Line5Done",7);

SetLocalString(oQuestNPC,"QuestStep1Line6","XXX");

SetLocalString(oQuestNPC,"QuestStep1Line7","How's it going?");
SetLocalString(oQuestNPC,"QuestStep1Line7Response1","Pretty good.");
}

void Quest3()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=3;
sEN_QSItem="";
iEN_QSCreateItem=0;
//iEN_QSMobType=2;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="Can you help me?";
sEN_QSLine1Response1="Yes, what do you need?";
iEN_QSLine1Response1Goto=2;
sEN_QSLine1Response1Script="";
iEN_QSLine1Response1Accept=0;
iEN_QSLine1Response1Check=0;

sEN_QSLine2="You should go speak with [npc] at [location].";
sEN_QSLine2Response1="I'll get right on it.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="";
iEN_QSLine2Response1Accept=3;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",6);
SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1HideItem", 0);
SetLocalInt(oQuestNPC,"QuestStep1CreateItem", 0);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 0);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalInt(oQuestNPC,"QuestStep1NPCType", 6);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);

SetLocalString(oQuestNPC,"QuestStep1Line2",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto", 0);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Accept", 3);

//Hardcoded
SetLocalString(oQuestNPC,"QuestStep1Line3","May I help you?");
SetLocalInt(oQuestNPC,"QuestStep1Line3NPC",1);
SetLocalString(oQuestNPC,"QuestStep1Line3Response1", "Yes, [giver] asked me to come speak with you.");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto", 4);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Check", 0);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1DeleteItem", 0);
SetLocalString(oQuestNPC,"QuestStep1Line3Response2","No.");

SetLocalString(oQuestNPC,"QuestStep1Line4","Whatever, dude, go away and tell [giver] to sod off.");
SetLocalInt(oQuestNPC,"QuestStep1Line4NPC",1);
SetLocalString(oQuestNPC,"QuestStep1Line4Response1","Okay.");
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto",0);
SetLocalInt(oQuestNPC,"QuestStep1Line4Done",7);

SetLocalString(oQuestNPC,"QuestStep1Line5","Have you delivered the [item] to [npc]?");
SetLocalString(oQuestNPC,"QuestStep1Line5Response1","Yes.");
SetLocalInt(oQuestNPC,"QuestStep1Line5Response1Goto",6);

SetLocalString(oQuestNPC,"QuestStep1Line6","Excellent.");
SetLocalString(oQuestNPC,"QuestStep1Line6Response1","");
SetLocalInt(oQuestNPC,"QuestStep1Line6Done",7);

SetLocalString(oQuestNPC,"QuestStep1Line7","How's it going?");
SetLocalString(oQuestNPC,"QuestStep1Line7Response1","Pretty good.");

SetLocalString(oQuestNPC,"QuestStep1Line100", "This is the completed quest line, what do you want?");
SetLocalString(oQuestNPC,"QuestStep1Line100Response1", "Get out of my face loser dude.");
}

void Quest4()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=4;
sEN_QSItem="";
iEN_QSCreateItem=0;
//iEN_QSMobType=2;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="Are they really all dead?";
sEN_QSLine1Response1="Yes.";
iEN_QSLine1Response1Goto=2;
sEN_QSLine1Response1Script="";
iEN_QSLine1Response1Accept=2;
iEN_QSLine1Response1Check=0;

sEN_QSLine2="Thanks a bunch, I thought I was a real goner.";
sEN_QSLine2Response1="No Problem.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="";
iEN_QSLine2Response1Accept=0;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",iEN_QNPCType);
//SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalString(oQuestNPC,"QuestOneLiner","Help! Help!");
SetLocalInt(oQuestNPC,"QuestNPCSpawn",2);

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1CreateItem", iEN_QSCreateItem);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 7);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);
SetLocalInt(oQuestNPC,"QuestStep1Boss",3);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);

SetLocalString(oQuestNPC,"QuestStep1Line2",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto", iEN_QSLine2Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Accept", iEN_QSLine2Response1Accept);

SetLocalInt(oQuestNPC,"QuestStep1Line2Done",6);
//Hardcoded
SetLocalString(oQuestNPC,"QuestStep1Line3","Are the [camp] dead?");
SetLocalString(oQuestNPC,"QuestStep1Line3Response1", "The [camp] are dead.");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto", 4);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Check", 1);
SetLocalString(oQuestNPC,"QuestStep1Line3Response2","I am still working on it.");

SetLocalString(oQuestNPC,"QuestStep1Line4","Did you find anything on the bodies?");
SetLocalString(oQuestNPC,"QuestStep1Line4Response1", "Yes, I found the [item].");
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto", 5);
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Check", 2);
SetLocalString(oQuestNPC,"QuestStep1Line4Response2","No, but I could go back and search.");

SetLocalString(oQuestNPC,"QuestStep1Line5","Excellent.");
SetLocalString(oQuestNPC,"QuestStep1Line5Response1","Done.");
SetLocalInt(oQuestNPC,"QuestStep1Line5Done",6);

SetLocalString(oQuestNPC,"QuestStep1Line6","How's it going?");
SetLocalString(oQuestNPC,"QuestStep1Line6Response1","Pretty good.");
}

void Quest5()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=2;
sEN_QSItem="";
iEN_QSCreateItem=0;
//iEN_QSMobType=2;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="I need some help, can you help me?";
sEN_QSLine1Response1="What do you need?";
iEN_QSLine1Response1Goto=2;
sEN_QSLine1Response1Script="qst_resetjrnlvar";
iEN_QSLine1Response1Accept=0;
iEN_QSLine1Response1Check=0;
//sEN_QSLine1Response2="No thanks.";

sEN_QSLine2="Great, I need you to go whipe out some [camp] located [location].";
sEN_QSLine2Response1="No Problem.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="";
iEN_QSLine2Response1Accept=3;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",iEN_QNPCType);
SetLocalInt(oQuestNPC,"QuestNPCSpawn",1);

//SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalString(oQuestNPC,"QuestOneLiner","It is dangerous out here...");

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1CreateItem", iEN_QSCreateItem);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 6);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);
SetLocalInt(oQuestNPC,"QuestStep1Boss",2);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);

SetLocalString(oQuestNPC,"QuestStep1Line2",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto", iEN_QSLine2Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Accept", iEN_QSLine2Response1Accept);

//SetLocalInt(oQuestNPC,"QuestStep1Line2Done",6);
//Hardcoded
SetLocalString(oQuestNPC,"QuestStep1Line3","Are the [camp] dead?");
SetLocalString(oQuestNPC,"QuestStep1Line3Response1", "The [camp] are dead.");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto", 4);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Check", 1);
SetLocalString(oQuestNPC,"QuestStep1Line3Response2","I am still working on it.");

SetLocalInt(oQuestNPC,"QuestStep1Line4Done",6);
SetLocalString(oQuestNPC,"QuestStep1Line4","Great!");
SetLocalString(oQuestNPC,"QuestStep1Line4Response1", "No Problem.");
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto", 0);
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Check", 0);
//SetLocalString(oQuestNPC,"QuestStep1Line4Response2","No, but I could go back and search.");

SetLocalString(oQuestNPC,"QuestStep1Line5","Excellent.");
SetLocalString(oQuestNPC,"QuestStep1Line5Response1","Done.");
SetLocalInt(oQuestNPC,"QuestStep1Line5Done",6);

SetLocalString(oQuestNPC,"QuestStep1Line6","How's it going?");
SetLocalString(oQuestNPC,"QuestStep1Line6Response1","Pretty good.");
}

void Quest6()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=5;
sEN_QSItem="en5_amulet";
iEN_QSCreateItem=0;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="Can I help you?";
sEN_QSLine1Response1="Yes, I found this [item], do you know anything about it?";
iEN_QSLine1Response1Goto=1;
sEN_QSLine1Response1Script="";
iEN_QSLine1Response1Accept=2;
iEN_QSLine1Response1Check=2;

sEN_QSLine2="The item means you must go kill some [camp] located [location].";
sEN_QSLine2Response1="Sure.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="";
iEN_QSLine2Response1Accept=0;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",iEN_QNPCType);
SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1CreateItem", iEN_QSCreateItem);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 7);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);
SetLocalInt(oQuestNPC,"QuestStep1Boss",3);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1StepDone", 1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1DeleteItem", 1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response2", "No, thanks.");

SetLocalString(oQuestNPC,"QuestStep2Line1",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep2Line1Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep2Line1Response1Goto", 0);
SetLocalString(oQuestNPC,"QuestStep2Line1Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep2Line1Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep2Line1Response1Accept", 3);
//SetLocalInt(oQuestNPC,"QuestStep1Line2Response1StepDone", 1);
SetLocalString(oQuestNPC,"QuestStep2Line1Response2", "No thanks.");
SetLocalInt(oQuestNPC,"QuestStep2Line1Response2Goto", 4);

//Hardcoded
SetLocalInt(oQuestNPC,"QuestStep2Type",2);
SetLocalInt(oQuestNPC,"QuestStep2CampSpot",1);

SetLocalString(oQuestNPC,"QuestStep2Line2","You need to go kill some [camp] located [location].");
SetLocalString(oQuestNPC,"QuestStep2Line2Response1", "I will take care of the [camp].");
SetLocalInt(oQuestNPC,"QuestStep2Line2Response1Goto", 0);
SetLocalInt(oQuestNPC,"QuestStep2Line2Response1LineStart", 3);

SetLocalString(oQuestNPC,"QuestStep2Line3","Did you take care of the [camp]?");
SetLocalString(oQuestNPC,"QuestStep2Line3Response1", "Yes, I took care of them.");
SetLocalInt(oQuestNPC,"QuestStep2Line3Response1Goto", 4);
SetLocalInt(oQuestNPC,"QuestStep2Line3Response1Check", 1);
SetLocalString(oQuestNPC,"QuestStep2Line3Response2","Not yet.");

SetLocalString(oQuestNPC,"QuestStep2Line4","Excellent.");
SetLocalString(oQuestNPC,"QuestStep2Line4Response1","Done.");
SetLocalInt(oQuestNPC,"QuestStep2Line4Done",5);

SetLocalString(oQuestNPC,"QuestStep2Line5","How's it going?");
SetLocalString(oQuestNPC,"QuestStep2Line5Response1","Pretty good.");
}

void Quest7()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=6;
sEN_QSItem="en5_amulet";
iEN_QSCreateItem=0;
iEN_QSMobType=2;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="Can you help me?";
sEN_QSLine1Response1="Yes, what do you need?";
iEN_QSLine1Response1Goto=2;
sEN_QSLine1Response1Script="";
iEN_QSLine1Response1Accept=0;
iEN_QSLine1Response1Check=0;

sEN_QSLine2="I need you to get the [item] which might be guarded by a pack of [camp] located [location].";
sEN_QSLine2Response1="Consider it done.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="";
iEN_QSLine2Response1Accept=3;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",iEN_QNPCType);
SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1CreateItem", iEN_QSCreateItem);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 7);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);
SetLocalInt(oQuestNPC,"QuestStep1Boss",3);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);

SetLocalString(oQuestNPC,"QuestStep1Line2",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto", iEN_QSLine2Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Accept", iEN_QSLine2Response1Accept);

//Hardcoded
SetLocalString(oQuestNPC,"QuestStep1Line3","Did you get it?");
SetLocalString(oQuestNPC,"QuestStep1Line3Response1", "Yes, I found the [item].");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto", 5);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Check", 2);
SetLocalString(oQuestNPC,"QuestStep1Line3Response2","I am still working on it.");

SetLocalString(oQuestNPC,"QuestStep1Line4","Did you find anything on the bodies?");
SetLocalString(oQuestNPC,"QuestStep1Line4Response1", "Yes, I found the [item].");
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto", 5);
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Check", 2);
SetLocalString(oQuestNPC,"QuestStep1Line4Response2","No, but I could go back and search.");

SetLocalString(oQuestNPC,"QuestStep1Line5","Excellent.");
SetLocalString(oQuestNPC,"QuestStep1Line5Response1","Done.");
SetLocalInt(oQuestNPC,"QuestStep1Line5Done",6);

SetLocalString(oQuestNPC,"QuestStep1Line6","How's it going?");
SetLocalString(oQuestNPC,"QuestStep1Line6Response1","Pretty good.");
}

void Quest8()
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QNotComplete;

int iEN_QSType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;

string sEN_QSLine1;
string sEN_QSLine1Response1;
int iEN_QSLine1Response1Goto;
string sEN_QSLine1Response1Script;
int iEN_QSLine1Response1Accept;
int iEN_QSLine1Response1StepDone;

string sEN_QSLine2;
string sEN_QSLine2Response1;
int iEN_QSLine2Response1Goto;
string sEN_QSLine2Response1Script;
int iEN_QSLine2Response1Accept;
int iEN_QSLine2Response1StepDone;

int iEN_QSLine1Response1Check;
int iEN_QSLine2Response1Check;

int iEN_QLevel;
string sEN_QZone;

iEN_QLevel=5;
sEN_QZone="TST";

sEN_QName="Defending the land";
//iEN_QSteps=1;
iEN_QType=0;
sEN_QScript="";
iEN_QItemChanceMod=0;
sEN_QItemReward="";
iEN_QGold=0;
iEN_QNPCType=0;
sEN_QNotComplete="RANDOM";

iEN_QSType=7;
sEN_QSItem="en5_amulet";
iEN_QSCreateItem=0;
iEN_QSMobType=2;
sEN_QSMob="";
sEN_QSNPC="";
iEN_QSAmbush=0;

iEN_QSCampSpot=1; //must get free spot in the setup codes

sEN_QSLine1="Can you help me?";
sEN_QSLine1Response1="Yes, what do you need?";
iEN_QSLine1Response1Goto=2;
sEN_QSLine1Response1Script="";
iEN_QSLine1Response1Accept=0;
iEN_QSLine1Response1Check=0;

sEN_QSLine2="I need you to get the [item] which might be guarded by a pack of [camp] located [location].";
sEN_QSLine2Response1="Consider it done.";
iEN_QSLine2Response1Goto=0;
sEN_QSLine2Response1Script="";
iEN_QSLine2Response1Accept=3;
iEN_QSLine2Response1Check=0;

object oQuestNPC;
oQuestNPC=GetObjectByTag("EN6_QUESTWP");

SetLocalString(oQuestNPC,"QuestName",sEN_QName);
SetLocalString(oQuestNPC,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC,"QuestLevel",iEN_QLevel);

SetLocalInt(oQuestNPC,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC,"QuestNPCType",iEN_QNPCType);
SetLocalString(oQuestNPC,"QuestNotComplete",sEN_QNotComplete);

SetLocalInt(oQuestNPC,"QuestStep1Type",iEN_QSType);
SetLocalInt(oQuestNPC,"QuestStep1SpecialArea",1);
SetLocalString(oQuestNPC,"QuestStep1Item", sEN_QSItem);
SetLocalInt(oQuestNPC,"QuestStep1CreateItem", iEN_QSCreateItem);
SetLocalInt(oQuestNPC,"QuestStep1Camp", 7);
//SetLocalInt(oQuestNPC,"QuestStep1MobType", iEN_QSMobType);
SetLocalString(oQuestNPC,"QuestStep1MobTag",sEN_QSMob);
SetLocalString(oQuestNPC,"QuestStep1NPC", sEN_QSNPC);
SetLocalInt(oQuestNPC,"QuestStep1Ambush", iEN_QSAmbush);
SetLocalInt(oQuestNPC,"QuestStep1CampSpot",iEN_QSCampSpot);
SetLocalInt(oQuestNPC,"QuestStep1BossOnly",0);
SetLocalInt(oQuestNPC,"QuestStep1Boss",3);

SetLocalString(oQuestNPC,"QuestStep1Line1", sEN_QSLine1);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1", sEN_QSLine1Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",iEN_QSLine1Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line1Response1Script", sEN_QSLine1Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Check", iEN_QSLine1Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Accept", iEN_QSLine1Response1Accept);

SetLocalString(oQuestNPC,"QuestStep1Line2",sEN_QSLine2);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1", sEN_QSLine2Response1);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto", iEN_QSLine2Response1Goto);
SetLocalString(oQuestNPC,"QuestStep1Line2Response1Script", sEN_QSLine2Response1Script);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Check", iEN_QSLine2Response1Check);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Accept", iEN_QSLine2Response1Accept);

//Hardcoded
SetLocalString(oQuestNPC,"QuestStep1Line3","Did you get it?");
SetLocalString(oQuestNPC,"QuestStep1Line3Response1", "Yes, I found the [item].");
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto", 5);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Check", 2);
SetLocalString(oQuestNPC,"QuestStep1Line3Response2","I am still working on it.");

SetLocalString(oQuestNPC,"QuestStep1Line4","Did you find anything on the bodies?");
SetLocalString(oQuestNPC,"QuestStep1Line4Response1", "Yes, I found the [item].");
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto", 5);
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Check", 2);
SetLocalString(oQuestNPC,"QuestStep1Line4Response2","No, but I could go back and search.");

SetLocalString(oQuestNPC,"QuestStep1Line5","Excellent.");
SetLocalString(oQuestNPC,"QuestStep1Line5Response1","Done.");
SetLocalInt(oQuestNPC,"QuestStep1Line5Done",6);

SetLocalString(oQuestNPC,"QuestStep1Line6","How's it going?");
SetLocalString(oQuestNPC,"QuestStep1Line6Response1","Pretty good.");
}

