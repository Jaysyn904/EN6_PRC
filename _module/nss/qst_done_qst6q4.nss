#include "qst_include"

void main()
{
object oPC;

oPC = GetPCSpeaker();

SetLocalInt(oPC,"QuestGold",10);
SetLocalInt(oPC,"QuestXP",150);
SetLocalInt(oPC,"QuestItemChance",0);
QuestDone(GetPCSpeaker());
}

