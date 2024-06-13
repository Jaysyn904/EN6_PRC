#include "qst_include"

void SetMQAccomplishment(object oPC,object oQuestNPC);

void main()
{
object oPC;
object oHenchman;
int iFavor;
int iXP;

oPC=GetPCSpeaker();

iXP = 1000 + 150*GetLocalInt(OBJECT_SELF,"QuestLevel");
RewardPartyXP(iXP, oPC);

RewardPartyGP(500, oPC);
RewardPartyFame(10, oPC);

SendMessageToParty(oPC,"You recieve bonus experience for completing the series of quests.");

if (GetLocalInt(OBJECT_SELF,"QuestLevel")<4)
    RewardPartyXP(1500, oPC);
else if (GetLocalInt(OBJECT_SELF,"QuestLevel")<7)
    RewardPartyXP(2000, oPC);
else if (GetLocalInt(OBJECT_SELF,"QuestLevel")<14)
    RewardPartyXP(2500, oPC);
else
    RewardPartyXP(3500, oPC);


SetMQAccomplishment(oPC,OBJECT_SELF);

SetLocalInt(OBJECT_SELF,"QuestComplete",1);
SetPartyInt(oPC,"OnQuest",0);
AddJournalQuestEntry("jQuest",21,oPC);
SetPartyVariables(oPC);
SetLocalInt(GetModule(),"Theme1",3);
}

void SetMQAccomplishment(object oPC,object oQuestNPC)
{
string sZone;
string sArea;
string sAccomplishment;
string sZoneAccomplishment;
int iAccomplishment;

sZone = GetLocalString(oQuestNPC,"QuestZone");
sArea = GetLocalString(oQuestNPC,"Area");
sAccomplishment = "helped " + GetName(oQuestNPC) + " avert a potential attack on " + sArea + ".";

if (sAccomplishment != "")
    {
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        iAccomplishment = GetLocalInt(oPartyMember,"Accomplishments");
        iAccomplishment++;
        SetLocalInt(oPartyMember,"Accomplishments",iAccomplishment);
        SetLocalString(oPartyMember,"Accomplishment" + IntToString(iAccomplishment),sAccomplishment);

        sZoneAccomplishment = GetLocalString(oPartyMember,sZone + "_Accomplishment");
        if (sZoneAccomplishment == "")
            SetPartyString(oPartyMember,sZone + "_Accomplishment",sAccomplishment);
        else
            if (Random(2)==0)
                SetPartyString(oPartyMember,sZone + "_Accomplishment",sAccomplishment);

        SetLocalString(oPartyMember,"MajorAccomplishment",sAccomplishment);
        SetLocalInt(oPartyMember,"MADifficulty",10);
        oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
    }
}

