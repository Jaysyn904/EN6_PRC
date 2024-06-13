//::///////////////////////////////////////////////
//:: On Conversation
//::
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    by the generic script after dialogue or a
    shout is initiated.
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{
if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default4",OBJECT_SELF);
    } else {

    object oT = OBJECT_INVALID;
    object oM = GetMaster( OBJECT_SELF );
    object oBroadcaster = GetLastSpeaker();
    int iBroadcast = GetListenPatternNumber();
    int iR = 0;

    if ( iBroadcast == -1 )
    {
        ClearAllActions();
        //SetLocalInt( OBJECT_SELF, "#ACTIVE", 1 );
        //ActionStartConversation( oBroadcaster );
        BeginConversation();
        //DoQueueShutdown( 6.0 );
    }
    else
    {
        if ( GetIsObjectValid( oM ) && oBroadcaster == oM )
        {
            if ( iBroadcast == ASSOCIATE_COMMAND_STANDGROUND )
            {
                //stand ground
                SetLocalLocation( OBJECT_SELF, "#SGLOC", GetLocation( OBJECT_SELF ) );
                SetLocalInt( OBJECT_SELF, "#STANDGROUND", 1 );
                ClearAllActions();
                PlayVoiceChat( VOICE_CHAT_TASKCOMPLETE );
                ActionMoveToLocation( GetLocation( OBJECT_SELF ) ); //stop here
            }
            else if ( iBroadcast == ASSOCIATE_COMMAND_ATTACKNEAREST )
            {
                //attack nearest
                DeleteLocalInt( OBJECT_SELF, "#STANDGROUND" );
                oT = GetTarget();
                if ( GetIsObjectValid( oT ) )
                {
                    PlayVoiceChat( VOICE_CHAT_GOODIDEA );
                    //DoQueueCombat( 8.0, 8.0 );
                    InitCombat();
                    SignalEvent( OBJECT_SELF, EventUserDefined( 1003 ) );
                }
                else
                {
                    PlayVoiceChat( VOICE_CHAT_CANTDO );
                }
            }
            else if ( iBroadcast == ASSOCIATE_COMMAND_HEALMASTER )
            {
                //heal master
                DeleteLocalInt( OBJECT_SELF, "#STANDGROUND" );
                if ( DoSpellHeal( oM ) )
                {
                    PlayVoiceChat( VOICE_CHAT_CANDO );
                }
                else
                {
                    PlayVoiceChat( VOICE_CHAT_CANTDO );
                }
            }
            else if ( iBroadcast == ASSOCIATE_COMMAND_FOLLOWMASTER )
            {
                //follow master
                DeleteLocalLocation( OBJECT_SELF, "#STANDGROUND" );
                ClearAllActions();
                ActionForceFollowObject( oM, 3.0 );
            }
            else if ( iBroadcast == ASSOCIATE_COMMAND_GUARDMASTER )
            {
                //guard master
                DeleteLocalInt( OBJECT_SELF, "#STANDGROUND" );
                if ( !GetIsObjectValid( oT = GetLastHostileActor( oM ) ) )
                {
                    if ( !GetIsObjectValid( oT = GetLastAttacker( oM ) ) )
                    {
                        PlayVoiceChat( VOICE_CHAT_CANTDO );
                    }
                }
                //list of actions to try against oT
                if ( GetIsObjectValid( oT ) && ( GetObjectSeen( oT ) || GetObjectHeard( oT ) ) )
                {
                    if ( !( iR = DoSpellDirect( oT ) ) )
                    {
                        if ( !( iR = DoTouch( oT ) ) )
                        {
                            if ( !( iR = DoAttackRanged( oT ) ) )
                            {
                                if ( !( iR = DoAttackMelee( oT ) ) )
                                {
                                    PlayVoiceChat( VOICE_CHAT_CANTDO );
                                }
                            }
                        }
                    }
                    if ( iR )
                    {
                        PlayVoiceChat( VOICE_CHAT_CANDO );
                    }
                }
            }
        }
        if ( iBroadcast == 699 ) //COMBAT going on nearby
        {
            //respond
            if ( GetArea( oBroadcaster ) == GetArea( OBJECT_SELF ) && GetDistanceBetween( oBroadcaster, OBJECT_SELF ) <= GetResponseRange( BC_FIGHTING ) )
            {
                object oE = GetTarget();
                if ( !GetIsObjectValid( oE ) )
                {
                    //I've heard combat but I can't see the combat or any enemies
                    //PrintString( "CHM: " + GetName( OBJECT_SELF ) + " moving to support " + GetName( oBroadcaster ) );
                    DoMoveToObject( oBroadcaster, TRUE, 5.0 );
                    DoFightBroadcast();
                }
                else
                {
                    //DoQueueCombat( 8.0, 8.0 );
                    InitCombat();
                }
            }
            else
            {
                //hearing something from another area or from out of our response range
                //SpeakString( "Ignoring combat sounds" );
            }
        }
        else if ( iBroadcast == 691 ) //DEAD
        {
            //if ( GetIsFriend( oBroadcaster ) )
            if ( GetFactionEqual( oBroadcaster ) )
            {
                DoVoiceChat( VOICE_CHAT_CUSS );
            }
            else if ( GetIsEnemy( oBroadcaster ) )
            {
                if ( Random( 2 ) )
                {
                    DoVoiceChat( VOICE_CHAT_CHEER );
                }
                else
                {
                    DoVoiceChat( VOICE_CHAT_LAUGH );
                }
            }
        }
    }
    //signal conversation to userdef
    SignalEvent( OBJECT_SELF, EventUserDefined( 1004 ) );

    }
}
