int StartingConditional()
{
int iResult;
object oHenchman;

iResult = TRUE;
oHenchman=OBJECT_SELF;

if (GetLocalInt(oHenchman,"RESURRECTION") ==0 && GetLevelByClass(CLASS_TYPE_CLERIC,oHenchman)>12)
    iResult=FALSE;
if (GetLocalInt(oHenchman,"RAISE_DEAD") ==0 && GetLevelByClass(CLASS_TYPE_CLERIC,oHenchman)>8)
    iResult=FALSE;
return iResult;
}
