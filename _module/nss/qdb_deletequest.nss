#include "qdb_include"

void main()
{
int iIndex;
int iIndex3;
int iLine;
int iSteps;
string sQuest;

SetQuestString("Name","DELETE");
SetQuestInt("MinLevel",0);
SetQuestInt("Steps",0);
SetQuestInt("ItemChanceMod",0);
SetQuestString("ItemReward","");
SetQuestInt("Gold",0);
SetQuestInt("NPCType",0);
SetQuestInt("NPCSpawn",0);
SetQuestString("OneLiner","");
SetQuestInt("Frequency",0);
SetQuestInt("DoOnce",0);
SetQuestInt("MinLevel",0);
SetQuestInt("MaxLevel",0);

iIndex=1;
while (iIndex<=GetQuestInt("Steps"))
    {
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
    iIndex++;
    }

}
