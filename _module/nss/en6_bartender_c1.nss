int StartingConditional()
{
    int iResult;

    iResult = FALSE;
    if (GetGold(GetPCSpeaker()) >= GetLocalInt(OBJECT_SELF,"Cost"))
        iResult=TRUE;

    return iResult;
}
