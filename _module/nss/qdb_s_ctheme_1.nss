#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("CampTheme",1);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
