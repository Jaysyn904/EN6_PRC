int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"GameMode") == 1)
    iResult=TRUE;
return iResult;
}
