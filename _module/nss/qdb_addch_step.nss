#include "qdb_include"

void main()
{
string sQuest;
int iType;

SetStepNumber(1);
iType=GetStepInt("Type");

if (iType==0)
    {
    SetStepInt("NPCType",1);
    SetQuestInt("Steps",1);
    }

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
