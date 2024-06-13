#include "qst_convo"

int StartingConditional()
{
int iResult;
int iStep;
object oQuestNPC;

iResult = FALSE;
oQuestNPC=OBJECT_SELF;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
if (iStep<1)
    iStep=1;
if (GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iStep) + "Type") == 4 && GetLocalInt(oQuestNPC,"QuestComplete") == 0 && !CheckMobs(oQuestNPC))
    iResult=TRUE;

return iResult;
}
