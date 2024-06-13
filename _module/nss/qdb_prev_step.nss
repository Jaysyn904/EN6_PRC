#include "qdb_include"

void main()
{
string sQuest;
int iType;
int iStep;

iStep=GetStepNumber()-1;
SetStepNumber(iStep);
iType=GetStepInt("Type");

if (iType==0)
    {
    iStep++;
    SetStepNumber(iStep);
    DelayCommand(0.1,SendMessageToPC(GetFirstPC(),"No Previous Step."));
    }

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
