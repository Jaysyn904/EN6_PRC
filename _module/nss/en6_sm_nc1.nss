int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"MP1") > 0)
    iResult=TRUE;

return iResult;
}
