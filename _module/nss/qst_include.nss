#include "en5_misc"
#include "nw_i0_tool"
#include "en5_treasure"
#include "en5_encounters"

void GetCampQuest(object oQuestNPC);
void GetNPCQuest(object oQuestNPC);
void GetMobQuest(object oQuestNPC);
string GetCampName();
void GivePartyMiscReward(object oPC);
void GivePartyItemReward(object oPC,string sItemReward, int iItemLevel);
//void SetDescription(object oQuestNPC, string sText);
void SetStepDone(object oQuestNPC,string sText);
string FixResponse(object oNPC,string sString);
void SetJournalEntry(object oPC,string sDescription);
void AcceptQuest(object oPC,object oNPC=OBJECT_SELF);
void QuestDone(object oPC, object oQuestNPC = OBJECT_SELF);
int CheckMobs(object oQuestNPC);
void SetPartyVariables(object oPC);
object GetQuestNPC(location lLoc,string sZone,int iNPCType, int iLevel,string sNPCTag="");
int GetQuestNPCHelperLoc(string sTag,object oCompare,int iNPCType);
int GetQuestLocation(string sTag,int iMaxLoc, int iNPCType=1);
int GetQuestNPCLoc(object oQuestNPC,string sZone,int iNPCSpawn=0,int iNPCType=1);
object CreateQuestNPC(int iNPCType,location lLoc, string sTag, int iLevel);
object GetQuestHelperNPC(object oQuest);
int OpenAreaType(int iType, int iZoneExit=1, string sZone="");
int GetSpecialAreaNumber(int iType);
int GetSpecialMaxNumber(int iType);
string GetSpecialArea(int iType);
string SetupSpecialZone(string sZone, int iZoneExit, int iType);
void EquipNPC(object oQuestNPC);
void EquipPriest(object oQuestNPC);
void SetNPCName(object oQuestNPC,int iNPCType, int iLevel);
void SetupQuest(string sZone);
void TransferQuest(object oQuestNPC,object oQuestNPC2);
int GetQuestStepLines(object oQuestNPC,int iStep);
int GetQuestSteps(object oQuestNPC);
int GetCamp(string sZone,int iNPC,string sZoneCheck);
int GetSpot(string sZone,int iNPC,string sZoneCheck);
int GetCampSpot(string sZone,int iType, int iNPC,string sZoneCheck);
int CheckQuest(string sZone);
void SetDialoguePostQuest(object oQuestNPC);
int QuestGold(object oQuestNPC);
int QuestXP(object oQuestNPC);
void SetMajorAccomplishment(object oPC,object oQuestNPC,string sAccomplishment);
void SetAccomplishment(object oPC,object oQuestNPC);
void CheckFavorAndBlessing(object oPC,object oQuestNPC);
string GetOverallBossTag();
string GetOverallBossName();
void GetPotion(object oTarget, int iItemLevel);
void CreateMiscItem(object oPC);
void RewardPartyFame(int iFame,object oPC);
int QuestDifficulty(object oQuestNPC);
void SetupTokens(object oNPC);
void CheckFame(object oPC);
void GetTRQuest(object oQuestNPC);

object GetQuestNPC(location lLoc,string sZone,int iNPCType, int iLevel,string sNPCTag="")
{
int iQuestNPC;
int iFlag;
string sTag;
object oQuestNPC;
object oTestQuestNPC;
string sName;
string sZoneNPCType;

sZoneNPCType = sZone + "_NPCType" + IntToString(iNPCType);
iFlag=TRUE;

if (GetLocalString(GetModule(),sZoneNPCType) != "")
    {
    oTestQuestNPC=GetObjectByTag(GetLocalString(GetModule(),sZoneNPCType));
    if (GetLocalInt(oTestQuestNPC,"Quest") == 0)
        {
        oQuestNPC=oTestQuestNPC;
        iFlag=FALSE;
        }
    }

if (iFlag)
    {
    iQuestNPC=GetLocalInt(GetModule(),"QuestNPCs");
    iQuestNPC++;
    SetLocalInt(GetModule(),"QuestNPCs",iQuestNPC);
    sTag = "EN6_QuestNPC" + IntToString(iQuestNPC);

    if (sNPCTag == "")
        {
        oQuestNPC=CreateQuestNPC(iNPCType,lLoc,sTag,iLevel);
        if (GetLocalString(GetModule(),sZoneNPCType) == "")
            SetLocalString(GetModule(),sZoneNPCType,GetTag(oQuestNPC));
        else
            if (Random(3)==0)
                SetLocalString(GetModule(),sZoneNPCType,GetTag(oQuestNPC));
        }
    else
        {
        oQuestNPC=CreateObject(OBJECT_TYPE_CREATURE,sNPCTag,lLoc);
        SetLocalInt(oQuestNPC,"NPC",1);
        }
    }

return oQuestNPC;
}

object CreateQuestNPC(int iNPCType,location lLoc, string sTag, int iLevel)
{
object oQuestNPC;
int iEquip;
int iClass;
int iRandom;
string sName;
string sNPCTag;

iEquip=1;

if (iNPCType<1)
    iNPCType=1;

/*
1=general 10
2=guard 8
3=scholar 8
4=priest 5
5=hunter 6
6=commoner 6
7=merchant
*/

if (iNPCType==1)
    {
    sNPCTag="qst_helper_1_" + IntToString(Random(10)+1);
    iRandom=Random(10);
    if (iRandom<1)
        iClass=EN5_CLASS_WIZARD;
    else if (iRandom<2)
        iClass=EN5_CLASS_MONK;
    else if (iRandom<3)
        iClass=EN5_CLASS_BARBARIAN;
    else if (iRandom<4)
        iClass=EN5_CLASS_RANGER;
    else if (iRandom<5)
        iClass=EN5_CLASS_ROGUE;
    else if (iRandom<7)
        iClass=EN5_CLASS_CLERIC;
    else
        iClass=EN5_CLASS_FIGHTER;
    if (Random(4)==0)
        {
        iEquip=2;
        iLevel=0;
        }
    }
if (iNPCType==2)
    {
    sNPCTag="qst_helper_2_" + IntToString(Random(8)+1);
    iRandom=Random(10);
    if (iRandom<3)
        iClass=EN5_CLASS_BARBARIAN;
    else
        iClass=EN5_CLASS_FIGHTER;
    }
if (iNPCType==3)
    {
    sNPCTag="qst_helper_3_" + IntToString(Random(8)+1);
    iRandom=Random(10);
    if (iRandom<5)
        iClass=EN5_CLASS_SORCERER;
    else
        iClass=EN5_CLASS_WIZARD;
    }
if (iNPCType==4)
    {
    sNPCTag="qst_helper_4_" + IntToString(Random(5)+1);
    iRandom=Random(10);
    if (iRandom<7)
        iClass=EN5_CLASS_CLERIC;
    else if (iRandom<8)
        iClass=EN5_CLASS_PALADIN;
    else
        iClass=EN5_CLASS_MONK;
    iEquip=1;
    }
if (iNPCType==5)
    {
    sNPCTag="qst_helper_5_" + IntToString(Random(6)+1);
    iRandom=Random(10);
    if (iRandom<5)
        iClass=EN5_CLASS_RANGER;
    else if (iRandom<7)
        iClass=EN5_CLASS_ROGUE;
    else if (iRandom<9)
        iClass=EN5_CLASS_DRUID;
    else
        iClass=EN5_CLASS_FIGHTER;
    }
if (iNPCType==6)
    {
    sNPCTag="qst_helper_6_" + IntToString(Random(6)+1);
    iClass=EN5_CLASS_MONK;
    iEquip=2;
    iLevel=0;
    }
if (iNPCType==7)
    {
    sNPCTag="qst_helper_6_" + IntToString(Random(6)+1);
    iClass=EN5_CLASS_MONK;
    iEquip=2;
    iLevel=0;
    }
oQuestNPC=CreateObject(OBJECT_TYPE_CREATURE,sNPCTag,lLoc,FALSE,sTag);
SetLocalInt(oQuestNPC,"NPC",1);

if (iLevel>0)
    LevelMob(oQuestNPC,iLevel,iClass);
if (iEquip==1 && iLevel>0)
    DelayCommand(1.0,EquipMob(oQuestNPC));
if (iEquip==2 || iLevel==0)
    DelayCommand(1.0,EquipNPC(oQuestNPC));
if (iNPCType==4)
    {
    DelayCommand(2.0,EquipPriest(oQuestNPC));
    }

SetNPCName(oQuestNPC,iNPCType,iLevel);

return oQuestNPC;
}

void SetNPCName(object oQuestNPC,int iNPCType, int iLevel)
{
string sFirst;
string sLast;
string sName;
int iRace;
int iGender;
int iFirst;
int iLast;
int iRandom;

iRace=GetRacialType(oQuestNPC);
iGender=GetGender(oQuestNPC);

if (iGender==GENDER_MALE)
    {
    switch (iRace)
        {
        case RACIAL_TYPE_DWARF: iFirst=NAME_FIRST_DWARF_MALE; iLast=NAME_LAST_DWARF; break;
        case RACIAL_TYPE_ELF: iFirst=NAME_FIRST_ELF_MALE; iLast=NAME_LAST_ELF; break;
        case RACIAL_TYPE_GNOME: iFirst=NAME_FIRST_GNOME_MALE; iLast=NAME_LAST_GNOME; break;
        case RACIAL_TYPE_HALFLING: iFirst=NAME_FIRST_HALFLING_MALE; iLast=NAME_LAST_HALFLING; break;
        case RACIAL_TYPE_HUMAN: iFirst=NAME_FIRST_HUMAN_MALE; iLast=NAME_LAST_HUMAN; break;
        case RACIAL_TYPE_HALFORC: iFirst=NAME_FIRST_HALFORC_MALE; iLast=NAME_LAST_HALFORC; break;
        }
    } else {
    switch (iRace)
        {
        case RACIAL_TYPE_DWARF: iFirst=NAME_FIRST_DWARF_FEMALE; iLast=NAME_LAST_DWARF; break;
        case RACIAL_TYPE_ELF: iFirst=NAME_FIRST_ELF_FEMALE; iLast=NAME_LAST_ELF; break;
        case RACIAL_TYPE_GNOME: iFirst=NAME_FIRST_GNOME_FEMALE; iLast=NAME_LAST_GNOME; break;
        case RACIAL_TYPE_HALFLING: iFirst=NAME_FIRST_HALFLING_FEMALE; iLast=NAME_LAST_HALFLING; break;
        case RACIAL_TYPE_HUMAN: iFirst=NAME_FIRST_HUMAN_FEMALE; iLast=NAME_LAST_HUMAN; break;
        case RACIAL_TYPE_HALFORC: iFirst=NAME_FIRST_HALFORC_FEMALE; iLast=NAME_LAST_HALFORC; break;
        }
    }

sFirst=RandomName(iFirst);
sLast=RandomName(iLast);

if (iNPCType==2)
    {
    if (iLevel<4)
        sFirst="Guard";
    else if (iLevel<10)
        sFirst="Sergeant";
    else if (iLevel<15)
        sFirst="Captain";
    else if (iLevel<25)
        sFirst="Commander";
    else
        sFirst="Lord";
    }

if (iNPCType==3)
    {
    if (iLevel<4)
        sFirst="Apprentice";
    else if (iLevel < 6)
        {
         if (Random(3)==0)
            if (Random(2)==0)
                sLast=sLast + " the Journeyman";
            else
                sFirst="Journeyman";
        }
    else if (iLevel<15)
        {
        if (Random(5)==0)
            if (Random(2)==0)
                sLast=sLast + " the Magician";
            else
                sLast=sLast + " the Magi";
        }
    else if (iLevel<21)
        {
        if (Random(5)==0)
            if (Random(2)==0)
                sLast=sLast + " the Theurgist";
            else
                sLast=sLast + " the Wizard";
        }
    else
        {
        iRandom=Random(10);
        if (iRandom<3)
            sFirst="Archmage";
        if (iRandom<5)
            sFirst="Adept";
        else if (iRandom<6)
            sLast=sLast + " the Wise";
        else if (iRandom<7)
            sLast=sLast + " the Powerful";
        else if (iRandom<8)
            sLast=sLast + " the Adept";
        }
    if (iLevel<20 && Random(4)==0)
        {
        iRandom=Random(4)+1;
        if (iRandom==1)
            sFirst="Scholar";
        else if (iRandom==2)
            sFirst="Sage";
        else if (iRandom==3)
            sFirst="Researcher";
        else
            sFirst="Scribe";
        }
    }

if (iNPCType==4)
    {
    if (iLevel<15)
        {
        iRandom=Random(10);
        if (iRandom>0)
            if (iGender==GENDER_MALE)
                sFirst="Brother";
            else
                sFirst="Sister";
        }
     else if (iLevel<25)
        {
        iRandom=Random(8);
        if (iRandom>0)
            if (iGender==GENDER_MALE)
                sFirst="Father";
            else
                sFirst="Elder Sister";
        }
      else
        {
        iRandom=Random(6);
        if (iRandom>0)
            if (iGender==GENDER_MALE)
                sFirst="Holy Father";
            else
                sFirst="Holy Mother";
        }
    }
if (iNPCType==5)
    {
    if (Random(6)==0)
        {
        iRandom=Random(6);
        if (iRandom<1)
            sFirst="Hunter";
        else if (iRandom<2)
            sFirst="Trapper";
        else if (iRandom<3)
            sFirst="Woodsman";
        else if (iRandom<4)
            sLast="the Trapper";
        else if (iRandom<5)
            sLast="the Hunter";
        else
            sLast="the Woodsman";
        }
    }
if (iNPCType==7)
    {
    if (Random(5) > 0)
        {
        sFirst="Merchant";
        } else {
        sLast="the Fence";
        SetLocalInt(oQuestNPC,"Fence",1);
        }
    }

sName=sFirst+ " " + sLast;
SetName(oQuestNPC,sName);
}

