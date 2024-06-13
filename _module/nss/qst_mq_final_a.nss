#include "qst_include"

void main()
{
object oPC;
string sDescription;

oPC=GetPCSpeaker();

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    SetLocalString(oPartyMember,"QuestNPC",GetTag(OBJECT_SELF));
    SetLocalString(oPartyMember,"QuestName","Cleansing the Land");
    SetLocalInt(oPartyMember,"OnQuest",1);
    CreateItemOnObject("en6_mqf_scroll",oPartyMember);
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
SetLocalInt(OBJECT_SELF,"QuestStep",1);
SetLocalInt(OBJECT_SELF,"QuestStep1Type",1);
SetLocalString(OBJECT_SELF,"QuestStep1MobTag",GetOverallBossTag());
SetLocalInt(OBJECT_SELF,"MainQuestNPC",1);

sDescription="I have promised " + GetName(OBJECT_SELF) + " I would venture deep into the Northern Red Desert and make my way to the northeast corner where I will find a passage that will take me to the lair of " + GetOverallBossName() + ".";
SetDescription(OBJECT_SELF,sDescription);
SetStepDone(OBJECT_SELF,"I have defeated " + GetOverallBossName() + ".  I should return to " + GetName(OBJECT_SELF) + " at the adobe house in the Red Desert.");
SetJournalEntry(oPC,sDescription);
SetLocalInt(OBJECT_SELF,"QuestAccepted",1);
}
