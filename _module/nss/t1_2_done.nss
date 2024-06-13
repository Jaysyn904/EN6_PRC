#include "qst_include"

void SetMQAccomplishment(object oPC,object oQuestNPC);

void main()
{
object oPC;
object oHenchman;
int iFavor;

oPC=GetPCSpeaker();

if (GetLocalInt(OBJECT_SELF,"QuestLevel")<4)
    RewardPartyXP(1000, oPC);
else if (GetLocalInt(OBJECT_SELF,"QuestLevel")<7)
    RewardPartyXP(1250, oPC);
else
    RewardPartyXP(1500, oPC);

RewardPartyFame(4, oPC);

SetMQAccomplishment(oPC,OBJECT_SELF);

SetLocalInt(OBJECT_SELF,"QuestComplete",1);
SetPartyInt(oPC,"OnQuest",0);
AddJournalQuestEntry("jQuest",21,oPC);
SetPartyVariables(oPC);
SetLocalInt(GetModule(),"Theme1",2);
}

void SetMQAccomplishment(object oPC,object oQuestNPC)
{
string sZone;
string sAccomplishment;
string sZoneAccomplishment;
int iAccomplishment;

sZone = GetLocalString(oQuestNPC,"QuestZone");
sAccomplishment = "helped " + GetName(oQuestNPC) + " take care of some " + GetLocalString(OBJECT_SELF,"QuestStep1Mob");

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

        oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
    }
}

