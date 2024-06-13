#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

string sQuest;

SetQuestString("NPCTag",sTalk);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
