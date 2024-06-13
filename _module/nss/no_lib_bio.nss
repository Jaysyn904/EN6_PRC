/*
====================
A subset of the Bioware functions included for use without including all of them.
Some changes have been made to these functions where necessary.
====================
*/

#include "x0_i0_behavior"
#include "x0_i0_modes"
#include "x0_i0_position"
#include "x0_i0_voice"
#include "no_inc_ptypes"

//Master Constants
int NW_FLAG_SPECIAL_CONVERSATION        = 0x00000001;
int NW_FLAG_SHOUT_ATTACK_MY_TARGET      = 0x00000002;
int NW_FLAG_STEALTH                     = 0x00000004;
int NW_FLAG_SEARCH                      = 0x00000008;
int NW_FLAG_SET_WARNINGS                = 0x00000010;
int NW_FLAG_ESCAPE_RETURN               = 0x00000020; //Failed
int NW_FLAG_ESCAPE_LEAVE                = 0x00000040;
int NW_FLAG_TELEPORT_RETURN             = 0x00000080; //Failed
int NW_FLAG_TELEPORT_LEAVE              = 0x00000100;
int NW_FLAG_PERCIEVE_EVENT              = 0x00000200;
int NW_FLAG_ATTACK_EVENT                = 0x00000400;
int NW_FLAG_DAMAGED_EVENT               = 0x00000800;
int NW_FLAG_SPELL_CAST_AT_EVENT         = 0x00001000;
int NW_FLAG_DISTURBED_EVENT             = 0x00002000;
int NW_FLAG_END_COMBAT_ROUND_EVENT      = 0x00004000;
int NW_FLAG_ON_DIALOGUE_EVENT           = 0x00008000;
int NW_FLAG_RESTED_EVENT                = 0x00010000;
int NW_FLAG_DEATH_EVENT                 = 0x00020000;
int NW_FLAG_SPECIAL_COMBAT_CONVERSATION = 0x00040000;
int NW_FLAG_AMBIENT_ANIMATIONS          = 0x00080000;
int NW_FLAG_HEARTBEAT_EVENT             = 0x00100000;
int NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS = 0x00200000;
int NW_FLAG_DAY_NIGHT_POSTING           = 0x00400000;
int NW_FLAG_AMBIENT_ANIMATIONS_AVIAN    = 0x00800000;
int NW_FLAG_APPEAR_SPAWN_IN_ANIMATION   = 0x01000000;
int NW_FLAG_SLEEPING_AT_NIGHT           = 0x02000000;
int NW_FLAG_FAST_BUFF_ENEMY             = 0x04000000;

//Additional constants for SoU animation craziness
const int CLEAR_DEBUG = FALSE;

string sAnimCondVarname = "NW_ANIM_CONDITION";

float ANIM_LOOPING_LENGTH = 4.0;
float ANIM_LOOPING_SPEED = 1.0;

string ANIM_CONVERSATION = "x0_npc_homeconv";

int NW_ANIM_FLAG_INITIALIZED             = 0x00000001;
int NW_ANIM_FLAG_CONSTANT                = 0x00000002;
int NW_ANIM_FLAG_CHATTER                 = 0x00000004;
int NW_ANIM_FLAG_IS_ACTIVE               = 0x00000008;
int NW_ANIM_FLAG_IS_INTERACTING          = 0x00000010;
int NW_ANIM_FLAG_IS_INSIDE               = 0x00000020;
int NW_ANIM_FLAG_HAS_HOME                = 0x00000040;
int NW_ANIM_FLAG_IS_TALKING              = 0x00000080;
int NW_ANIM_FLAG_IS_MOBILE               = 0x00000100;
int NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE   = 0x00000200;
int NW_ANIM_FLAG_IS_CIVILIZED            = 0x00000400;
int NW_ANIM_FLAG_CLOSE_DOORS             = 0x00001000;

const int CLEAR_NW_I0_GENERIC_DetermineSpecialBehavior1 = 11;
const int CLEAR_NW_I0_GENERIC_DetermineSpecialBehavior2 = 12;
const int CLEAR_X0_I0_ANIMS_PlayMobile = 16;
const int CLEAR_X0_I0_ANIMS_PlayRandomMobile = 17;
const int CLEAR_X0_I0_ANIMS_PlayRandomCloseRange1 = 18;
const int CLEAR_X0_I0_ANIMS_PlayRandomCloseRange2 = 19;
const int CLEAR_X0_I0_ANIMS_AnimActionPlayRandomMobile1 = 20;
const int CLEAR_X0_I0_ANIMS_AnimActionPlayRandomMobile2 = 21;
const int CLEAR_X0_I0_ANIMS_AnimActionPlayRandomUncivilized =22;
const int CLEAR_X0_I0_ANIMS_AnimActionGetUpFromChair = 23;
const int CLEAR_X0_I0_ANIMS_AnimActionGoToStop = 24;
const int CLEAR_X0_I0_ANIMS_AnimActionRest1 = 25;
const int CLEAR_X0_I0_ANIMS_AnimActionRest2 = 26;
const int CLEAR_X0_I0_ANIMS_GoHome = 27;
const int CLEAR_X0_I0_ANIMS_AnimActionLeaveHome = 28;
const int CLEAR_X0_I0_ANIMS_AnimActionChallengeIntruder = 29;

//::///////////////////////////////////////////////
//:: Master Local Get and Set
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All On Spawn in conditions in the game are now
    being stored within one local.  The get and set
    changed or checks the condition of this one
    Hex local.  The NW_FLAG_XXX variables above
    allow for the user of these functions throughout
    the generic scripts.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 14, 2001
//:://////////////////////////////////////////////

void SetSpawnInCondition(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetSpawnInLocals(nCondition);
        SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", nPlot);
    }
}

int GetSpawnInCondition(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

void SetSpawnInLocals(int nCondition)
{
    if(nCondition == NW_FLAG_SHOUT_ATTACK_MY_TARGET)
    {
        SetListenPattern(OBJECT_SELF, "NW_ATTACK_MY_TARGET", 5);
    }
    else if(nCondition == NW_FLAG_ESCAPE_RETURN)
    {
        SetLocalLocation(OBJECT_SELF, "NW_GENERIC_START_POINT", GetLocation(OBJECT_SELF));
    }
    else if(nCondition == NW_FLAG_TELEPORT_LEAVE)
    {
        SetLocalLocation(OBJECT_SELF, "NW_GENERIC_START_POINT", GetLocation(OBJECT_SELF));
    }
}

//::///////////////////////////////////////////////
//:: SetListeningPatterns
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the correct listen checks on the NPC by
    determining what talents they possess or what
    class they use.

    This is also a good place to set up all of
    the sleep and appear disappear animations for
    various models.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////

void SetListeningPatterns()
{
    if(GetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION))
    {
        effect eAppear = EffectAppear();
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAppear, OBJECT_SELF);
    }

    SetListening(OBJECT_SELF, TRUE);

    //NO: Broadcast listen patterns
    SetListenPattern( OBJECT_SELF, "BC_DEAD", 691 );
    SetListenPattern( OBJECT_SELF, "BC_FIGHTING", 699 );

    SetListenPattern(OBJECT_SELF, "NW_I_WAS_ATTACKED", 1);

    //This sets the commoners listen pattern to mob under
    //certain conditions
    if(GetLevelByClass(CLASS_TYPE_COMMONER) > 0)
    {
        SetListenPattern(OBJECT_SELF, "NW_MOB_ATTACK", 2);
    }
    SetListenPattern(OBJECT_SELF, "NW_I_AM_DEAD", 3);

    SetListenPattern(OBJECT_SELF, "inventory",101);

    //Set a custom listening pattern for the creature so that placables with
    //"NW_BLOCKER" + Blocker NPC Tag will correctly call to their blockers.
    string sBlocker = "NW_BLOCKER_BLK_" + GetTag(OBJECT_SELF);
    SetListenPattern(OBJECT_SELF, sBlocker, 4);
    SetListenPattern(OBJECT_SELF, "NW_CALL_TO_ARMS", 6);
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//
//WAY POINT WALK FUNCTIONS
//
//************************************************************************************************************************************
//************************************************************************************************************************************

