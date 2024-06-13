int StartingConditional()
{
int iResult;
string sTag;

iResult = TRUE;

sTag=GetLocalString(OBJECT_SELF,"QuestStep1MobTag");
if (GetIsObjectValid(GetObjectByTag(sTag)))
    iResult=FALSE;

if (GetIsDead(GetObjectByTag(sTag)))
    iResult=TRUE;

return iResult;
}
