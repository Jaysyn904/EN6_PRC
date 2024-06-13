#include "qst_include"

void SetMQAccomplishment(object oPC,object oQuestNPC);

void main()
{
object oPC;
object oHenchman;

oPC=GetPCSpeaker();

RewardPartyXP(5000, oPC);
RewardPartyGP(500, oPC);
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

object oItemToTake = GetItemPossessedBy(oPC, "en6_mq1item");
if(GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);
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

        sZoneAccomplishment = GetLocalString(oPartyMember,"BF1_Accomplishment");
        if (sZoneAccomplishment == "")
            SetPartyString(oPartyMember,"BF1_Accomplishment",sAccomplishment);
        else
            if (Random(2)==0)
                SetPartyString(oPartyMember,"BF1_Accomplishment",sAccomplishment);

        SetLocalString(oPC,"MajorAccomplishment",sAccomplishment);

        oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
    }
}

