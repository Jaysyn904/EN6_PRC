#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("DoOnce",0);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
