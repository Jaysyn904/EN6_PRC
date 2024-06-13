#include "qst_include"

void main()
{
SetPartyInt(GetPCSpeaker(),"QuestItemChance",0);
SetPartyInt(GetPCSpeaker(),"QuestGold",5);
SetPartyInt(GetPCSpeaker(),"QuestXP",50);
SetPartyString(GetPCSpeaker(),"QuestAccomplishment","");
QuestDone(GetPCSpeaker());
}

