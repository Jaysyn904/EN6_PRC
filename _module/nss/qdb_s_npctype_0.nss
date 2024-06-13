#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("NPCType",0);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
