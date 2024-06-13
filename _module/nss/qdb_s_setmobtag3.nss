#include "qdb_include"

void main()
{
string sQuest;

SetStepString("MobTag","");

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
