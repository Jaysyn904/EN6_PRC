int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(OBJECT_SELF,"SpecialQuest") == 2)
    iResult=TRUE;

return iResult;
}
