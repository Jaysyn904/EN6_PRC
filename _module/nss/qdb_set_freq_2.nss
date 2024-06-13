#include "qdb_include"

void main()
{
string sQuest;

SetQuestInt("Frequency",2);

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
