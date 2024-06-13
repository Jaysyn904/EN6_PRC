//::///////////////////////////////////////////////
//:: On Damaged
//::
//:://////////////////////////////////////////////
/*
    Set damager as an enemy if they are not a friend
    or enemy (ie/ neutral), and initiate combat AI if
    it is not already running.
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default6",OBJECT_SELF);
    } else {

    float fHP;
    object oDam = GetLastDamager();
    object oT = OBJECT_INVALID;

    //if timestamp has elapsed and there is a friendly nearby
    if ( !GetLocalInt( OBJECT_SELF, "#HEALDEL" ) &&
        GetIsObjectValid( GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE ) ) )
    {
        fHP = IntToFloat( GetCurrentHitPoints( OBJECT_SELF ) ) / GetMaxHitPoints( OBJECT_SELF );
        //only start calling for healing once we've taken 50%
        if ( fHP < 0.51 )
        {
            //broadcast request for healing for display purposes
            DoVoiceChat( VOICE_CHAT_HEALME );
            //do not broadcast again until next combat round event when this int is cleared
            SetLocalInt( OBJECT_SELF, "#HEALDEL", 1 );
            DelayCommand( 3.0, DeleteLocalInt( OBJECT_SELF, "#HEALDEL" ) );
        }
    }
    if ( GetIsObjectValid( oDam ) )
    {
        /*
        if ( GetIsFriend( oDam ) )
        {
            PrintString( GetName( OBJECT_SELF ) + " damaged by friend " + GetName( oDam ) );
        }
        */
        if ( !GetIsFriend( oDam ) && !GetIsEnemy( oDam ) && GetMaster( OBJECT_SELF ) != oDam )
        {
            //neutrals
            SetIsTemporaryEnemy( oDam, OBJECT_SELF, TRUE, 300.0 );
        }
        //DoQueueCombat( 8.0, 8.0 );
        InitCombat();
        //signal damage to userdef
        SignalEvent( OBJECT_SELF, EventUserDefined( 1006 ) );
    }

    }
}
