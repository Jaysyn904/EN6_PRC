int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(OBJECT_SELF,"Random") == 1)
    iResult=TRUE;

return iResult;
}
