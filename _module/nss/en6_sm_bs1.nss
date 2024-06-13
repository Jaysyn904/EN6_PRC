int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"BS1") > 0)
    iResult=TRUE;

return iResult;
}