//::///////////////////////////////////////////////
//:: Walk Way Point Path
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows specified person walk a waypoint path
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)  //Run first circuit
{
    ClearAllActions();
    string DayWayString;
    string NightWayString;
    string DayPostString;
    string NightPostString;
    string sWay;
    string sPost;

    //The block of code below deals with night and day cycle for postings and walkway points.
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        DayWayString = "WP_";
        NightWayString = "WN_";
        DayPostString = "POST_";
        NightPostString = "NIGHT_";
    }
    else
    {
        DayWayString = "WP_";
        NightWayString = "WP_";
        DayPostString = "POST_";
        NightPostString = "POST_";
    }

    if(GetIsDay() || GetIsDawn())
    {
        SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX", DayWayString);
        SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_PREFIX", DayPostString);
    }
    else
    {
        SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX", NightWayString);
        SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_PREFIX", NightPostString);
    }


    sWay = GetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX");
    sPost = GetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_PREFIX");

    //I have now determined what the prefixs for the current walkways and postings are and will use them instead
    // of POST_ and WP_

    if(GetSpawnInCondition(NW_FLAG_STEALTH))
    {
        //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Attempting to Activate Stealth");
        ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    }
    if(GetSpawnInCondition(NW_FLAG_SEARCH))
    {
        //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Attempting to Activate Search");
        ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
    }

    //Test if OBJECT_SELF has waypoints to walk
    string sWayTag = GetTag( OBJECT_SELF );
    sWayTag = sWay + sWayTag + "_01";
    object oWay1 = GetNearestObjectByTag(sWayTag);
    if(!GetIsObjectValid(oWay1))
    {
        oWay1 = GetObjectByTag(sWayTag);
    }
    if(GetIsObjectValid(oWay1) && GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS))
    {
        //turn off the ambient animations if the creature should walk way points.
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE);
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, FALSE);
    }

    if(GetIsObjectValid(oWay1))
    {
        int nNth = 1;
        int nTens;
        int nNum;
        object oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, nNth);
        while (GetIsObjectValid(oNearest))
        {
           string sNearestTag = GetTag(oNearest);
           //removes the first 3 and last three characters from the waypoint's tag
           //and checks it against his own tag.  Waypoint tag format is WP_MyTag_XX.
           if( GetSubString( sNearestTag, 3, GetStringLength( sNearestTag ) - 6 ) == GetTag( OBJECT_SELF ) )
           {
                string sTens = GetStringRight(GetTag(oNearest),2);
                nTens = StringToInt(sTens)/10;
                nNum= StringToInt(GetStringRight(GetTag(oNearest),1));
                oNearest = OBJECT_INVALID;
           }
           else
           {
               nNth++;
               oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT,OBJECT_SELF,nNth);
           }
        }
        RunCircuit(nTens, nNum, nRun, fPause); //***************************************
        ActionWait(fPause);
        ActionDoCommand(RunNextCircuit(nRun, fPause));
        //ActionDoCommand(SignalEvent(OBJECT_SELF,EventUserDefined(2)));
    }
    else
    {
        sWayTag = GetTag( OBJECT_SELF );
        sWayTag = sPost + sWayTag;
        oWay1 = GetNearestObjectByTag(sWayTag);
        if(!GetIsObjectValid(oWay1))
        {
            oWay1 = GetObjectByTag(sWayTag);
        }

        if(GetIsObjectValid(oWay1))
        {
            ActionForceMoveToObject(oWay1, nRun, 1.0, 60.0);
            float fFacing = GetFacing(oWay1);
            ActionDoCommand(SetFacing(fFacing));
        }
    }
    if(GetIsObjectValid(oWay1) && GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS))
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE);
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, FALSE);
    }
}

void RunNextCircuit(int nRun = FALSE, float fPause = 1.0)
{
    RunCircuit(0,1, nRun, fPause);  //***************************************
    ActionWait(fPause);
    ActionDoCommand(RunNextCircuit(nRun, fPause));
    //ActionDoCommand(SignalEvent(OBJECT_SELF,EventUserDefined(2)));
}

//::///////////////////////////////////////////////
//:: Run Circuit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the proper path to follow along a
    predetermined set of way points
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0)
{
    // starting at a given way point, move sequentialy through incrementally
    // increasing points until there are no more valid ones.
    string sWay = GetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_PREFIX");

    object oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));

    while(GetIsObjectValid(oTargetPoint))
    {
        ActionWait(fPause);
        ActionMoveToObject(oTargetPoint, nRun);
        nNum++;
        if (nNum > 9)
        {
            nTens++;
            nNum = 0;
        }
        oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
    }
    // once there are no more waypoints available, decriment back to the last
    // valid point.
    nNum--;
    if (nNum < 0)
    {
        nTens--;
        nNum = 9;
    }

    // start the cycle again going back to point 01
    oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
    while(GetIsObjectValid(oTargetPoint))
    {
        ActionWait(fPause);
        ActionMoveToObject(oTargetPoint, nRun);
        nNum--;
        if (nNum < 0)
        {
            nTens--;
            nNum = 9;
        }
        oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
    }
}

//::///////////////////////////////////////////////
//:: Check Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks the passed in object to
    see if they are supposed to be walking to
    day or night postings.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 26, 2002
//:://////////////////////////////////////////////

int CheckWayPoints(object oWalker = OBJECT_SELF)
{
    object oWay1;
    object oWay2;
    object oWay3;
    object oWay4;
    string sTag = GetTag(oWalker);
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        oWay2 = GetWaypointByTag("NIGHT_" + sTag);
        oWay4 = GetWaypointByTag("WN_" + sTag + "_01");
    }

    oWay1 = GetWaypointByTag("POST_" + sTag);
    oWay3 = GetWaypointByTag("WP_" + sTag + "_01");

    if(GetIsObjectValid(oWay2) || GetIsObjectValid(oWay4) || GetIsObjectValid(oWay1) || GetIsObjectValid(oWay3))
    {

        return TRUE;
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Check for Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks if the passed in object
    has waypoints using their tag.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: MAy 13, 2002
//:://////////////////////////////////////////////
/*
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        DayWayString = "WP_";
        NightWayString = "WN_";
        DayPostString = "POST_";
        NightPostString = "NIGHT_";
    }
    else
    {
        DayWayString = "WP_";
        NightWayString = "WP_";
        DayPostString = "POST_";
        NightPostString = "POST_";
    }
*/
int GetIsPostOrWalking(object oWalker = OBJECT_SELF)
{
    string sTag = GetTag(oWalker);

    object oPost = GetWaypointByTag("POST_" + sTag);
    if(!GetIsObjectValid(oPost))
    {
        oPost = GetWaypointByTag("NIGHT_" + sTag);
        if(!GetIsObjectValid(oPost))
        {
            oPost = GetWaypointByTag("WP_" + sTag + "_01");
            if(!GetIsObjectValid(oPost))
            {
                oPost = GetWaypointByTag("WN_" + sTag + "_01");
                if(!GetIsObjectValid(oPost))
                {
                    return FALSE;
                }
            }
        }
    }
    return TRUE;
}

//:://////////////////////////////////////////////////////////////////////////////////////////////
//:: Special Behavior Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://///////////////////////////////////////////////////////////////////////////////////////////
/*
    These commands handle the setting and getting of the Behavioral Master
    If these special behaviors are used they will override the normal behavior expected
    the animals normal Neutral Faction.
*/
//:://///////////////////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 10, 2001
//:://///////////////////////////////////////////////////////////////////////////////////////////
/*
void SetBehaviorState(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER");
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER", nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER", nPlot);
    }
}

int GetBehaviorState(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER");
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}
*/

//::///////////////////////////////////////////////
//:: Play Mobile Ambient Animations
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used for spawned creatures to not look like
    zombies
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

void PlayMobileAmbientAnimations()
{
    if(!GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)) {
        // not a bird
        PlayMobileAmbientAnimations_NonAvian();
    } else {
        // a bird
        PlayMobileAmbientAnimations_Avian();
    }
}

