int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetGold(GetPCSpeaker()) > 99)
    iResult = TRUE;
return iResult;
}