void EquipNPC(object oQuestNPC)
{
object oItem;
string sTag;
int iGender;

SetLocalInt(oQuestNPC,"Armor",1);
SetLocalInt(oQuestNPC,"EN5_Equip",1);

iGender=GetGender(oQuestNPC);
if (iGender==GENDER_MALE)
    sTag = "EN_GENERAL_" + IntToString(Random(10)+1);
else
    sTag = "EN_FGENERAL_" + IntToString(Random(8)+1);

oItem=CreateItemOnObject(sTag,oQuestNPC,1);
EquipItem(INVENTORY_SLOT_CHEST, oItem, oQuestNPC);
}

void EquipPriest(object oQuestNPC)
{
object oItem;
string sTag;
int iGender;

SetLocalInt(oQuestNPC,"Armor",1);
SetLocalInt(oQuestNPC,"EN5_Equip",1);
SetLocalInt(oQuestNPC,"EN6_DISARM",1);
sTag = "en_priestrobe";

oItem=CreateItemOnObject(sTag,oQuestNPC,1);
EquipItem(INVENTORY_SLOT_CHEST, oItem, oQuestNPC);
DelayCommand(0.1,AssignCommand(oQuestNPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oQuestNPC))));
DelayCommand(0.1,AssignCommand(oQuestNPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oQuestNPC))));

SetLocalString(oQuestNPC,"EN6_ARMOR",sTag);
}

object GetQuestHelperNPC(object oQuest)
{
int iQuestNPC;
int iFlag;
int iStep;
string sTag;
object oQuestNPC;
object oTestQuestNPC;
string sName;
string sZoneNPCType;
string sSpawnTag;
location lLoc;
string sZone;
string sQS;
string sLocation;
int iNPCType;
int iLevel;
int iNPCSpawn;
int iSpot;

iStep=GetLocalInt(oQuest,"QuestStep");
if (iStep<1)
    iStep=1;
sQS="QuestStep" + IntToString(iStep);
sZone=GetLocalString(oQuest,"QuestZone");
iNPCType=GetLocalInt(oQuest,sQS + "NPCType");
iNPCSpawn=GetLocalInt(oQuest,sQS + "NPCSpawn");

sZoneNPCType = sZone + "_NPCType" + IntToString(iNPCType);
iFlag=TRUE;


if (GetLocalString(GetModule(),sZoneNPCType) != "" && iNPCSpawn == 0)
    {
    oTestQuestNPC=GetObjectByTag(GetLocalString(GetModule(),sZoneNPCType));
    //debug code
    //if (GetTag(oTestQuestNPC) != GetTag(oQuest))
    if (GetTag(oTestQuestNPC) != GetTag(oQuest) && GetArea(oTestQuestNPC) != GetArea(oQuest) && GetLocalInt(oTestQuestNPC,"NoHelper") == 0)
        {
        oQuestNPC=oTestQuestNPC;
        iFlag=FALSE;
        }
    }

if (iFlag)
    {

    iLevel=GetLocalInt(oQuest,"QuestLevel");

    sSpawnTag=sZone+"_Q_NPC";
    iSpot=GetQuestNPCHelperLoc(sSpawnTag,oQuest,iNPCType);
    sSpawnTag=sSpawnTag+IntToString(iSpot);
    oTestQuestNPC=GetObjectByTag(sSpawnTag);
    if (GetLocalInt(oTestQuestNPC,"NoHelper")>0)
        {
        iSpot=GetQuestNPCHelperLoc(sSpawnTag,oQuest,iNPCType);
        sSpawnTag=sSpawnTag+IntToString(iSpot);
        oTestQuestNPC=GetObjectByTag(sSpawnTag);
        if (GetLocalInt(oTestQuestNPC,"NoHelper")>0)
            {
            iSpot=GetQuestNPCHelperLoc(sSpawnTag,oQuest,iNPCType);
            sSpawnTag=sSpawnTag+IntToString(iSpot);
            }
        }
    lLoc=GetLocation(GetObjectByTag(sSpawnTag));

    iQuestNPC=GetLocalInt(GetModule(),"QuestNPCs");
    iQuestNPC++;
    SetLocalInt(GetModule(),"QuestNPCs",iQuestNPC);
    sTag = "EN6_QuestNPC" + IntToString(iQuestNPC);

    oQuestNPC=CreateQuestNPC(iNPCType,lLoc,sTag,iLevel);
    if (iNPCType>1 && iNPCType <6)
        ChangeFaction(oQuestNPC,GetObjectByTag("en6_defender"));

    SetLocalInt(oQuestNPC,"QuestSpot",iSpot);
    sLocation = GetLocalString(GetObjectByTag(sSpawnTag),"Location");

    SetLocalString(oQuestNPC,"Location",sLocation);
    SetLocalString(oQuestNPC,"QuestStep1Line1", "May I help you?");
    SetLocalString(oQuestNPC,"QuestStep1Line1Response1", "Not right now, thanks.");

    if (GetLocalString(GetModule(),sZoneNPCType) == "")
        SetLocalString(GetModule(),sZoneNPCType,GetTag(oQuestNPC));
    else
        if (Random(3)==0)
            SetLocalString(GetModule(),sZoneNPCType,GetTag(oQuestNPC));
    }

return oQuestNPC;
}

void GetNPCQuest(object oQuestNPC)
{
int iQuestNPC;
int iStep;
int iGold;
int iXP;
int iQuestLevel;
int iNPCType;
int iSpot;
int iAmbush;
int iCampSpot;
int iBoss;
int iLine;
string sZone;
string sTag;
string sNPCTag;
string sName;
string sQS;
string sItem;
string sItemName;
string sSpawnTag;
string sLocation;
string sNPCName;
string sQSL;
object oNewNPC;
object oBoss;
location lLoc;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
if (iStep<1)
    iStep=1;
iLine=GetLocalInt(oQuestNPC,"QuestLine");
if (iLine<1)
    iLine=1;

sQS="QuestStep" + IntToString(iStep);
sQSL="QuestStep" + IntToString(iStep) + "Line" + IntToString(iLine);

if (oQuestNPC != OBJECT_SELF && GetIsObjectValid(OBJECT_SELF))
    oNewNPC=oQuestNPC;
else
    oNewNPC=GetQuestHelperNPC(oQuestNPC);

sItem=GetLocalString(oQuestNPC,sQS + "Item");
if (sItem != "")
    {
    sItemName=GetName(GetObjectByTag(sItem));
    if (sItemName=="")
        {
        CreateItemOnObject(sItem,GetObjectByTag("en_itemholder"));
        sItemName=GetName(GetObjectByTag(sItem));
        }
    }

sLocation = GetLocalString(oNewNPC,"Location");

SetLocalString(oQuestNPC,sQS + "NPC",GetTag(oNewNPC));
SetLocalString(oQuestNPC,sQS + "NPCName",GetName(oNewNPC));
SetLocalString(oQuestNPC,sQS + "ItemName",sItemName);
SetLocalString(oQuestNPC,sQS + "Location",sLocation);

if (oQuestNPC == OBJECT_SELF || !GetIsObjectValid(OBJECT_SELF))
    sNPCName = GetName(oQuestNPC);
else
    sNPCName = GetName(OBJECT_SELF);

SetLocalInt(oQuestNPC,"QuestJournalUpdate",0);

if (sItem != "")
    SetDescription(oQuestNPC,"I have promised " + sNPCName + " I would take the " + sItemName + " to " + GetName(oNewNPC) + " located " + sLocation);
else
    SetDescription(oQuestNPC,"I have promised " + sNPCName + " I would seek out " + GetName(oNewNPC) + " located " + sLocation);

}

int GetQuestLocation(string sTag,int iMaxLoc, int iNPCType=1)
{
int iCount;
int iRandom;
int iReturn;
int iFlag;
int iIndex;
object oSpot;

iReturn=0;
iRandom=Random(iMaxLoc)+1;

//if spot is used try to find another spot
oSpot=GetObjectByTag(sTag + IntToString(iRandom));
if (GetLocalInt(oSpot,"Used") == 1)
    {
    iFlag=FALSE;
    iIndex=iRandom;
    while (iIndex<=iMaxLoc)
        {
        if (GetLocalInt(oSpot,"Used") == 0)
            {
            iFlag=TRUE;
            iRandom=iIndex;
            iIndex=iMaxLoc+1;
            } else {
            iIndex++;
            }
        }
    //if no spot found after random spot check before it
    if (iFlag==FALSE)
        {
        iIndex=1;
        while (iIndex < iRandom)
            {
            if (GetLocalInt(oSpot,"Used") == 0)
                {
                iFlag=TRUE;
                iRandom=iIndex;
                iIndex=iMaxLoc+1;
                } else {
                iIndex++;
                }
            }
        }
    }

//If spot has npctype not the same as npc then move down one
oSpot=GetObjectByTag(sTag + IntToString(iRandom));
if (GetLocalInt(oSpot,"NPCType") > 0 && GetLocalInt(oSpot,"NPCType") != iNPCType)
    iRandom++;
if (iRandom>iMaxLoc)
    iRandom=1;

//check to see if there is npctype spot to spawn at
iIndex=1;
oSpot=GetObjectByTag(sTag + IntToString(iIndex));
while (iIndex<=iMaxLoc)
    {
    if (GetLocalInt(oSpot,"NPCType") == iNPCType)
        {
        iRandom=iIndex;
        iIndex=iMaxLoc+1;
        } else {
        iIndex++;
        }
    }

oSpot=GetObjectByTag(sTag + IntToString(iRandom));
SetLocalInt(oSpot,"Used",1);
iReturn=iRandom;


//sTest used to be passed to function, but was never used.  Seems to be
//for testing for unique spot but I forgot why I put it in there so not sure.
//I should take more notes.

/*
if (sTest=="")
    iReturn=iRandom;
else if (GetLocalInt(oSpot,sTest) == 0)
    {
    iReturn=iRandom;
    SetLocalInt(oSpot,sTest,1);
    }
else
    {
    iCount=iRandom+1;
    iFlag=FALSE;
    while (iCount <= iMaxLoc && iFlag==FALSE)
        {
        oSpot=GetObjectByTag(sTag + IntToString(iCount));
        if (GetLocalInt(oSpot,sTest) == 0)
            {
            iReturn=iRandom;
            SetLocalInt(oSpot,sTest,1);
            iFlag=TRUE;
            } else {
            iCount++;
            }
        }
    if (iFlag==FALSE)
        {
        iCount=1;
        iFlag=FALSE;
        while (iCount < iRandom && iFlag==FALSE)
            {
            oSpot=GetObjectByTag(sTag + IntToString(iCount));
            if (GetLocalInt(oSpot,sTest) == 0)
                {
                iReturn=iRandom;
                SetLocalInt(oSpot,sTest,1);
                iFlag=TRUE;
                } else {
                iCount++;
                }
            }
        }
    }
*/
return iReturn;
}

