int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"EN5_BossNamed") == 1)
    iResult = TRUE;

return iResult;
}
