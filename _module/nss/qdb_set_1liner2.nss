#include "qdb_include"

void main()
{
string sQuest;

SetQuestString("OneLiner","");

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
