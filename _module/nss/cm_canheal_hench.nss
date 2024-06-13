#include "nw_i0_generic"
int StartingConditional()
{
    if (GetCurrentHitPoints(OBJECT_SELF) < GetMaxHitPoints(OBJECT_SELF))
    {
        if (GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION001") != OBJECT_INVALID
         || GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION002") != OBJECT_INVALID
         || GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION003") != OBJECT_INVALID
         || GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION012") != OBJECT_INVALID
         || GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION020") != OBJECT_INVALID)
        return TRUE;
    }
    return FALSE;
}
