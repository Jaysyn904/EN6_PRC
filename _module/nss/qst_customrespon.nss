int StartingConditional()
{
int iResult;
string sTalk;

iResult=FALSE;

sTalk = GetLocalString(OBJECT_SELF,"QUEST_Talk");
if (sTalk != "")
    iResult = TRUE;

return iResult;
}
