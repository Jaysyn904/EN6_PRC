//::///////////////////////////////////////////////
//:: On Attacked
//:: NW_C2_DEFAULT5
//:://////////////////////////////////////////////
/*
    Set attacker as an enemy if they are not a friend
    or enemy (ie/ neutral), and initiate combat AI if
    it is not already running.
*/
//:://////////////////////////////////////////////

//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default5",OBJECT_SELF);
    } else {

    object oA = GetLastAttacker();

    if ( GetIsObjectValid( oA ) )
    {
        /*
        if ( GetIsFriend( oA ) )
        {
            PrintString( GetName( OBJECT_SELF ) + " attacked by friend " + GetName( oA ) );
        }
        */
        if ( !GetIsFriend( oA ) && !GetIsEnemy( oA ) && GetMaster( OBJECT_SELF ) != oA )
        {
            //neutrals
            SetIsTemporaryEnemy( oA, OBJECT_SELF, TRUE, 300.0 );
        }
        //DoQueueCombat( 8.0, 8.0 );
        InitCombat();
        SignalEvent(OBJECT_SELF, EventUserDefined(1005));
    }

    }
}
