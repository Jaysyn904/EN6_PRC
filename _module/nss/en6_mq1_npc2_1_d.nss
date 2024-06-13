#include "qst_include"

void SetMQAccomplishment(object oPC,object oQuestNPC);

void main()
{
object oPC;
object oHenchman;
int iFavor;

oPC=GetPCSpeaker();

RewardPartyXP(15000, oPC);
RewardPartyGP(1000, oPC);
if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    RewardPartyFame(8, oPC);
else
    RewardPartyFame(15, oPC);
GivePartyItemReward(oPC,"WEAPON",5);

SetMQAccomplishment(oPC,OBJECT_SELF);

SetLocalInt(OBJECT_SELF,"QuestComplete",1);
SetPartyInt(oPC,"OnQuest",0);
AddJournalQuestEntry("jQuest",21,oPC);
SetLocalInt(GetModule(),"MainQuest",98);
SetPartyVariables(oPC);

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    iFavor=GetLocalInt(oPartyMember,"DivineBlessing");
    SetLocalInt(oPartyMember,"DivineBlessing",iFavor+2);
    SendMessageToPC(oPartyMember,"You have earned two Divine Blessings from the Church in Nova City.");
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }

object oItemToTake = GetItemPossessedBy(oPC, "en6_mq2item");
if(GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);

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
sAccomplishment = "helped " + GetName(oQuestNPC) + " recover an Orb of Attraction from the Depths of Morug-ta";

if (sAccomplishment != "")
    {
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        iAccomplishment = GetLocalInt(oPartyMember,"Accomplishments");
        iAccomplishment++;
        SetLocalInt(oPartyMember,"Accomplishments",iAccomplishment);
        SetLocalString(oPartyMember,"Accomplishment" + IntToString(iAccomplishment),sAccomplishment);
        SetLocalInt(oPartyMember,"Accomplishment" + IntToString(iAccomplishment) + "Diff",25);

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

