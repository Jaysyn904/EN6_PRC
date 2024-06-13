#include "qdb_include"

void main()
{
string sQuest;
int iType;
int iStep;

iStep=GetStepNumber()+1;
SetStepNumber(iStep);
iType=GetStepInt("Type");

while (iType>0)
    {
    iStep++;
    SetStepNumber(iStep);
    iType=GetStepInt("Type");
    }

SetStepInt("Type",1);
SetStepInt("NPCType",1);
SetQuestInt("Steps",iStep);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