int GetQuestNPCHelperLoc(string sTag,object oCompare,int iNPCType)
{
int iMaxLoc;
int iLoc;
int iCount;
int iFlag;
string sTestTag;
object oSpot;

iMaxLoc=MaxObject(sTag);
iLoc=GetQuestLocation(sTag,iMaxLoc,iNPCType);
if (iLoc==0)
    iLoc = Random(iMaxLoc) + 1;

sTestTag=sTag + IntToString(iLoc);
oSpot = GetObjectByTag(sTestTag);

if (GetArea(oSpot)==GetArea(oCompare))
    {
    iCount=1;
    iFlag=FALSE;
    while (iCount <= iMaxLoc && iFlag==FALSE)
        {
        oSpot=GetObjectByTag(sTag + IntToString(iCount));
        if (GetArea(oSpot)==GetArea(oCompare) || GetLocalString(GetArea(oSpot),"Zone") == GetLocalString(GetArea(oCompare),"Zone"))
            {
            iCount++;
            } else {
            iFlag=TRUE;
            }
        }
    if (iCount>iMaxLoc)
        iCount=Random(iMaxLoc)+1;
    iLoc=iCount;
    }


return iLoc;
}

int QuestDifficulty(object oQuestNPC)
{
int iIndex;
int iSteps;
int iCamps;
int iSpots;
int iDelivery;
int iQuestStepType;
int iQuestLevel;
int iXP;
int iBaseXP;
int iAmbush;
int iDifficulty;

iQuestLevel=GetLocalInt(oQuestNPC,"QuestLevel");

iIndex=1;
iSteps=GetLocalInt(oQuestNPC,"QuestSteps");

iCamps=0;
iSpots=0;
iDelivery=0;
while (iIndex <= iSteps)
    {
    iQuestStepType=GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Type");
    if (iQuestStepType==1)
        iSpots++;
    if (iQuestStepType==2 || iQuestStepType==4 || iQuestStepType==5 || iQuestStepType==6 || iQuestStepType==7)
        iCamps++;
    if (iQuestStepType==3)
        iDelivery++;
    if (iQuestStepType==3 && GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Ambush") >0)
        iAmbush++;

    iIndex++;
    }

iDifficulty = iDelivery + (iSpots + iAmbush) * 2 + iCamps * 4;

//slight bonus for quest level
iDifficulty = iDifficulty + (iDifficulty * iQuestLevel/50);

return iDifficulty;
}

int QuestXP(object oQuestNPC)
{
int iIndex;
int iSteps;
int iCamps;
int iSpots;
int iDelivery;
int iQuestStepType;
int iQuestLevel;
int iXP;
int iBaseXP;
int iAmbush;

iQuestLevel=GetLocalInt(oQuestNPC,"QuestLevel");

iIndex=1;
iSteps=GetLocalInt(oQuestNPC,"QuestSteps");

iCamps=0;
iSpots=0;
iDelivery=0;
while (iIndex <= iSteps)
    {
    iQuestStepType=GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Type");
    if (iQuestStepType==1)
        iSpots++;
    if (iQuestStepType==2 || iQuestStepType==4 || iQuestStepType==5 || iQuestStepType==6 || iQuestStepType==7)
        iCamps++;
    if (iQuestStepType==3)
        iDelivery++;
    if (iQuestStepType==3 && GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Ambush") >0)
        iAmbush++;

    iIndex++;
    }

iXP=0;
iBaseXP=800 + ((300 + 200 * iCamps) * iQuestLevel)/5;
if (iCamps>0)
    iXP=iBaseXP * iCamps;
iBaseXP=400 + ((100 + 100 * iSpots) * iQuestLevel)/5;
if (iSpots>0)
    iXP=iXP + iBaseXP * iSpots;
iBaseXP=400 + ((150 + 100 * iDelivery) * iQuestLevel)/5;
if (iDelivery>0)
    iXP=iXP + iBaseXP * iDelivery;
iBaseXP=400 + ((100 + 100 * iAmbush) * iQuestLevel)/5;
if (iAmbush>0)
    iXP=iXP + iBaseXP * iAmbush;

return iXP;

}

int QuestGold(object oQuestNPC)
{
int iIndex;
int iSteps;
int iCamps;
int iSpots;
int iDelivery;
int iQuestStepType;
int iQuestLevel;
int iGold;
int iBaseGold;

iQuestLevel=GetLocalInt(oQuestNPC,"QuestLevel");


iIndex=1;
iSteps=GetLocalInt(oQuestNPC,"QuestSteps");
iCamps=0;
iSpots=0;
iDelivery=0;
while (iIndex <= iSteps)
    {
    iQuestStepType=GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Type");
    if (iQuestStepType==1)
        iSpots++;
    if (iQuestStepType==2 || iQuestStepType==4 || iQuestStepType==5 || iQuestStepType==6 || iQuestStepType==7)
        iCamps++;
    if (iQuestStepType==3)
        iDelivery++;

    iIndex++;
    }

iGold=0;
iBaseGold=50 + 50 * (iQuestLevel/5);
if (iCamps>0)
    iGold=iBaseGold * iCamps;
iBaseGold=20 + 10 * (iQuestLevel/5);
if (iSpots>0)
    iGold=iGold + iBaseGold * iSpots;
iBaseGold=10 + 5 * (iQuestLevel/5);
if (iDelivery>0)
    iGold=iGold + iBaseGold * iDelivery;

if (GetLocalInt(oQuestNPC,"QuestGold") > 0)
    iGold = GetLocalInt(oQuestNPC,"QuestGold");

return iGold;

}


void QuestDone(object oPC, object oQuestNPC = OBJECT_SELF)
{
int iGold;
int iXP;
int iChance;
int iReward;
int iMaxLevel;
int iItemLevel;
int iQuestLine;
int iNPCType;
int iQuestLevel;
int iFame;
string sItemReward;
string sNPC;

/*
iGold = GetLocalInt(oQuestNPC,"QuestGold");
if (iGold<0)
    iGold=0;
iXP = GetLocalInt(oQuestNPC,"QuestXP");
*/
iGold=QuestGold(oQuestNPC);
iXP=QuestXP(oQuestNPC);
iChance = GetLocalInt(oQuestNPC,"QuestItemChance");
sItemReward = GetLocalString(oQuestNPC,"QuestItemReward");
iNPCType=GetLocalInt(oQuestNPC,"QuestNPCType");
iQuestLevel=GetLocalInt(oQuestNPC,"QuestLevel");

if (iNPCType==1)
    iChance=iChance + 1 + iQuestLevel/10;
if (iNPCType==2 || iNPCType==5)
    iChance=iChance + 2 + iQuestLevel/8;
if (iNPCType==3 || iNPCType==4)
    iChance=iChance + 5 + iQuestLevel/6;

iReward = Random(100);
if (GetSkillRank(SKILL_PERSUADE,oPC)>4)
    {
    if (GetIsSkillSuccessful(oPC,SKILL_PERSUADE,25))
        {
        iGold=iGold*3/2;
        iReward=iReward-2;
        }
    }

if (GetSkillRank(SKILL_INTIMIDATE,oPC)>4)
    {
    if (GetIsSkillSuccessful(oPC,SKILL_INTIMIDATE,25))
        {
        iGold=iGold*3/2;
        iReward=iReward-2;
        }
    }

if (GetSkillRank(SKILL_BLUFF,oPC)>4)
    {
    if (GetIsSkillSuccessful(oPC,SKILL_BLUFF,25))
        {
        iGold=iGold*3/2;
        iReward=iReward-2;
        }
    }

if (iReward < 0)
    iReward = 0;

iMaxLevel = GetLocalInt(oQuestNPC,"QuestLevel");
if (iMaxLevel < 8)
    iMaxLevel = iMaxLevel + 5;
else if (iMaxLevel < 16)
    iMaxLevel = iMaxLevel + 10;
else
    iMaxLevel = 41;

if (GetHitDice(oPC)>iMaxLevel)
    {
    iXP = 0;
    iChance=0;
    }

if (GetHitDice(oPC)<(GetLocalInt(oQuestNPC,"QuestLevel")-3) && GetLocalInt(oQuestNPC,"QuestLevel")<20)
    iXP = iXP + iXP/4;


if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    iXP = iXP * 75/100;

//GetError("XP="+ IntToString(iXP) + " | GP=" + IntToString(iGold) + " | MaxQuestLevel = " + IntToString(iMaxLevel));

RewardPartyXP(iXP, oPC);
RewardPartyGP(iGold, oPC);
iFame=QuestDifficulty(oQuestNPC);
if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    iFame = iFame/2;
if (GetLocalInt(oQuestNPC,"QuestType")==1)
    iFame = iFame + 5 * GetLocalInt(oQuestNPC,"QuestNPCNumber");

if (GetLocalInt(oQuestNPC,"QuestType")==2)
    iFame = iFame + GetLocalInt(oQuestNPC,"QuestNPCNumber");

RewardPartyFame(iFame,oPC);

iItemLevel = GetItemLevel(GetLocalInt(OBJECT_SELF,"QuestLevel"));

while (iItemLevel>0)
    {
    if (iReward<iChance)
        {
        GivePartyItemReward(oPC,sItemReward,iItemLevel);
        iItemLevel=0;
        iReward=120;
        } else {
        iItemLevel--;
        sItemReward="";
        }
    }

if (iReward<100 && (iReward-15) < iChance)
    GivePartyMiscReward(oPC);

CheckFavorAndBlessing(oPC,oQuestNPC);
SetAccomplishment(oPC,oQuestNPC);

SetPartyVariables(oPC);

SetLocalInt(oQuestNPC,"QuestComplete",1);
SetPartyInt(oPC,"OnQuest",0);
AddJournalQuestEntry("jQuest",21,oPC);
SetLocalInt(oQuestNPC,"QuestLine",0);
SetLocalInt(oQuestNPC,"QuestStep",1);
SetLocalInt(oQuestNPC,"QuestLineStart",100);

CheckFame(oPC);

if (GetLocalInt(oQuestNPC,"QuestType")==1)
    {
    if (GetLocalInt(oQuestNPC,"QuestNPCNumber") == GetLocalInt(GetModule(),"MQ_MaxNPCs"))
        SetLocalInt(GetModule(),"MainQuest",98);
    else
        SetLocalInt(GetModule(),"MainQuest",GetLocalInt(oQuestNPC,"QuestNPCNumber"));
    }

SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);

}

void CheckFame(object oPC)
{
int iTotalFame;
int iFameLevel;

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    iTotalFame=GetLocalInt(oPartyMember,"Fame");
    iFameLevel=GetLocalInt(oPartyMember,"FameLevel");
    if (iFameLevel == 0 && iTotalFame >49)
        {
        SendMessageToPC(oPartyMember,"Your fame has increased enough so that you are now known in Nova City.");
        SetLocalInt(oPC,"FameLevel",1);
        }
    if (iFameLevel == 1 && iTotalFame >99)
        {
        SendMessageToPC(oPartyMember,"Your fame has increased enough so that you are now known in Nova City.");
        SetLocalInt(oPC,"FameLevel",2);
        }
    if (iFameLevel == 2 && iTotalFame >149)
        {
        SendMessageToPC(oPartyMember,"Your fame has increased enough so that you are now known in Nova City.");
        SetLocalInt(oPC,"FameLevel",3);
        }
    if (iFameLevel == 3 && iTotalFame >199)
        {
        SendMessageToPC(oPartyMember,"Your fame has increased enough so that you are now known in Nova City.");
        SetLocalInt(oPC,"FameLevel",4);
        }
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }

}

void RewardPartyFame(int iFame,object oPC)
{
int iTotalFame;

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    iTotalFame=GetLocalInt(oPC,"Fame");
    iTotalFame=iTotalFame+iFame;
    SetLocalInt(oPC,"Fame",iTotalFame);
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }

}

