#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

string sQuest;

SetQuestInt("MQNumber",StringToInt(sTalk));

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
