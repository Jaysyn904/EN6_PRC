#include "qst_include"

void main()
{
SetPartyInt(GetPCSpeaker(),"QuestItemChance",0);
SetPartyInt(GetPCSpeaker(),"QuestGold",GetLocalInt(OBJECT_SELF,"QuestGold")/2);
SetPartyInt(GetPCSpeaker(),"QuestXP",GetLocalInt(OBJECT_SELF,"QuestXP")/2);
SetPartyString(GetPCSpeaker(),"QuestAccomplishment","");

if (GetLocalInt(GetPCSpeaker(),"Quest")>99)
    SetPartyInt(GetPCSpeaker(),"Quest",99);

QuestDone(GetPCSpeaker());
}

