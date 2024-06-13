int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetGold(GetPCSpeaker())>99 && GetLocalInt(GetPCSpeaker(),"BorderHills") == 1)
    iResult=TRUE;
return iResult;
}
