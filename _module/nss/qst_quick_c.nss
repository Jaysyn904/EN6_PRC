int StartingConditional()
{
int iResult;
int iQuest;

iResult = FALSE;

iQuest = GetLocalInt(GetPCSpeaker(),"QuickQuest");

if (iQuest==1)
    {
    if (GetLocalInt(OBJECT_SELF,"QuestComplete") == 0 && GetLocalString(GetPCSpeaker(),"QuestGiver") == GetTag(OBJECT_SELF))
       iResult = TRUE;

    //if (GetLocalInt(GetPCSpeaker(),"QuestType") == 4 && GetLocalString(GetPCSpeaker(),"QuestNPC") == GetTag(OBJECT_SELF))
    //    iResult = TRUE;
    if (GetLocalString(GetPCSpeaker(),"QuestNPC") == GetTag(OBJECT_SELF))
        iResult = TRUE;

    //if (GetLocalInt(GetPCSpeaker(),"QuestType") == 4 && GetLocalString(GetPCSpeaker(),"QuestNPC") != GetTag(OBJECT_SELF))
    if (GetLocalString(GetPCSpeaker(),"QuestNPC") != "" && GetLocalString(GetPCSpeaker(),"QuestNPC") != GetTag(OBJECT_SELF))
        iResult = FALSE;
    }
return iResult;

}
