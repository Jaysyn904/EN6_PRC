#include "utl_i_sqluuid"

int StartingConditional()
{
int iQuestPoints;

iQuestPoints = SQLocalsUUID_GetInt(GetPCSpeaker(),"QuestPoints");

if (iQuestPoints < 2)
    return TRUE;

return FALSE;
}
