#include "qdb_include"

void main()
{
string sQuest;
int iCreateItem;

iCreateItem=GetStepInt("CreateItem");
if (iCreateItem==0)
    SetStepInt("CreateItem",1);
else
    SetStepInt("CreateItem",0);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
