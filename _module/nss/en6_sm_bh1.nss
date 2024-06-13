int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"BH1") > 0)
    iResult=TRUE;

return iResult;
}
