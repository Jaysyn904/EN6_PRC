#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("Boss",2);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
