#include "qdb_include"

void main()
{
int iIndex3;
int iLine;
int iSteps;
string sQuest;

SetStepInt("Type",0);
SetStepInt("SpecialArea",0);
SetStepString("Item","");
SetStepInt("HideItem",0);
SetStepInt("Camp",0);
SetStepString("MobTag","");
SetStepInt("NPCType",0);
SetStepInt("NPCSpawn",0);
SetStepInt("Ambush",0);
SetStepInt("BossOnly",0);
SetStepInt("Boss",0);
SetStepInt("CreateItem",0);

iLine=1;
SetLineNumber(iLine);
while (GetLine() != "")
    {
    SetLine("");
    SetLineInt("Done",0);
    SetLineInt("NPC",0);

    iIndex3=1;
    while (iIndex3<=5)
        {
        SetResponseNumber(iIndex3);

        SetResponse("");
        SetResponseInt("Goto",0);
        SetLineString("Script","");
        SetLineInt("Check",0);
        SetLineInt("Accept",0);
        SetLineInt("DeleteItem",0);
        SetLineInt("StepDone",0);
        SetLineInt("LineStart",0);

        iIndex3++;
        }
    iLine++;
    SetLineNumber(iLine);
    }

iSteps=GetQuestInt("Steps");
iSteps--;
SetStepNumber(iSteps);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);

}
