#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("CampTheme",5);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
