#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("Type",8);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
