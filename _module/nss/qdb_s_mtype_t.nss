#include "qdb_include"

void main()
{
string sQuest;
int iMobType;

iMobType=GetStepInt("MobType");
if (iMobType==0)
    SetStepInt("MobType",1);
else
    SetStepInt("MobType",0);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
