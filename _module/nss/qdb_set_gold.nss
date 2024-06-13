#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

string sQuest;

SetQuestInt("Gold",StringToInt(sTalk));

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