//::///////////////////////////////////////////////
//:: Determine Special Behavior
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the special behavior used by the NPC.
    Generally all NPCs who you want to behave differently
    than the defualt behavior.
    For these behaviors, passing in a valid object will
    cause the creature to become hostile the the attacker.

    MODIFIED February 7 2003:
    - Rearranged logic order a little so that the creatures
    will actually randomwalk when not fighting
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 14, 2001
//:://////////////////////////////////////////////

void DetermineSpecialBehavior(object oIntruder = OBJECT_INVALID)
{
    //object oTarget = GetNearestSeenEnemy();
    object oTarget = GetTarget();
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE))
    {
        int bAttack = FALSE;
        if(!GetIsObjectValid(oIntruder))
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttackTarget()))
            {
                if(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 8.0)
                {
                    if(GetIsEnemy(oTarget))
                    {
                        if(GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 && GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0)
                        {
                            SetIsTemporaryEnemy(oTarget, OBJECT_SELF, FALSE, 20.0);
                            bAttack = TRUE;
                            //DetermineCombatRound(oTarget);
                            InitCombat(oTarget);
                        }
                    }
                }
            }
        }
        else if(!IsInConversation(OBJECT_SELF))
        {
            bAttack = TRUE;
            //DetermineCombatRound(oIntruder);
            InitCombat(oIntruder);
        }

        // * if not attacking, the wander
        if (bAttack == FALSE)
        {
            ClearActions(CLEAR_NW_I0_GENERIC_DetermineSpecialBehavior1);
            ActionRandomWalk();
            return;
        }
    }
    else if(GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
    {
        if(!GetIsObjectValid(GetAttemptedAttackTarget()) &&
           !GetIsObjectValid(GetAttemptedSpellTarget()) &&
           !GetIsObjectValid(GetAttackTarget()))
        {
            if(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 6.0)
            {
                if(!GetIsFriend(oTarget))
                {
                    if(GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 && GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0)
                    {
                        //TalentFlee(oTarget);
                        DoAvoidEnemies();
                    }
                }
            }
        }
        else if(!IsInConversation(OBJECT_SELF))
        {
            ClearActions(CLEAR_NW_I0_GENERIC_DetermineSpecialBehavior2);
            ActionRandomWalk();
            return;
        }
    }
}

//::///////////////////////////////////////////////
//:: ClearActions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a wrapper for ClearAllActions.
    Added to try and track down some bugs in
    the AI.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: February 6, 2003
//:://////////////////////////////////////////////
void ClearActions(int nClearConstant=0, int bClearCombat=FALSE)
{
    // SpeakString ("Clearing Action # " + IntToString(bClearConstant));
    if (CLEAR_DEBUG == TRUE)
    {
        SpeakString("Clearing all actions in State # " + IntToString(nClearConstant));
    }
    ClearAllActions(bClearCombat);
}

/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

// Debugging function. Will be commented out for final.
void AnimDebug(string sMsg)
{
    //ActionSpeakString("ANIM: " + GetName(OBJECT_SELF) + " " + sMsg);
    //SpeakString("ANIM: " + GetName(OBJECT_SELF) + " " + sMsg);
    //PrintString("ANIM: " + GetName(OBJECT_SELF) + ": " + sMsg);
}

// TRUE if the given creature has the given condition set
int GetAnimationCondition(int nCondition, object oCreature=OBJECT_SELF)
{
    return (GetLocalInt(oCreature, sAnimCondVarname) & nCondition);
}

// Mark that the given creature has the given condition set
void SetAnimationCondition(int nCondition, int bValid=TRUE, object oCreature=OBJECT_SELF)
{
    int nCurrentCond = GetLocalInt(oCreature, sAnimCondVarname);
    if (bValid) {
        SetLocalInt(oCreature, sAnimCondVarname, nCurrentCond | nCondition);
    } else {
        SetLocalInt(oCreature, sAnimCondVarname, nCurrentCond & ~nCondition);
    }
}

// Returns TRUE if the creature is busy talking or interacting
// with a placeable.
int GetIsBusyWithAnimation(object oCreature)
{
    int bReturn = GetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, oCreature)
        || GetAnimationCondition(NW_ANIM_FLAG_IS_INTERACTING, oCreature)
        || GetCurrentAction(oCreature) != ACTION_INVALID;

//    if (bReturn == TRUE)     AssignCommand(oCreature, SpeakString("Busy with anim"));
    return bReturn;
}

// Get a random nearby friend within the specified distance limit,
// that isn't busy doing something else.
object GetRandomFriend(float fMaxDistance)
{
    object oFriend = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                                        REPUTATION_TYPE_FRIEND,
                                        OBJECT_SELF, d2(),
                                        CREATURE_TYPE_PERCEPTION,
                                        PERCEPTION_SEEN);

    if (GetIsObjectValid(oFriend)
        && !GetIsPC(oFriend)
        //&& !GetIsBusyWithAnimation(oFriend) BK Feb 2003: There's not enough talking happening
        && GetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE, oFriend)
        && !IsInConversation(oFriend)
        && !GetIsInCombat(oFriend)
        && GetDistanceToObject(oFriend) <= fMaxDistance)
    {
        return oFriend;
    }

    return OBJECT_INVALID;
}

// Get a random nearby object within the specified distance with
// the specified tag.
object GetRandomObjectByTag(string sTag, float fMaxDistance)
{
    int nNth;
    if (fMaxDistance == DISTANCE_SHORT) {
        nNth = d2();
    } else if (fMaxDistance == DISTANCE_MEDIUM) {
        nNth = d4();
    } else {
        nNth = d6();
    }
    object oObj = GetNearestObjectByTag(sTag, OBJECT_SELF, nNth);
    if (GetIsObjectValid(oObj) && GetDistanceToObject(oObj) <= fMaxDistance)
        return oObj;
    return OBJECT_INVALID;
}

// Get a random nearby object within the specified distance with
// the specified type.
// nObjType: Any of the OBJECT_TYPE_* constants
object GetRandomObjectByType(int nObjType, float fMaxDistance)
{
    int nNth;
    if (fMaxDistance == DISTANCE_SHORT) {
        nNth = d2();
    } else if (fMaxDistance == DISTANCE_LARGE) {
        nNth = d4();
    } else {
        nNth = d6();
    }
    AnimDebug("looking for random object: " + IntToString(nNth));
    object oObj = GetNearestObject(nObjType, OBJECT_SELF, nNth);
    if (GetIsObjectValid(oObj) && GetDistanceToObject(oObj) <= fMaxDistance)
        return oObj;
    return OBJECT_INVALID;
}

// Get a random "NW_STOP" object in the area.
// If fMaxDistance is non-zero, will return OBJECT_INVALID
// if the stop is too far away.
// The first time this is called in a given area, it cycles
// through all the stops in the area and stores them.
object GetRandomStop(float fMaxDistance)
{
    object oStop;
    object oArea = GetArea(OBJECT_SELF);
    if (! GetLocalInt(oArea, "ANIM_STOPS_INITIALIZED") ) {
        AnimDebug("Initializing stops in area " + GetName(oArea));
        // first time -- look up all the stops in the area and store them
        int nNth = 1;
        oStop = GetNearestObjectByTag("NW_STOP");
        while (GetIsObjectValid(oStop)) {
            AnimDebug("Stop found");
            SetLocalObject(oArea, "ANIM_STOP_" + IntToString(nNth), oStop);
            nNth++;
            oStop = GetNearestObjectByTag("NW_STOP", OBJECT_SELF, nNth);
        }
        SetLocalInt(oArea, "ANIM_STOPS", nNth-1);
        SetLocalInt(oArea, "ANIM_STOPS_INITIALIZED", TRUE);
    }

    int nStop = Random(GetLocalInt(oArea, "ANIM_STOPS")) + 1;
    oStop = GetLocalObject(oArea, "ANIM_STOP_" + IntToString(nStop));
    AnimDebug("Stop: " + IntToString(nStop)
                + ": " + GetTag(oStop)
                + ": " + FloatToString(GetDistanceToObject(oStop)));
    if (GetIsObjectValid(oStop) && GetDistanceToObject(oStop) <= fMaxDistance)
        return oStop;
    return OBJECT_INVALID;
}

