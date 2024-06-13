int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"Theme2") <2)
    iResult=TRUE;
return iResult;
}
