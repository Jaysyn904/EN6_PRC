#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("HideItem",1);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
