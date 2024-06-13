int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetXP(GetPCSpeaker()) == 0)
    iResult=TRUE;

return iResult;
}
