int StartingConditional()
{
    int iResult;

    iResult = FALSE;
    if (GetLocalInt(OBJECT_SELF,"HenchmanClass") == 0)
        iResult=TRUE;
    return iResult;
}
