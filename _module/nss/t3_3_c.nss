int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetModule(),"Theme3") <2)
    iResult=TRUE;
return iResult;
}
