int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(GetPCSpeaker(),"Fame")>49)
    iResult=TRUE;

return iResult;
}
