#include "qst_include"

void main()
{
object oPC;
object oHenchman;
object oObject;
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
SetLocalString(OBJECT_SELF,"QuestStep1Item","en6_mq1item");
sDescription="I have promised " + GetName(OBJECT_SELF) + " I would ride to Nirra Hamlett and defend it against an attack by powerful creatures.";
SetDescription(OBJECT_SELF,sDescription);
SetStepDone(OBJECT_SELF,"I have defended Nirra Hamlett.  I should return to " + GetName(OBJECT_SELF) + " at the woodsman cottage in the Black Forest.");
SetJournalEntry(oPC,sDescription);
SetLocalInt(OBJECT_SELF,"QuestAccepted",1);
SetLocalInt(OBJECT_SELF,"MainQuestNPC",1);

}
