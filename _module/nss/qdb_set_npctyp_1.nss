#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("NPCType",1);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
