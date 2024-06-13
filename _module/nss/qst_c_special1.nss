int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(OBJECT_SELF,"SpecialQuest") == 1)
    iResult=TRUE;

return iResult;
}
