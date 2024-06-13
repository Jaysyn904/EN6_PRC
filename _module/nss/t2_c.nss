int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"Theme2") == 0)
    iResult=TRUE;
return iResult;
}
