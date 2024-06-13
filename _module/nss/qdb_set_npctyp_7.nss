#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("NPCType",7);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
