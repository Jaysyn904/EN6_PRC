int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"AV1") > 0)
    iResult=TRUE;

return iResult;
}
