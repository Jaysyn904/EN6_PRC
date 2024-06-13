int StartingConditional()
{
    int iResult;
    iResult = FALSE;
    if (GetLocalString(OBJECT_SELF,"QUEST_Response") != "")
        iResult=TRUE;
    return iResult;
}
