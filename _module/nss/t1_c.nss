int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"Theme1") == 0)
    iResult=TRUE;
return iResult;
}