void GivePartyItemReward(object oPC,string sItemReward, int iItemLevel)
{

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    if (sItemReward == "")
        GetMagicItem(oPartyMember,iItemLevel);
    else
        {
        if (sItemReward == "WEAPON")
            GetMagicItem(oPartyMember,iItemLevel,1);
        else if (sItemReward == "ARMOR")
            GetMagicItem(oPartyMember,iItemLevel,2);
        else
            CreateItemOnObject(sItemReward,oPartyMember);
        }
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

void GivePartyMiscReward(object oPC)
{
int iItemLevel;
int iRandom;

iItemLevel = GetItemLevel(GetLocalInt(OBJECT_SELF,"QuestLevel"));

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    iRandom=Random(10);
    if (iRandom<6)
        GetPotion(oPartyMember,iItemLevel);
    else if (iRandom<8)
        CreateMiscItem(oPartyMember);
    else if (iItemLevel>2)
        GetMagicItem(oPartyMember,1);
    else
        GetPotion(oPartyMember,iItemLevel);

    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

void CheckFavorAndBlessing(object oPC,object oQuestNPC)
{
int iType;
int iFavor;
int iIndex;
int iSteps;
int iDifficulty;
int iChance;
int iQuestStepType;
object oPartyMember;

iType=GetLocalInt(oQuestNPC,"QuestNPCType");

iIndex=1;
iSteps=GetLocalInt(oQuestNPC,"QuestSteps");
iDifficulty=0;
while (iIndex <= iSteps)
    {
    iQuestStepType=GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Type");
    if (iQuestStepType==1)
        iDifficulty=iDifficulty+1;
    if (iQuestStepType==2 || iQuestStepType==4 || iQuestStepType==5 || iQuestStepType==6 || iQuestStepType==7)
        iDifficulty=iDifficulty+3;
    if (iQuestStepType==3 && GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Ambush") >0)
        iDifficulty=iDifficulty+2;
    iIndex++;
    }

if (iDifficulty<3)
    iChance=0;
else if (iDifficulty<4)
    iChance=5;
else if (iDifficulty<6)
    iChance=10;
else if (iDifficulty<9)
    iChance=25;
else if (iDifficulty<10)
    iChance=50;
else
    iChance=100;

if (Random(100)<iChance)
    {
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        if (iType==3)
            {
            iFavor=GetLocalInt(oPartyMember,"MagicalFavor");
            SetLocalInt(oPartyMember,"MagicalFavor",iFavor+1);
            SendMessageToPC(oPartyMember,"You have earned the favor of the Mage's Guild in Nova City.");
            }
        if (iType==4)
            {
            iFavor=GetLocalInt(oPartyMember,"DivineBlessing");
            SetLocalInt(oPartyMember,"DivineBlessing",iFavor+1);
            SendMessageToPC(oPartyMember,"You have earned a Divine Blessing from the Church in Nova City.");
            }
        oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
    }
}

void SetAccomplishment(object oPC,object oQuestNPC)
{
string sZone;
string sAccomplishment;
string sZoneAccomplishment;
int iAccomplishment;
int iDifficulty;

sZone = GetLocalString(oQuestNPC,"QuestZone");
sAccomplishment = GetLocalString(oQuestNPC,"QuestAccomplishment");
sAccomplishment=FixResponse(oQuestNPC,sAccomplishment);
iDifficulty=QuestXP(oQuestNPC);

if (sAccomplishment != "")
    {
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        iAccomplishment = GetLocalInt(oPartyMember,"Accomplishments");
        iAccomplishment++;
        SetLocalInt(oPartyMember,"Accomplishments",iAccomplishment);
        SetLocalString(oPartyMember,"Accomplishment" + IntToString(iAccomplishment),sAccomplishment);
        SetLocalInt(oPartyMember,"Accomplishment" + IntToString(iAccomplishment) + "Diff",iDifficulty);
        oPartyMember = GetNextFactionMember(oPC, TRUE);

        sZoneAccomplishment = GetLocalString(oPartyMember,sZone + "_Accomplishment");
        if (sZoneAccomplishment == "")
            SetPartyString(oPartyMember,sZone + "_Accomplishment",sAccomplishment);
        else
            if (Random(2)==0)
                SetPartyString(oPartyMember,sZone + "_Accomplishment",sAccomplishment);

        SetMajorAccomplishment(oPartyMember,oQuestNPC,sAccomplishment);
        }
    }
}

void SetMajorAccomplishment(object oPC,object oQuestNPC,string sAccomplishment)
{
int iMADifficulty;
int iDifficulty;

iMADifficulty= GetLocalInt(oPC,"MADifficulty");
iDifficulty=QuestXP(oQuestNPC);

if (iDifficulty>=iMADifficulty)
    {
    SetLocalString(oPC,"MajorAccomplishment",sAccomplishment);
    SetLocalInt(oPC,"MADifficulty",iDifficulty);
    }
}

void GetTRQuest(object oQuestNPC)
{
int iStep;
int iSA;
int iMaxChest;
int iRandom;
string sTag;
string sQS;
string sQuestItem;
string sZone;
string sSALoc;
string sLocation;
string sNPCName;
string sNPCLocation;
object oChest;
object oItem;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
sQS="QuestStep" + IntToString(iStep);
iSA=GetLocalInt(oQuestNPC,sQS + "SpecialArea");
sQuestItem=GetLocalString(oQuestNPC,sQS + "Item");
sZone=GetLocalString(oQuestNPC,sQS + "Zone");
if (sZone=="")
    sZone=GetLocalString(oQuestNPC,"Zone");

sTag=sZone + "_TREASURE";
iMaxChest=MaxObject(sTag);
if (iMaxChest <1)
    {
    SendMessageToPC(GetFirstPC(),"ERROR: No chest in " + sZone + " to spawn item in.");
    return;
    }
iRandom=Random(iMaxChest)+1;
sTag=sTag + ItS(iRandom);
oChest = GetObjectByTag(sTag);
if (!GetIsObjectValid(oChest))
    SendMessageToPC(GetFirstPC(),"ERROR: Could not create chest " + sTag + ".");
oItem=CreateItemOnObject(sQuestItem,oChest);
if (!GetIsObjectValid(oItem) && sQuestItem != "")
    SendMessageToPC(GetFirstPC(),"ERROR: Could not create " + sQuestItem + " in " + sTag + ".");

WriteTimestampedLogEntry(GetName(oItem) + " (" + sQuestItem + ") spawned at " + sTag + ".");

sSALoc=GetLocalString(oQuestNPC,"QuestZone") + "_1_Enter";
sLocation= GetLocalString(GetObjectByTag(sSALoc),"Location");
if (sLocation=="")
    sLocation = "somewhere in the nearby area";

SetLocalString(oQuestNPC,sQS + "Location",sLocation);
SetLocalString(oQuestNPC,sQS + "ItemName",GetName(oItem));

if (oQuestNPC == OBJECT_SELF || !GetIsObjectValid(OBJECT_SELF))
    {
    sNPCName = GetName(oQuestNPC);
    sNPCLocation = GetLocalString(oQuestNPC,"Location");
    } else {
    sNPCName = GetName(OBJECT_SELF);
    sNPCLocation = GetLocalString(OBJECT_SELF,"Location");
    }
SetLocalString(oQuestNPC,sQS + "NPCName",sNPCName);
SetLocalString(oQuestNPC,sQS + "NPCLocation",sNPCLocation);

if (iSA==9)
    SetDescription(oQuestNPC,"I should begin my search in a dungeon located " + sLocation + ".");
else
    SetDescription(oQuestNPC,"I should begin my search " + sLocation + ".");
SetStepDone(oQuestNPC,"I have found the " + GetName(oItem) + ".  I should return to " + sNPCName + " " + sNPCLocation + ".");

SetLocalInt(oQuestNPC,"QuestJournalUpdate",0);

}

void GetCampQuest(object oQuestNPC)
{
int iQuestLevel;
int iCampSpot;
int iStep;
int iHideItem;
//int iMagicChance;
int iBoss;
int iCamp;
int iGold;
int iXP;
int iTotalCamps;
int iStepType;
int iSAType;
int iRepeatCamp;
int iChance;
int iCampTheme;
string sQS;
string sCamp;
string sMob;
string sLocation;
string sMobName;
string sQuestItem;
string sCampType;
string sZone;
string sChest;
string sSALoc;
string sNPCName;
string sNPCLocation;
string sTag;
object oBoss;
object oItem;
object oChest;
object oTest;
location lChest;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
sQS="QuestStep" + IntToString(iStep);
iCamp=GetLocalInt(oQuestNPC,sQS + "Camp");
iCampSpot=GetLocalInt(oQuestNPC,sQS + "CampSpot");
iCampTheme=GetLocalInt(oQuestNPC,sQS + "CampTheme");
iStepType=GetLocalInt(oQuestNPC,sQS + "Type");
iRepeatCamp=GetLocalInt(oQuestNPC,sQS + "RepeatCamp");
sQuestItem=GetLocalString(oQuestNPC,sQS + "Item");
iBoss=GetLocalInt(oQuestNPC,sQS + "Boss");
sZone=GetLocalString(oQuestNPC,sQS + "Zone");
if (sZone=="")
    sZone=GetLocalString(oQuestNPC,"Zone");
sCampType="C";

if (iStepType==7)
    sCampType="Q";

iHideItem=GetLocalInt(oQuestNPC,sQS + "HideItem");
iQuestLevel=GetLocalInt(oQuestNPC,"QuestLevel");

if (iBoss==1 && Random(20)==0)
    iBoss=3;
SetLocalString(GetModule(),"SPAWN_Zone",sZone);
SetLocalString(GetModule(),"SPAWN_CampType",sCampType);
SetLocalInt(GetModule(),"SPAWN_Camp",iCampSpot);
SetLocalInt(GetModule(),"SPAWN_Boss",iBoss);

sCamp=sCampType + IntToString(iCampSpot);

if (iCampTheme>0)
    iCamp=GetMobTheme(iCampTheme,iQuestLevel);

if (iRepeatCamp==1 && iCamp==0)
    {
    iCamp=GetLocalInt(oQuestNPC,"QuestRepeatCamp");
    if (iCamp==0)
        iCamp=GetQuestRepeatCamp(iQuestLevel);
    }

SetLocalInt(GetModule(),"MobWander",50);
oBoss=GetQuestCamp(iCamp,iQuestLevel);
if (!GetIsObjectValid(oBoss))
    WriteTimestampedLogEntry("Quest Camp Error Spawning CampType " + ItS(iCamp) + " at " + sZone + "_" + sCampType + ItS(iCampSpot));

SetLocalInt(GetModule(),"MobWander",0);

SetLocalInt(oQuestNPC,"QuestRepeatCamp",iCamp);

if (sQuestItem!="")
    {
    iStepType=GetLocalInt(oQuestNPC,sQS + "Type");
    if (iStepType == 6)
        {
        sChest="en_q_treasure" + IntToString(Random(5)+1);
        sTag=sZone + "_C" + IntToString(iCampSpot) + "_Treasure";
        oTest=GetObjectByTag(sTag);
         if (!GetIsObjectValid(oTest))
            {
            sTag=sZone + "_C" + IntToString(iCampSpot) + "_1";
            oTest=GetObjectByTag(sTag);
            }
        lChest=GetLocation(oTest);
        oChest = CreateObject(OBJECT_TYPE_PLACEABLE,sChest,lChest,FALSE,sTag + "_S");
        if (GetIsObjectValid(oChest))
            {
            oItem=CreateItemOnObject(sQuestItem,oChest);
            if (!GetIsObjectValid(oItem))
                GetError("ERROR: Could not create " + sQuestItem + " on " + GetName(oBoss));

            iChance=15;
            if (HasRogue())
                iChance=8;
            if (Random(iChance)==0)
                {
                SetLockUnlockDC(oChest,3+iQuestLevel+Random(3));
                SetLocked(oChest,TRUE);
                }

            if (Random(iChance)==0)
                {
                CreateTrapOnObject(GetTrapType(iQuestLevel),oChest,STANDARD_FACTION_HOSTILE,"en5_trap_disarm");
                }
            }
        else
            oItem=CreateItemOnObject(sQuestItem,oBoss);
        }
    else
        {
        oItem=CreateItemOnObject(sQuestItem,oBoss);
        if (!GetIsObjectValid(oItem))
            GetError("ERROR: Could not create " + sQuestItem + " on " + GetName(oBoss));
        }
    }

sMob = GetCampName();
sLocation = GetLocalString(GetObjectByTag(sZone + "_" + sCamp + "_1"),"Location");
if (iStepType==7)
    {
    sSALoc=GetLocalString(oQuestNPC,"QuestZone") + "_1_Enter";
    sLocation= GetLocalString(GetObjectByTag(sSALoc),"Location");
    if (sLocation=="")
        sLocation = "somewhere in the nearby area";
    }

sMobName = GetName(oBoss);


SetLocalString(oQuestNPC,sQS + "Mob",sMob);
SetLocalString(oQuestNPC,sQS + "Location",sLocation);
SetLocalString(oQuestNPC,sQS + "MobName",sMobName);
SetLocalString(oQuestNPC,sQS + "MobTag",GetTag(oBoss));
SetLocalString(oQuestNPC,sQS + "CampTag",sCamp);
SetLocalString(oQuestNPC,sQS + "ItemName",GetName(oItem));
SetLocalString(oQuestNPC,sQS + "Zone",sZone);

if (oQuestNPC == OBJECT_SELF || !GetIsObjectValid(OBJECT_SELF))
    {
    sNPCName = GetName(oQuestNPC);
    sNPCLocation = GetLocalString(oQuestNPC,"Location");
    }
else
    {
    sNPCName = GetName(OBJECT_SELF);
    sNPCLocation = GetLocalString(OBJECT_SELF,"Location");
    }
SetLocalString(oQuestNPC,sQS + "NPCName",sNPCName);
SetLocalString(oQuestNPC,sQS + "NPCLocation",sNPCLocation);


SetLocalInt(oQuestNPC,"QuestJournalUpdate",0);

if (sQuestItem=="")
    {
    //SetupQuestType2(oBoss,sMob,sCamp,5 * iZoneLevel,iXP,sZone);
    SetStepDone(oQuestNPC,"I have taken care of the " + sMob + ".  I should return to " + sNPCName + " " + sNPCLocation + ".");
    }
else
    {
    //SetupQuestType7(oBoss,sMob,sCamp,sQuestItem,sQuestItemNPC,5 * iZoneLevel,iXP,sZone);
    if (iHideItem>0)
        SetStepDone(oQuestNPC,"I have taken care of the " + sMob + ".  I should return to " + sNPCName + " " + sNPCLocation + ".");
    else
        if (GetIsObjectValid(oItem))
            SetStepDone(oQuestNPC,"I have taken care of the " + sMob + ".  I should search the bodies and then return to " + sNPCName + " " + sNPCLocation + ".");
        else
            SetStepDone(oQuestNPC,"I have taken care of the " + sMob + ".  I should search around and then return to " + sNPCName + " " + sNPCLocation + ".");
    }

if (iStepType==6)
    {
    SetDescription(oQuestNPC,"I have promised " + sNPCName + " I would try to find the " + GetName(oItem) + " either on or near some " + sMob + " located " + sLocation);
    SetStepDone(oQuestNPC,"I have found the " + GetName(oItem) + ".  I should return to " + sNPCName + " " + sNPCLocation + ".");
    }
else
    SetDescription(oQuestNPC,"I have promised " + sNPCName + " I would take care of some " + sMob + " located " + sLocation);

}

void GetMobQuest(object oQuestNPC)
{
int iQuestLevel;
int iCampSpot;
int iStep;
int iHideItem;
int iMagicChance;
int iBoss;
int iGold;
int iXP;
int iTotalMobs;
int iMobClass;
int iRepeatCamp;
int iCamp;
int iCampTheme;
string sQS;
string sCamp;
string sMob;
string sLocation;
string sMobName;
string sQuestItem;
string sCampType;
string sMobTag;
string sZone;
string sNPCName;
string sNPCLocation;
object oBoss;
object oItem;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
sQS="QuestStep" + IntToString(iStep);
//iCamp=GetLocalInt(oQuestNPC,sQS + "Camp");
iCampSpot=GetLocalInt(oQuestNPC,sQS + "CampSpot");
iMagicChance=GetLocalInt(oQuestNPC,sQS + "MagicChance");
sQuestItem=GetLocalString(oQuestNPC,sQS + "Item");
iBoss=GetLocalInt(oQuestNPC,sQS + "Boss");
sZone=GetLocalString(oQuestNPC,sQS + "Zone");
if (sZone=="")
    sZone=GetLocalString(oQuestNPC,"Zone");
sCampType="S";
iHideItem=GetLocalInt(oQuestNPC,sQS + "HideItem");
iQuestLevel=GetLocalInt(oQuestNPC,"QuestLevel");
sMobTag=GetLocalString(oQuestNPC,sQS + "MobTag");
iMobClass=GetLocalInt(oQuestNPC,sQS + "MobClass");
iRepeatCamp=GetLocalInt(oQuestNPC,sQS + "RepeatCamp");
iCampTheme=GetLocalInt(oQuestNPC,sQS + "CampTheme");

SetLocalString(GetModule(),"SPAWN_Zone",sZone);
SetLocalString(GetModule(),"SPAWN_CampType",sCampType);
SetLocalInt(GetModule(),"SPAWN_Boss",iBoss);


sCamp=sZone + "_" + sCampType + "_" + IntToString(iCampSpot);

if (sMobTag=="")
    sMobTag = GetQuestTag(iQuestLevel);

SetLocalInt(GetModule(),"MobWander",50);
if (iRepeatCamp==1)
    {
    iCamp=GetLocalInt(oQuestNPC,"QuestRepeatCamp");
    if (iCamp==0)
        {
        iCamp=GetQuestRepeatCamp(iQuestLevel);
        SetLocalInt(oQuestNPC,"QuestRepeatCamp",iCamp);
        }
    oBoss=GetSingleSpawnMob(sCamp,iCamp,iQuestLevel);
    } else {
    if (sMobTag=="CAMP")
        {
        iCamp=GetLocalInt(oQuestNPC,sQS + "Camp");
        SetLocalInt(oQuestNPC,"QuestRepeatCamp",iCamp);
        oBoss=GetSingleSpawnMob(sCamp,iCamp,iQuestLevel);
        } else {
        if (iCampTheme>0)
            {
            iCamp=GetMobTheme(iCampTheme,iQuestLevel);
            SetLocalInt(oQuestNPC,"QuestRepeatCamp",iCamp);
            oBoss=GetSingleSpawnMob(sCamp,iCamp,iQuestLevel);
            } else {
            oBoss=GetMob(sMobTag,sCamp);
            if (iMobClass>0)
                LevelMob(oBoss,iQuestLevel,iMobClass);
            }
        }
    }
SetLocalInt(GetModule(),"MobWander",0);

if (sQuestItem!="")
    {
    oItem=CreateItemOnObject(sQuestItem,oBoss);
    if (!GetIsObjectValid(oItem))
        GetError("ERROR: Could not create " + sQuestItem + " on " + GetName(oBoss));
    }
if (iMagicChance>0)
    if (Random(100)<iMagicChance)
        GetMagicItem(oBoss);

sMob = GetCampName();
sLocation = GetLocalString(GetObjectByTag(sCamp),"Location");
sMobName = GetName(oBoss);

SetLocalString(oQuestNPC,sQS + "Mob",sMob);
SetLocalString(oQuestNPC,sQS + "Location",sLocation);
SetLocalString(oQuestNPC,sQS + "MobName",sMobName);
SetLocalString(oQuestNPC,sQS + "MobTag",GetTag(oBoss));
SetLocalString(oQuestNPC,sQS + "CampTag",sCamp);
SetLocalString(oQuestNPC,sQS + "ItemName",GetName(oItem));

if (oQuestNPC == OBJECT_SELF || !GetIsObjectValid(OBJECT_SELF))
    {
    sNPCName = GetName(oQuestNPC);
    sNPCLocation = GetLocalString(oQuestNPC,"Location");
    }
else
    {
    sNPCName = GetName(OBJECT_SELF);
    sNPCLocation = GetLocalString(OBJECT_SELF,"Location");
    }
SetLocalString(oQuestNPC,sQS + "NPCName",sNPCName);
SetLocalString(oQuestNPC,sQS + "NPCLocation",sNPCLocation);

SetLocalInt(oQuestNPC,"QuestJournalUpdate",0);

if (sQuestItem=="")
    {
    //SetupQuestType2(oBoss,sMob,sCamp,5 * iZoneLevel,iXP,sZone);
    SetStepDone(oQuestNPC,"I have taken care of the " + sMobName + ".  I should return to " + sNPCName + " " + sNPCLocation + ".");
    }
else
    {
    //SetupQuestType7(oBoss,sMob,sCamp,sQuestItem,sQuestItemNPC,5 * iZoneLevel,iXP,sZone);
    if (iHideItem>0)
        SetStepDone(oQuestNPC,"I have taken care of the " + sMobName + ".  I should return to " + sNPCName + " " + sNPCLocation + ".");
    else
        if (GetIsObjectValid(oItem))
            SetStepDone(oQuestNPC,"I have taken care of the " + sMobName + ".  I should search the body and then return to " + sNPCName + " " + sNPCLocation + ".");
        else
            SetStepDone(oQuestNPC,"I have taken care of the " + sMobName + ".  I should search around and then return to " + sNPCName + " " + sNPCLocation + ".");
    }

SetDescription(oQuestNPC,"I have promised " + sNPCName + " I would take care of a " + sMobName + " located " + sLocation);

}


string GetCampName()
{
string sName;

sName = GetLocalString(GetModule(),"EN5_CampDescription");

return sName;
}

void SetStepDone(object oQuestNPC,string sText)
{
SetLocalString(oQuestNPC,"QuestStepDone",sText);
}

/* void SetDescription(object oQuestNPC,string sText)
{
SetLocalString(oQuestNPC,"QuestDescription",sText);
}
 */
void AcceptQuest(object oPC,object oNPC=OBJECT_SELF)
{
int iStep;
string sDescription;
string sQS;
string sTarget;
int iAmbush;
int iCampSpot;
int iBoss;
string sZone;
int iQuestLevel;
object oBoss;

iStep=GetLocalInt(oNPC,"QuestStep");
sQS="QuestStep" + IntToString(iStep);
sTarget=GetLocalString(oNPC,sQS + "NPC");

if (iStep==1)
    {
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        SetLocalString(oPartyMember,"QuestNPC",GetTag(oNPC));
        SetLocalString(oPartyMember,"QuestName",GetLocalString(oNPC,"QuestName"));
        SetLocalInt(oPartyMember,"OnQuest",1);
        oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
    }
if (sTarget != "")
    SetPartyString(oPC,"QuestTarget",sTarget);

if (GetLocalInt(oNPC,sQS + "CreateItem") > 0)
    CreateItemOnObject(GetLocalString(oNPC,sQS + "Item"),oPC);


sDescription = GetLocalString(oNPC,"QuestDescription");
if (GetLocalInt(oNPC,sQS + "Type") != 5)
    SetJournalEntry(oPC,sDescription);
if (iStep==1)
    SetLocalInt(oNPC,"QuestAccepted",1);

SetPartyInt(oPC,"QItemUpdate",0);

iAmbush=GetLocalInt(oNPC,sQS + "Ambush");

if (iAmbush==0 && GetLocalInt(oNPC,sQS + "Type") == 3 && Random(8)==1)
    {
    iAmbush=36;
    SetLocalInt(oNPC,sQS + "Type",iAmbush);
    }

if (iAmbush>0)
    {
    iCampSpot=0;
    iBoss=GetLocalInt(oNPC,sQS + "Boss");
    sZone=GetLocalString(oNPC,"QuestZone");
    iQuestLevel=GetLocalInt(oNPC,"QuestLevel");

    SetLocalString(GetModule(),"SPAWN_Zone",sZone);
    SetLocalString(GetModule(),"SPAWN_CampType","C");
    SetLocalInt(GetModule(),"SPAWN_Camp",iCampSpot);
    SetLocalInt(GetModule(),"SPAWN_Boss",iBoss);


    //sCamp=sZone + "_C" + IntToString(iCampSpot);

    SetLocalInt(GetModule(),"MobWander",50);
    oBoss=GetQuestCamp(iAmbush,iQuestLevel);
    SetLocalInt(GetModule(),"MobWander",0);
    }

}

void SetJournalEntry(object oPC,string sDescription)
{
string sQuestName;
int iJournal;

if (sDescription != "")
    {
    iJournal = GetLocalInt(oPC,"QuestJournal") + 1;
    if (iJournal>20)
        iJournal = 1;
    SetPartyInt(oPC,"QuestJournal",iJournal);
    SetPartyString(oPC,"QuestJournalDesc",sDescription);
    SetCustomToken(110+iJournal,sDescription);
    AddJournalQuestEntry("jQuest",iJournal,oPC,TRUE,FALSE,TRUE);
    }
//GetError(IntToString(iJournal) + ": " + sDescription);
}

string FixResponse(object oNPC,string sString)
{
int iStep;
string sMobName;
string sTarget;
string sLocation;
string sQS;
string sItem;
string sNPC;
string sGiver;
string sArea;

iStep=GetLocalInt(oNPC,"QuestStep");
if (iStep<1)
    iStep=1;
sQS="QuestStep" + IntToString(iStep);

sMobName=GetLocalString(oNPC,sQS + "MobName");
sTarget=GetLocalString(oNPC,sQS + "Mob");
sLocation=GetLocalString(oNPC,sQS + "Location");
sItem=GetLocalString(oNPC,sQS + "ItemName");
sNPC=GetLocalString(oNPC,sQS + "NPCName");
sArea=GetLocalString(oNPC,"Area");
sGiver=GetName(oNPC);

if (sArea=="")
    sArea = "the settlement";

sString=ReplaceText(sString,"[mob]",sMobName);
sString=ReplaceText(sString,"[camp]",sTarget);
sString=ReplaceText(sString,"[location]",sLocation);
sString=ReplaceText(sString,"[item]",sItem);
sString=ReplaceText(sString,"[npc]",sNPC);
sString=ReplaceText(sString,"[giver]",sGiver);
sString=ReplaceText(sString,"[area]",sArea);

sString=ReplaceText(sString,"[Mob]",sMobName);
sString=ReplaceText(sString,"[Camp]",sTarget);
sString=ReplaceText(sString,"[Location]",sLocation);
sString=ReplaceText(sString,"[Item]",sItem);
sString=ReplaceText(sString,"[Npc]",sNPC);
sString=ReplaceText(sString,"[Giver]",sGiver);
sString=ReplaceText(sString,"[Area]",sArea);

return sString;
}

int CheckMobs(object oQuestNPC)
{
int iResult;
int iType;
int iStep;
int iCampSpot;
int iBossOnly;
int iIndex;
int iIndex2;
string sQS;
string sZone;
string sTag;
string sWP;
object oMob;
object oWP;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
if (iStep<1)
    iStep=1;
iResult=TRUE;

sQS="QuestStep" + IntToString(iStep);
iType=GetLocalInt(oQuestNPC,sQS + "Type");
iBossOnly=GetLocalInt(oQuestNPC,sQS + "BossOnly");
iCampSpot=GetLocalInt(oQuestNPC,sQS + "CampSpot");
sZone=GetLocalString(oQuestNPC,sQS + "Zone");
if (sZone=="")
    sZone=GetLocalString(oQuestNPC,"QuestZone");

if (iType==1 || ((iType==2 || iType == 4 || iType == 7) && iBossOnly>0))
    {
    sTag=GetLocalString(oQuestNPC,sQS + "MobTag");
    oMob=GetObjectByTag(sTag);
    if (GetIsObjectValid(oMob) && !GetIsDead(oMob))
       iResult=FALSE;
    }
if ((iType==2 || iType == 4 || iType == 7) && iBossOnly==0)
    {
    iIndex = 1;
    sTag = sZone + "_" + GetLocalString(oQuestNPC,sQS + "CampTag") + "_";
    sWP = sTag + IntToString(iIndex);
    oWP = GetObjectByTag(sWP);
    while (GetIsObjectValid(oWP))
        {
        iIndex2=0;
        while (iIndex2<8)
            {
            oMob = GetObjectByTag(sWP + "_S",iIndex2);
            if (GetIsObjectValid(oMob) && !GetIsDead(oMob))

                iResult = FALSE;
            oMob = GetObjectByTag(sWP + "a_S",iIndex2);
            if (GetIsObjectValid(oMob) && !GetIsDead(oMob))
                iResult = FALSE;
            iIndex2++;
            }
        iIndex++;
        sWP = sTag + IntToString(iIndex);
        oWP = GetObjectByTag(sWP);
        }
    }

return iResult;
}

void SetPartyVariables(object oPC)
{
int iQuests;

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    SetLocalInt(oPartyMember,"OnQuest",0);
    SetLocalString(oPartyMember,"QuestNPC","");
    SetLocalString(oPartyMember,"QuestName","");
    SetLocalString(oPartyMember,"QuestTarget","");
    iQuests = GetLocalInt(oPartyMember,"QuestsComplete");

    iQuests++;
    SetLocalInt(oPartyMember,"QuestsComplete",iQuests);
    SetLocalInt(oPartyMember,"QuestJournal",0);

    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

string SetupSpecialZone(string sZone, int iZoneExit, int iType)
{
string sSpecial;
int iSpecial;
string sTag;
object oTransfer;
object oSpecial;

sSpecial = GetSpecialArea(iType);
iSpecial = GetSpecialAreaNumber(iType);

sTag = sSpecial + IntToString(iSpecial);
SetLocalInt(GetModule(),sTag,1);

if (iType == 2)
    {
    oTransfer = GetObjectByTag(sZone + "_CAVE_" + IntToString(iZoneExit));
    SetLocalInt(GetModule(),sZone + "_CAVE_" + IntToString(iZoneExit),1);
    } else {
    oTransfer = GetObjectByTag(sZone + "_SPECIAL_" + IntToString(iZoneExit));
    SetLocalInt(GetModule(),sZone + "_SPECIAL_" + IntToString(iZoneExit),1);
    }
if (GetIsObjectValid(oTransfer))
    {
    SetLocalString(oTransfer,"Area",sTag + "_Enter");
    oTransfer = GetObjectByTag(sTag + "_Exit");
        if (GetIsObjectValid(oTransfer))
            if (iType == 2)
                SetLocalString(oTransfer,"Area",sZone + "_C" + IntToString(iZoneExit) + "_Enter");
            else
                SetLocalString(oTransfer,"Area",sZone + "_" + IntToString(iZoneExit) + "_Enter");
        else
            GetError("Could not set up special zone transfer: " + sTag + "_Exit");

    } else
        GetError("Could not set up special zone transfer: " + sZone + "_" + IntToString(iZoneExit) + "_Enter");

oSpecial=GetObjectByTag(sTag + "_INFO");
SetLocalInt(oSpecial,"MinLevel",GetMinLevel(sZone));
SetLocalInt(oSpecial,"MaxLevel",GetMaxLevel(sZone));

return sTag;
}

string GetSpecialArea(int iType)
{
string sTag;
sTag = "FLD";

switch (iType)
    {
    case 1: sTag = "FLD"; break;
    case 2: sTag = "CAVE"; break;
    case 3: sTag = "FORT"; break;
    case 4: sTag = "AFLD"; break;
    case 5: sTag = "GRAVE"; break;
    case 6: sTag = "LAKE"; break;
    case 7: sTag = "WFOREST"; break;
    case 8: sTag = "TOWER"; break;
    case 9: sTag = "DNGTR"; break;
    case 10: sTag = "LAIR"; break;
    case 11: sTag = "DNG"; break;
    case 12: sTag = "CRYPT"; break;
    }

return sTag;
}

int GetSpecialMaxNumber(int iType)
{
int iMaxNumber;

switch (iType)
    {
    case 1: iMaxNumber = 2; break;
    case 2: iMaxNumber = 7; break;
    case 3: iMaxNumber = 3; break;
    case 4: iMaxNumber = 1; break;
    case 5: iMaxNumber = 3; break;
    case 6: iMaxNumber = 1; break;
    case 7: iMaxNumber = 1; break;
    case 8: iMaxNumber = 4; break;
    case 9: iMaxNumber = 3; break;
    case 10: iMaxNumber = 4; break;
    case 11: iMaxNumber = 4; break;
    case 12: iMaxNumber = 3; break;
    }

return iMaxNumber;
}

int GetSpecialAreaNumber(int iType)
{
int iMaxNumber;
int iNumber;
int iFlag;
string sType;
string sTag;

iMaxNumber = GetSpecialMaxNumber(iType);

iNumber = Random(iMaxNumber)+1;
sType = GetSpecialArea(iType);
sTag = sType + IntToString(iNumber);

if (GetLocalInt(GetModule(),sTag) == 1)
    {
    iNumber = 1;
    iFlag = FALSE;
    while (iNumber <= iMaxNumber && iFlag == FALSE)
        {
        sTag = sType + IntToString(iNumber);
        if (GetLocalInt(GetModule(),sTag) == 0)
            iFlag = TRUE;
        else
            iNumber++;
        }

    }

return iNumber;
}

int OpenAreaType(int iType, int iZoneExit=1, string sZone="")
{
int iMaxNumber;
int iNumber;
string sType;
string sTag;
int iResult;

iResult = FALSE;

if (sZone == "")
    sZone = GetMyZone();

iMaxNumber = GetSpecialMaxNumber(iType);
sType = GetSpecialArea(iType);

iNumber = 1;

while (iNumber <= iMaxNumber && iResult == FALSE)
    {
    sTag = sType + IntToString(iNumber);
    if (GetLocalInt(GetModule(),sTag) == 0)
        iResult = TRUE;
    else
        iNumber++;
    }

//Make sure area in zone is open
if (iResult == TRUE)
    {
    if (iType == 2)
        {
        if (GetLocalInt(GetModule(),sZone + "_CAVE_" + IntToString(iZoneExit)) == 1)
            iResult = FALSE;
        } else {
        if (GetLocalInt(GetModule(),sZone + "_SPECIAL_" + IntToString(iZoneExit)) == 1)
            iResult = FALSE;
        }
    }
return iResult;
}

void SetupQuest(string sZone)
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
string sSAZone;
string sTag;
string sName;
string sLocation;
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

if (iNPCSpawn == 1)
    sTag=sZone + "_S_" + IntToString(iSpot);
else if (iNPCSpawn == 2)
    sTag=sZone + "_C" + IntToString(iSpot) + "_1";
else sTag=sZone + "_Q_NPC" + IntToString(iSpot);

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
        SetLocalInt(GetObjectByTag(sZone + "_C" + IntToString(iSpot) + "_1"),"Quest",1);
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
oQuestNPC=GetQuestNPC(lLoc,sZone,iNPCType,iQuestLevel,sNPCTag);
if (iNPCSpawn>0)
    SetLocalInt(oQuestNPC,"NoHelper",1);
else
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

int CheckQuest(string sZone)
{
int iIndex;
int iSteps;
int iQuestStepType;
int iCamps;
int iSpots;
int iResult;
int iFreeCamps;
int iFreeSpots;
int iNPCSpawn;
string sTag;
object oQuestWP;
object oWP;

iResult=TRUE;
oQuestWP=GetObjectByTag("EN6_QUESTWP");
if (GetLocalString(oQuestWP,"QuestScript") != "")
    return TRUE;

iNPCSpawn=GetLocalInt(oQuestWP,"QuestNPCSpawn");

iIndex=1;
iSteps=GetLocalInt(oQuestWP,"QuestSteps");
iCamps=0;
iSpots=0;
while (iIndex <= iSteps)
    {
    iQuestStepType=GetLocalInt(oQuestWP,"QuestStep" + IntToString(iIndex) + "Type");
    if (iQuestStepType==1)
        iSpots++;
    if (iQuestStepType==2 || iQuestStepType==4 || iQuestStepType==5 || iQuestStepType==6)
        iCamps++;
    if (iQuestStepType==7)
        {
        if (GetLocalInt(GetModule(),sZone + "_SPECIAL_1")==1)
            iResult=FALSE;
        if (GetLocalInt(GetObjectByTag(sZone + "_INFO"),"SA") >0)
            iResult=FALSE;
        }
    iIndex++;
    }

if (iNPCSpawn==1)
    iSpots++;
if (iNPCSpawn==2)
    iCamps++;

iFreeSpots=0;
iIndex=1;
sTag=sZone+"_S_" + IntToString(iIndex);
oWP=GetObjectByTag(sTag);
while (GetIsObjectValid(oWP))
    {
    if (GetLocalInt(oWP,"Quest")==0)
        iFreeSpots++;
    iIndex++;
    sTag=sZone+"_S_" + IntToString(iIndex);
    oWP=GetObjectByTag(sTag);
    }

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

if (iSpots>iFreeSpots)
    iResult=FALSE;
if (iCamps>iFreeCamps)
    iResult=FALSE;

return iResult;
}

int GetQuestNPCLoc(object oQuestNPC,string sZone,int iNPCSpawn=0,int iNPCType=1)
{
int iMaxLoc;
int iLoc;
string sTag;

iLoc=1;
if (iNPCSpawn==0)
    {
    sTag=sZone + "_Q_NPC";
    iMaxLoc=MaxObject(sTag);
    iLoc=GetQuestLocation(sTag,iMaxLoc,iNPCType);
    if (iLoc==0)
        iLoc = Random(iMaxLoc) + 1;
    }

if (iNPCSpawn==1)
    {
    iLoc =GetCampSpot(sZone,1,0,"");
    SetLocalInt(GetObjectByTag(sZone + "_S_" + IntToString(iLoc)),"Quest",1);
    }

if (iNPCSpawn==2)
    {
    if (GetLocalInt(oQuestNPC,"QuestStep1CampSpot") == 0 || GetLocalInt(oQuestNPC,"QuestStep1Type") == 1 || GetLocalInt(oQuestNPC,"QuestStep1Type") == 3 || GetLocalInt(oQuestNPC,"QuestStep1Type") == 7)
        {
        iLoc =GetCampSpot(sZone,2,0,"");
        SetLocalInt(GetObjectByTag(sZone + "_C" + IntToString(iLoc) + "_1"),"Quest",1);
        } else {
        iLoc=GetLocalInt(oQuestNPC,"QuestStep1CampSpot");
        }
    }

return iLoc;
}

int GetCampSpot(string sZone,int iType,int iNPC,string sZoneCheck)
{
int iCampSpot;
if (iType==1)
    iCampSpot=GetSpot(sZone,iNPC,sZoneCheck);
else
    iCampSpot=GetCamp(sZone,iNPC,sZoneCheck);

return iCampSpot;
}

int GetSpot(string sZone,int iNPC,string sZoneCheck)
{
int iSpot;
int iMaxSpot;
int iRandom;
int iIndex;
string sTag;
object oWP;

if (sZoneCheck=="")
    sZoneCheck="X";

iIndex=1;
sTag=sZone+"_S_" + IntToString(iIndex);
oWP=GetObjectByTag(sTag);
while (GetIsObjectValid(oWP))
    {
    iIndex++;
    sTag=sZone+"_S_" + IntToString(iIndex);
    oWP=GetObjectByTag(sTag);
    }

iMaxSpot=iIndex-1;
iRandom=Random(iMaxSpot)+1;

//SendMessageToPC(GetFirstPC(),"MaxSpot=" + IntToString(iMaxSpot));

iSpot=iRandom;
sTag=sZone+"_S_" + IntToString(iSpot);
oWP=GetObjectByTag(sTag);
while (GetLocalInt(oWP,"Quest")==1 || (GetLocalString(oWP,"NoZone") == sZoneCheck && iNPC==0) || (GetLocalString(oWP,"NoZone") != "" && iNPC==1))
    {
    iSpot++;
    if (iSpot>iMaxSpot)
        iSpot=1;
    if (iSpot==iRandom)
        iSpot=0;
    sTag=sZone+"_S_" + IntToString(iSpot);
    oWP=GetObjectByTag(sTag);
    }

return iSpot;
}

int GetCamp(string sZone,int iNPC,string sZoneCheck)
{
int iCamp;
int iMaxCamp;
int iRandom;
int iIndex;
string sTag;
object oWP;

if (sZoneCheck=="")
    sZoneCheck="X";

iIndex=1;
sTag=sZone+"_C" + IntToString(iIndex) +"_1";
oWP=GetObjectByTag(sTag);
while (GetIsObjectValid(oWP))
    {
    iIndex++;
    sTag=sZone+"_C" + IntToString(iIndex) +"_1";
    oWP=GetObjectByTag(sTag);
    }

iMaxCamp=iIndex-1;
iRandom=Random(iMaxCamp)+1;

//SendMessageToPC(GetFirstPC(),"MaxCamp=" + IntToString(iMaxCamp));

iCamp=iRandom;
sTag=sZone+"_C" + IntToString(iCamp) +"_1";
oWP=GetObjectByTag(sTag);
while (GetLocalInt(oWP,"Quest")==1 || (GetLocalString(oWP,"NoZone") == sZoneCheck && iNPC==0) || (GetLocalString(oWP,"NoZone") != "" && iNPC==1))
    {
    iCamp++;
    if (iCamp>iMaxCamp)
        iCamp=1;
    if (iCamp==iRandom)
        iCamp=0;
    sTag=sZone+"_C" + IntToString(iCamp) +"_1";
    oWP=GetObjectByTag(sTag);
    }

return iCamp;
}

void TransferQuest(object oQuestNPC,object oQuestNPC2)
{
string sEN_QName;
int iEN_QSteps;
int iEN_QType; //0=Normal 1=Script
string sEN_QScript;
int iEN_QItemChanceMod;
string sEN_QItemReward;
int iEN_QGold; // (-1=None,0=Code Determine)
int iEN_QNPCType;
string sEN_QZone;
int iEN_QLevel;
string sEN_QOneLiner;
int iEN_QNPCSpawn;
int iEN_QDoOnce;
int iEN_QFrequency;
int iEN_QMinLevel;
int iEN_QMaxLevel;
string sEN_QAccomplishment;
string sEN_QSZone;

int iEN_QSType;
int iEN_QSSAType;
string sEN_QSItem;
int iEN_QSCreateItem;
int iEN_QSLineResponseDeleteItem;
//int iEN_QSMobType; //(1=SingleMob,2=Camp,3=SpecificCamp)
string sEN_QSMob;
string sEN_QSNPC;
int iEN_QSAmbush;
int iEN_QSCampSpot;
int iEN_QSBossOnly;
int iEN_QSBoss;
int iEN_QSCamp;
int iEN_QSHideItem;
int iEN_QSNPCType;
int iEN_QSNPCSpawn;
int iEN_QSMobClass;
int iEN_QSRepeatCamp;
int iEN_QSCampTheme;

string sEN_QSLine;
string sEN_QSLineResponse;
string sEN_QSLineScript;
int iEN_QSLineResponseGoto;
string sEN_QSLineResponseScript;
int iEN_QSLineResponseAccept;
int iEN_QSLineDone;
int iEN_QSLineNPC;
int iEN_QSLineResponseCheck;
int iEN_QSLineResponseStop;
int iEN_QSLineResponseStepDone;

string sQS;
string sQSL;
string sQSLR;
int iIndex;
int iIndex2;
int iIndex3;
int iSteps;
int iLines;

int iEN_QMExecute;
int iEN_QMQNum;
int iEN_QThemeNum;
int iEN_QNPCNum;
string sEN_QNPCTag;

sEN_QName=GetLocalString(oQuestNPC,"QuestName");
sEN_QZone=GetLocalString(oQuestNPC,"QuestZone");
iEN_QLevel=GetLocalInt(oQuestNPC,"QuestLevel");
iEN_QSteps=GetLocalInt(oQuestNPC,"QuestSteps");
iEN_QItemChanceMod=GetLocalInt(oQuestNPC,"QuestItemChanceMod");
sEN_QItemReward=GetLocalString(oQuestNPC,"QuestItemReward");
iEN_QGold=GetLocalInt(oQuestNPC,"QuestGold");
iEN_QNPCType=GetLocalInt(oQuestNPC,"QuestNPCType");
iEN_QNPCSpawn=GetLocalInt(oQuestNPC,"QuestNPCSpawn");
sEN_QOneLiner=GetLocalString(oQuestNPC,"QuestOneLiner");
iEN_QFrequency=GetLocalInt(oQuestNPC,"QuestFrequency");
iEN_QDoOnce=GetLocalInt(oQuestNPC,"QuestDoOnce");
iEN_QMinLevel=GetLocalInt(oQuestNPC,"QuestMinLevel");
iEN_QMaxLevel=GetLocalInt(oQuestNPC,"QuestMaxLevel");
sEN_QScript=GetLocalString(oQuestNPC,"QuestScript");
sEN_QAccomplishment=GetLocalString(oQuestNPC,"QuestAccomplishment");
iEN_QMExecute=GetLocalInt(oQuestNPC,"QuestExecute");
iEN_QType=GetLocalInt(oQuestNPC,"QuestType");
iEN_QMQNum=GetLocalInt(oQuestNPC,"QuestMQNumber");
iEN_QThemeNum=GetLocalInt(oQuestNPC,"QuestThemeNumber");
iEN_QNPCNum=GetLocalInt(oQuestNPC,"QuestNPCNumber");
sEN_QNPCTag=GetLocalString(oQuestNPC,"QuestNPCTag");

SetLocalString(oQuestNPC2,"QuestName",sEN_QName);
SetLocalString(oQuestNPC2,"QuestZone",sEN_QZone);
SetLocalInt(oQuestNPC2,"QuestLevel",iEN_QLevel);
SetLocalInt(oQuestNPC2,"QuestSteps",iEN_QSteps);
SetLocalInt(oQuestNPC2,"QuestItemChanceMod",iEN_QItemChanceMod);
SetLocalString(oQuestNPC2,"QuestItemReward",sEN_QItemReward);
SetLocalInt(oQuestNPC2,"QuestGold",iEN_QGold);
SetLocalInt(oQuestNPC2,"QuestNPCType",iEN_QNPCType);
SetLocalInt(oQuestNPC2,"QuestNPCSpawn",iEN_QNPCSpawn);
SetLocalString(oQuestNPC2,"QuestOneLiner",sEN_QOneLiner);
SetLocalInt(oQuestNPC2,"QuestFrequency",iEN_QFrequency);
SetLocalInt(oQuestNPC2,"QuestDoOnce",iEN_QDoOnce);
SetLocalInt(oQuestNPC2,"QuestMinLevel",iEN_QMinLevel);
SetLocalInt(oQuestNPC2,"QuestMaxLevel",iEN_QMaxLevel);
SetLocalString(oQuestNPC2,"QuestScript",sEN_QScript);
SetLocalString(oQuestNPC2,"QuestAccomplishment",sEN_QAccomplishment);
SetLocalInt(oQuestNPC2,"QuestExecute",iEN_QMExecute);
SetLocalInt(oQuestNPC2,"QuestType",iEN_QType);
SetLocalInt(oQuestNPC2,"QuestMQNumber",iEN_QMQNum);
SetLocalInt(oQuestNPC2,"QuestThemeNumber",iEN_QThemeNum);
SetLocalInt(oQuestNPC2,"QuestNPCNumber",iEN_QNPCNum);
SetLocalString(oQuestNPC2,"QuestNPCTag",sEN_QNPCTag);


iIndex=1;
while (iIndex<=iEN_QSteps)
    {
    sQS="QuestStep" + IntToString(iIndex);
    iEN_QSType=GetLocalInt(oQuestNPC,sQS + "Type");
    iEN_QSSAType=GetLocalInt(oQuestNPC,sQS + "SpecialArea");
    sEN_QSItem=GetLocalString(oQuestNPC,sQS + "Item");
    iEN_QSHideItem=GetLocalInt(oQuestNPC,sQS + "HideItem");
    iEN_QSCreateItem=GetLocalInt(oQuestNPC,sQS + "CreateItem");
    //iEN_QSKeepItem=GetLocalInt(oQuestNPC,sQS + "KeepItem");
    iEN_QSCamp=GetLocalInt(oQuestNPC,sQS + "Camp");
    //iEN_QSMobType=GetLocalInt(oQuestNPC,sQS + "MobType");
    sEN_QSMob=GetLocalString(oQuestNPC,sQS + "MobTag");
    sEN_QSNPC=GetLocalString(oQuestNPC,sQS + "NPC");
    iEN_QSNPCType=GetLocalInt(oQuestNPC,sQS + "NPCType");
    iEN_QSNPCSpawn=GetLocalInt(oQuestNPC,sQS + "NPCSpawn");
    iEN_QSAmbush=GetLocalInt(oQuestNPC,sQS + "Ambush");
    iEN_QSCampSpot=GetLocalInt(oQuestNPC,sQS + "CampSpot");
    iEN_QSBossOnly=GetLocalInt(oQuestNPC,sQS + "BossOnly");
    iEN_QSBoss=GetLocalInt(oQuestNPC,sQS + "Boss");
    iEN_QSMobClass=GetLocalInt(oQuestNPC,sQS + "MobClass");
    iEN_QSRepeatCamp=GetLocalInt(oQuestNPC,sQS + "RepeatCamp");
    iEN_QSCampTheme=GetLocalInt(oQuestNPC,sQS + "CampTheme");
    sEN_QSZone=GetLocalString(oQuestNPC,sQS + "Zone");

    SetLocalInt(oQuestNPC2,sQS + "Type",iEN_QSType);
    SetLocalInt(oQuestNPC2,sQS + "SpecialArea",iEN_QSSAType);
    SetLocalString(oQuestNPC2,sQS + "Item",sEN_QSItem);
    SetLocalInt(oQuestNPC2,sQS + "HideItem",iEN_QSHideItem);
    SetLocalInt(oQuestNPC2,sQS + "Camp",iEN_QSCamp);
    //SetLocalInt(oQuestNPC2,sQS + "MobType",iEN_QSMobType);
    SetLocalString(oQuestNPC2,sQS + "MobTag",sEN_QSMob);
    SetLocalString(oQuestNPC2,sQS + "NPC",sEN_QSNPC);
    SetLocalInt(oQuestNPC2,sQS + "NPCType",iEN_QSNPCType);
    SetLocalInt(oQuestNPC2,sQS + "NPCSpawn",iEN_QSNPCSpawn);

    SetLocalInt(oQuestNPC2,sQS + "Ambush",iEN_QSAmbush);
    SetLocalInt(oQuestNPC2,sQS + "CampSpot",iEN_QSCampSpot);
    SetLocalInt(oQuestNPC2,sQS + "BossOnly",iEN_QSBossOnly);
    SetLocalInt(oQuestNPC2,sQS + "Boss",iEN_QSBoss);
    SetLocalInt(oQuestNPC2,sQS + "CreateItem",iEN_QSCreateItem);
    SetLocalInt(oQuestNPC2,sQS + "MobClass",iEN_QSMobClass);
    SetLocalInt(oQuestNPC2,sQS + "RepeatCamp",iEN_QSRepeatCamp);
    SetLocalInt(oQuestNPC2,sQS + "CampTheme",iEN_QSCampTheme);
    SetLocalString(oQuestNPC2,sQS + "Zone",sEN_QSZone);

    iLines=GetQuestStepLines(oQuestNPC,iIndex);
    iIndex2=1;
    sQSL="QuestStep" + IntToString(iIndex) + "Line" + IntToString(iIndex2);
    while (GetLocalString(oQuestNPC,sQSL)!= "")
        {
        sQSL="QuestStep" + IntToString(iIndex) + "Line" + IntToString(iIndex2);

        sEN_QSLine=GetLocalString(oQuestNPC,sQSL);
        iEN_QSLineDone=GetLocalInt(oQuestNPC,sQSL + "Done");
        iEN_QSLineNPC=GetLocalInt(oQuestNPC,sQSL + "NPC");
        sEN_QSLineScript=GetLocalString(oQuestNPC,sQSL + "Script");

        SetLocalString(oQuestNPC2,sQSL,sEN_QSLine);
        SetLocalInt(oQuestNPC2,sQSL + "Done",iEN_QSLineDone);
        SetLocalInt(oQuestNPC2,sQSL + "NPC",iEN_QSLineNPC);
        SetLocalString(oQuestNPC2,sQSL + "Script",sEN_QSLineScript);

        iIndex3=1;
        while (iIndex3<=5)
            {
            sQSLR="QuestStep" + IntToString(iIndex) + "Line" + IntToString(iIndex2) + "Response" + IntToString(iIndex3);

            sEN_QSLineResponse=GetLocalString(oQuestNPC,sQSLR);
            iEN_QSLineResponseGoto=GetLocalInt(oQuestNPC,sQSLR + "Goto");
            sEN_QSLineResponseScript=GetLocalString(oQuestNPC,sQSLR + "Script");
            iEN_QSLineResponseCheck=GetLocalInt(oQuestNPC,sQSLR + "Check");
            iEN_QSLineResponseAccept=GetLocalInt(oQuestNPC,sQSLR + "Accept");
            iEN_QSLineResponseDeleteItem=GetLocalInt(oQuestNPC,sQSLR + "DeleteItem");
            iEN_QSLineResponseStepDone=GetLocalInt(oQuestNPC,sQSLR + "StepDone");
            iEN_QSLineResponseStop=GetLocalInt(oQuestNPC,sQSLR + "Stop");

            SetLocalString(oQuestNPC2,sQSLR,sEN_QSLineResponse);
            SetLocalInt(oQuestNPC2,sQSLR + "Goto",iEN_QSLineResponseGoto);
            SetLocalString(oQuestNPC2,sQSLR + "Script",sEN_QSLineResponseScript);
            SetLocalInt(oQuestNPC2,sQSLR + "Check",iEN_QSLineResponseCheck);
            SetLocalInt(oQuestNPC2,sQSLR + "Accept",iEN_QSLineResponseAccept);
            SetLocalInt(oQuestNPC2,sQSLR + "DeleteItem",iEN_QSLineResponseDeleteItem);
            SetLocalInt(oQuestNPC2,sQSLR + "StepDone",iEN_QSLineResponseStepDone);
            SetLocalInt(oQuestNPC2,sQSLR + "Stop",iEN_QSLineResponseStop);

            iIndex3++;
            }
        iIndex2++;
        sQSL="QuestStep" + IntToString(iIndex) + "Line" + IntToString(iIndex2);
        if (GetLocalString(oQuestNPC,sQSL)== "" && iIndex2<100)
            {
            iIndex2=100;
            sQSL="QuestStep" + IntToString(iIndex) + "Line" + IntToString(iIndex2);
            }
        }
    iIndex++;
    }

if (sEN_QOneLiner != "")
    DelayCommand(1.0,AssignCommand(oQuestNPC2,SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION)));
}

int GetQuestSteps(object oQuestNPC)
{
int iFlag;
int iIndex;

iIndex=1;
iFlag=TRUE;
while (iFlag)
    {
    if (GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iIndex) + "Type") == 0)
        {
        iIndex--;
        iFlag=FALSE;
        } else {
        iIndex++;
        }
    }

return iIndex;
}

