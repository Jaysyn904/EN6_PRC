#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("Execute",3);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
