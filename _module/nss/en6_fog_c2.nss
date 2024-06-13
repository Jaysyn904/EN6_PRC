int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(OBJECT_SELF,"Random") == 2)
    iResult=TRUE;

return iResult;
}
