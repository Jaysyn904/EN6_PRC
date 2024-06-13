int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"Debug")==1)
    iResult=TRUE;

return iResult;
}
