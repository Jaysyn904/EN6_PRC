int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"GameMode") == 0)
    iResult=TRUE;
return iResult;
}
