//::///////////////////////////////////////////////
//:: On Death
//::
//:://////////////////////////////////////////////
/*
    Shouts to allies that they have been killed
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"

void main()
{
ExecuteScript("nw_c2_default7",OBJECT_SELF);
/*
if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("nw_c2_default7",OBJECT_SELF);
    } else {

    //float fDieDelay = GetLocalFloat( OBJECT_SELF, "#DECAYDELAY" );
    //corpse decay deactivated for Murray module
    float fDieDelay = 10.0;

    ClearAllActions();
    //broadcast death
    SpeakString( "BC_DEAD", TALKVOLUME_SILENT_TALK );
    //PrintString( GetName( OBJECT_SELF ) + " killed by " + GetName( GetLastKiller() ) );
    if ( GetName( GetItemInSlot( INVENTORY_SLOT_CARMOUR, OBJECT_SELF ) ) == "Balor Properties" )
    {
        ExecuteScript( "nw_s3_balordeth", OBJECT_SELF );
    }
    DelayCommand( fDieDelay, ExecuteScript( "no_scr_cleanvars", OBJECT_SELF ) );
    DelayCommand( fDieDelay + 0.5, ExecuteScript( "no_scr_excorpse", OBJECT_SELF ) );
    //signal death to userdef
    SignalEvent( OBJECT_SELF, EventUserDefined( 1007 ) );

    ExecuteScript("en4_mobdeath",OBJECT_SELF);

    }
*/
}

