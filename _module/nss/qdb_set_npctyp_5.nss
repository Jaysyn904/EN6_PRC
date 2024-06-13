#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("NPCType",5);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
