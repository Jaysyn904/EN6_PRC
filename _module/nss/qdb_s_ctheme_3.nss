#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("CampTheme",3);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
