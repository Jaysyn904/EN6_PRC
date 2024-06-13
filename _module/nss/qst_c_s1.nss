int StartingConditional()
{
int iResult;

iResult = TRUE;

if (GetLocalInt(GetPCSpeaker(),"OnQuest")>0)
    iResult=FALSE;
if (GetLocalInt(OBJECT_SELF,"QuestComplete")>0)
    iResult=FALSE;
if (GetLocalInt(OBJECT_SELF,"QuestStep")!=1)
    iResult=FALSE;

return iResult;
}
