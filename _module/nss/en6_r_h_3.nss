int StartingConditional()
{
int iResult;
string sTag;

iResult = FALSE;

sTag=GetLocalString(OBJECT_SELF,"RezTag");
if (GetDistanceBetween(OBJECT_SELF,GetObjectByTag(sTag)) > 10.0)
    iResult=TRUE;

return iResult;
}
