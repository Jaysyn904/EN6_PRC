#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("BossOnly",1);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
