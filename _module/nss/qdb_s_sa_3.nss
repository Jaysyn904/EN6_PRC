#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("SpecialArea",3);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
