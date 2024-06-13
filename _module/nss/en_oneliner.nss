#include "NW_I0_GENERIC"

int StartingConditional()
{
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION))
    {
        if(!GetIsObjectValid(GetPCSpeaker()))
        {
            if (GetLocalInt(OBJECT_SELF,"OneLiner") == 0)
                {
                SetLocalInt(OBJECT_SELF,"OneLiner",1);
                SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION,FALSE);
                return TRUE;
                }
        }
    }
    return FALSE;
}

