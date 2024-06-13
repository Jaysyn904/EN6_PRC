#include "qst_include"

void main()
{
int iBless;
object oPC;

SetLocalInt(OBJECT_SELF,"SpecialQuest",0);

oPC = GetPCSpeaker();
object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    iBless = GetLocalInt(oPartyMember,"DivineBlessing");
    iBless++;
    SetLocalInt(oPartyMember,"DivineBlessing",iBless);
    SendMessageToPC(oPartyMember,"You have recieved a divine blessing");
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
QuestDone(GetPCSpeaker());

}

