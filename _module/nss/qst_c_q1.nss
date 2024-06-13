int StartingConditional()
{
int iResult;
int iQuest;

iResult = FALSE;
iQuest = GetLocalInt(OBJECT_SELF,"Quest");

if (iQuest == 1)
    iResult = TRUE;

return iResult;
}
