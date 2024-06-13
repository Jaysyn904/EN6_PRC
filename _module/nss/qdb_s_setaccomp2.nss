#include "qdb_include"

void main()
{
string sQuest;

SetQuestString("Accomplishment","");

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
