int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(GetPCSpeaker(),"Fame")>99)
    iResult=TRUE;

return iResult;
}
