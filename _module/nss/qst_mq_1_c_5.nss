int StartingConditional()
{
int iResult;

iResult = FALSE;
if (!GetIsObjectValid(GetObjectByTag("TOWER4_Q1_1_S")))
    iResult=TRUE;

return iResult;
}
