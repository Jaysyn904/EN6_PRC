//::///////////////////////////////////////////////
//:: On Spell Cast At
//::
//:://////////////////////////////////////////////
/*
    This determines if the spell just cast at the
    target is harmful or not.
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_defaultb",OBJECT_SELF);
    } else {

    int iS = GetLastSpell();
    int iH = GetLastSpellHarmful();
    object oC = GetLastSpellCaster();

    if ( !iH )
    {
        if ( iS == SPELL_RAISE_DEAD || iS == SPELL_RESURRECTION )
        {
            SetCommandable( TRUE, OBJECT_SELF );
            DeleteLocalObject( OBJECT_SELF, "#RAISER" );
        }
        else if ( iS == SPELL_HEAL || iS == SPELL_CURE_CRITICAL_WOUNDS ||
            iS == SPELL_CURE_SERIOUS_WOUNDS || iS == SPELL_CURE_MODERATE_WOUNDS ||
            iS == SPELL_CURE_LIGHT_WOUNDS || iS == SPELL_CURE_MINOR_WOUNDS )
        {
            if ( oC != OBJECT_SELF && GetIsFriend( oC ) )
            {
                DoVoiceChat( VOICE_CHAT_THANKS );
            }
            DeleteLocalObject( OBJECT_SELF, "#HEALER" );
        }
        else if ( iS == SPELL_DARKVISION )
        {
            DeleteLocalInt( OBJECT_SELF, "#DARKNESS" );
            DeleteLocalObject( OBJECT_SELF, "#VISION" );
        }
        else if ( iS == SPELL_SEE_INVISIBILITY )
        {
            DeleteLocalInt( OBJECT_SELF, "#VANISHED" );
            DeleteLocalObject( OBJECT_SELF, "#VISION" );
        }
        else if ( iS == SPELL_TRUE_SEEING )
        {
            DeleteLocalInt( OBJECT_SELF, "#DARKNESS" );
            DeleteLocalInt( OBJECT_SELF, "#VANISHED" );
            DeleteLocalObject( OBJECT_SELF, "#VISION" );
        }
    }
    if ( iS == SPELL_DARKNESS )
    {
        SetLocalInt( OBJECT_SELF, "#DARKNESS", 1 );
    }
    if ( iH )
    {
        if ( !GetIsFriend( oC ) && !GetIsEnemy( oC ) && GetMaster( OBJECT_SELF ) != oC )
        {
            //neutrals
            SetIsTemporaryEnemy( oC, OBJECT_SELF, TRUE, 300.0 );
        }
        //DoQueueCombat( 8.0, 8.0 );
        InitCombat();
    }
    //signal spell at to userdef
    SignalEvent( OBJECT_SELF, EventUserDefined( 1011 ) );

    }
}
