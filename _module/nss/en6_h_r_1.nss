int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF)<9)
    iResult=TRUE;

return iResult;
}
