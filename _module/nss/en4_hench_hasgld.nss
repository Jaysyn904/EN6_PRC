int StartingConditional()
{
int iResult;
int iGold;

iResult = FALSE;
iGold = GetHitDice(GetPCSpeaker()) * 250;
if (GetGold(GetPCSpeaker()) >= iGold)
    iResult = TRUE;

return iResult;
}
