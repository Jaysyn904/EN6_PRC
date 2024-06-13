#include "qst_include"

void main()
{
SetLocalInt(OBJECT_SELF,"SpecialQuest",0);
QuestDone(GetPCSpeaker());
}

