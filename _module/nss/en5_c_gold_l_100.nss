int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetGold(GetPCSpeaker()) < 100)
    iResult = TRUE;
return iResult;
}
