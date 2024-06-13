#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("Type",7);
SetStepInt("SpecialArea",3);
SetStepInt("Boss",1);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
