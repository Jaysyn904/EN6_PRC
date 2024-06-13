#include "en5_include"

int StartingConditional()
{
    int iResult;

    iResult = FALSE;
    if (GetLocalInt(OBJECT_SELF,"HenchmanClass") == EN5_CLASS_PALEMASTER && GetHitDice(OBJECT_SELF)>13 && GetLocalInt(OBJECT_SELF,"ANIMATE_DEAD") == 0)
        iResult=TRUE;

    iResult = FALSE;
    return iResult;
}
