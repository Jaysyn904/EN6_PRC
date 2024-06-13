int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"BF1") > 0)
    iResult=TRUE;

return iResult;
}
