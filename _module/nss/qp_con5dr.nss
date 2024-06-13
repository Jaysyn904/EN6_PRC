#include "utl_i_sqluuid"

int StartingConditional()
{
int iQuestPoints;
int iDR;

iDR=SQLocalsUUID_GetInt(GetPCSpeaker(),"DR");

iQuestPoints = SQLocalsUUID_GetInt(GetPCSpeaker(),"QuestPoints");

if (iQuestPoints >= 5 && iDR == 1)
    return TRUE;

if (iQuestPoints >= 10 && iDR == 0)
    return TRUE;

return FALSE;
}
