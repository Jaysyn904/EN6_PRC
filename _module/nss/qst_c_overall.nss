int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(OBJECT_SELF,"QuestMain") > (GetLocalInt(GetModule(),"OverallQuest") + 1))
    iResult = TRUE;
if (GetLocalInt(GetPCSpeaker(),"Debug")==1)
    iResult = FALSE;

return iResult;
}
