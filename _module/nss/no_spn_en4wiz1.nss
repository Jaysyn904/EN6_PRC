//::///////////////////////////////////////////////
//:: On Spawn In
//::
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    after having just been spawned in
*/
//:://////////////////////////////////////////////

#include "no_lib_data"
#include "no_inc"
#include "nw_o2_coninclude"
#include "x0_i0_treasure"

void main()
{

if (GetLocalInt(GetModule(),"NoAI") == 1)
    SetLocalInt(OBJECT_SELF,"NoAI",1);

if (GetLocalInt(OBJECT_SELF,"NoAI") == 1)
    {
    ExecuteScript("en3_boss_spawn",OBJECT_SELF);
    } else {

    //Behaviour config
    AddBehaviour( "+AVOIDMELEE",    30 + Random(40) );   //avoid melee
    AddBehaviour( "+EVACAOE",       50 + Random(40));   //evac AOEs
    AddBehaviour( "+HEALSELF",      100 );  //heal self
    AddBehaviour( "+REGROUP",       10 + Random(30));   //regroup
    AddBehaviour( "+SUMMON",        40 + Random(20));   //summon spells
    AddBehaviour( "+EN4INVIS",   50 );

    if (Random(3)==0)
        AddBehaviour( "+EN4DMGSHIELD",   80 );
    else
        AddBehaviour( "+EN4DMGSHIELD",   25 );

    if (Random(3) == 0)
        {
    AddBehaviour( "+BREACH",        10 + Random(20));   //breach
    AddBehaviour( "+AREA",          60 + Random(30));   //area attack spells
    AddBehaviour( "+DIRECT",        60 + Random(30));   //direct attack spells
    AddBehaviour( "+HELP",          50 );   //help
    AddBehaviour( "+VIS",           50 );   //vision
    AddBehaviour( "+DEFSELF",       10 );   //defend self
    AddBehaviour( "+DEFSING",       5 );    //defend single
    AddBehaviour( "+ENHANCESELF",   10 + Random(40));   //enhance self
    AddBehaviour( "+GROUPENHANCE",  5 + Random(15));    //enhance group
    AddBehaviour( "+ENHANCESING",   5 + Random(15));    //enhance single
    AddBehaviour( "+FEATENHANCE",   10 );   //enhance self via feats
    AddBehaviour( "+DISPEL",        10 );   //dispel single
    AddBehaviour( "+DISPELAOE",     10 );   //dispel AOEs
    AddBehaviour( "+DISMISSAL",     10 + Random(10));   //dismiss summons
    AddBehaviour( "+TIMESTOP",      10 );   //time stop
    AddBehaviour( "+TOUCH",         40 + Random(30));   //touch attack spells
        } else {
    AddBehaviour( "+HELP",          50 );   //help
    AddBehaviour( "+VIS",           50 );   //vision
    AddBehaviour( "+DEFSELF",       10 );   //defend self
    AddBehaviour( "+DEFSING",       5 );    //defend single
    AddBehaviour( "+ENHANCESELF",   20 + Random(40));   //enhance self
    AddBehaviour( "+GROUPENHANCE",  5 + Random(35));    //enhance group
    AddBehaviour( "+ENHANCESING",   5 + Random(35));    //enhance single
    AddBehaviour( "+FEATENHANCE",   10 );   //enhance self via feats
    AddBehaviour( "+DISPEL",        10 );   //dispel single
    AddBehaviour( "+DISPELAOE",     10 );   //dispel AOEs
    AddBehaviour( "+DISMISSAL",     10 + Random(10));   //dismiss summons
    AddBehaviour( "+BREACH",        10 + Random(20));   //breach
    AddBehaviour( "+AREA",          60 + Random(30));   //area attack spells
    AddBehaviour( "+DIRECT",        60 + Random(30));   //direct attack spells
    AddBehaviour( "+TIMESTOP",      10 );   //time stop
    AddBehaviour( "+TOUCH",         40 + Random(30));   //touch attack spells
        }
    AddBehaviour( "+ATKRANGED",     100 );  //ranged attack
    AddBehaviour( "+ATKMELEE",      100 );

    //Other config
    //Corpse decay set up and exclusions
    SetCorpseDelay();

    //Set whether the creature can use EffectDisappearAppear when moving
    SetIsFlier();

    if ( GetIsObjectValid( GetMaster( OBJECT_SELF ) ) )
    {
        //I am probably a summoned creature, possibly a henchman
        SetAssociateListenPatterns();
    }

    //set voice chat config
    SetVoiceChat( NO_VC_DEFAULT, 10 );

    //configure perception ranges
    SetPerceptionRanges();

    //set response range for fighting broadcast
    SetResponseRange( BC_FIGHTING, 50.0 );

    //tell creature it is ready to act
    //SetReadyStatus();

    //set fastbuffer status, should always be left on
    SetIsFastBuffer( TRUE );

    AddFastBuff( SPELL_MAGE_ARMOR );

/*
    if (Random(2)==0 || GetHitDice(OBJECT_SELF)>15)
        {
        if (GetHasSpell(SPELL_PREMONITION) > 0)
            AddFastBuff( SPELL_PREMONITION );
        else if (GetHasSpell(SPELL_GREATER_STONESKIN) > 0)
            AddFastBuff( SPELL_GREATER_STONESKIN );
        else if (GetHasSpell(SPELL_STONESKIN) > 0)
            AddFastBuff( SPELL_STONESKIN );
        else if (GetHasSpell(SPELL_GHOSTLY_VISAGE) > 0)
            AddFastBuff( SPELL_GHOSTLY_VISAGE );
        }
*/
    //This allows liches or other high lvl undead to automatically have mean shield up
//    if (GetHasSpell(SPELL_MESTILS_ACID_SHEATH) && GetRacialType(OBJECT_SELF) == RACIAL_TYPE_UNDEAD)
//        AddFastBuff(SPELL_MESTILS_ACID_SHEATH);
    //SetLocalInt( OBJECT_SELF, "#FASTBUFFER", 1 );
    //SetLocalInt( OBJECT_SELF, "#ACTIVE", 1 );

    //log starting location
    ExecuteScript( "no_scr_logspnloc", OBJECT_SELF );

    //log loaded melee weapons
    DelayCommand(3.0f,ExecuteScript( "no_scr_logeq", OBJECT_SELF ));

    // OPTIONAL BEHAVIORS (Comment In or Out to Activate ) ****************************************************************************
    //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
    //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
        // This causes the creature to say a special greeting in their conversation file
        // upon Perceiving the player. Attach the [NW_D2_GenCheck.nss] script to the desired
        // greeting in order to designate it. As the creature is actually saying this to
        // himself, don't attach any player responses to the greeting.

    //SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
        // This will set the listening pattern on the NPC to attack when allies call
    //SetSpawnInCondition(NW_FLAG_STEALTH);
        // If the NPC has stealth and they are a rogue go into stealth mode
    //SetSpawnInCondition(NW_FLAG_SEARCH);
        // If the NPC has Search go into Search Mode
    //SetSpawnInCondition(NW_FLAG_SET_WARNINGS);
        // This will set the NPC to give a warning to non-enemies before attacking

    //SetSpawnInCondition(NW_FLAG_SLEEP);
        //Creatures that spawn in during the night will be asleep.
    //SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);
    //SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
    //SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    if (Random(4)==0)
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    // SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);
    SetAnimationCondition(NW_ANIM_FLAG_CONSTANT);
    // SetAnimationCondition(NW_ANIM_FLAG_CHATTER);
    // SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);
        //This will play Ambient Animations until the NPC sees an enemy or is cleared.
    //NOTE that these animations will play automatically for Encounter Creatures.

    // NOTE: ONLY ONE OF THE FOLOOWING ESCAPE COMMANDS SHOULD EVER BE ACTIVATED AT ANY ONE TIME.
    //SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);    // OPTIONAL BEHAVIOR (Flee to a way point and return a short time later.)
    //SetSpawnInCondition(NW_FLAG_ESCAPE_LEAVE);     // OPTIONAL BEHAVIOR (Flee to a way point and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_LEAVE);   // OPTIONAL BEHAVIOR (Teleport to safety and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);  // OPTIONAL BEHAVIOR (Teleport to safety and return a short time later.)

    // CUSTOM USER DEFINED EVENTS
    /*
    The following settings will allow the user to fire one of the blank user defined events in the NW_D2_DefaultD.  Like the
    On Spawn In script this script is meant to be customized by the end user to allow for unique behaviors.  The user defined
    events user 1000 - 1010
    */
    //SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007

    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.

int iRandom;
iRandom = Random(100)+1;
if (iRandom<94)
    DelayCommand(1.0f,CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF));
else if (iRandom<97)
    DelayCommand(1.0f,CTG_GenerateNPCTreasure(TREASURE_TYPE_MED, OBJECT_SELF));
else if (iRandom<100)
    DelayCommand(1.0f,CTG_GenerateNPCTreasure(TREASURE_TYPE_HIGH, OBJECT_SELF));
else
    DelayCommand(1.0f,CTG_GenerateNPCTreasure(TREASURE_TYPE_UNIQUE, OBJECT_SELF));

    }
}