// Check for a waypoint marked NW_HOME in the area; if it
// exists, mark it as the caller's home waypoint.
void SetCreatureHomeWaypoint()
{
    object oHome = GetNearestObjectByTag("NW_HOME");
    if (GetIsObjectValid(oHome)) {
        SetAnimationCondition(NW_ANIM_FLAG_HAS_HOME);
        SetLocalObject(OBJECT_SELF, "NW_ANIM_HOME", oHome);
    }
}

// Get a creature's home waypoint; returns OBJECT_INVALID if none set.
object GetCreatureHomeWaypoint()
{
    if (GetAnimationCondition(NW_ANIM_FLAG_HAS_HOME)) {
        return GetLocalObject(OBJECT_SELF, "NW_ANIM_HOME");
    }
    return OBJECT_INVALID;
}


// Set a specific creature (or OBJECT_INVALID to clear) as the caller's "friend"
void SetCurrentFriend(object oFriend)
{
    if (!GetIsObjectValid(oFriend)) {
        DeleteLocalObject(OBJECT_SELF, "NW_ANIM_FRIEND");
    } else {
        SetLocalObject(OBJECT_SELF, "NW_ANIM_FRIEND", oFriend);
    }
}

// Get the caller's current friend, if set; OBJECT_INVALID otherwise
object GetCurrentFriend()
{
    return GetLocalObject(OBJECT_SELF, "NW_ANIM_FRIEND");
}

// Set an object (or OBJECT_INVALID to clear) as the caller's interactive
// target.
void SetCurrentInteractionTarget(object oTarget)
{
    if (!GetIsObjectValid(oTarget)) {
        DeleteLocalObject(OBJECT_SELF, "NW_ANIM_TARGET");
    } else {
        SetLocalObject(OBJECT_SELF, "NW_ANIM_TARGET", oTarget);
    }
}

// Get the caller's current interaction target, if set; OBJECT_INVALID otherwise
object GetCurrentInteractionTarget()
{
    return GetLocalObject(OBJECT_SELF, "NW_ANIM_TARGET");
}


// Mark the caller as civilized based on its racialtype.
// This will not unset the NW_ANIM_FLAG_IS_CIVILIZED flag
// if it was set outside.
void CheckIsCivilized()
{
    int nRacialType = GetRacialType(OBJECT_SELF);
    switch (nRacialType) {
    case RACIAL_TYPE_ELF :
    case RACIAL_TYPE_GNOME :
    case RACIAL_TYPE_HALFELF :
    case RACIAL_TYPE_HALFLING :
    case RACIAL_TYPE_HALFORC :
    case RACIAL_TYPE_HUMAN :
    case RACIAL_TYPE_HUMANOID_GOBLINOID :
    case RACIAL_TYPE_HUMANOID_REPTILIAN :
    case RACIAL_TYPE_HUMANOID_ORC:
        SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);
    }
}

// Check to see if we should switch on detect/stealth mode
void CheckCurrentModes()
{
    object oWay = GetNearestObject(OBJECT_TYPE_WAYPOINT);
    string sTag = GetTag(oWay);
    if (sTag == "NW_STEALTH") {
        if (GetModeActive(NW_MODE_STEALTH)) {
            // turn off stealth mode
            SetModeActive(NW_MODE_STEALTH, FALSE);
        } else {
            // turn on stealth mode
            SetModeActive(NW_MODE_STEALTH);
        }
    } else if (sTag == "NW_DETECT") {
        if (GetModeActive(NW_MODE_DETECT)) {
            // turn off detect mode
            SetModeActive(NW_MODE_DETECT);
        } else {
            // turn on detect mode
            SetModeActive(NW_MODE_DETECT);
        }
    }
}


// Check if the creature should be active and turn off if not,
// returning FALSE. This respects the NW_ANIM_FLAG_CONSTANT
// setting.
int CheckIsAnimActive(object oCreature)
{
    // Unless we're set to be constant, turn off if there's
    // no PC in the area
    if ( ! GetAnimationCondition(NW_ANIM_FLAG_CONSTANT)) {
        object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                        PLAYER_CHAR_IS_PC);
        if ( !GetIsObjectValid(oPC) || GetArea(oPC) != GetArea(OBJECT_SELF)) {
            // turn off
            SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE, FALSE);
            return FALSE;
        }
    }
    return TRUE;
}


// Check to see if we're in the middle of some action
// so we don't interrupt or pile actions onto the queue.
// Returns TRUE if in the middle of an action, FALSE otherwise.
int CheckCurrentAction()
{
    int nAction = GetCurrentAction();
    if (nAction == ACTION_SIT) {
        // low prob of getting up, so we don't bop up and down constantly
        if (Random(10) == 0) {
            AnimActionGetUpFromChair();
        }
        return TRUE;
    } else if (nAction != ACTION_INVALID) {
        // we're doing *something*, don't switch
        AnimDebug("performing action");
        return TRUE;
    }
    return FALSE;
}

// General initialization for animations.
// Called from all the Play_* functions.
void AnimInitialization()
{
    // If we've been set to be constant, flag us as
    // active.
    // if (GetAnimationCondition(NW_ANIM_FLAG_CONSTANT))
    SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);

    // Set our home, if we have one
    SetCreatureHomeWaypoint();

    // Mark whether we're civilized or not
    CheckIsCivilized();

    SetAnimationCondition(NW_ANIM_FLAG_INITIALIZED);

}

// This function should be used for mobile NPCs and monsters
// other than avian ones. It should be called by the creature
// that you want to perform the animations.
//
// Creatures will interact with each other and move around,
// possibly even moving between areas.
//
// Creatures who are spawned in an area with the "NW_HOME" tag
// will mark that area as their home, leave from the nearest
// door during the day, and return at night.
//
// Injured creatures will go to the nearest "NW_SAFE" waypoint
// in their immediate area and rest there.
//
// If at any point the nearest waypoint is "NW_DETECT" or
// "NW_STEALTH", the creature will toggle search/stealth mode
// respectively.
//
// Creatures who are spawned in an outdoor area (for instance,
// in city streets) will go inside areas that have one of the
// interior waypoints (NW_TAVERN, NW_SHOP), if those areas
// are connected by an unlocked door. They will come back out
// as well.
//
// Creatures will also move randomly between objects in their
// area that have the tag "NW_STOP".
//
// Mobile creatures will have all the same behaviors as immobile
// creatures, just tending to move around more.
void PlayMobileAmbientAnimations_NonAvian()
{

    if (!GetAnimationCondition(NW_ANIM_FLAG_INITIALIZED)) {
        // General initialization
        AnimInitialization();

        // Mark us as mobile
        SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE);
    }

    // Short-circuit everything if we're not active yet
    if (!GetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE))
        return;
    AnimDebug("currently active");

    // Check if we should turn off
    if (!CheckIsAnimActive(OBJECT_SELF))
        return;

    AnimDebug("staying active");

    //SpawnScriptDebugger();
    int nCurrentAction = GetCurrentAction();

    // Check current actions so we don't interrupt something in progress
    // Feb 14 2003: Because of the random walkthere needs to be a chance
    //  to stop walking.
    if (CheckCurrentAction() && (nCurrentAction != ACTION_MOVETOPOINT)&& (nCurrentAction != ACTION_WAIT)) {
        return;
    }

    // Go someplace safe and rest if we are hurt
    if (AnimActionRest()) {
        AnimDebug("resting");
        return;
    }

    // Check if current modes should change
    CheckCurrentModes();
    UseStealthMode();
    UseDetectMode();

    int bIsCivilized = GetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);
    if (bIsCivilized)
    {


        // Challenge an intruding PC
        if (AnimActionChallengeIntruder()) {
            return;
        }

        // Check if we should go home
        if (AnimActionGoHome()) {
            AnimDebug("going home");
            return;
        }

        // Check if we should leave home
        if (AnimActionLeaveHome()) {
            AnimDebug("leaving home");
            return;
        }

        // Otherwise, do something random
        AnimActionPlayRandomMobile();
    } else
    {
        AnimDebug("uncivilized");
        AnimActionPlayRandomUncivilized();
    }
}

