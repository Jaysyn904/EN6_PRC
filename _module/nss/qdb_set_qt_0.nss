#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("Type",0);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
