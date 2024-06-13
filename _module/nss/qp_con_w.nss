#include "utl_i_sqluuid"

int StartingConditional()
{
int iQuestPoints;
int iReturn;
string sTag;

sTag = SQLocalsUUID_GetString(GetPCSpeaker(),"QPTag");

iQuestPoints = SQLocalsUUID_GetInt(GetPCSpeaker(),"QuestPoints");

iReturn = TRUE;

if (sTag == "en3_questring")
    iReturn=FALSE;

return iReturn;
}
