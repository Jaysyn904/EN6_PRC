int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetGold(GetPCSpeaker()) > 199)
    iResult = TRUE;
return iResult;
}
