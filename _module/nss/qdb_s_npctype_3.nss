#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("NPCType",3);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