// Avian creatures will fly around randomly.
void PlayMobileAmbientAnimations_Avian()
{
    int nRoll = d4();
    object oFriend = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                                        REPUTATION_TYPE_FRIEND,
                                        OBJECT_SELF,
                                        nRoll,
                                        CREATURE_TYPE_PERCEPTION,
                                        PERCEPTION_SEEN);

    effect eBird;
    int nBird = d4();
    ClearActions(CLEAR_X0_I0_ANIMS_PlayMobile);
    if(GetIsObjectValid(oFriend)) {
        if(nBird == 1) {
            ActionMoveToObject(oFriend, TRUE);
        } else if (nBird == 2 || nBird == 3) {
            AnimActionRandomMoveAway(oFriend, 100.0);
        } else {
            eBird = EffectDisappearAppear(GetLocation(oFriend));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBird, OBJECT_SELF, 4.0);
            AnimActionRandomMoveAway(oFriend, 100.0);
        }
    } else {
        ActionRandomWalk();
    }
}

// This function should be used for any NPCs that should
// not move around. It should be called by the creature
// that you want to perform the animations.
//
// Creatures who call this function will never leave the
// area they spawned in.
//
// Injured creatures will rest at their starting location.
//
// Creatures who have the NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE
// flag set will move around slightly within the area.
// Creatures in an area with an "interior" waypoint (NW_HOME,
// NW_SHOP, NW_TAVERN) will be set to have this flag automatically.
//
// Close-range creatures will move around the area, frequently
// returning to their starting point, interacting with other
// creatures and placeables. They will visit NW_STOP waypoints
// in their immediate vicinity, and they will close opened doors.
//
// In all other cases, the creature will not move from its starting
// position. They will turn around randomly, turn to and 'talk' to
// other NPCs in their immediate vicinity, and interact with
// placeables in their immediate vicinity.
//
void PlayImmobileAmbientAnimations()
{
    if (!GetAnimationCondition(NW_ANIM_FLAG_INITIALIZED)) {
        // General initialization
        AnimInitialization();

        // if we are at home, make us mobile in close-range
        if (GetIsObjectValid(GetCreatureHomeWaypoint())) {
            SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);
        }

        // also save our starting location
        SetLocalLocation(OBJECT_SELF,
                         "ANIM_START_LOCATION",
                         GetLocation(OBJECT_SELF));
    }

    // Short-circuit everything if we're not active yet
    if (!GetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE))
        return;

    AnimDebug("currently active");

    // Check if we should turn off
    if (!CheckIsAnimActive(OBJECT_SELF))
        return;

    AnimDebug("staying active");

    // Check current actions so we don't interrupt something in progress
    if (CheckCurrentAction()) {
        return;
    }

    // First check: go back to starting position and rest if we are hurt
    if (AnimActionRest()) {
        AnimDebug("resting");
        return;
    }

    // Check if current modes should change
    CheckCurrentModes();
    UseStealthMode();
    UseDetectMode();

    // Challenge an intruding PC
    if (AnimActionChallengeIntruder()) {
        return;
    }

    int bIsCivilized = GetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);

    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE)) {
        AnimDebug("close range");
        AnimActionPlayRandomCloseRange();
    } else {
        AnimDebug("immobile");
        AnimActionPlayRandomImmobile();
    }
}


// Perform a strictly immobile action.
// Includes:
// - turn towards a nearby unoccupied friend and 'talk'
// - turn towards a nearby placeable and interact
// - turn around randomly
// - play a random animation
void AnimActionPlayRandomImmobile()
{
    int nRoll = Random(12);

    //SpawnScriptDebugger();


    // If we're talking, either keep going or stop.
    // Low prob of stopping, since both parties have
    // a chance and conversations are cool.
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_TALKING)) {
        object oFriend = GetCurrentFriend();
        int nHDiff = GetHitDice(OBJECT_SELF) - GetHitDice(oFriend);

        if (nRoll == 0) {
            AnimActionStopTalking(oFriend, nHDiff);
        } else {
            AnimActionPlayRandomTalkAnimation(nHDiff);
        }
        return;
    }

    // If we're interacting with a placeable, either keep going or
    // stop. High probability of stopping, since looks silly to
    // constantly turn something on-and-off.
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_INTERACTING)) {
        if (nRoll < 4) {
            AnimActionStopInteracting();
        } else {
            AnimActionPlayRandomInteractAnimation(GetCurrentInteractionTarget());
        }
        return;
    }

    // If we got here, we're not busy at the moment.

    // Clean out the action queue
    ClearActions(CLEAR_X0_I0_ANIMS_PlayRandomMobile);
    if (nRoll <=9) {
        if (AnimActionFindFriend(DISTANCE_LARGE))
            return;
    }

    if (nRoll > 9) {
        // Try and interact with a nearby placeable
        if (AnimActionFindPlaceable(DISTANCE_SHORT))
            return;
    }

    // Default: clear our action queue and play a random animation
    if ( nRoll < 5 ) {
        // Turn around and play a random animation

        // BK Feb 2003: I got rid of this because I've never seen it look appropriate
        // it always looks out of place and unrealistic
       AnimActionTurnAround();
        AnimActionPlayRandomAnimation();
    } else {
        // Just play a random animation
        AnimActionPlayRandomAnimation();
    }
}

// Perform a random close-range action.
// This will include:
// - any of the immobile actions
// - close any nearby doors, then return to current position
// - go to a nearby placeable and interact with it
// - go to a nearby friend and interact with them
// - walk to a nearby 'NW_STOP' waypoint
// - going back to starting point
void AnimActionPlayRandomCloseRange()
{
    if (GetIsBusyWithAnimation(OBJECT_SELF)) {
        // either we're already in conversation or
        // interacting with something, so continue --
        // all handled already in RandomImmobile.
        AnimActionPlayRandomImmobile();
        return;
    }

    // If we got here, we're not busy

    // Clean out the action queue
    ClearActions(CLEAR_X0_I0_ANIMS_PlayRandomCloseRange1);

    // Possibly close open doors
    if (GetAnimationCondition(NW_ANIM_FLAG_CLOSE_DOORS) && AnimActionCloseRandomDoor()) {
        return;
    }

    // For the rest of these, we check for specific rolls,
    // to ensure that we don't do a lot of lookups on any one
    // given pass.

    int nRoll = Random(6);

    // Possibly start talking to a friend
    if (nRoll == 0 || nRoll == 1) {
        if (AnimActionFindFriend(DISTANCE_LARGE))
            return;
        // fall through to default
    }

    // Possibly start fiddling with a placeable
    if (nRoll == 2) {
        if (AnimActionFindPlaceable(DISTANCE_LARGE))
            return;
        // fall through if no placeable found
    }

    // Possibly sit down
    if (nRoll == 3) {
        if (AnimActionSitInChair(DISTANCE_LARGE))
            return;
    }

    // Go to a nearby stop
    if (nRoll == 4) {
        if (AnimActionGoToStop(DISTANCE_LARGE)) {
            return;
        }

        // No stops, so do a random walk and then come back
        // to our current location
        ClearActions(CLEAR_X0_I0_ANIMS_PlayRandomCloseRange2);
        location locCurr = GetLocation(OBJECT_SELF);
        ActionRandomWalk();
        ActionMoveToLocation(locCurr);
    }

    if (nRoll == 5 && !GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE)) {
        // Move back to starting point, saved at initialization
        ActionMoveToLocation(GetLocalLocation(OBJECT_SELF,
                                              "ANIM_START_LOCATION"));
        return;
    }

    // Default: do a random immobile animation
    AnimActionPlayRandomImmobile();
}

