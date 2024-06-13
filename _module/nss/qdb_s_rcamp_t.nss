#include "qdb_include"

void main()
{
string sQuest;
int iRepeatCamp;

iRepeatCamp=GetStepInt("RepeatCamp");
if (iRepeatCamp==0)
    SetStepInt("RepeatCamp",1);
else
    SetStepInt("RepeatCamp",0);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
