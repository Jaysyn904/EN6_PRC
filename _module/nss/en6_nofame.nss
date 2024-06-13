int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(GetPCSpeaker(),"Fame")<50)
    iResult=TRUE;

return iResult;
}
