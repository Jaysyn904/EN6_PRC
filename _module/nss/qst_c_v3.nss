int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetLocalInt(GetPCSpeaker(),"QuestVariance")==3)
    iResult = TRUE;

return iResult;
}
