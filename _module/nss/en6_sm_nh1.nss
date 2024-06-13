int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"NH1") > 0)
    iResult=TRUE;

return iResult;
}
