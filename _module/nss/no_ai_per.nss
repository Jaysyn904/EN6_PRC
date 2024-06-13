//::///////////////////////////////////////////////
//:: On Percieve
//::
//:://////////////////////////////////////////////
/*
    Checks to see if the perceived target is an
    enemy and if so fires the Determine Combat
    Round function
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default2",OBJECT_SELF);
    } else {

    object oPer = GetLastPerceived();

    if ( !GetIsObjectValid( oPer ) )
    {
        //invalid object, do nothing
        return;
    }

    //for associates
    if ( !GetLocalInt( OBJECT_SELF, "#ACTIVE" ) && GetIsMaster( oPer ) )
    {
        ActionForceFollowObject( oPer, GetFollowDist() );
    }

    //main
    if ( GetLastPerceptionSeen() && GetIsPerceived( oPer, NO_PERCEPTION_SEEN ) )
    {
        if ( GetIsEnemy( oPer ) && !GetIsDead( oPer ) )
        {
            //trigger combat
            //PrintString( "ENEMY: " + GetName( OBJECT_SELF ) + " -> " + GetName( oPer ) );
            DoVoiceChat( VOICE_CHAT_ENEMIES );
            if ( GetIsFastBuffer() == TRUE && GetIsFastBuffed() == FALSE )
            {
                //only to this once per start up
                ClearAllActions();
                if ( DoFastBuffs() )
                {
                    //PrintString( "FASTBUFF: " + GetName( OBJECT_SELF ) );
                }
                SetIsFastBuffed( TRUE );
            }
            //DoQueueCombat( 8.0, 8.0 );
            DelayCommand( 0.5, InitCombat() );
        }
        else if ( !GetLocalInt( OBJECT_SELF, "#ACTIVE" ) )
        {
            if ( GetIsFriend( oPer ) && GetIsDead( oPer ) && GetHasRaisingAbility() )
            {
                ClearAllActions();
                if ( DoSpellRaise( oPer ) )
                {
                    SetLocalInt( OBJECT_SELF, "#ACTIVE", 1 );
                    DoQueueShutdown( 12.0 );
                }
            }
        }
    }
    else if ( GetLastPerceptionHeard() && GetIsPerceived( oPer, NO_PERCEPTION_HEARD ) )
    {
        if ( !GetIsObjectValid( GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE ) ) )
        {
            if ( GetIsEnemy( oPer ) && GetObjectType( oPer ) == OBJECT_TYPE_CREATURE && !GetIsDead( oPer ) )
            {
                //check perceptions
                if ( !GetIsPerceived( oPer, NO_PERCEPTION_SEEN ) )
                {
                    //heard something that is not visible, no visible enemies, respond
                    //SetLocalInt( OBJECT_SELF, "#VANISHED", 1 );
                    //DoQueueCombat( 8.0, 8.0 );
                    DelayCommand( 0.5, InitCombat() );
                }
            }
        }
    }
    else if ( GetLastPerceptionVanished() && GetIsPerceived( oPer, NO_PERCEPTION_VANISHED ) )
    {
        //make sure it isn't a corpse that just faded out
        //report vanished enemies who have not just died
        if ( GetIsEnemy( oPer ) )
        {
            if( !GetIsDead( oPer ) )
            {
                DoVoiceChat( VOICE_CHAT_CUSS );
                SetLocalInt( OBJECT_SELF, "#VANISHED", 1 );
            }
        }
    }
    //signal perception to userdef
    SignalEvent( OBJECT_SELF, EventUserDefined( 1002 ) );

    }
}

