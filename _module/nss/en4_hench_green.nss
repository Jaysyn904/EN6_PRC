int StartingConditional()
{
    int iResult;

    iResult = FALSE;
    if (GetHitDice(GetPCSpeaker())<(GetHitDice(OBJECT_SELF)-1))
        iResult = TRUE;
    return iResult;
}
