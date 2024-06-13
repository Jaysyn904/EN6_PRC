int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(GetPCSpeaker(),"DivineBlessing")>0)
    iResult=TRUE;
return iResult;
}
