#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("Execute",0);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
