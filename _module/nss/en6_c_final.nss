int StartingConditional()
{
    int iResult;

    iResult = FALSE;
    if (GetLocalInt(GetModule(),"MainQuest") >=99)
        iResult=TRUE;
    return iResult;
}
