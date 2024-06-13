#include "qdb_include"

void main()
{
string sQuest;

SetStepInt("SpecialArea",1);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
