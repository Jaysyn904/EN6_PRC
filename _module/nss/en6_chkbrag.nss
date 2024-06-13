int StartingConditional()
{
    int iResult;

    iResult = FALSE;
    if (GetLocalInt(OBJECT_SELF,"Brag") == 1)
        iResult=TRUE;
    return iResult;
}
