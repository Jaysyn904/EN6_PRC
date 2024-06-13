int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"Quest")>0)
    iResult=TRUE;
return iResult;
}
