#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("Frequency",1);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