// Perform a mobile action.
// Includes:
// - walk to an 'NW_STOP' waypoint in the area
// - walk to an area door and possibly go inside
// - go outside if previously went inside
// - fall through to AnimActionPlayRandomCloseRange
void AnimActionPlayRandomMobile()
{
    if (GetIsBusyWithAnimation(OBJECT_SELF)) {
        // either we're already in conversation or
        // interacting with something, so continue --
        // all handled already in RandomImmobile.
        AnimActionPlayRandomImmobile();
        return;
    }

    // If we got here, we're not busy

    // Clean out the action queue
    ClearActions(CLEAR_X0_I0_ANIMS_AnimActionPlayRandomMobile1);

    int nRoll = Random(9);

    if (nRoll == 0) {
        // If we're inside, possibly leave
        if (AnimActionGoOutside())
            return;
    }

    if (nRoll == 1) {
        // Possibly go into an interior area
        if (AnimActionGoInside())
            return;
    }

    // If we fell through or got a random number
    // less than 7, go to a stop waypoint, or random
    // walk if no stop waypoints were found.
    if (nRoll < 5) {
        // Pass in a huge number so any stop will be valid
        if (AnimActionGoToStop(1000.0))
            return;

        // If no stops, do a random walk
        ClearActions(CLEAR_X0_I0_ANIMS_AnimActionPlayRandomMobile2);
        ActionRandomWalk();
        return;
    }

    // Default: do something close-range
//    AnimActionPlayRandomCloseRange();

    // MODIFIED February 14 2003. Will play an immobile animation, if nothing else found to do

    PlayImmobileAmbientAnimations();
}

// Perform a mobile action for an uncivilized creature.
// Includes:
// - perform random limited animations
// - walk to an 'NW_STOP' waypoint in the area
// - random walk if none available
void AnimActionPlayRandomUncivilized()
{
    int nRoll = Random(6);

    if (nRoll != 5) {
        if (AnimActionGoToStop(1000.0))
            return;
        // no stops, so random walk
        ClearActions(CLEAR_X0_I0_ANIMS_AnimActionPlayRandomUncivilized);
        ActionRandomWalk();
    }

    // Play one of our few random animations
    AnimActionPlayRandomBasicAnimation();
}

/**********************************************************************
 **********************************************************************
 * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE
 * The functions below here are building blocks used in the main
 * functions above.
 * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE
 **********************************************************************
 **********************************************************************/


// Start interacting with a placeable object
void AnimActionStartInteracting(object oPlaceable)
{
    SetAnimationCondition(NW_ANIM_FLAG_IS_INTERACTING);

    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE)
        || GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE))
    {
        ActionMoveToObject(oPlaceable, FALSE, DISTANCE_TINY);
    }
    ActionDoCommand(SetFacingPoint(GetPosition(oPlaceable)));
    SetCurrentInteractionTarget(oPlaceable);

    AnimActionPlayRandomInteractAnimation(oPlaceable);
}

// Stop interacting with a placeable object
void AnimActionStopInteracting()
{
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE)) {
        AnimActionRandomMoveAway(GetCurrentInteractionTarget(), DISTANCE_LARGE);
    }
    SetCurrentInteractionTarget(OBJECT_INVALID);

    SetAnimationCondition(NW_ANIM_FLAG_IS_INTERACTING, FALSE);

    AnimActionTurnAround();
    AnimActionPlayRandomAnimation();
}

// Start talking with a friend
void AnimActionStartTalking(object oFriend, int nHDiff=0)
{
    AnimDebug("started talking to " + GetName(oFriend));
    object oMe = OBJECT_SELF;

    // Say hello and move to each other if we're not immobile
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE)
        || GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE))
    {
        ActionMoveToObject(oFriend, FALSE, DISTANCE_TINY);
        AnimActionPlayRandomGreeting(nHDiff);
    }
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE, oFriend)
        || GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE, oFriend))
    {
        AssignCommand(oFriend,
                      ActionMoveToObject(oMe, FALSE, DISTANCE_TINY));
        AssignCommand(oFriend, AnimActionPlayRandomGreeting(0 - nHDiff));
    }

    SetCurrentFriend(oFriend);
    AssignCommand(oFriend, SetCurrentFriend(oMe));
    ActionDoCommand(SetFacingPoint(GetPosition(oFriend)));
    AssignCommand(oFriend, ActionDoCommand(SetFacingPoint(GetPosition(oMe))));
    SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING);
    SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, TRUE, oFriend);
}

// Stop talking to the given friend
void AnimActionStopTalking(object oFriend, int nHDiff=0)
{
    AnimDebug("stopped talking to " + GetName(oFriend));
    object oMe = OBJECT_SELF;

    // Say goodbye and move away if we're not immobile
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE)) {
        AnimActionPlayRandomGoodbye(nHDiff);
        AnimActionRandomMoveAway(oFriend, DISTANCE_LARGE);
    } else {
        AnimActionTurnAround();
        AnimActionPlayRandomAnimation();
    }

    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE, oFriend)) {
        AssignCommand(oFriend, AnimActionPlayRandomGoodbye(0 - nHDiff));
        AssignCommand(oFriend,
                      AnimActionRandomMoveAway(oMe, DISTANCE_HUGE));
    } else {
        AssignCommand(oFriend, AnimActionTurnAround());
        AssignCommand(oFriend, AnimActionPlayRandomAnimation());
    }

    SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, FALSE);
    SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, FALSE, oFriend);

}

// Play a greeting animation and possibly voicechat.
// If a negative hit dice difference (HD caller - HD greeted) is
// passed in, the caller will bow.
void AnimActionPlayRandomGreeting(int nHDiff=0)
{
    if (Random(2) == 0 && GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
        VoiceHello();
    }

    if (nHDiff < 0 || Random(4) == 0)
        ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);
    else
        ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING);
}

// Play a random farewell animation and possibly voicechat.
// If a negative hit dice difference is passed in, the
// caller will bow.
void AnimActionPlayRandomGoodbye(int nHDiff)
{
    if (Random(2) == 0 && GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
        VoiceGoodbye();
    }

    if (nHDiff < 0 || Random(4) == 0)
        ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);
    else
        ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING);
}

// Randomly move away from an object the specified distance.
// This is mainly because ActionMoveAwayFromLocation isn't working.
void AnimActionRandomMoveAway(object oSource, float fDistance)
{
    location lTarget = GetRandomLocation(GetArea(OBJECT_SELF), oSource, fDistance);

    ActionMoveToLocation(lTarget);
}

// Play animation of shaking head "no" to left & right
void AnimActionShakeHead()
{
    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 3.0);
    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 3.0);
}

// Play animation of looking to left and right
void AnimActionLookAround()
{
    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75);
}

// Turn around to face a random direction
void AnimActionTurnAround()
{
// BK Feb 2003: This never looks good. Don't do it.
//    ActionDoCommand(SetFacing(IntToFloat(Random(360))));
}



// Go through a door and close it behind you,
// then walk a short distance away.
// This assumes the door exists, is unlocked, etc.
void AnimActionGoThroughDoor(object oDoor)
{
    AnimDebug("going through door " + GetTag(oDoor));
    SetLocalInt(oDoor, "BEING_CLOSED", TRUE);
    object oDest = GetTransitionTarget(oDoor);
    ActionMoveToObject(oDest);
    ActionDoCommand(AssignCommand(oDest, ActionCloseDoor(oDest)));
    ActionDoCommand(AssignCommand(oDoor, ActionCloseDoor(oDoor)));
    ActionDoCommand(SetLocalInt(oDoor, "BEING_CLOSED", FALSE));
    DelayCommand(10.0, SetLocalInt(oDoor, "BEING_CLOSED", FALSE));
    AnimActionRandomMoveAway(oDest, DISTANCE_MEDIUM);
}

/**********************************************************************
 * The following AnimAction functions have a possibility of failing
 * and not assigning any actions.
 * They return TRUE on success, FALSE on failure. See notes up in the
 * prototype section for details.
 **********************************************************************/


