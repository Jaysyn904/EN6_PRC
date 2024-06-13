int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"Theme3") == 0)
    iResult=TRUE;
return iResult;
}
