//::///////////////////////////////////////////////
//:: End of Combat Round
//::
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default3",OBJECT_SELF);
    } else {
    //SetReadyStatus();
    //DoCombat();
    InitCombat();
    //signal combat to userdef
    SignalEvent( OBJECT_SELF, EventUserDefined( 1003 ) );
    }
}
