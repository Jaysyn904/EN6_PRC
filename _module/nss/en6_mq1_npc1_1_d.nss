#include "qst_include"

void SetMQAccomplishment(object oPC,object oQuestNPC);

void main()
{
object oPC;
object oHenchman;

oPC=GetPCSpeaker();

RewardPartyXP(10000, oPC);
RewardPartyGP(500, oPC);
if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    RewardPartyFame(5, oPC);
else
    RewardPartyFame(10, oPC);

GivePartyItemReward(oPC,"",5);

SetMQAccomplishment(oPC,OBJECT_SELF);

SetLocalInt(OBJECT_SELF,"QuestComplete",1);
SetPartyInt(oPC,"OnQuest",0);
AddJournalQuestEntry("jQuest",21,oPC);
SetLocalInt(GetModule(),"MainQuest",1);
SetPartyVariables(oPC);

oHenchman=GetObjectByTag("mq1_1_scout");
if (!GetIsDead(oHenchman))
    RemoveHenchman(GetMaster(oHenchman),oHenchman);

object oWP=GetObjectByTag("TST_START");
DelayCommand(0.1,AssignCommand(oHenchman,JumpToLocation(GetLocation(oWP))));

SetLocalInt(OBJECT_SELF,"QuestLine",0);
SetLocalInt(OBJECT_SELF,"QuestStep",1);
SetLocalInt(OBJECT_SELF,"QuestLineStart",100);

CheckFame(GetPCSpeaker());

SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
}

void SetMQAccomplishment(object oPC,object oQuestNPC)
{
string sZone;
string sAccomplishment;
string sZoneAccomplishment;
int iAccomplishment;

sZone = GetLocalString(oQuestNPC,"QuestZone");
sAccomplishment = "helped " + GetName(oQuestNPC) + " investigate an abandoned tower in the Western Black Forest";

if (sAccomplishment != "")
    {
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        iAccomplishment = GetLocalInt(oPartyMember,"Accomplishments");
        iAccomplishment++;
        SetLocalInt(oPartyMember,"Accomplishments",iAccomplishment);
        SetLocalString(oPartyMember,"Accomplishment" + IntToString(iAccomplishment),sAccomplishment);
        SetLocalInt(oPartyMember,"Accomplishment" + IntToString(iAccomplishment) + "Diff",16);

        sZoneAccomplishment = GetLocalString(oPartyMember,"BF1_Accomplishment");
        if (sZoneAccomplishment == "")
            SetPartyString(oPartyMember,"BF1_Accomplishment",sAccomplishment);
        else
            if (Random(2)==0)
                SetPartyString(oPartyMember,"BF1_Accomplishment",sAccomplishment);

        oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
    }
}

