#include "qst_include"

void SetMQAccomplishment(object oPC,object oQuestNPC);

void main()
{
object oPC;
object oHenchman;
int iFavor;

oPC=GetPCSpeaker();

RewardPartyXP(20000, oPC);
RewardPartyGP(1000, oPC);
if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    RewardPartyFame(15, oPC);
else
    RewardPartyFame(25, oPC);
GivePartyItemReward(oPC,"WEAPON",6);
GivePartyItemReward(oPC,"ARMOR",6);

SetMQAccomplishment(oPC,OBJECT_SELF);

SetLocalInt(OBJECT_SELF,"QuestComplete",1);
SetPartyInt(oPC,"OnQuest",0);
AddJournalQuestEntry("jQuest",21,oPC);
SetLocalInt(GetModule(),"MainQuest",99);
SetLocalInt(GetModule(),"MQFinal",2);
SetPartyVariables(oPC);

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    iFavor=GetLocalInt(oPartyMember,"MagicalFavor");
    SetLocalInt(oPartyMember,"MagicalFavor",iFavor+2);
    SendMessageToPC(oPartyMember,"You have earned two favors from the Mage's Guild in Nova City.");
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
CheckFame(GetPCSpeaker());
}

void SetMQAccomplishment(object oPC,object oQuestNPC)
{
string sZone;
string sAccomplishment;
string sZoneAccomplishment;
int iAccomplishment;

sZone = GetLocalString(oQuestNPC,"QuestZone");
sAccomplishment = "saved the land by defeating " + GetOverallBossName();

if (sAccomplishment != "")
    {
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        iAccomplishment = GetLocalInt(oPartyMember,"Accomplishments");
        iAccomplishment++;
        SetLocalInt(oPartyMember,"Accomplishments",iAccomplishment);
        SetLocalString(oPartyMember,"Accomplishment" + IntToString(iAccomplishment),sAccomplishment);
        SetLocalInt(oPartyMember,"Accomplishment" + IntToString(iAccomplishment) + "Diff",50);

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