// If there's an open door nearby, possibly go close it,
// then come back to our current spot.
int AnimActionCloseRandomDoor()
{
    if (Random(4) != 0) return FALSE;

    int nNth = 1;
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
    location locCurrent = GetLocation(OBJECT_SELF);
    while (GetIsObjectValid(oDoor)) {
        // make sure everyone doesn't run to close the same door
        if (GetIsOpen(oDoor) && !GetLocalInt(oDoor, "BEING_CLOSED")) {
            AnimDebug("closing door: " + GetTag(oDoor));
            SetLocalInt(oDoor, "BEING_CLOSED", TRUE);
            ActionCloseDoor(oDoor);
            ActionDoCommand(SetLocalInt(oDoor, "BEING_CLOSED", FALSE));
            ActionMoveToLocation(locCurrent);
            return TRUE;
        } else {
            AnimDebug("closed or being closed: " + GetTag(oDoor));
        }
        nNth++;
        oDoor = GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF, nNth);
    }
    return FALSE;
}

// Sit in a random nearby chair if available.
// Looks for items with tag: Chair
int AnimActionSitInChair(float fMaxDistance)
{
    object oChair = GetRandomObjectByTag("Chair", fMaxDistance);
    if (GetIsObjectValid(oChair) && !GetIsObjectValid(GetSittingCreature(oChair))) {
        ActionSit(oChair);
        SetAnimationCondition(NW_ANIM_FLAG_IS_INTERACTING);
        return TRUE;
    }
    return FALSE;
}

// Get up from a chair if we're sitting
int AnimActionGetUpFromChair()
{
    AnimDebug("getting up from chair");
    if (GetCurrentAction() == ACTION_SIT) {
        ClearActions(CLEAR_X0_I0_ANIMS_AnimActionGetUpFromChair);
        SetAnimationCondition(NW_ANIM_FLAG_IS_INTERACTING, FALSE);
        AnimActionRandomMoveAway(GetNearestObject(OBJECT_TYPE_PLACEABLE), DISTANCE_SHORT);
        AnimDebug("got up from chair");
        return TRUE;
    }
    return FALSE;
}

// Go through a nearby door if appropriate.
// This will be done if the door is unlocked and
// the area the door leads to contains a waypoint
// with one of these tags:
//             NW_TAVERN, NW_SHOP
int AnimActionGoInside()
{
    // Don't go inside a second area, since we'll never get
    // back to our original one if we do that.
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_INSIDE)) {
        AnimDebug("is inside already");
        return FALSE;
    }

    object oDoor = GetRandomObjectByType(OBJECT_TYPE_DOOR, 1000.0);
    if (!GetIsObjectValid(oDoor) || GetLocked(oDoor)) {
        AnimDebug("Failed to enter door: " + GetTag(oDoor));
        return FALSE;
    }

    object oDest = GetTransitionTarget(oDoor);
    AnimDebug("Destination: " + GetTag(oDest));
    object oWay = GetNearestObjectByTag("NW_TAVERN", oDest);
    if (!GetIsObjectValid(oWay))
        oWay = GetNearestObjectByTag("NW_SHOP", oDest);
    if (GetIsObjectValid(oWay)) {
        AnimDebug("Valid waypoint found: " + GetTag(oWay));
        AnimActionGoThroughDoor(oDoor);
        SetAnimationCondition(NW_ANIM_FLAG_IS_INSIDE);
        SetLocalObject(OBJECT_SELF, "NW_ANIM_DOOR", oDest);
        return TRUE;
    }

    return FALSE;
}

// Leave area if appropriate.
// This only works for NPCs that entered an area that
// has a waypoint with one of these tags:
//             NW_TAVERN, NW_SHOP
// If the NPC entered through a door, they will exit through
// that door.
int AnimActionGoOutside()
{
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_INSIDE)) {
        object oDoor = GetLocalObject(OBJECT_SELF, "NW_ANIM_DOOR");
        if (GetIsObjectValid(oDoor)) {
            DeleteLocalObject(OBJECT_SELF, "NW_ANIM_DOOR");
            AnimActionGoThroughDoor(oDoor);
            SetAnimationCondition(NW_ANIM_FLAG_IS_INSIDE, FALSE);
            return TRUE;
        }
    }
    return FALSE;
}

// Go to a nearby waypoint or placeable marked with the
// tag "NW_STOP".
int AnimActionGoToStop(float fMaxDistance)
{
    object oStop = GetRandomStop(fMaxDistance);
    if (GetIsObjectValid(oStop)) {
        ClearActions(CLEAR_X0_I0_ANIMS_AnimActionGoToStop);
        ActionMoveToObject(oStop, FALSE, DISTANCE_SHORT);
        return TRUE;
    }
    return FALSE;
}

// Find a friend within the given distance and talk to them.
// Returns TRUE on success, FALSE on failure.
int AnimActionFindFriend(float fMaxDistance)
{
    // If we had a friend recently, make sure we don't start talking
    // again right away
//    if (GetIsObjectValid(GetCurrentFriend())) {
//        SetCurrentFriend(OBJECT_INVALID);
//    } else
   {
        // Try and find a friend to talk to
        object oFriend = GetRandomFriend(fMaxDistance);
        if (GetIsObjectValid(oFriend) && !GetIsBusyWithAnimation(oFriend)) {
            int nHDiff = GetHitDice(OBJECT_SELF) - GetHitDice(oFriend);
            AnimActionStartTalking(oFriend, nHDiff);
            return 1;
        }
    }
    return 0;
}

// Find a placeable within the given distance and interact
// with it.
// Returns TRUE on success, FALSE on failure.
int AnimActionFindPlaceable(float fMaxDistance)
{
    object oPlaceable = GetRandomObjectByTag("NW_INTERACTIVE", DISTANCE_SHORT);
    if (GetIsObjectValid(oPlaceable)) {
        AnimActionStartInteracting(oPlaceable);
        return 1;
    }
    return 0;
}

// If injured, find the nearest "NW_SAFE" object,
// go to it, and rest.
// Returns TRUE on success, FALSE on failure.
int AnimActionRest()
{
    if (GetCurrentHitPoints() < GetMaxHitPoints()) {
        object oSafe = GetNearestObjectByTag("NW_SAFE");
        if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE) && GetIsObjectValid(oSafe)) {
            ClearActions(CLEAR_X0_I0_ANIMS_AnimActionRest1);
            ActionMoveToObject(oSafe);
            //ActionRest();
            return TRUE;
        } else {
            location lStart = GetLocalLocation(OBJECT_SELF, "ANIM_START_LOCATION");
            ClearActions(CLEAR_X0_I0_ANIMS_AnimActionRest2);
            ActionMoveToLocation(lStart);
            //ActionRest();
            return TRUE;
        }
    }
    return FALSE;
}

// If it is night, go back to our home waypoint, if we have one.
// This is only meaningful for mobile NPCs who would have left
// their homes during the day.
// Returns TRUE on success, FALSE on failure.
int AnimActionGoHome()
{
    object oHome = GetCreatureHomeWaypoint();
    if ( GetIsObjectValid(oHome) && !GetIsDay() && GetArea(OBJECT_SELF) != GetArea(oHome)) {
        ClearActions(CLEAR_X0_I0_ANIMS_GoHome);
        AnimActionGoOutside();
        AnimActionGoThroughDoor(GetLocalObject(OBJECT_SELF,
                                               "NW_ANIM_DOOR_HOME"));
        return TRUE;
    }
    return FALSE;
}

// If it is day, leave our home area, if we have one.
// This is only meaningful for mobile NPCs.
// Returns TRUE on success, FALSE on failure.
int AnimActionLeaveHome()
{
    object oHome = GetCreatureHomeWaypoint();
    if ( GetIsObjectValid(oHome) && GetIsDay() && GetArea(OBJECT_SELF) == GetArea(oHome)) {
        // Find the nearest door and walk out
        ClearActions(CLEAR_X0_I0_ANIMS_AnimActionLeaveHome);
        object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
        if (!GetIsObjectValid(oDoor) || GetLocked(oDoor))
            return FALSE;

        object oDest = GetTransitionTarget(oDoor);
        if (GetIsObjectValid(oDest)) {
            SetLocalObject(OBJECT_SELF, "NW_ANIM_DOOR_HOME", oDest);
            AnimActionGoThroughDoor(oDoor);
            return TRUE;
        }
    }
    return FALSE;
}