int GetQuestStepLines(object oQuestNPC,int iStep)
{
int iFlag;
int iIndex;

iIndex=1;
iFlag=TRUE;
while (iFlag)
    {
    if (GetLocalString(oQuestNPC,"QuestStep" + IntToString(iStep) + "Line" + IntToString(iIndex)) == "")
        {
        iIndex--;
        iFlag=FALSE;
        } else {
        iIndex++;
        }
    }

return iIndex;
}

string GetOverallBossName()
{
int iBoss;
string sName;

iBoss = GetLocalInt(GetModule(),"OverallQuestBoss");
switch (iBoss)
    {
    case 1: sName="Vecna"; break;
    case 2: sName="Azeroth"; break;
    case 3: sName="Lolth"; break;
    case 4: sName="Randall Kross"; break;
    case 5: sName="Lord Blackclaw"; break;
    case 6: sName="Mephistopheles"; break;
    case 7: sName="Sin Dragonfire"; break;
    case 8: sName="Prism"; break;
    }


return sName;
}


string GetOverallBossTag()
{
int iBoss;
string sTag;

iBoss = GetLocalInt(GetModule(),"OverallQuestBoss");
switch (iBoss)
    {
    case 1: sTag="EN5_VECNA"; break;
    case 2: sTag="en5_azeroth"; break;
    case 3: sTag="EN5_LOLTH"; break;
    case 4: sTag="en5_kross"; break;
    case 5: sTag="en5_blackclaw"; break;
    case 6: sTag="en5_meph"; break;
    case 7: sTag="en5_sin"; break;
    case 8: sTag="en5_prism"; break;
    }

return sTag;
}

