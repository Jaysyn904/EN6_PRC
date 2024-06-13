int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"QuestVariance")==2)
    iResult = TRUE;

return iResult;
}
