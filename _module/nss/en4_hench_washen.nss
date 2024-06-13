int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetName(GetPCSpeaker()) == GetLocalString(OBJECT_SELF,"Master"))
    iResult = TRUE;
return iResult;
}
