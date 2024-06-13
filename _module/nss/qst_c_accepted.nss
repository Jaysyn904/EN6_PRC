int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(OBJECT_SELF,"QuestAccepted") == 0 && GetLocalInt(GetPCSpeaker(),"OnQuest") == 0)
    iResult = TRUE;

return iResult;
}