void CreateMiscItem(object oPC)
{
int iArmor;
int iQuantity;
int iRandom;
int iScrollLevel;
int iScroll;
int iACBonus;
string sItem;
object oItem;

iACBonus=0;
iQuantity=1;

if (GetLocalInt(oPC,"EN5_GivenArmor") == 0 && Random(2)==0)
    {
    iArmor = ENGetArmorType(oPC);
    sItem = GetArmorTag(iArmor);
    if (iArmor != 3)
        {
        iACBonus=1;
        sItem=sItem + IntToString(Random(2));
        }
    SetLocalInt(oPC,"EN5_GivenArmor",1);
    }
else if (GetLocalInt(oPC,"EN5_GivenHelm") == 0 && Random(2)==0)
    {
    if (GetLevelByClass(CLASS_TYPE_WIZARD)>0 || GetLevelByClass(CLASS_TYPE_SORCERER)>0)
        {
        iScrollLevel = Random(3)+1;
        iScroll = Random(21)+1;
        if (iScroll < 10)
            sItem = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + "0" + IntToString(iScroll);
        else
            sItem = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + IntToString(iScroll);
        } else {
        sItem = "en3_helm_" + IntToString(Random(10)+1);
        }
    SetLocalInt(oPC,"EN5_GivenHelm",1);
    }
else if ((GetLevelByClass(CLASS_TYPE_WIZARD)>0 || GetLevelByClass(CLASS_TYPE_SORCERER)>0) && Random(3)==0)
        {
        iScrollLevel = Random(3)+1;
        iScroll = Random(21)+1;
        if (iScroll < 10)
            sItem = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + "0" + IntToString(iScroll);
        else
            sItem = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + IntToString(iScroll);
        }
else
    {
    iRandom=Random(21)+1;
    switch (iRandom)
        {
        case 1: sItem = "nw_wamar001";  iQuantity=Random(10)+21; break;
        case 2: sItem = "nw_wambo001"; iQuantity=Random(10)+21;  break;
        case 3: sItem = "nw_wambu001"; iQuantity=Random(10)+21;  break;
        case 4: sItem = "nw_wammar001";iQuantity=Random(10)+21;  break;
        case 5: sItem = "nw_wammbo001";iQuantity=Random(10)+21;  break;
        case 6: sItem = "nw_wammbo002"; iQuantity=Random(10)+21; break;
        case 7: sItem="nw_it_medkit001"; break;
        case 8: sItem = "nw_it_gem001";         break;
        case 9: sItem = "nw_it_gem007";         break;
        case 10: sItem = "nw_it_gem002";         break;
        case 11: sItem = "nw_it_gem004";         break;
        case 12: sItem = "nw_it_gem014";  break;
        case 13:  sItem = "nw_it_gem003";  break;
        case 14:  sItem = "nw_it_gem015"; break;
        case 15: sItem = "nw_it_gem011";         break;
        case 16: sItem = "nw_it_gem013";         break;
        case 17: sItem = "nw_it_mring021";            break;
        case 18:  sItem = "nw_it_mneck020";    break;
        case 19: sItem = "nw_it_mring022";            break;
        case 20:  sItem = "nw_it_mneck023";            break;
        case 21: sItem="X1_WMGRENADE00" + IntToString(Random(7)+1); iQuantity=Random(3)+1; break;
        }
    }

oItem=CreateItemOnObject(sItem,oPC,iQuantity);
if (iACBonus>0)
    {
    itemproperty ip=ItemPropertyACBonus(1);
    IPSafeAddItemProperty(oItem,ip);
    }
}


