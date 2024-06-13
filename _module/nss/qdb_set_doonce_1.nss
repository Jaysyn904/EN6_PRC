#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("DoOnce",1);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
