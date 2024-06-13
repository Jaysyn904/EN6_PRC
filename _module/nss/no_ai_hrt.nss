//::///////////////////////////////////////////////
//:: On Heartbeat
//::
//:://////////////////////////////////////////////
/*
    This script will have people perform default
    animations.
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default1",OBJECT_SELF);
    } else {

    //if the AI level is very low and the combat AI is not active do nothing
    //need this change so that combat AI can shut itself down properly before ignoring heartbeats
    if ( GetAILevel() == AI_LEVEL_VERY_LOW && !IsActive() )
    {
        return;
    }

    if ( IsActive() )
    {
        //if combat AI is active this is the only segment of the heartbeat that will run
        int iE = GetHostileCount( 50.0 );
        if ( iE == 0 )
        {
            object oA = GetFurthestActiveAlly( 50.0 );
            if ( GetIsObjectValid( oA ) && GetDistanceBetween( OBJECT_SELF, oA ) > 20.0 && !GetIsPerceived( oA ) )
            {
                DoMoveToObject( oA, TRUE );
            }
            else
            {
                ExecuteScript( "no_scr_shutdown", OBJECT_SELF );
            }
        }
    }
    else
    {
        //combat AI isn't active
        if( GetSpawnInCondition( NW_FLAG_DAY_NIGHT_POSTING ) )
        {
            int nDay = FALSE;
            if( GetIsDay() || GetIsDawn() )
            {
                nDay = TRUE;
            }
            if( GetLocalInt( OBJECT_SELF, "NW_GENERIC_DAY_NIGHT" ) != nDay )
            {
                if( nDay == TRUE )
                {
                    SetLocalInt( OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", TRUE );
                }
                else
                {
                    SetLocalInt( OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", FALSE );
                }
                WalkWayPoints();
            }
        }

        if( CanAct() )
        {
            object oE = GetTarget();
            if( !GetIsPostOrWalking() )
            {
                if( !GetIsObjectValid( GetAttemptedAttackTarget() ) && !GetIsObjectValid( GetAttemptedSpellTarget() ) )
                {
                    //if( !GetIsObjectValid( GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN) ) )
                    if ( !GetIsObjectValid( oE ) )
                    {
                        if( /*!GetBehaviorState( NW_FLAG_BEHAVIOR_SPECIAL ) &&*/ !IsInConversation( OBJECT_SELF ) )
                        {
                            if( GetSpawnInCondition( NW_FLAG_AMBIENT_ANIMATIONS ) || GetSpawnInCondition( NW_FLAG_AMBIENT_ANIMATIONS_AVIAN ) )
                            {
                                PlayMobileAmbientAnimations();
                            }
                            else if( GetIsEncounterCreature() )
                                //won't be here unless this next condition is true so it is redundant to check it
                                //!GetIsObjectValid( GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN ) ) )
                            {
                                PlayMobileAmbientAnimations();
                            }
                            else if( GetSpawnInCondition( NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS ) )
                                //won't be in here unless this next condition is true so it is redundant to check it
                                //!GetIsObjectValid( GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN ) ) )
                            {
                                PlayImmobileAmbientAnimations();
                            }
                        }
                        else
                        {
                            DetermineSpecialBehavior();
                        }
                    }
                    else
                    {
                        //DetermineCombatRound()
                        InitCombat();
                    }
                }
            }
        }
        else
        {
            if( GetSpawnInCondition( NW_FLAG_SLEEPING_AT_NIGHT ) )
            {
                effect eVis = EffectVisualEffect( VFX_IMP_SLEEP );
                if( d10() > 6 )
                {
                    ApplyEffectToObject( DURATION_TYPE_INSTANT, eVis, OBJECT_SELF );
                }
            }
        }
    }

    //Signal heart beat event to userdef
    SignalEvent( OBJECT_SELF, EventUserDefined( 1001 ) );

    }
}
