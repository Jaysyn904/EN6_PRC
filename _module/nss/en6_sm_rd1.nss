int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"RD1") > 0)
    iResult=TRUE;

return iResult;
}
