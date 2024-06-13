#include "nw_i0_tool"
//#include "en5_misc"
int StartingConditional()
{
int iResult;

//GetError("PC QS=" + IntToString(GetLocalInt(GetPCSpeaker(),"QuestQuickStep")));
//GetError("NPC QS=" + IntToString(GetLocalInt(OBJECT_SELF,"QuestQuickStep")));

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"QuestQuickStep") == 1)
    {
    iResult=TRUE;
    if (GetLocalInt(GetPCSpeaker(),"QuestHideItem") == 1 && !HasItem(GetPCSpeaker(),GetLocalString(GetPCSpeaker(),"QuestItem")))
        iResult=FALSE;
    if (GetLocalInt(GetPCSpeaker(),"QuestHideItem") == 1 && GetLocalInt(OBJECT_SELF,"QuestIsDead") == 1)
        iResult=FALSE;
    }

return iResult;
}
