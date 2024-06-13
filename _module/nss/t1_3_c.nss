int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"Theme1") <2)
    iResult=TRUE;
return iResult;
}