// If a PC is in the NPC's home and has not been challenged before,
// challenge them.
// This involves speaking a one-liner conversation from the
// conversation file ANIM_CONVERSATION, set above.
// Returns TRUE on success, FALSE on failure.
int AnimActionChallengeIntruder()
{
    object oHome = GetCreatureHomeWaypoint();
    if (GetIsObjectValid(oHome) && GetArea(OBJECT_SELF) == GetArea(oHome)) {
        object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
        if (GetIsObjectValid(oPC) && !GetLocalInt(OBJECT_SELF, GetName(oPC) + "_CHALLENGED")) {
            ClearActions(CLEAR_X0_I0_ANIMS_AnimActionChallengeIntruder);
            ActionDoCommand(SetFacingPoint(GetPosition(oPC)));
            ActionDoCommand(SpeakOneLinerConversation(ANIM_CONVERSATION, oPC));
            SetLocalInt(OBJECT_SELF, GetName(oPC) + "_CHALLENGED", TRUE);
            return TRUE;
        }
    }
    return FALSE;
}


/**********************************************************************
 **********************************************************************
 * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE
 * The functions stuck below here are generally just big ugly
 * switch statements to choose between a bunch of random
 * animations.
 * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE * NOTE
 **********************************************************************
 **********************************************************************/

// Interact with a placeable object.
// This will activate/deactivate the placeable object if a valid
// one is passed in.
// KLUDGE: If a placeable object without an inventory should
//         still be opened/shut instead of de/activated, set
//         its Will Save to 1.
void AnimActionPlayRandomInteractAnimation(object oPlaceable)
{
    int nRoll = Random(5);

    if (nRoll == 0) {
        ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        return;
    }

    // See where the placeable is in relation to us, height-wise
    vector vPos = GetPosition(oPlaceable);
    vector vMyPos = GetPosition(OBJECT_SELF);
    float fZDiff = vMyPos.z - vPos.z;
    if ( fZDiff > 0.0 ) {
        // we're above the placeable
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,
                            ANIM_LOOPING_SPEED,
                            ANIM_LOOPING_LENGTH);
    } else {
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,
                            ANIM_LOOPING_SPEED,
                            ANIM_LOOPING_LENGTH);
    }

    // KLUDGE! KLUDGE! KLUDGE!
    // Because of placeables like the trap doors, etc, that should be
    // "opened" rather than "activated", but don't have an inventory,
    // we use this ugly hack: set the "Will" saving throw of a placeable
    // to the value 1 if it should be opened rather than activated.
    if (GetHasInventory(oPlaceable) || GetWillSavingThrow(oPlaceable) == 1) {
        if (GetIsOpen(oPlaceable)) {
            AssignCommand(oPlaceable,
                          DelayCommand(ANIM_LOOPING_LENGTH,
                                       ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
        } else {
            AssignCommand(oPlaceable,
                          DelayCommand(ANIM_LOOPING_LENGTH,
                                       ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN)));
        }
    } else {
        int bIsActive = GetLocalInt(oPlaceable, "NW_ANIM_PLACEABLE_ACTIVE");
        if (bIsActive) {
            AssignCommand(oPlaceable,
                          DelayCommand(ANIM_LOOPING_LENGTH,
                                       ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
            SetLocalInt(oPlaceable, "NW_ANIM_PLACEABLE_ACTIVE", FALSE);
        } else {
            AssignCommand(oPlaceable,
                          DelayCommand(ANIM_LOOPING_LENGTH,
                                       ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)));
            SetLocalInt(oPlaceable, "NW_ANIM_PLACEABLE_ACTIVE", TRUE);
        }
    }

    return;
}

// Play a random talk gesture animation.
// If a hit dice difference (should be the hit dice of the caller
// minus the hit dice of the person being talked to) is passed in,
// the caller will play slightly different animations if they are
// weaker.
void AnimActionPlayRandomTalkAnimation(int nHDiff)
{
    int nRoll = Random(9);
//SpeakString("Talk " + IntToString(nRoll));
    switch (nRoll) {
    case 0:
        if (GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
            VoiceYes();
        }
        // deliberate fall-through!
    case 1:
        ActionPlayAnimation(ANIMATION_LOOPING_LISTEN,
                            ANIM_LOOPING_SPEED,
                            ANIM_LOOPING_LENGTH);
        break;
    case 2:
    case 3:
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,
                            ANIM_LOOPING_SPEED,
                            ANIM_LOOPING_LENGTH);
        break;
    case 4:
        if (nHDiff < 0)
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
        else {
            if (Random(2) == 0 && GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
                VoiceLaugh();
            }
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
        }
        break;
    case 5:
        // BK Feb 2003 Salutes look stupid
      //  if (nHDiff < 0)
      //      ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE, 0.75);
      //  else
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
        break;
    case 6:
        if (GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
            VoiceNo();
        }
        // deliberate fall-through!
    case 7:
        AnimActionShakeHead();
        break;
    case 8:
        if (nHDiff > 0)
            ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
        else {
            if (Random(2) == 0 && GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
                VoiceLaugh();
            }
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
        }
        break;
    }

    return;
}

// Play a random animation that all creatures should have.
void AnimActionPlayRandomBasicAnimation()
{
    int nRoll = Random(2);
    switch (nRoll) {
    case 0:
    // BK Feb 2003: This always looks dumb
    //    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,
    //                        ANIM_LOOPING_SPEED,
    //                        ANIM_LOOPING_LENGTH);
        break;
    case 1:
        ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
        break;
    }
}


// Play a random animation.
void AnimActionPlayRandomAnimation()
{
    int nRoll;
    int bInTavern=FALSE;
    int bInHome=FALSE;
    int bNearAltar=FALSE;

    object oWay = GetNearestObjectByTag("NW_TAVERN");
    if (GetIsObjectValid(oWay)) {
        bInTavern = TRUE;
    } else {
        oWay = GetNearestObjectByTag("NW_HOME");
        if (GetIsObjectValid(oWay)) {
            bInHome = TRUE;
        } else {
            oWay = GetNearestObjectByTag("NW_ALTAR");
            if (GetIsObjectValid(oWay) && GetDistanceToObject(oWay) < DISTANCE_SHORT) {
                bNearAltar = TRUE;
            }
        }
    }

    if (bInTavern) {
        nRoll = Random(15);
        switch (nRoll) {
        case 0:
        case 1:
            ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK); break;
        case 2:
            if (GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
                VoicePoisoned();
            }
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 3:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 4:
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1); break;
        case 5:
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2); break;
        case 6:
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3); break;
        case 7:
        case 8:
            if (GetAnimationCondition(NW_ANIM_FLAG_CHATTER)) {
                VoiceLaugh();
            }
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 9:
        case 10:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED); break;
        case 11:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD); break;
        case 12:
        case 13:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 14:
            AnimActionLookAround(); break;
        }
    } else if (bNearAltar) {
        nRoll = Random(10);
        switch (nRoll) {
        case 0:
            ActionPlayAnimation(ANIMATION_FIREFORGET_READ); break;
        case 1:
        case 2:
        case 3:
            ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH * 2);
            break;
        case 4:
        case 5:
            ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH * 2);
            break;
        case 6:
            ActionPlayAnimation(ANIMATION_LOOPING_LISTEN,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 7:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 8:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 9:
            AnimActionLookAround(); break;
        }
    } else if (bInHome) {
        nRoll = Random(6);
        switch (nRoll) {
        case 0:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 1:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 2:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 3:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED); break;
        case 4:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD); break;
        case 5:
            AnimActionLookAround(); break;
        }
    } else {
        // generic set, for the street
        nRoll = Random(8);
        switch (nRoll) {
        case 0:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 1:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 2:
            /* Bk Feb 2003: Looks dumb
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;*/
        case 3:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED); break;
        case 4:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD); break;
        case 5:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 6:
            ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,
                                ANIM_LOOPING_SPEED,
                                ANIM_LOOPING_LENGTH);
            break;
        case 7:
            AnimActionLookAround(); break;
        }
    }
    return;
}
