int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"MQ5_Runes") > 0 && GetLocalInt(GetPCSpeaker(),"RuneRing") == 0)
    iResult=TRUE;

return iResult;
}
