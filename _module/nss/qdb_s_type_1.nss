#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("Type",1);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
