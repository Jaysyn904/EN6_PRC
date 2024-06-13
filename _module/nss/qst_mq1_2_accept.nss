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
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
SetLocalInt(OBJECT_SELF,"QuestStep",1);
SetLocalInt(OBJECT_SELF,"QuestStep1Type",6);
SetLocalString(OBJECT_SELF,"QuestStep1Item","en6_mq2item");
SetLocalInt(OBJECT_SELF,"MainQuestNPC",1);

sDescription="I have promised " + GetName(OBJECT_SELF) + " I would venture into the Depths of Morug-ta located in the Northern Border Hills and seek out this mysterous orb the letter talks about.";
SetDescription(OBJECT_SELF,sDescription);
SetStepDone(OBJECT_SELF,"I have found the orb.  I should return to " + GetName(OBJECT_SELF) + " at the church in the Border Hills.");
SetJournalEntry(oPC,sDescription);
SetLocalInt(OBJECT_SELF,"QuestAccepted",1);

}
