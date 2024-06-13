int StartingConditional()
{
int iResult;
object oPC;

iResult = FALSE;
oPC=GetPCSpeaker();

if (GetLocalInt(oPC,"QuestResponse") == 1 && GetLocalString(oPC,"QuestNPC") == GetTag(OBJECT_SELF))
    iResult = TRUE;

return iResult;
}
