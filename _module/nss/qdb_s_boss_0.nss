#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("Boss",0);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
