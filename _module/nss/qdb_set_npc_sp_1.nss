#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("NPCSpawn",1);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