void GetPotion(object oTarget, int iItemLevel)
{
    string sPotion = "";

    if (iItemLevel==1)
    {
        int nRandom = d10();
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: sPotion = "nw_it_mpotion001"; break;
            case 5: case 6: case 7: sPotion = "nw_it_mpotion020";  break;
            case 8: sPotion = "nw_it_mpotion002";  break;
            case 9: sPotion = "nw_it_mpotion009";  break;
            case 10: sPotion = "nw_it_mpotion005";  break;
        }

    }
    else if (iItemLevel==2)
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: sPotion = "nw_it_mpotion001"; break;
            case 4: case 5: case 6: case 7: case 8: sPotion = "nw_it_mpotion020";  break;
            case 9: case 10: case 11: case 12: sPotion = "nw_it_mpotion002";  break;
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    else if (iItemLevel==3)
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: case 10: case 11: case 12:
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    else if (iItemLevel==4)
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: case 10: case 11: case 12: sPotion = "nw_it_mpotion003"; break;
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    else  // keep 5 and 6 the same
    {
       int nRandom = Random(30) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: sPotion = "nw_it_mpotion003" ;
            case 10: case 11: case 12: case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
            case 30: sPotion = "en5_drpotion"; break;
        }
    }
    CreateItemOnObject(sPotion, oTarget, 1);
}

void SetupTokens(object oNPC)
{
int iStep;
string sMobName;
string sTarget;
string sLocation;
string sQS;
string sItem;
string sNPC;
string sGiver;

iStep=GetLocalInt(oNPC,"QuestStep");
if (iStep<1)
    iStep=1;
sQS="QuestStep" + IntToString(iStep);

sMobName=GetLocalString(oNPC,sQS + "MobName");
sTarget=GetLocalString(oNPC,sQS + "Mob");
sLocation=GetLocalString(oNPC,sQS + "Location");
sItem=GetLocalString(oNPC,sQS + "ItemName");
sNPC=GetLocalString(oNPC,sQS + "NPCName");

SetCustomToken(100,sTarget);
SetCustomToken(101,sMobName);
SetCustomToken(102,sLocation);
SetCustomToken(103,sItem);
SetCustomToken(104,sNPC);
}

//:: void main(){}
