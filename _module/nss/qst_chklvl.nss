int StartingConditional()
{
int iResult;
int iQuestLevel;
int iLevel;

iResult = FALSE;

iLevel=GetHitDice(GetPCSpeaker());
iQuestLevel = GetLocalInt(OBJECT_SELF,"QuestLevel");

if (GetLocalInt(OBJECT_SELF,"QuestComplete") == 0)
    {
    if (iQuestLevel < 10 && iLevel+2<iQuestLevel)
        iResult=TRUE;
    else if (iQuestLevel < 18 && iLevel+3<iQuestLevel)
        iResult=TRUE;
    else if (iQuestLevel < 26 && iLevel+4<iQuestLevel)
        iResult=TRUE;
    else if (iLevel+5<iQuestLevel)
        iResult=TRUE;
    }


return iResult;
}
