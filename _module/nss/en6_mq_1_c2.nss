int StartingConditional()
{
int iResult;

iResult = TRUE;

if (GetLocalInt(GetPCSpeaker(),"QuestComplete")>0)
    iResult=FALSE;

return iResult;
}
