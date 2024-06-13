int StartingConditional()
{
int iResult;

iResult = TRUE;

if (GetLocalInt(GetPCSpeaker(),"OnQuest")==0)
    iResult=FALSE;

return iResult;
}
