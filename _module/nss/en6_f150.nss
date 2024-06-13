int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(GetPCSpeaker(),"Fame")>149)
    iResult=TRUE;

return iResult;
}
