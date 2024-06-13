int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(OBJECT_SELF,"Random") == 3)
    iResult=TRUE;

return iResult;
}
