int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"EF1") > 0)
    iResult=TRUE;

return iResult;
}
