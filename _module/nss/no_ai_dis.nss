//::///////////////////////////////////////////////
//:: Default: On Disturbed
//:: NW_C2_DEFAULT8
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//::///////////////////////////////////////////

// * Make me hostile the faction of my last attacker (TEMP)
//  AdjustReputation(OBJECT_SELF,GetFaction(GetLastAttacker()),-100);
// * Determined Combat Round

/*
NOTE: Blocked to stop interference.
Update coming in next version.
*/

//#include "NW_I0_GENERIC"
#include "no_lib_data"
#include "no_inc"

void main()
{

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default8",OBJECT_SELF);
    } else {

    object oT = GetLastDisturbed();

    if ( GetIsObjectValid( oT ) )
    {
        SetIsTemporaryEnemy( oT, OBJECT_SELF, TRUE, 300.0 );
        //DoQueueCombat( 8.0, 8.0 );
        InitCombat();
        SignalEvent(OBJECT_SELF, EventUserDefined(1008));
    }

    }
}
