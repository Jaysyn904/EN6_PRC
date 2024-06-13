#include "qdb_include"

void main()
{
string sQuest;
int iBossOnly;

iBossOnly=GetStepInt("BossOnly");
if (iBossOnly==0)
    SetStepInt("BossOnly",1);
else
    SetStepInt("BossOnly",0);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
