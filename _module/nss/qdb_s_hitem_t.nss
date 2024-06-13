#include "qdb_include"

void main()
{
string sQuest;
int iHideItem;

iHideItem=GetStepInt("HideItem");
if (iHideItem==0)
    SetStepInt("HideItem",1);
else
    SetStepInt("HideItem",0);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
