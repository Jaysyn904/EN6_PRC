int StartingConditional()
{
int iResult;

iResult = TRUE;

if (GetLocalInt(OBJECT_SELF,"QuestComplete")>0)
    iResult=FALSE;
if (GetLocalInt(OBJECT_SELF,"QuestStep") != 2)
    iResult=FALSE;
if (GetLocalString(GetPCSpeaker(),"QuestNPC") != GetTag(OBJECT_SELF))
    iResult=FALSE;

return iResult;
}
