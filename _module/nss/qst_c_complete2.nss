int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(OBJECT_SELF,"QuestComplete") == 0)
    iResult = TRUE;

return iResult;
}
