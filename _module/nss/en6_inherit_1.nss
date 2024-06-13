int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(OBJECT_SELF,"G" + GetName(GetPCSpeaker())) == 0 &&
    GetLocalInt(OBJECT_SELF,GetName(GetPCSpeaker())) == 1)
    iResult=TRUE;

return iResult;
}
