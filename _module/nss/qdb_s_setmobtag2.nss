#include "qdb_include"

void main()
{
string sQuest;

SetStepString("MobTag","CAMP");

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
