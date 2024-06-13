#include "no_inc_ptypes"

//support functions
void NO_ActionCastSpellAtLocation( int iSpell, location lTargetLocation, int iMetaMagic=METAMAGIC_ANY, int iCheat=FALSE, int iProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int iInstantSpell=FALSE, int iDefensive=TRUE )
{
    int iLevel = 14;
    int iConc = GetCombatConcentration();
    int iDefCast = FALSE;

    if ( iDefensive == TRUE && iConc >= iLevel && GetHostileCount( 5.0 ) > 0 )
    {
        iDefCast = TRUE;
    }
    SetActionMode( OBJECT_SELF, ACTION_MODE_DEFENSIVE_CAST, iDefCast );
    ActionCastSpellAtLocation( iSpell, lTargetLocation, iMetaMagic, iCheat, iProjectilePathType, iInstantSpell );
}

void NO_ActionCastSpellAtObject( int iSpell, object oTarget, int iMetaMagic=METAMAGIC_ANY, int iCheat=FALSE, int iDomainLevel=0, int iProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int iInstantSpell=FALSE, int iDefensive=TRUE )
{
    int iLevel = 14;
    int iConc = GetCombatConcentration();
    int iDefCast = FALSE;

    if ( iDefensive == TRUE && iConc >= iLevel && GetHostileCount( 5.0 ) > 0 )
    {
        iDefCast = TRUE;
    }
    SetActionMode( OBJECT_SELF, ACTION_MODE_DEFENSIVE_CAST, iDefCast );
    ActionCastSpellAtObject( iSpell, oTarget, iMetaMagic, iCheat, iDomainLevel, iProjectilePathType, iInstantSpell );
}

void NO_ActionUseTalentAtLocation( talent tChosenTalent, location lTargetLocation, int iDefensive=TRUE )
{
    int iLevel = 14;
    int iConc = GetCombatConcentration();
    int iDefCast = FALSE;

    if ( iDefensive == TRUE && iConc >= iLevel && GetHostileCount( 5.0 ) > 0 )
    {
        iDefCast = TRUE;
    }
    SetActionMode( OBJECT_SELF, ACTION_MODE_DEFENSIVE_CAST, iDefCast );
    ActionUseTalentAtLocation( tChosenTalent, lTargetLocation );
}

void NO_ActionUseTalentOnObject( talent tChosenTalent, object oTarget, int iDefensive=TRUE )
{
    int iLevel = 14;
    int iConc = GetCombatConcentration();
    int iDefCast = FALSE;

    if ( iDefensive == TRUE && iConc >= iLevel && GetHostileCount( 5.0 ) > 0 )
    {
        iDefCast = TRUE;
    }
    SetActionMode( OBJECT_SELF, ACTION_MODE_DEFENSIVE_CAST, iDefCast );
    ActionUseTalentOnObject( tChosenTalent, oTarget );
}

void ActivateCombatMode( int iMode=0, object oE=OBJECT_SELF )
{
    int iM = 0;

    switch( iMode )
    {
        case FEAT_DIRTY_FIGHTING:
            iM = ACTION_MODE_DIRTY_FIGHTING;
            break;
        case FEAT_EXPERTISE:
            iM = ACTION_MODE_EXPERTISE;
            break;
        case FEAT_IMPROVED_EXPERTISE:
            iM  = ACTION_MODE_IMPROVED_EXPERTISE;
            break;
        case FEAT_FLURRY_OF_BLOWS:
            iM = ACTION_MODE_FLURRY_OF_BLOWS;
            break;
        case FEAT_POWER_ATTACK:
            iM = ACTION_MODE_POWER_ATTACK;
            break;
        case FEAT_IMPROVED_POWER_ATTACK:
            iM = ACTION_MODE_IMPROVED_POWER_ATTACK;
            break;
        case FEAT_RAPID_SHOT:
            iM = ACTION_MODE_RAPID_SHOT;
            break;
    }
    if ( GetActionMode( oE, iM ) == FALSE )
    {
        SetActionMode( oE, iM, TRUE );
    }
}

void DeactivateCombatModes( int iException=0, object oE=OBJECT_SELF )
{
    if ( iException != FEAT_DIRTY_FIGHTING && GetActionMode( oE, ACTION_MODE_DIRTY_FIGHTING ) == TRUE )
    {
        SetActionMode( oE, ACTION_MODE_DIRTY_FIGHTING, FALSE );
    }
    if ( iException != FEAT_EXPERTISE && GetActionMode( oE, ACTION_MODE_EXPERTISE ) == TRUE )
    {
        SetActionMode( oE, ACTION_MODE_EXPERTISE, FALSE );
    }
    if ( iException != FEAT_IMPROVED_EXPERTISE && GetActionMode( oE, ACTION_MODE_IMPROVED_EXPERTISE ) == TRUE )
    {
        SetActionMode( oE, ACTION_MODE_IMPROVED_EXPERTISE, FALSE );
    }
    if ( iException != FEAT_FLURRY_OF_BLOWS && GetActionMode( oE, ACTION_MODE_FLURRY_OF_BLOWS ) == TRUE )
    {
        SetActionMode( oE, ACTION_MODE_FLURRY_OF_BLOWS, FALSE );
    }
    if ( iException != FEAT_POWER_ATTACK && GetActionMode( oE, ACTION_MODE_POWER_ATTACK ) == TRUE )
    {
        SetActionMode( oE, ACTION_MODE_POWER_ATTACK, FALSE );
    }
    if ( iException != FEAT_IMPROVED_POWER_ATTACK && GetActionMode( oE, ACTION_MODE_IMPROVED_POWER_ATTACK ) == TRUE )
    {
        SetActionMode( oE, ACTION_MODE_IMPROVED_POWER_ATTACK, FALSE );
    }
    if ( iException != FEAT_RAPID_SHOT && GetActionMode( oE, ACTION_MODE_RAPID_SHOT ) == TRUE )
    {
        SetActionMode( oE, ACTION_MODE_RAPID_SHOT, FALSE );
    }
}

int DoHideInPlainSight( object oE=OBJECT_SELF )
{
    if ( GetHasFeat( FEAT_HIDE_IN_PLAIN_SIGHT, oE ) )
    {
        SetActionMode( oE, ACTION_MODE_STEALTH, TRUE );
        return TRUE;
    }
    return FALSE;
}

void DoFireBeholderRay( int iS, object oT )
{
    if ( iS < 776 || iS > 784 || iS == 781 || iS == 782 ) //not a valid beholder ray spell definition
    {
        return;
    }

    if ( TouchAttackRanged( oT ) == FALSE )
    {
        vector vT;
        location lT;
        int iF = 785 + Random( 3 );

        vT = GetPosition( oT ) + 1.0 * AngleToVector( IntToFloat( Random( 360 ) ) );
        lT = Location( GetArea( OBJECT_SELF ), vT, GetFacing( OBJECT_SELF ) );
        //ActionCastFakeSpellAtLocation( iS, lT );
        ActionCastSpellAtLocation( iF, lT, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE );
    }
    else
    {
        ActionCastSpellAtObject( iS, oT, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE );
    }
}

void DoMoveToLocation( location lDest, int bRun=FALSE )
{
    effect eVis;
    float fD = 4.0;
    float fMinDist = 15.0;

    //activate hide in plain sight while moving
    DoHideInPlainSight();

    if ( GetLocalInt( OBJECT_SELF, "TELEPORTER" ) && GetDistanceBetweenLocations( GetLocation( OBJECT_SELF ), lDest ) > fMinDist )
    {
        DoTeleport( lDest );
    }
    else if ( GetLocalInt( OBJECT_SELF, "FLIER" ) && GetDistanceBetweenLocations( GetLocation( OBJECT_SELF ), lDest ) > fMinDist )
    {
        if ( !GetLocalInt( OBJECT_SELF, "DRAGONFLIGHTDEL" ) )
        {
            SetLocalInt( OBJECT_SELF, "DRAGONFLIGHTDEL", 1 );
            DelayCommand( fD + 0.5, DeleteLocalInt( OBJECT_SELF, "DRAGONFLIGHTDEL" ) );
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectDisappearAppear( lDest ), OBJECT_SELF, fD );
        }
    }
    else
    {
        ActionMoveToLocation( lDest, bRun );
    }
}

void DoMoveToObject( object oDest, int bRun=FALSE, float fDist=1.0f )
{
    location lDest;
    vector vT;
    float fD = 4.0;
    float fMinDist = 15.0;

    //activate hide in plain sight while moving
    DoHideInPlainSight();

    if ( GetIsObjectValid( oDest ) )
    {
        if ( GetLocalInt( OBJECT_SELF, "TELEPORTER" ) && GetDistanceBetweenLocations( GetLocation( OBJECT_SELF ), GetLocation( oDest ) ) > fMinDist )
        {
            vT = GetPosition( oDest ) + fDist * VectorNormalize( GetPosition( OBJECT_SELF ) - GetPosition( oDest ) );
            lDest = Location( GetArea( oDest ), vT, VectorToAngle( GetPosition( oDest ) - vT ) );
            DoTeleport( lDest );
        }
        else if ( GetLocalInt( OBJECT_SELF, "FLIER" ) && GetDistanceBetweenLocations( GetLocation( OBJECT_SELF ), GetLocation( oDest ) ) > fMinDist )
        {
            if ( !GetLocalInt( OBJECT_SELF, "DRAGONFLIGHTDEL" ) )
            {
                vT = GetPosition( oDest ) + fDist * VectorNormalize( GetPosition( OBJECT_SELF ) - GetPosition( oDest ) );
                lDest = Location( GetArea( oDest ), vT, VectorToAngle( GetPosition( oDest ) - vT ) );
                SetLocalInt( OBJECT_SELF, "DRAGONFLIGHTDEL", 1 );
                DelayCommand( fD + 0.5, DeleteLocalInt( OBJECT_SELF, "DRAGONFLIGHTDEL" ) );
                ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectDisappearAppear( lDest ), OBJECT_SELF, fD );
            }
        }
        else
        {
            ActionMoveToObject( oDest, bRun, fDist );
        }
    }
}

void DoTeleport( location lLoc )
{
    effect eVis = EffectVisualEffect( VFX_IMP_GLOBE_USE );

    ActionCastFakeSpellAtObject( SPELLABILITY_SUMMON_CELESTIAL, OBJECT_SELF );
    ActionDoCommand( ApplyEffectAtLocation( DURATION_TYPE_INSTANT, eVis, GetLocation( OBJECT_SELF ) ) );
    ActionDoCommand( ApplyEffectAtLocation( DURATION_TYPE_INSTANT, eVis, lLoc ) );
    ActionDoCommand( ActionJumpToLocation( lLoc ) );
}

object GetTarget()
{
    object oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    object oH = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE );
    object oT = OBJECT_INVALID;

    if ( !GetIsPerceived( oS, NO_PERCEPTION_SEEN ) )
    {
        oS = OBJECT_INVALID;
    }
    if ( !GetIsPerceived( oH, NO_PERCEPTION_HEARD ) )
    {
        oH = OBJECT_INVALID;
    }

    if ( GetIsObjectValid( oS ) && GetIsObjectValid( oH ) )
    {
        //target the closer of the two
        oT = GetDistanceBetween( OBJECT_SELF, oH ) < GetDistanceBetween( OBJECT_SELF, oS ) ? oH : oS;
    }
    else if ( GetIsObjectValid( oS ) )
    {
        //oH is invalid
        oT = oS;
    }
    else
    {
        //oS is invalid
        oT = oH;
    }
    return oT;
}

float DotProduct( vector v1, vector v2 )
{
    float fDP;

    fDP = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;

    return fDP;
}

location GetFlankLoc( object oT, location lL )
{
    vector vU;
    vector vT;
    vector vM;
    location lF;

    if ( GetIsObjectValid( oT ) )
    {
        vT = GetPosition( oT ) - GetPosition( OBJECT_SELF );
    }
    else
    {
        vT = GetPositionFromLocation( lL ) - GetPosition( OBJECT_SELF );
    }
    vM = VectorNormalize( AngleToVector( VectorToAngle( vT ) - 45.0 + 90.0 * IntToFloat( Random( 2 ) ) ) );
    vM = DotProduct( vT, vM ) * VectorNormalize( vM ) + GetPosition( OBJECT_SELF );
    lF = Location( GetArea( oT ), vM, VectorToAngle( vT - vM ) );

    return lF;
}

void DoEquipMelee( object oT )
{
    object oL = GetLocalObject( OBJECT_SELF, "LHAND" );
    object oR = GetLocalObject( OBJECT_SELF, "RHAND" );

    if ( GetIsObjectValid( oR ) || GetIsObjectValid( oL ) )
    {
        if ( GetIsObjectValid( oR ) )
        {
            if ( !GetIsObjectValid( GetItemPossessor( oR ) ) )
            {
                //weapon is on the ground after being disarmed?
                //try to pick it up
                ActionPickUpItem( oR );
                ActionEquipItem( oR, INVENTORY_SLOT_RIGHTHAND );
            }
            else if ( GetItemPossessor( oR ) == OBJECT_SELF && GetItemInSlot( INVENTORY_SLOT_RIGHTHAND ) != oR )
            {
                ActionEquipItem( oR, INVENTORY_SLOT_RIGHTHAND );
            }
        }
        if ( GetIsObjectValid( oL ) )
        {
            if ( !GetIsObjectValid( GetItemPossessor( oL ) ) )
            {
                //weapon is on the ground after being disarmed?
                //try to pick it up
                ActionPickUpItem( oL );
                ActionEquipItem( oL, INVENTORY_SLOT_LEFTHAND );
            }
            else if ( GetItemPossessor( oL ) == OBJECT_SELF && GetItemInSlot( INVENTORY_SLOT_LEFTHAND ) != oL )
            {
                ActionEquipItem( oL, INVENTORY_SLOT_LEFTHAND );
            }
        }
    }
    else if ( GetIsObjectValid( oT ) )
    {
        //nothing stored
        ActionEquipMostDamagingMelee( oT );
    }
    else
    {
        ActionEquipMostDamagingMelee();
    }
}

talent GetTalentSpell( int iCat, int iD )
{
    int iCR = 21;
    talent tT;
    talent iT; //reserve for invalid talent return

    while ( --iCR )
    {
        tT = GetCreatureTalentBest( iCat, iCR );
        if ( ( GetIsTalentValid( tT ) && GetIdFromTalent( tT ) == iD ) || !GetIsTalentValid( tT ) )
        {
            break;
        }
    }
    if ( GetIsTalentValid( tT ) && GetIdFromTalent( tT ) == iD )
    {
        return tT;
    }
    return iT;
}


void DoFightBroadcast()
{
    //broadcast fight "noise" at most once a second
    //respect silence spell
    int iDelay = 2;
    int iTime = GetTimeSecond();
    int iLast = GetLocalInt( OBJECT_SELF, "#LASTCREBC" );
    int iS = iTime < iLast ? iTime + 60 : iTime;
    int iVol = NO_CAN_USE_DM_CHANNEL ? TALKVOLUME_SILENT_SHOUT : TALKVOLUME_SILENT_TALK;

    //anti-spamloop delay
    if ( iS - iLast >= iDelay )
    {
        //only broadcast noise if silence is not in effect
        if ( !( GetEffectsOnObject() & NO_EFFECT_SILENCE ) )
        {
           SpeakString( "BC_FIGHTING", iVol );
        }
        SetLocalInt( OBJECT_SELF, "#LASTCREBC", iTime );
        DeleteLocalInt( OBJECT_SELF, "#LASTREST" );
    }
}

int GetTimeSinceLastCombat()
{
    int iTime = GetTimeSecond();
    int iLast = GetLocalInt( OBJECT_SELF, "#LASTCREBC" );
    int iS = iTime < iLast ? iTime + 60 : iTime;
    int iT = iS - iLast;

    return iT;
}

void DoConditionalRestart( float fT=6.0 )
{
    DeleteLocalInt( OBJECT_SELF, "#RESTARTQUEUED" );
    if ( GetLocalInt( OBJECT_SELF, "#ACTIVE" ) && GetTimeSinceLastCombat() > FloatToInt( fT ) )
    {
        ClearAllActions();
        DeleteLocalInt( OBJECT_SELF, "#COMBATQUEUED" );
        //SetReadyStatus();
        DelayCommand( 0.1, DoQueueCombat( 8.0, 8.0 ) );
    }
}

void DoQueueShutdown( float fT=0.0 )
{
    if ( !GetLocalInt( OBJECT_SELF, "#QUEUESHUTDOWN" ) )
    {
        SetLocalInt( OBJECT_SELF, "#QUEUESHUTDOWN", 1 );
        DelayCommand( fT, ExecuteScript( "no_scr_shutdown", OBJECT_SELF ) );
    }
}

void DoQueueCombat( float fD=6.0, float fT=6.0 )
{
    if ( !GetLocalInt( OBJECT_SELF, "#ACTIVE" ) )
    {
        SetLocalInt( OBJECT_SELF, "#ACTIVE", 1 );
        DelayCommand( 0.1, ClearAllActions() );
    }
    if ( !GetLocalInt( OBJECT_SELF, "#COMBATQUEUED" ) )
    {
        SetLocalInt( OBJECT_SELF, "#COMBATQUEUED", 1 );
        DelayCommand( 0.2, ActionDoCommand( DoCombat() ) );
    }
    if ( !GetLocalInt( OBJECT_SELF, "#RESTARTQUEUED" ) )
    {
        SetLocalInt( OBJECT_SELF, "#RESTARTQUEUED", 1 );
        DelayCommand( fD, DoConditionalRestart( fT ) );
    }
}

void InitCombat( object oE=OBJECT_INVALID )
{
    int iT = GetLastActionTimestamp();

    if ( IsActive() == FALSE || GetCurrentAction() == ACTION_INVALID || iT > 8 )
    {
        ClearAllActions();
        SetIsActive( TRUE );
        DoCombat();
    }
}

void DoVoiceChat( int iV=-1 )
{
    int iC = GetLocalInt( OBJECT_SELF, "#VCC_" + IntToString( iV ) );

    if ( iC == -1 || !CanAct() )
    {
        //do not do this voice chat
        return;
    }
    if ( iC == 0 )
    {
        //no specific setting for this voice chat, use default chance
        iC = GetLocalInt( OBJECT_SELF, "#VCC" );
    }
    if ( Random( 100 ) < iC )
    {
        //don't bother talking to ourselves, look for a nearby friend
        object oF = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE );
        if ( GetIsObjectValid( oF ) && GetDistanceBetween( OBJECT_SELF, oF ) < 50.0 )
        {
            //there is a friendly nearby, do the voice chat
            int iD = iV;
            if ( iV == NO_VC_MELEE || iV == NO_VC_RANGED || iV == NO_VC_MELEEASSIST )
            {
                //custom voice chat handling
                iD = Random( 5 );
                switch( iD )
                {
                    case 1: iD = VOICE_CHAT_ATTACK;
                    case 2: iD = VOICE_CHAT_BATTLECRY1;
                    case 3: iD = VOICE_CHAT_BATTLECRY2;
                    case 4: iD = VOICE_CHAT_BATTLECRY3;
                    default: iD = VOICE_CHAT_TAUNT;
                }
            }
            PlayVoiceChat( iD );
        }
    }
}

void DoMainCombatLoop()
{
    int iCnt = 1;
    string sPri = GetPriority( iCnt );
    int iPri = GetPriorityChance( iCnt++ );

    while ( sPri != "" )
    {
        if ( sPri == "+ATKMELEE" && Random( 100 ) < iPri && DoAttackMelee() ) //atkmelee
        {
            //PrintString( "+ATKMELEE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+ATKRANGED" && Random( 100 ) < iPri && DoAttackRanged() ) //atkranged
        {
            //PrintString( "+ATKRANGED: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+COUNTERSPELL" && Random( 100 ) < iPri && DoCounterSpell() ) //counterspell
        {
            //PrintString( "+COUNTERSPELL: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+EVACAOE" && Random( 100 ) < iPri && DoEvacAOE() ) //evac AOEs
        {
            //PrintString( "+EVACAOE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+REGROUP" && Random( 100 ) < iPri && DoRegroup() ) //regroup with allies
        {
            //PrintString( "+REGROUP: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+DEFSELF" && Random( 100 ) < iPri && DoDefendSelf() ) //apply defenses
        {
            //PrintString( "+DEFSELF: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+DEFSING" && Random( 100 ) < iPri && DoDefendSingle() ) //apply defenses to single
        {
            //PrintString( "+DEFSING: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+ENHANCESELF" && Random( 100 ) < iPri && DoEnhanceSelf() ) //enhance self
        {
            //PrintString( "+ENHANCESELF: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+ENHANCESING" && Random( 100 ) < iPri && DoEnhanceSingle() ) //enhance single
        {
            //PrintString( "+ENHANCESING: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+HELP" && Random( 100 ) < iPri && DoSpellHelp() ) //remove afflictions
        {
            //PrintString( "+HELP: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+HEAL" && Random( 100 ) < iPri && DoSpellHeal() ) //heal
        {
            //PrintString( "+HEAL: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+RAISE" && Random( 100 ) < iPri && DoSpellRaise() ) //raise
        {
            //PrintString( "+RAISE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+BREACH" && Random( 100 ) < iPri && DoSpellBreach() ) //breach
        {
            //PrintString( "+BREACH: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+DIRECT" && Random( 100 ) < iPri && DoSpellDirect() ) //direct attack spell
        {
            //PrintString( "+DIRECT: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+TOUCH" && Random( 100 ) < iPri && DoTouch() ) //touch attack spell
        {
            //PrintString( "+TOUCH: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+AREA" && Random( 100 ) < iPri && DoSpellArea() ) //area attack spell
        {
            //PrintString( "+AREA: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+SUMMON" && Random( 100 ) < iPri && DoSpellSummon() ) //summon help
        {
            //PrintString( "+SUMMON: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+FEATENHANCE" && Random( 100 ) < iPri && DoFeatEnhance() ) //enhance via feat
        {
            //PrintString( "+FEATENHANCE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+AVOIDMELEE" && Random( 100 ) < iPri && DoAvoidMelee() ) //avoid melee
        {
            //PrintString( "+AVOIDMELEE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+TIMESTOP" && Random( 100 ) < iPri && DoTimeStop() ) //time stop
        {
            //PrintString( "+TIMESTOP: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+VIS" && Random( 100 ) < iPri && DoVision() ) //vision
        {
            //PrintString( "+VIS: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+BREATH" && Random( 100 ) < iPri && DoBreathWeapon() ) //breathweapon
        {
            //PrintString( "+BREATH: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+TURN" && Random( 100 ) < iPri && DoTurning() ) //turn undead
        {
            //PrintString( "+TURN: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+HEALSELF" && Random( 100 ) < iPri && DoHealSelf() ) //heal self
        {
            //PrintString( "+HEALSELF: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+GROUPENHANCE" && Random( 100 ) < iPri && DoSpellGroupEnhance() ) //group enhance
        {
            //PrintString( "+GROUPENHANCE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+DISPELAOE" && Random( 100 ) < iPri && DoDispelPersAOE() ) //dispel hostile AOEs
        {
            //PrintString( "+DISPELAOE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+DISPEL" && Random( 100 ) < iPri && DoDispelSingle() ) //dispel buffs on single enemy
        {
            //PrintString( "+DISPEL: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+DISMISSAL" && Random( 100 ) < iPri && DoDismissal() ) //dismiss enemy summons
        {
            //PrintString( "+DISMISSAL: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+MELEEASSIST" && Random( 100 ) < iPri && DoMeleeAssist() ) //assist friends in melee
        {
            //PrintString( "+MELEEASSIST: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+FLANK" && Random( 100 ) < iPri && DoFlank() ) //flank enemy
        {
            //PrintString( "+FLANK: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+GROUPHEAL" && Random( 100 ) < iPri && DoSpellGroupHeal() ) //use area heals
        {
            //PrintString( "+GROUPHEAL: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+MINDBLAST" && Random( 100 ) < iPri && DoMindBlast() ) //use mind blast psionics
        {
            //PrintString( "+MINDBLAST: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+BRAINEXTRACT" && Random( 100 ) < iPri && DoBrainExtraction() ) //Illithid brain extraction
        {
            //PrintString( "+BRAINEXTRACT: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+AVOIDENEMY" && Random( 100 ) < iPri && DoAvoidEnemies() ) //Move away from enemies
        {
            //PrintString( "+AVOIDENEMY: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+EYERAYS" && Random( 100 ) < iPri && DoBeholderRays() ) //Beholder eye rays
        {
            //PrintString( "+EYERAYS: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+CENTRALEYE" && Random( 100 ) < iPri && DoBeholderCentralEye() ) //Beholder's antimagic cone
        {
            //PrintString( "+CENTRALEYE: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+EN4INVIS" && Random( 100 ) < iPri && DoEN4Invis() )
        {
            SetLastAction( sPri );
            break;
        }
        else if ( sPri == "+EN4DMGSHIELD" && Random( 100 ) < iPri && DoEN4DmgShield() )
        {
            SetLastAction( sPri );
            break;
        }
        else if ( sPri == "+UNDEADHEAL" && Random( 100 ) < iPri && DoSpellUndeadHeal() ) //heal
        {
            //PrintString( "+HEAL: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }
        else if ( sPri == "+UNDEADHEALSELF" && Random( 100 ) < iPri && DoUndeadHealSelf() ) //heal self
        {
            //PrintString( "+HEALSELF: " + GetName( OBJECT_SELF ) );
            //return;
            SetLastAction( sPri );
            //SetLastActionTimestamp();
            break;
        }

        sPri = GetPriority( iCnt );
        iPri = GetPriorityChance( iCnt++ );
    }
}

//action functions
void DoCombat()
{
    //int iTime, iLast, iDiff;
    int iAct;
    float fDelay = 0.0;

    //delete queue marker
    DeleteLocalInt( OBJECT_SELF, "#COMBATQUEUED" );

    if ( GetIsDead( OBJECT_SELF ) )
    {
        return;
    }

    //int iE = GetHostileCount( 50.0 );
    int iE = GetOmniscientHostileCount( 50.0 );
    if ( iE == 0 )
    {
        return;
    }

    //make combat noise for nearby listeners
    DoFightBroadcast();

    //don't bother running scripts if we can't do anything
    if ( !CanAct() )
    {
        ClearAllActions();
        //queue a delay before checking again
        fDelay += 0.1;
        DelayCommand( fDelay, ActionWait( 1.0 ) );
        //return;
    }
    else
    {
        //can take action
        //If creature is busy do not proceed
        iAct = GetCurrentAction();
        if ( iAct == ACTION_CASTSPELL || iAct == ACTION_HEAL || iAct == ACTION_ITEMCASTSPELL || iAct == ACTION_PICKUPITEM || iAct == ACTION_WAIT ||
            GetLocalInt( OBJECT_SELF, "#EYERAYS" ) == 1 )
        {
            //do nothing
        }
        else
        {
            //run the combat response table
            ClearAllActions();
            DoMainCombatLoop();
            SetLastActionTimestamp();
        }
    }
    DoHideInPlainSight(); //testing HIPS between actions

    if ( !CanAct() || ShortAction() )
    {
        //DoQueueCombat( 8.0, 8.0 );
        fDelay += 0.1;
        DelayCommand( fDelay, ActionDoCommand( DoCombat() ) );
    }
}

int DoAttackMelee( object oT=OBJECT_INVALID )
{
    object oTarget;
    int iSpecial;
    int iMode;
    int iPen = 0;
    int iMelee = GetAttackerCount( 5.0 );
    int iCnt = 1;
    int iChat;
    location lLoc;
    vector vT, vU;
    object test;

    if ( GetIsObjectValid( oT ) )
    {
        oTarget = oT;
    }
    else if ( iMelee )
    {
        oTarget = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        while ( GetIsObjectValid( oTarget ) && GetDistanceBetween( OBJECT_SELF, oTarget ) <= 5.0 && GetAttackTarget( oTarget ) != OBJECT_SELF )
        {
            oTarget = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        }
    }
    else
    {
        oTarget = GetTarget();
    }

    if ( GetIsObjectValid( oTarget ) && ( GetObjectSeen( oTarget ) || GetObjectHeard( oTarget ) ) )
    {
        //PrintString( GetName( OBJECT_SELF ) + " melee attack " + GetName( oTarget ) + ": " + FloatToString( GetDistanceBetween( OBJECT_SELF, oTarget ) ) );
        DoEquipMelee( oTarget );
        DoVoiceChat( NO_VC_MELEE );
        //combat modes
        if ( iMode = SelectMeleeCombatModes( oTarget ) )
        {
            iPen = GetCombatModeModifier( iMode );
            DeactivateCombatModes( iMode );
            ActivateCombatMode( iMode );
            //ActionUseFeat( iMode, oTarget );

        }
        //special melee attacks
        if ( iSpecial = GetBestMeleeSpecial( oTarget, iPen ) )
        {
            ActionUseFeat( iSpecial, oTarget );
        }
        else
        {
            ActionAttack( oTarget );
        }
        return TRUE;
    }
    else
    {
        if ( !GetIsObjectValid( oTarget = GetLastDamager() ) )
        {
            if ( !GetIsObjectValid( oTarget = GetLastAttacker() ) )
            {
                oTarget = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE );
            }
        }
        if ( GetIsObjectValid( oTarget ) && GetDistanceBetween( OBJECT_SELF, oTarget ) <= 40.0 )
        {
            /*
            vU = GetPosition( OBJECT_SELF );
            vT = GetPosition( oTarget ) - vU;
            vT = VectorMagnitude( vT ) * VectorNormalize( AngleToVector( VectorToAngle( vT ) - 45.0 + IntToFloat( Random( 90 ) ) ) );
            lLoc = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
            */
            lLoc = GetLocation( oTarget );
            DoMoveToLocation( lLoc, TRUE );
            return TRUE;
        }
    }
    return FALSE;
}

int DoAttackRanged( object oT=OBJECT_INVALID )
{
    object oTarget = ( GetIsObjectValid( oT ) ) ? oT : GetTarget();
    object oHurt;
    //talent tSpecial;
    int iSpecial;
    int iMode;
    int iPen = 0;
    int iAtk = GetAttackerCount();
    int iChat;
    location lLoc;

    //don't proceed if enemies are close
    //if creature should avoid melee that should be added as a priority
    //above this behaviour
    if ( GetHostileCount( 5.0 ) )
    {
        return FALSE;
    }

    //raging barbarians should not use ranged attack
    if ( GetHasFeatEffect( FEAT_BARBARIAN_RAGE, OBJECT_SELF ) || GetHasFeatEffect( FEAT_MIGHTY_RAGE, OBJECT_SELF ) )
    {
        //raging barbarians should skip ranged
        return FALSE;
    }

    if ( !GetLocalInt( OBJECT_SELF, "#RANGEDCAPABLE" ) )
    {
        if ( !GetHasRangedCapability() )
        {
            return FALSE;
        }
        SetLocalInt( OBJECT_SELF, "#RANGEDCAPABLE", 1 );
    }

    if ( GetIsObjectValid( oTarget ) && !iAtk )
    {
        /* This should be done explicitly with the avoid melee behaviour
        if ( GetHostileCount( 5.0 ) )
        {
            if ( DoAvoidMelee() )
            {
                //PrintString( GetName( OBJECT_SELF ) + " avoiding melee before ranged attack" );
                return TRUE;
            }
        }
        */

        //PrintString( GetName( OBJECT_SELF ) + " ranged attack " + GetName( oTarget ) + ": " + IntToString( iAtk ) + FloatToString( GetDistanceBetween( OBJECT_SELF, oTarget ) ) );
        if ( !GetIsObjectValid( oT ) ) //not specifically told to attack a target
        {
            if ( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) &&
                GetIsObjectValid( oHurt = GetMostDamagedAlly( 20.0, oTarget, TRUE ) ) )
            {
                oTarget = oHurt;
            }
        }

        ActionEquipMostDamagingRanged( oTarget );
        DoVoiceChat( NO_VC_RANGED );
        //combat modes
        if ( iMode = SelectRangedCombatModes( oTarget ) )
        {
            iPen = GetCombatModeModifier( iMode );
            DeactivateCombatModes( iMode );
            ActivateCombatMode( iMode );
            ActionUseFeat( iMode, oTarget );
        }
        //special ranged attacks
        if ( iSpecial = GetBestRangedSpecial( oTarget, iPen ) )
        {
            ActionUseFeat( iSpecial, oTarget );
        }
        else
        {
            ActionAttack( oTarget );
        }
        return TRUE;
    }
    //PrintString( GetName( OBJECT_SELF ) + " aborting ranged attack: " + IntToString( iAtk ) );
    return FALSE;
}

int DoCounterSpell( object oT=OBJECT_INVALID )
{
    object oC = ( GetIsObjectValid( oT ) ) ? oT : GetNearestEnemyCaster();

    //do not counterspell if I have timestop running
    if ( GetHasSpellEffect( SPELL_TIME_STOP ) )
    {
        return FALSE;
    }
    //do not counterspell if I have attackers
    if ( GetAttackerCount( 40.0 ) )
    {
        return FALSE;
    }

    //dead/living status should be handled by GetNearestEnemyCaster()
    if ( GetIsObjectValid( oC ) )
    {
        //PrintString( GetName( OBJECT_SELF ) + " counterspelling " + GetName( oC ) );
        ActionCounterSpell( oC );
        return TRUE;
    }
    return FALSE;
}

int DoEvacAOE()
{
    vector vT;
    location lLoc;

    //don't bother if we have time stop
    if ( GetHasSpellEffect( SPELL_TIME_STOP ) )
    {
        return FALSE;
    }

    if ( GetAOECount( 7.5 ) )
    {
        vT = GetAOEEvacVector( GetAOEVector( 15.0 ) );
        lLoc = Location( GetArea( OBJECT_SELF ), vT, GetFacing( OBJECT_SELF ) );
        SetLocalLocation( OBJECT_SELF, "LASTLOC", GetLocation( OBJECT_SELF ) );
        DoMoveToLocation( lLoc, TRUE );
        return TRUE;
    }
    return FALSE;
}

int DoRegroup( object oT=OBJECT_INVALID )
{
    int iCnt = 0;
    int iE = 0;
    object oFriend;
    object oDistant = OBJECT_INVALID;
    vector vU, vT, vM;
    location lLoc;

    //check for order to regroup to a particular object
    if ( GetIsObjectValid( oT ) )
    {
        DoMoveToObject( oT, TRUE, 5.0 );
        return TRUE;
    }

    //don't bother if we have time stop
    if ( GetHasSpellEffect( SPELL_TIME_STOP ) )
    {
        return FALSE;
    }

    vU = GetPosition( OBJECT_SELF );
    vT = Vector( 0.0, 0.0, 0.0 );
    oFriend = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    while ( GetIsObjectValid( oFriend ) )
    {
        vT = vT + GetPosition( oFriend ) - vU;
        oFriend = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }

    if ( VectorMagnitude( vT ) > 0.0 )
    {
        vT = vT / IntToFloat( iCnt - 1 );
    }

    if ( VectorMagnitude( vT ) == 0.0 )
    {
        oFriend = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE );
        if ( GetIsObjectValid( oFriend ) && GetDistanceBetween( OBJECT_SELF, oFriend ) < 60.0 /*&& GetDistanceBetween( OBJECT_SELF, oFriend ) > 30.0*/ )
        {
            //we do have friends nearby but can't see them
            DoMoveToLocation( GetLocation( oFriend ), TRUE );
            return TRUE;
        }
    }
    if ( VectorMagnitude( vT ) > 25.0 )
    {
        if ( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) )
        {
            //need to regroup, get movement vector
            vT = vT - 10.0 * VectorNormalize( vT );
            vM = vU + vT;
            lLoc = Location( GetArea( OBJECT_SELF ), vM, VectorToAngle( vT ) );
            DoMoveToLocation( lLoc, TRUE );
            //PrintString( GetName( OBJECT_SELF ) + " REGROUPING: (" + FloatToString( vM.x ) + "," + FloatToString( vM.y ) + ")" );
            DoVoiceChat( VOICE_CHAT_GROUP );
            return TRUE;
        }
    }
    else
    {
        //look for outliers
        iCnt = 0;
        oFriend = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        while ( GetIsObjectValid( oFriend ) )
        {
            oDistant = oFriend;
            oFriend = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        }
        if ( GetIsObjectValid( oDistant ) )
        {
            if ( GetDistanceBetween( OBJECT_SELF, oDistant ) > 30.0 )
            {
                DoMoveToObject( oDistant, TRUE, 10.0 );
                //PrintString( GetName( OBJECT_SELF ) + " finding OUTLIER " + GetName( oDistant ) );
                DoVoiceChat( VOICE_CHAT_GROUP );
                return TRUE;
            }
        }
    }
    return FALSE;
}

int DoDefendSelf()
{
    int iMagic = GetCasterCount( 40.0 );
    int iPhys = GetAttackerCount( 40.0 );
    int iPotAtk = GetHostileCount( 40.0 );
    int iSpell = 0;
    talent tSpell;
    struct sSpellDefStatus strMDef = EvaluateSpellDefenses();
    struct sPhysDefStatus strPDef = EvaluatePhysicalDefenses();

    if ( ( iPhys || iPotAtk ) && strPDef.iTotal < 4 )
    {
        /*
        if ( iSpell = GetBestPhysDefense() ) //again, no acid fog
        {
            tSpell = TalentSpell( iSpell );
        }
        */
        if ( iSpell = GetBestPhysDefenseSelf() )
        //if ( GetIsTalentValid( tSpell ) )
        {
            //PrintString( "PD: " + GetName( OBJECT_SELF ) + "(" + IntToString( iSpell ) + ")" );
            //ActionCastSpellAtObject( iSpell, OBJECT_SELF );
            NO_ActionCastSpellAtObject( iSpell, OBJECT_SELF );
            //ActionUseTalentOnObject( tSpell, OBJECT_SELF );
            return TRUE;
        }
    }
    if ( iMagic && strMDef.iTotal < 4 )
    {
        /*
        if ( iSpell = GetBestMagicDefense() ) //can assume acid fog (int val 0) won't be returned here
        {
            tSpell = TalentSpell( iSpell );
        }
        */
        if ( iSpell = GetBestMagicDefenseSelf() )
        //if ( GetIsTalentValid( tSpell ) )
        {
            //PrintString( "MD: " + GetName( OBJECT_SELF ) + "(" + IntToString( iSpell ) + ")" );
            //ActionCastSpellAtObject( iSpell, OBJECT_SELF );
            NO_ActionCastSpellAtObject( iSpell, OBJECT_SELF );
            //ActionUseTalentOnObject( tSpell, OBJECT_SELF );
            return TRUE;
        }
    }

    /*
    if ( iSpell = GetBestGenericProtection() )
    {
        tSpell = TalentSpell( iSpell );
    }
    if ( GetIsTalentValid( tSpell ) )
    {
        //ActionCastSpellAtObject( iSpell, OBJECT_SELF );
        ActionUseTalentOnObject( tSpell, OBJECT_SELF );
        return TRUE;
    }
    */
    return FALSE;
}

int DoDefendSingle( object oT=OBJECT_INVALID )
{
    object oD;
    int iSpell;
    struct sSpellDefStatus strM;
    struct sPhysDefStatus strP;

    oD = ( GetIsObjectValid( oT ) ) ? oT : GetLeastDefendedAlly( 20.0 );
    if ( GetIsObjectValid( oD ) )
    {
        strM = EvaluateSpellDefenses( oD );
        strP = EvaluatePhysicalDefenses( oD );
        if ( strM.iTotal < strP.iTotal )
        {
            if ( iSpell = GetBestMagicDefenseSingle( oD ) )
            {
                //PrintString( "DDSM: " + GetName( OBJECT_SELF ) + " -> " + GetName( oD ) + " (" + IntToString( iSpell ) + ")" );
                //ActionCastSpellAtObject( iSpell, oD );
                NO_ActionCastSpellAtObject( iSpell, oD );
                return TRUE;
            }
        }
        else
        {
            //strP.iTotal <= strM.iTotal
            if ( iSpell = GetBestPhysDefenseSingle( oD ) )
            {
                //PrintString( "DDSP: " + GetName( OBJECT_SELF ) + " -> " + GetName( oD ) + " (" + IntToString( iSpell ) + ")" );
                //ActionCastSpellAtObject( iSpell, oD );
                NO_ActionCastSpellAtObject( iSpell, oD );
                return TRUE;
            }
        }
    }
    return FALSE;
}

int DoEnhanceSelf()
{
    int iMinLvl = GetHitDice( OBJECT_SELF );
    iMinLvl = iMinLvl > 20 ? 20 : iMinLvl;
    iMinLvl = iMinLvl / 3;
    int iSpell = GetEnhanceSpellSelf( iMinLvl );
    vector vT, vU;
    location lM;
    //talent tSpell;

    if ( iSpell )
    {
        /*
        tSpell = TalentSpell( iSpell );
        if ( GetIsTalentValid( tSpell ) )
        {
            ActionUseTalentOnObject( tTest, OBJECT_SELF );
        }
        */
        //ActionCastSpellAtObject( iSpell, OBJECT_SELF );
        NO_ActionCastSpellAtObject( iSpell, OBJECT_SELF );
        if ( iSpell == SPELL_INVISIBILITY || iSpell == SPELL_IMPROVED_INVISIBILITY )
        {
            //move a bit after casting invisibility on self
            if ( VectorMagnitude( vT = GetHostileVector( 10.0 ) ) > 0.0 )
            {
                vU = GetPosition( OBJECT_SELF );
                vT = 5.0 * AngleToVector( VectorToAngle( vT ) + 90.0 + IntToFloat( Random( 180 ) ) );
                lM = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
                DoMoveToLocation( lM, TRUE );
                vT = 5.0 * AngleToVector( VectorToAngle( vT ) - 90.0 + IntToFloat( Random( 180 ) ) );
                lM = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
                DoMoveToLocation( lM, TRUE );
            }
        }
        return TRUE;
    }
    return FALSE;
}

int DoEnhanceSingle( object oT=OBJECT_INVALID )
{
    int iMinLvl = GetHitDice( OBJECT_SELF );
    iMinLvl = iMinLvl > 20 ? 20 : iMinLvl;
    iMinLvl = iMinLvl / 3;
    int iSpell = 0;
    vector vT, vU;
    location lM;
    object oE = ( GetIsObjectValid( oT ) ) ? oT : GetLeastBuffedAlly( 20.0, TRUE );

    if ( GetIsObjectValid( oE ) )
    {
        if ( iSpell = GetEnhanceSpellSingle( iMinLvl, oE ) )
        {
            //PrintString( "DES: " + GetName( OBJECT_SELF ) + " -> " + GetName( oE ) + " (" + IntToString( iSpell ) + ")" );
            //ActionCastSpellAtObject( iSpell, oE );
            NO_ActionCastSpellAtObject( iSpell, oE );
            return TRUE;
        }
        if ( oE == OBJECT_SELF )
        {
            if ( iSpell == SPELL_INVISIBILITY || iSpell == SPELL_IMPROVED_INVISIBILITY )
            {
                //move a bit after casting invisibility on self
                if ( VectorMagnitude( vT = GetHostileVector( 10.0 ) ) > 0.0 )
                {
                    vU = GetPosition( OBJECT_SELF );
                    vT = 5.0 * AngleToVector( VectorToAngle( vT ) + 90.0 + IntToFloat( Random( 180 ) ) );
                    lM = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
                    DoMoveToLocation( lM, TRUE );
                    vT = 5.0 * AngleToVector( VectorToAngle( vT ) - 90.0 + IntToFloat( Random( 180 ) ) );
                    lM = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
                    DoMoveToLocation( lM, TRUE );
                }
            }
        }
    }
    return FALSE;
}

/*
====================
DoSpellHelp:

Description: Find the ally with the most hampering effects on them and try to remove them.

Notes: Problem with this behaviour is that it always looks for most hampered ally. If it can't help that ally then
it will not help anyone. If there are less hampered allies that it could help it will never know because it goes
straight to the most hampered

Possible fix: First generate full list of possible help it can provide stored as bits and do bitwise AND against
effects on each ally. If there are no matches at all, do not consider them. Store the ally with the most matches
of available help vs hampering effects. Not yet tried.
====================
*/
int DoSpellHelp( object oT=OBJECT_INVALID )
{
    object oHurt;
    int iHelp;

    if ( GetHasHelpingAbility() )
    {
        oHurt = ( GetIsObjectValid( oT ) ) ? oT : GetMostHamperedAlly( 30.0, OBJECT_SELF, TRUE );
        if ( GetIsObjectValid( oHurt ) )
        {
            iHelp = GetBestHelp( oHurt );
            if ( iHelp )
            {
                SetLocalObject( oHurt, "HELPER", OBJECT_SELF );
                DelayCommand( 6.0, DeleteLocalObject( oHurt, "HELPER" ) );
                //PrintString( "HELP: " + GetName( OBJECT_SELF ) + " -> " + GetName( oHurt ) + "(" + IntToString( iHelp ) + ")" );
                //ActionCastSpellAtObject( iHelp, oHurt );
                NO_ActionCastSpellAtObject( iHelp, oHurt );
                return TRUE;
            }
            //PrintString( "HELP: fail " + GetName( OBJECT_SELF ) + " -> " + GetName( oHurt ) );
        }
    }
    return FALSE;
}

int DoSpellHeal( object oT=OBJECT_INVALID )
{
    //original heal code
    object oHurt;
    int iHeal, iCR;
    talent tHeal;
    int iMin = 8;

    if ( GetHasHealingAbility() )
    //if ( GetIsTalentValid( GetCreatureTalentBest( TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20 ) ) )
    {
        oHurt = ( GetIsObjectValid( oT ) ) ? oT : GetLowestHPAllyNoHealer( 30.0, iMin, OBJECT_SELF, TRUE );
        if ( GetIsObjectValid( oHurt ) )
        {
            /*
            // Need to use this hack with talents because GetHasSpell will pick up spontaneous casting ability
            // but ActionCastSpell* cannot do the spontaneous casting, which leaves the creature daydreaming
            // rather than acting
            */
            iHeal = GetBestHeal( oHurt, iMin );
            tHeal = GetTalentSpell( TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, iHeal );
            //if ( iHeal )
            if ( GetIsTalentValid( tHeal ) )
            {
                //PrintString( "HEAL: " + GetName( OBJECT_SELF ) + " -> " + GetName( oHurt ) + " (" + IntToString( iHeal ) + ")" );
                SetLocalObject( oHurt, "#HEALER", OBJECT_SELF );
                DelayCommand( 6.0, DeleteLocalObject( oHurt, "#HEALER" ) );
                //ActionCastSpellAtObject( iHeal, oHurt );
                //ActionUseTalentOnObject( tHeal, oHurt );
                NO_ActionUseTalentOnObject( tHeal, oHurt );
                return TRUE;
            }
        }
    }
    return FALSE;
}

int DoSpellRaise( object oT=OBJECT_INVALID )
{
    //original raise code
    object oHurt;
    int iRaise;

    if ( GetHasRaisingAbility() )
    {
        oHurt = ( GetIsObjectValid( oT ) && GetIsDead( oT ) ) ? oT : GetNearestDeadAllyNoRaiser( 30.0, OBJECT_SELF, TRUE );
        if ( GetIsObjectValid( oHurt ) )
        {
            iRaise = GetBestRaise( TRUE );
            if ( iRaise )
            {
                SetLocalObject( oHurt, "#RAISER", OBJECT_SELF );
                DelayCommand( 6.0, DeleteLocalObject( oHurt, "#RAISER" ) );
                //ActionCastSpellAtObject( iRaise, oHurt );
                NO_ActionCastSpellAtObject( iRaise, oHurt );
                return TRUE;
            }
        }
    }
    return FALSE;
}

int DoSpellBreach( object oT=OBJECT_INVALID )
{
    int iCnt = 1;
    int iSpell = 0;
    int iMaxLvl = 0;
    int iMaxNum = 0;
    struct sSpellDefStatus strMDef;
    struct sPhysDefStatus strPDef;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
    object oTarget = OBJECT_INVALID;

    //add breach check before doing search?
    if ( GetIsObjectValid( oT ) )
    {
        oTarget = oT;
    }
    else
    {
        while ( !GetIsObjectValid( oTarget ) && GetIsObjectValid( oSub ) )
        {
            if ( !GetIsDead( oSub ) && !GetIsObjectValid( GetLocalObject( oSub, "BREACHER" ) ) )
            {
                strMDef = EvaluateSpellDefenses( oSub );
                strPDef = EvaluatePhysicalDefenses( oSub );

                if ( strMDef.iTotal + strPDef.iTotal > iMaxLvl )
                {
                    oTarget = oSub;
                    iMaxLvl = strMDef.iTotal + strPDef.iTotal;
                }
            }
            oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
        }
    }

    if ( GetIsObjectValid( oTarget ) )
    {
        if ( iSpell = GetBestBreach( iMaxLvl ) )
        {
            //ActionCastSpellAtObject( iSpell, oTarget );
            NO_ActionCastSpellAtObject( iSpell, oTarget );
            SetLocalObject( oTarget, "BREACHER", OBJECT_SELF );
            DelayCommand( 4.0, DeleteLocalObject( oTarget, "BREACHER" ) );
            return TRUE;
        }
    }
    return FALSE;
}

int DoSpellDirect( object oT=OBJECT_INVALID )
{
    int iSpell = -1;
    int iMinLvl = 0;
    float fRange = 25.0;
    object oHurt;
    object oTarget;
    float fRad;
    float fRatio;
    location lLoc;
    talent tSpell;

    //go for least defended, failing that go for most damaged
    //in practice GetLeastMagicDefendedEnemy should always return someone if any
    //enemies are visible to caller
    if ( GetIsObjectValid( oT ) )
    {
        oTarget = oT;
    }
    else if ( !GetIsObjectValid( oTarget = GetLeastMagicDefendedEnemy( fRange ) ) )
    {
        oTarget = GetTarget();
        if ( DoAbilityCheck( ABILITY_INTELLIGENCE, 5) )
        {
            oHurt = GetMostDamagedAlly( 20.0, oTarget, TRUE );
        }
        if ( GetIsObjectValid( oHurt ) && GetObjectSeen( oHurt, OBJECT_SELF ) )
        {
            oTarget = oHurt;
        }
    }

    //open up spell level selection range
    iMinLvl = GetHitDice( oTarget ) / 3;

    //PrintString( GetName( OBJECT_SELF ) + " DS" + IntToString( iMinLvl ) );
    if ( GetIsObjectValid( oTarget ) && GetObjectSeen( oTarget, OBJECT_SELF ) )
    {
        iSpell = GetDirectSpell( oTarget, FALSE, iMinLvl );
    }
    if ( iSpell > -1 && ( fRad = GetAreaSpellRadius( iSpell ) ) > 0.0 )
    {
        //direct spell has radius effect
        //this code should be unnecessary now
        fRatio = GetFriendFoeRatio( GetLocation( oTarget ), fRad );
        if ( fRatio < GetFriendFoeTolerance() )
        {
            iSpell = GetDirectSpell( oTarget, TRUE, iMinLvl );
        }
    }
    //Testing immunity checks
    //result: feh, doesn't work properly, 100% immunity to damage type doesn't count as "immunity". go figure.
    //SpeakString( "IT " + GetName( oTarget ) + " " + IntToString( FortitudeSave( oTarget, 1000, SAVING_THROW_TYPE_FIRE ) ) );

    /* Spell/Talent Issue
    if ( iSpell > -1 )
    {
        tSpell = TalentSpell( iSpell );
    }
    */
    if ( iSpell > -1 )
    {
        //ActionCastSpellAtObject( iSpell, oTarget );
        NO_ActionCastSpellAtObject( iSpell, oTarget );
        //ActionUseTalentOnObject( tSpell, oTarget );
        return TRUE;
    }
    return FALSE;
}

int DoTouch( object oT=OBJECT_INVALID )
{
    int iSpell = -1;
    int iMinLvl = 0;
    float fRange = 20.0;
    object oHurt;
    object oTarget;

    //go for least defended, failing that go for most damaged
    //in practice GetLeastMagicDefendedEnemy should always return someone if any
    //enemies are visible to caller
    if ( GetIsObjectValid( oT ) )
    {
        oTarget = oT;
    }
    else if ( !GetIsObjectValid( oTarget = GetLeastMagicDefendedEnemy( fRange ) ) )
    {
        oTarget = GetTarget();
        if ( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) )
        {
            oHurt = GetMostDamagedAlly( 10.0, oTarget, TRUE );
        }
        if ( GetIsObjectValid( oHurt ) && GetObjectSeen( oHurt, OBJECT_SELF ) )
        {
            oTarget = oHurt;
        }
    }

    //open up spell level selection range
    iMinLvl = GetHitDice( oTarget ) / 3;

    //PrintString( GetName( OBJECT_SELF ) + " TS" + IntToString( iMinLvl ) );
    if ( GetIsObjectValid( oTarget ) && GetObjectSeen( oTarget, OBJECT_SELF ) )
    {
        iSpell = GetTouchSpell( oTarget, iMinLvl );
    }

    /* Spell/Talent Issue
    if ( iSpell > -1 )
    {
        tSpell = TalentSpell( iSpell );
    }
    */
    if ( iSpell > -1 )
    {
        //ActionCastSpellAtObject( iSpell, oTarget );
        NO_ActionCastSpellAtObject( iSpell, oTarget );
        //ActionUseTalentOnObject( tSpell, oTarget );
        return TRUE;
    }
    return FALSE;
}

int DoSpellArea()
{
    int iCnt;
    int iMinLvl = 0;
    int iSpell = -1;
    int iHostiles = GetHostileCount( 40.0 );
    float fRad;
    float fRange;
    float fRatio;
    float fDist;
    float fMinSearch = 0.0;
    float fMaxSearch;
    vector vU;
    vector vT;
    vector vS;
    location lMark;
    object oTarget;
    object oD;
    talent tSpell;

    if ( !iHostiles )
    {
        return FALSE;
    }

    //estimate average enemy hit dice to get an idea of what spell level range we should consider
    iMinLvl = GetSafeAverageEnemyLevel();

    if ( iHostiles == 1 )
    {
        oTarget = GetTarget();
        if ( !GetIsObjectValid( oTarget ) )
        {
            return FALSE;
        }
        else
        {
            fMaxSearch = GetDistanceBetween( OBJECT_SELF, oTarget );
            iSpell = GetAreaSpell( Vector( 0.0, 0.0, 0.0 ), FALSE, iMinLvl, fMaxSearch );
            if ( iSpell == -1 )
            {
                return FALSE;
            }
            fRad = GetAreaSpellRadius( iSpell );
            vT = GetPosition( oTarget ) - GetPosition( OBJECT_SELF );
        }
    }
    else if ( iHostiles > 1 )
    {
        //fMaxSearch = VectorMagnitude( GetHostileVector( 40.0 ) );
        /*
        oD = GetMostDistantEnemy( 40.0 );
        if ( GetIsObjectValid( oD ) )
        {
            fMaxSearch = GetDistanceBetween( OBJECT_SELF, oD );
        }
        else
        {
            //apparently no enemies spotted, should be impossible at this point
            fMaxSearch = 40.0;
        }
        */
        fMaxSearch = GetAverageDistanceToEnemy( 40.0 );
        //SpeakString( "ADtE: " + FloatToString( fMaxSearch ) + " AEL: " + IntToString( iMinLvl ) );
        iSpell = GetAreaSpell( Vector( 0.0, 0.0, 0.0 ), FALSE, iMinLvl, fMaxSearch );
        if ( iSpell < 0 )
        {
            //SpeakString( "No spell" );
            return FALSE;
        }
        //SpeakString( "Spell: " + IntToString( iSpell ) );
        fRad = GetAreaSpellRadius( iSpell );
        vT = GetAreaTarget( iSpell, fRad, fMinSearch, fMaxSearch );
        vS = GetAverageEnemySaveInArea( vT, fRad );
        //SpeakString( "AES: " + FloatToString( vS.x ) + " " + FloatToString( vS.y ) + " " + FloatToString( vS.z ) );
    }

    //PrintString( GetName( OBJECT_SELF ) + " AS" + IntToString( iMinLvl ) );

    fRange = GetSpellRange( iSpell );
    vU = GetPosition( OBJECT_SELF );
    //single target case
    if ( iHostiles == 1 )
    {
        lMark = GetLocation( OBJECT_SELF );
        if ( GetIsDiscriminantSpell( iSpell ) )
        {
            if ( fRange == 0.0 )
            {
                //ActionCastSpellAtLocation( iSpell, lMark );
                NO_ActionCastSpellAtLocation( iSpell, lMark );
            }
            else
            {
                //ActionCastSpellAtObject( iSpell, oTarget );
                NO_ActionCastSpellAtObject( iSpell, oTarget );
            }
            return TRUE;
        }
        else
        {
            if ( fRange == 0.0 )
            {
                fRatio = GetFriendFoeRatio( lMark, fRad );
                if ( fRatio < GetFriendFoeTolerance() )
                {
                    iSpell = GetAreaSpell( Vector( 0.0, 0.0, 0.0 ), TRUE, iMinLvl, fMaxSearch );
                    if ( iSpell < 0 )
                    {
                        //fRatio not acceptable, no discriminant spells
                        return FALSE;
                    }
                }
                //either fRatio is okay or we have a discriminant spell
                fRange = GetSpellRange( iSpell );
                if ( fRange == 0.0 )
                {
                    //ActionCastSpellAtLocation( iSpell, lMark );
                    NO_ActionCastSpellAtLocation( iSpell, lMark );
                }
                else
                {
                    //ActionCastSpellAtObject( iSpell, oTarget );
                    NO_ActionCastSpellAtObject( iSpell, oTarget );
                }
                return TRUE;
            }
            fRatio = GetFriendFoeRatio( GetLocation( oTarget ), fRad );
            if ( fRatio < GetFriendFoeTolerance() )
            {
                iSpell = GetAreaSpell( Vector( 0.0, 0.0, 0.0 ), TRUE, iMinLvl, fMaxSearch );
                if ( iSpell < 0 )
                {
                    return FALSE;
                }
            }
            //either fRatio is okay or we have a discriminant spell
            fRange = GetSpellRange( iSpell );
            if ( fRange == 0.0 )
            {
                //ActionCastSpellAtLocation( iSpell, lMark );
                NO_ActionCastSpellAtLocation( iSpell, lMark );
            }
            else
            {
                //ActionCastSpellAtObject( iSpell, oTarget );
                NO_ActionCastSpellAtObject( iSpell, oTarget );
            }
            return TRUE;
        }
    }
    //multiple target case
    if ( iHostiles > 1 )
    {
        //PrintString( "AREA: " + GetName( OBJECT_SELF ) + FloatToString( fMaxSearch ) );
        if ( VectorMagnitude( vT ) == 0.0 )
        {
            //SpeakString( "No target" );
            return FALSE;
        }
        /*
        if ( 5 - GetAbilityModifier( ABILITY_INTELLIGENCE ) > 0 )
        {
            lMark = Location( GetArea( OBJECT_SELF ),
                    vU + vT + VectorNormalize( AngleToVector( IntToFloat( Random( 360 ) ) ) ) * IntToFloat( Random( 5 - GetAbilityModifier( ABILITY_INTELLIGENCE ) ) ),
                    GetFacing( OBJECT_SELF ) );
        }
        else
        {
            lMark = Location( GetArea( OBJECT_SELF ), vU + vT, GetFacing( OBJECT_SELF ) );
        }
        */
        lMark = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
        //SpeakString( GetName( OBJECT_SELF ) + " AS(" + IntToString( iSpell ) + ")" );
        if ( !GetIsDiscriminantSpell( iSpell ) )
        {
            fRatio = GetFriendFoeRatio( lMark, fRad );
            //SpeakString( "AS FFR" + FloatToString( fRatio ) );
            if ( fRatio < GetFriendFoeTolerance() )
            {
                iSpell = GetAreaSpell( Vector( 0.0, 0.0, 0.0 ), TRUE, iMinLvl, fMaxSearch ); //get discriminant area spell if possible
                if ( iSpell < 0 )
                {
                    //SpeakString( GetName( OBJECT_SELF ) + " !iDisc " + FloatToString( fRatio ) );
                    return FALSE;
                }
                //PrintString( GetName( OBJECT_SELF ) + " iDisc " + FloatToString( fRatio ) );
            }
            else
            {
                //SpeakString( GetName( OBJECT_SELF ) + " FFOK " + FloatToString( fRatio ) );
            }
        }
        //either friendfoe ratio is acceptable or we have a discriminant spell
        //if the spell is lightning or chain lightning target it at nearest creature
        //do this sometimes with delayed blast fireball
        if ( iSpell == SPELL_LIGHTNING_BOLT || iSpell == SPELL_CHAIN_LIGHTNING || iSpell == SPELL_GEDLEES_ELECTRIC_LOOP )
        {
            oTarget = GetFirstObjectInShape( SHAPE_SPHERE, fRad, lMark );
            while ( GetIsObjectValid( oTarget ) )
            {
                if ( GetObjectType( oTarget ) == OBJECT_TYPE_CREATURE || GetIsPC( oTarget ) )
                {
                    if ( GetObjectSeen( oTarget ) && !GetIsDead( oTarget ) && GetIsEnemy( oTarget ) )
                    {
                        //PrintString( "AS LCL " + GetName( oTarget ) );
                        break;
                    }
                }
                oTarget = GetNextObjectInShape( SHAPE_SPHERE, fRad, lMark );
            }
            if ( GetIsObjectValid( oTarget ) ) //should always be valid
            {
                //PrintString( "AS CL" + GetName( oTarget ) );
                //ActionCastSpellAtObject( iSpell, oTarget );
                NO_ActionCastSpellAtObject( iSpell, oTarget );
                return TRUE;
            }
        }
        //don't cast an area spell right next to myself
        //maybe later add something to see if I am immune to the spell
        //and cast anyway if so
        //Spells with range of 0 should be okay to cast
        else if ( GetIsDiscriminantSpell( iSpell ) ||
            ( GetSpellRange( iSpell ) > 0.0 && VectorMagnitude( vT ) > fRad ) ||  GetSpellRange( iSpell ) == 0.0 ||
            IsCone( iSpell ) )
        {
            //ActionCastSpellAtLocation( iSpell, lMark );
            NO_ActionCastSpellAtLocation( iSpell, lMark );
            return TRUE;
        }
    }
    return FALSE;
}

int DoSpellSummon()
{
    int iMinLvl = GetAverageEnemyLevel();
    int iSpell = GetSummonSpell( iMinLvl );
    int iA;
    vector vT, vA;
    object oTarget = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );

    if ( iSpell && !GetLocalInt( OBJECT_SELF, "#SUMMONDEL" ) && !GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_SUMMONED ) ) )
    {
        /*
        vT = AngleToVector( GetFacing( OBJECT_SELF ) - 90.0 + IntToFloat( Random( 180 ) ) );
        //testing addition to stop summoning creatures into AOEs
        if ( GetAOECount( 10.0 ) )
        {
            vT = GetAOEVector( 10.0 );
            vT *= -1.0;
        }
        //end test code
        vT = 3.0 * VectorNormalize( vT );
        vT = GetPosition( OBJECT_SELF ) + vT;
        ActionCastSpellAtLocation( iSpell, Location( GetArea( OBJECT_SELF ), vT, GetFacing( OBJECT_SELF ) ) );
        */
        //ActionCastSpellAtLocation( iSpell, GetLocation( OBJECT_SELF ) );
        NO_ActionCastSpellAtLocation( iSpell, GetLocation( OBJECT_SELF ) );
        SetLocalInt( OBJECT_SELF, "#SUMMONDEL", 1 );
        DelayCommand( 6.0, DeleteLocalInt( OBJECT_SELF, "#SUMMONDEL" ) );
        DelayCommand( 6.0, SpeakString( "BC_FIGHTING", TALKVOLUME_SILENT_TALK ) );
        return TRUE;
    }
    return FALSE;
}

int DoSpellCharm()
{
    //included in DoSpellDirect()
    return FALSE;
}

int DoFeatEnhance()
{
    //NOTE: should be okay to rely on enhance feats to be non-zero as Alertness should never be returned
    int iFeat = GetEnhanceFeat();

    if ( iFeat )
    {
        ActionUseFeat( iFeat, OBJECT_SELF );
        return TRUE;
    }
    return FALSE;
}

int DoDragonFlight()
{
    //unused due to lack of re-entry animation
    /*
    int iCnt = 1;
    object oTarget = OBJECT_INVALID;

    if ( GetLocalInt( OBJECT_SELF, "FLIER" ) && GetHostileCount() > 3 )
    {
        oTarget = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
        while ( GetIsObjectValid( oTarget ) )
        {
            if ( Random( 5 ) && GetDistanceBetween( OBJECT_SELF, oTarget ) > 10.0 )
            {
                break;
            }
            oTarget = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
        }
        if ( GetIsObjectValid( oTarget ) )
        {
            DoMoveToObject( oTarget );
            return TRUE;
        }
    }
    */
    return FALSE;
}

/*
int DoAvoidMelee()
{
    vector vT;
    location lLoc;

    //don't bother if we have time stop
    if ( GetHasSpellEffect( SPELL_TIME_STOP ) )
    {
        return FALSE;
    }

    //if ( GetAttackerCount( 5.0 ) )
    if ( GetHostileCount( 5.0 ) )
    {
        vT = GetHostileEvacVector( GetHostileVector( 15.0 ) );
        if ( VectorMagnitude( vT ) > 5.0 )
        {
            SetLocalLocation( OBJECT_SELF, "#LASTHOTSPOT", GetLocation( OBJECT_SELF ) );
            SetLocalFloat( OBJECT_SELF, "#LASTAMANGLE", VectorToAngle( vT ) );
            vT = GetPosition( OBJECT_SELF ) - vT;
            lLoc = Location( GetArea( OBJECT_SELF ), vT, VectorToAngle( vT ) );
            DoMoveToLocation( lLoc, TRUE );
            return TRUE;
        }
    }
    return FALSE;
}
*/
int DoAvoidMelee()
{
    vector vT;
    location lD;

    if ( GetHasSpellEffect( SPELL_TIME_STOP, OBJECT_SELF ) == TRUE )
    {
        //don't bother if we have time stop, dish out some pain instead
        return FALSE;
    }

    if ( GetHostileCount( 5.0 ) )
    {
        vT = ( -1.0 * ( 10.0 + IntToFloat( Random( 20 ) ) ) ) * VectorNormalize( GetHostileVector( 20.0 ) );
        lD = Location( GetArea( OBJECT_SELF ), vT + GetPosition( OBJECT_SELF ), VectorToAngle( vT ) );
        if ( GetLocalInt( OBJECT_SELF, "#LASTDEST" ) )
        {
            if ( GetDistanceBetweenLocations( GetLocalLocation( OBJECT_SELF, "#LASTDEST" ), GetLocation( OBJECT_SELF ) ) < 5.0 )
            {
                //close enough to target location
                DeleteLocalInt( OBJECT_SELF, "#LASTDEST" );
                DeleteLocalLocation( OBJECT_SELF, "#LASTDEST" );
            }
            else if ( GetDistanceBetweenLocations( GetLocalLocation( OBJECT_SELF, "#LASTDEST" ), GetLocation( OBJECT_SELF ) ) > 5.0 )
            {
                //didn't make it close enough to our last desired location for some reason
                vT = ( 10.0 + IntToFloat( Random( 20 ) ) ) * VectorNormalize( AngleToVector( VectorToAngle( vT ) - 90.0 + 180 * IntToFloat( Random( 2 ) ) ) );
                lD = Location( GetArea( OBJECT_SELF ), vT + GetPosition( OBJECT_SELF ), VectorToAngle( vT ) );
            }
        }
        SetLocalInt( OBJECT_SELF, "#LASTDEST", 1 );
        SetLocalLocation( OBJECT_SELF, "#LASTDEST", lD );
        DoMoveToLocation( lD, TRUE );
        /*XXX this queueing now handled by main combat loop
        ActionDoCommand( DelayCommand( 1.0, DoCombat() ) );
        */
        return TRUE;
    }
    return FALSE;
}

int DoTimeStop()
{
    int iEnemy = GetHostileCount( 40.0f );

    if ( iEnemy )
    {
        if ( GetHasSpell( SPELL_TIME_STOP ) && !GetHasSpellEffect( SPELL_TIME_STOP ) )
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            return TRUE;
        }
    }
    return FALSE;
}

int DoVision()
{
    object oS;
    int iCnt = 1;
    int iSpell = 0;

    if ( !GetHasVisionSpells() )
    {
        return FALSE;
    }

    oS = GetVisionDeprived( 20.0 );
    if ( GetIsObjectValid( oS ) )
    {
        iSpell = GetVisionSpellNeeded( oS );
        if ( iSpell )
        {
            //oS should be creature that needs vision, iSpell is the spell needed
            SetLocalObject( oS, "#VISION", OBJECT_SELF );
            DelayCommand( 6.0, DeleteLocalObject( oS, "#VISION" ) );
            //ActionCastSpellAtObject( iSpell, oS );
            NO_ActionCastSpellAtObject( iSpell, oS );
            return TRUE;
        }
    }
    return FALSE;
}

int DoBreathWeapon()
{
    int iSpell = GetBreathWeapon();
    int iHostiles;
    float fRad = RADIUS_SIZE_LARGE;
    float fMinSearch = 2.5;
    float fMaxSearch = fRad;
    vector vT;
    object oT;
    location lMark;
    int iMeta= METAMAGIC_ANY;
    int iCheat = TRUE;

    if ( iSpell && GetLocalInt( OBJECT_SELF, "#BDEL" ) == 0 )
    {
        iHostiles = GetHostileCount( 50.0 );
        if ( iHostiles == 1 )
        {
            //we have a breath weapon ready to go, single target
            oT = GetTarget();
            if ( oT != OBJECT_INVALID )
            {
                //ActionCastSpellAtObject( iSpell, oT, iMeta, iCheat );
                NO_ActionCastSpellAtObject( iSpell, oT, iMeta, iCheat, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE, FALSE );
                SetLocalInt( OBJECT_SELF, "#BDEL", 1 );
                DelayCommand( RoundsToSeconds( d4() ), DeleteLocalInt( OBJECT_SELF, "#BDEL" ) );
                return TRUE;
            }
        }
        else if ( iHostiles > 1 )
        {
            //we have a breath weapon ready to go, multiple targets
            vT = GetAreaTarget( iSpell, fRad, fMinSearch, fMaxSearch );
            if ( VectorMagnitude( vT ) > 0.0 )
            {
                lMark = Location( GetArea( OBJECT_SELF ), GetPosition( OBJECT_SELF ) + vT, GetFacing( OBJECT_SELF ) );
                //ActionCastSpellAtLocation( iSpell, lMark );
                NO_ActionCastSpellAtLocation( iSpell, lMark, iMeta, iCheat, PROJECTILE_PATH_TYPE_DEFAULT, FALSE, FALSE );
                SetLocalInt( OBJECT_SELF, "#BDEL", 1 );
                DelayCommand( RoundsToSeconds( d4() ), DeleteLocalInt( OBJECT_SELF, "#BDEL" ) );
                return TRUE;
            }
        }
    }
    return FALSE;
}

int DoTurning()
{
    int iTurn = GetHasFeat( FEAT_TURN_UNDEAD );
    vector vT = Vector( 0.0, 0.0, 0.0 );
    location lLoc;

    if ( !iTurn )
    {
        return FALSE;
    }

    vT = GetTurningVector();
    if ( VectorMagnitude( vT ) > 0.0 )
    {
        vT = GetPosition( OBJECT_SELF ) + vT;
        lLoc = Location( GetArea( OBJECT_SELF ), vT, VectorToAngle( vT ) );
        DoMoveToLocation( lLoc, TRUE );
        ActionUseFeat( FEAT_TURN_UNDEAD, OBJECT_SELF );
        return TRUE;
    }
    return FALSE;
}

int DoSpellCone()
{
    //moving this over to DoSpellArea()
    /*
    object oT;
    int iSpell, iMinLvl;
    float fRad = 10.0;
    vector vT, vU, vX;
    location lLoc, lMove;

    if ( GetIsObjectValid( oT = GetTarget() ) )
    {
        iMinLvl = GetAverageEnemyLevel() / 3;
    }

    if ( iSpell = GetConeSpell( iMinLvl ) )
    {
        vU = GetPosition( OBJECT_SELF );
        vT = GetAreaTarget( iSpell, fRad );
        if ( VectorMagnitude( vT ) > 0.0 )
        {
            //extend slightly past center of area
            vT = vT + 2.5 * VectorNormalize( vT );
            lLoc = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
            ActionCastSpellAtLocation( iSpell, lLoc );
            return TRUE;
        }
    }
    */
    return FALSE;
}

int DoHealSelf()
{
    //Testing via talents, having to go via random seems kind of wasteful
    //Look for another way to do this
    int iHeal;
    int iHealTalent;
    int iCR;
    int iFeat;
    int iDam;
    int iP;
    int iLimit = 0;
    talent tHeal, tP;
    object oP, oHeal, oHealer;
    event evHeal;

    oHealer = GetLocalObject( OBJECT_SELF, "#HEALER" );
    if ( GetIsObjectValid( oHealer ) )
    {
        if ( GetDistanceBetween( OBJECT_SELF, oHealer ) < 10.0 )
        {
            //got a healer who is close, don't double up, healing is on the way
            return FALSE;
        }
    }

    iDam = GetMaxHitPoints() - GetCurrentHitPoints();
    if ( iDam == 0 )
    {
        return FALSE;
    }
    //see if wholeness of body is an option
    if ( GetHasFeat( FEAT_WHOLENESS_OF_BODY ) )
    {
        iFeat = FEAT_WHOLENESS_OF_BODY;
        if ( iDam < GetLevelByClass( CLASS_TYPE_MONK ) * 2 )
        {
            iFeat = 0;
        }
    }

    //iCR = 20;
    iCR = 10;
    iHealTalent = 0;
    if ( GetRacialType( OBJECT_SELF ) != RACIAL_TYPE_UNDEAD ) //undead do not use healing potions
    {
        //while ( iCR && GetIsTalentValid( tP = GetCreatureTalentBest( TALENT_CATEGORY_BENEFICIAL_HEALING_POTION, iCR-- ) ) )
        while ( iCR-- && GetIsTalentValid( tP = GetCreatureTalentRandom( TALENT_CATEGORY_BENEFICIAL_HEALING_POTION ) ) )
        {
            if ( iP = GetTalentPotionHealAmount( tP ) )
            {
                if ( iP > iHealTalent && iP < iDam )
                {
                    tHeal = tP;
                    iHealTalent = iP;
                }
            }
        }
    }
    if ( iFeat )
    {
        ActionUseFeat( iFeat, OBJECT_SELF );
        SetLocalObject( OBJECT_SELF, "#HEALER", OBJECT_SELF );
        DelayCommand( 4.0, DeleteLocalObject( OBJECT_SELF, "#HEALER" ) );
        return TRUE;
    }
    if ( iHealTalent && GetIsTalentValid( tHeal ) )
    {
        ActionUseTalentOnObject( tHeal, OBJECT_SELF );
        SetLocalObject( OBJECT_SELF, "#HEALER", OBJECT_SELF );
        DelayCommand( 4.0, DeleteLocalObject( OBJECT_SELF, "#HEALER" ) );
        return TRUE;
    }
    return FALSE;
}

int DoSpellGroupEnhance()
{
    int iSpell, iMinLvl;
    float fRad = 0.0;
    vector vT, vU, vX;
    location lLoc, lMove;
    object oT;

    if ( GetIsObjectValid( oT = GetTarget() ) )
    {
        iMinLvl = GetAverageEnemyLevel() / 3;
    }

    //try feats first
    if ( iSpell = GetGroupEnhanceFeat() )
    {
        fRad = GetGroupEnhanceFeatRadius( iSpell );
        vU = GetPosition( OBJECT_SELF );
        vT = GetFriendlyAreaTarget( fRad, iSpell, 1 );
        if ( VectorMagnitude( vT ) > 0.0 )
        {
            lLoc = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
            DoMoveToLocation( lLoc, TRUE );
            ActionUseFeat( iSpell, OBJECT_SELF );
            return TRUE;
        }
    }
    //then spells
    if ( iSpell = GetGroupEnhanceSpell( iMinLvl ) )
    {
        fRad = GetGroupEnhanceSpellRadius( iSpell );
        vU = GetPosition( OBJECT_SELF );
        vT = GetFriendlyAreaTarget( fRad, iSpell );
        if ( VectorMagnitude( vT ) > 0.0 )
        {
            lLoc = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
            //ActionCastSpellAtLocation( iSpell, lLoc );
            NO_ActionCastSpellAtLocation( iSpell, lLoc );
            return TRUE;
        }
    }
    return FALSE;
}

int DoSpellGroupHeal()
{
    int iSpell, iMinLvl, iHeal;
    float fRad = 0.0;
    vector vT, vU, vX;
    location lLoc, lMove;
    float fDam;
    object oT;

    if ( GetIsObjectValid( oT = GetTarget() ) )
    {
        iMinLvl = GetAverageEnemyLevel() / 3;
    }

    if ( iSpell = GetGroupHealSpell( iMinLvl ) )
    {
        iHeal = GetGroupHealSpellAmount( iSpell );
        fRad = GetGroupHealSpellRadius( iSpell );
        vU = GetPosition( OBJECT_SELF );
        vT = GetAreaHealTarget( fRad, iHeal );
        lLoc = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
        fDam = GetAllyDamageStats( lLoc, fRad );
        if ( VectorMagnitude( vT ) > 0.0 && IntToFloat( iHeal ) < fDam )
        {
            //ActionCastSpellAtLocation( iSpell, lLoc );
            NO_ActionCastSpellAtLocation( iSpell, lLoc );
            return TRUE;
        }
    }
    return FALSE;
}

int DoDispelPersAOE()
{
    vector vT, vU;
    location lT;
    int iD;

    if ( ( iD = GetDispelSpell() ) == -1 )
    {
        //no dispel capability available
        return FALSE;
    }

    if ( GetHostileAOECount( 30.0 ) )
    {
        vU = GetPosition( OBJECT_SELF );
        vT = GetHostileAOEVector( 30.0 );
        lT = Location( GetArea( OBJECT_SELF ), vU + vT, VectorToAngle( vT ) );
        //ActionCastSpellAtLocation( iD, lT );
        NO_ActionCastSpellAtLocation( iD, lT );
        return TRUE;
    }
    return FALSE;
}

int DoDispelSingle()
{
    object oTarget;
    int iAverage = 0;
    int iSpell = 0;
    int iCL = GetMaxDispelCasterLevel();

    if ( GetIsObjectValid( oTarget = GetMostBuffedEnemy( 30.0 ) ) )
    {
        iAverage = GetAverageEffectCasterLevel( oTarget );
        if ( ( iSpell = GetBestDispel( iAverage, iCL ) ) )
        {
            //PrintString( "DISPEL: " + GetName( OBJECT_SELF ) + " " + IntToString( iSpell ) + " " + GetName( oTarget ) );
            //ActionCastSpellAtObject( iSpell, oTarget );
            NO_ActionCastSpellAtObject( iSpell, oTarget );
            return TRUE;
        }
    }
    return FALSE;
}

int DoDismissal()
{
    int iSpell;
    float fRad = RADIUS_SIZE_COLOSSAL;
    object oT;
    vector vT;
    location lT;

    //banishment and dismissal is next optimal choices for enemy summons
    iSpell = GetHasSpell( SPELL_BANISHMENT, OBJECT_SELF ) ? SPELL_BANISHMENT : SPELL_DISMISSAL;
    if ( GetHasSpell( iSpell, OBJECT_SELF ) )
    {
        vT = GetEnemySummonedAssociatesVector( fRad );
        if ( VectorMagnitude( vT ) > 0.0 )
        {
            lT = Location( GetArea( OBJECT_SELF ), GetPosition( OBJECT_SELF ) + vT, VectorToAngle( vT ) );
            //ActionCastSpellAtLocation( iSpell, lT );
            NO_ActionCastSpellAtLocation( iSpell, lT );
            return TRUE;
        }
    }
    //next check is to look for Outsiders and Elementals and clear them out with Word of Faith
    //this will pick up against summoned and non-summoned planars
    iSpell = SPELL_WORD_OF_FAITH;
    if ( GetHasSpell( iSpell, OBJECT_SELF ) )
    {
        vT = GetEnemyPlanarVector( fRad );
        if ( VectorMagnitude( vT ) > 0.0 )
        {
            lT = Location( GetArea( OBJECT_SELF ), GetPosition( OBJECT_SELF ) + vT, VectorToAngle( vT ) );
            //ActionCastSpellAtLocation( iSpell, lT );
            NO_ActionCastSpellAtLocation( iSpell, lT );
            return TRUE;
        }
    }
    //no dismissal, look for a summoned associate owner to use dispel magic on if we have it
    if ( iSpell = GetDispelSpell() )
    {
        //we have a dispel
        if ( GetIsObjectValid( oT = GetStrongestEnemySummonedAssociateOwner( 30.0 ) ) )
        {
            //ActionCastSpellAtObject( iSpell, oT );
            NO_ActionCastSpellAtObject( iSpell, oT );
            return TRUE;
        }
    }
    return FALSE;
}

int DoFastBuffs()
{
    int iSpell = 0;
    int iCnt;

    if ( !GetLocalInt( OBJECT_SELF, "#FASTBUFFER" ) || GetLocalInt( OBJECT_SELF, "#FASTBUFFED" ) )
    {
        return FALSE;
    }

    iCnt = GenerateFastBuffList();

    while ( iCnt )
    {
        iSpell = GetLocalInt( OBJECT_SELF, "#SPL_FB" + IntToString( iCnt ) );
        ActionCastSpellAtObject( iSpell, OBJECT_SELF, METAMAGIC_ANY, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE );
        DeleteLocalInt( OBJECT_SELF, "#SPL_FB" + IntToString( iCnt-- ) );
    }

    if ( iSpell )
    {
        return TRUE;
    }
    return FALSE;
}

/*
int DoFlee()
{
    vector vT;
    location lLoc;

    //if we have time stop running use the time to flee

    //if ( GetAttackerCount( 5.0 ) )
    if ( GetHostileCount( 5.0 ) )
    {
        vT = GetHostileEvacVector( GetHostileVector( 15.0 ) );
        if ( VectorMagnitude( vT ) > 5.0 )
        {
            SetLocalLocation( OBJECT_SELF, "#LASTHOTSPOT", GetLocation( OBJECT_SELF ) );
            SetLocalFloat( OBJECT_SELF, "#LASTAMANGLE", VectorToAngle( vT ) );
            vT = GetPosition( OBJECT_SELF ) - vT;
            lLoc = Location( GetArea( OBJECT_SELF ), vT, VectorToAngle( vT ) );
            DoMoveToLocation( lLoc, TRUE );
            return TRUE;
        }
    }
    return FALSE;
}
*/

int DoMeleeAssist()
{
    object oF, oE, oT, oTarget;
    int iCnt1, iCnt2, iF, iE, iChat, iSpecial;
    float fAssistRange = 30.0;
    float fMeleeRange = 3.0;
    float fRatio, fT, fDist, fDistMin;

    oT = OBJECT_INVALID;
    fT = 1.0;
    //look for a friend who needs assistance in melee
    iCnt1 = 0;
    oF = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt1, CREATURE_TYPE_IS_ALIVE, TRUE );
    while ( GetIsObjectValid( oF ) && GetDistanceBetween( OBJECT_SELF, oF ) < fAssistRange )
    {
        if ( GetObjectSeen( oF ) || GetObjectHeard( oF ) )
        {
            iF = GetHitDice( oF ) + GetAllyHD( fMeleeRange, oF );
            iE = GetHostileHD( fMeleeRange, oF );
            fRatio = IntToFloat( iE ) / IntToFloat( iF );
            if ( fRatio > fT )
            {
                fT = fRatio;
                oT = oF;
            }
        }
        oF = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt1, CREATURE_TYPE_IS_ALIVE, TRUE );
    }

    if ( GetIsObjectValid( oT ) )
    {
        //found a friend in trouble, stored highest enemy concentration to aid friend
        //should be closest friend in a given melee
        //get nearest enemy fighting friend
        fDistMin = 100.0;
        iCnt1 = 0;
        oTarget = OBJECT_INVALID;
        oE = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT, ++iCnt1, CREATURE_TYPE_IS_ALIVE, TRUE );
        while ( GetIsObjectValid( oE ) )
        {
            if ( GetObjectSeen( oE ) || GetObjectHeard( oE ) )
            {
                if ( ( fDist = GetDistanceBetween( OBJECT_SELF, oE ) ) < fDistMin )
                {
                    oTarget = oE;
                    fDistMin = fDist;
                }
            }
            oE = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT, ++iCnt1, CREATURE_TYPE_IS_ALIVE, TRUE );
        }
        //should now have a valid enemy to target, closest to me in target group
        if ( GetIsObjectValid( oTarget ) )
        {
            //SpeakString( "Assisting " + GetName( oT ) );
            DoEquipMelee( oTarget );
            DoVoiceChat( NO_VC_MELEEASSIST );
            if ( iSpecial = GetBestMeleeSpecial( oTarget ) )
            {
                //use special attack type
                ActionUseFeat( iSpecial, oTarget );
            }
            else
            {
                ActionAttack( oTarget );
            }
            return TRUE;
        }
    }

    //either nobody needs help or I couldn't find a target
    return FALSE;
}

int DoFlank( object oE=OBJECT_INVALID )
{
    object oF = OBJECT_INVALID;
    location lL = GetLocation( OBJECT_SELF );
    int iCnt = 0;

    if ( GetIsObjectValid( oE ) )
    {
        oF = oE;
    }
    else
    {
        oE = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
        while ( GetIsObjectValid( oE ) && !GetIsObjectValid( oF ) )
        {
            if ( GetObjectSeen( oE, OBJECT_SELF ) || GetObjectHeard( oE, OBJECT_SELF ) )
            {
                if ( GetDistanceBetween( oE, OBJECT_SELF ) > 10.0 )
                {
                    //enemy is seen or heard and more than 10.0 away, flank it
                    oF = oE;
                }
                else
                {
                    //creature is within minimum range, abort flank
                    break;
                }
            }
            oE = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
        }
    }
    if ( GetIsObjectValid( oF ) )
    {
        lL = GetFlankLoc( oF, lL );
        DoMoveToLocation( lL, TRUE );
        /*XXX
        ActionDoCommand( DelayCommand( 1.0, DoCombat() ) );
        */
        return TRUE;
    }
    return FALSE;
}

int DoMindBlast()
{
    vector vT;
    object oT;
    int iSpell = -69;
    int iEnemies = GetHostileCount( 40.0 );
    int iEff;
    float fRad = 15.0;
    float fMinSrch = 0.0;
    float fMaxSrch = 30.0;
    location lMark;

    if ( iEnemies == 1 )
    {
        oT = GetTarget();
        if ( GetIsObjectValid( oT ) )
        {
            iEff = GetEffectsOnObject( oT );
            if ( ( iEff & NO_EFFECT_STUNNED ) + ( iEff & NO_EFFECT_PARALYZE ) + ( iEff & NO_EFFECT_DAZED ) == 0 )
            {
                //target not stunned, paralyzed or dazed
                //should switch to direct targetting once function is available
                //ActionMindBlast( oT, GetLocation( oT ) );
                //ActionCastSpellAtObject( 1522, oT, METAMAGIC_ANY, TRUE );
                ActionCastSpellAtObject( CODI_MIND_BLAST, oT, METAMAGIC_ANY, TRUE );
                return TRUE;
            }
        }
    }
    else if ( iEnemies > 1 )
    {
        vT = GetAreaTarget( iSpell, fRad, fMinSrch, fMaxSrch );
        if ( VectorMagnitude( vT ) > 0.0 )
        {
            lMark = Location( GetArea( OBJECT_SELF ), GetPosition( OBJECT_SELF ) + vT, VectorToAngle( vT ) );
            //ActionMindBlast( OBJECT_INVALID, lMark );
            //ActionCastSpellAtLocation( 1522, lMark, METAMAGIC_ANY, TRUE );
            ActionCastSpellAtLocation( CODI_MIND_BLAST, lMark, METAMAGIC_ANY, TRUE );
            return TRUE;
        }
    }
    return FALSE;
}

int DoBrainExtraction()
{
    float fScanRange = 30.0;
    float fImmRange = 10.0;
    object oT = GetNearestAddledEnemyNoExtractor( fScanRange );
    int iCnt = 0;
    int iC = 0;
    int iH = 0;
    int iEff;
    int iDo = TRUE;

    if ( !GetIsObjectValid( oT ) )
    {
        //look for non-petrified enemy close by
        oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
        while ( GetIsObjectValid( oT ) && GetDistanceBetween( OBJECT_SELF, oT ) < fImmRange )
        {
            if ( IsBrainExtractable( oT ) )
            {
                break;
            }
            oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
        }
        //double check we aren't looking at a petrified enemy
        if ( GetIsObjectValid( oT ) )
        {
            if ( !IsBrainExtractable( oT ) )
            {
                oT = OBJECT_INVALID;
            }
        }
        //see if we have decent chances of extracting
        if ( GetIsObjectValid( oT ) )
        {
            iDo = FALSE;
            int iAttNorm = GetCreatureAttackBonus( OBJECT_SELF );
            int iDefAC = GetAC( oT ) - 10;
            if ( iAttNorm > iDefAC )
            {
                int iAttGrap = GetGrappleBonus( OBJECT_SELF );
                int iDefGrap = GetGrappleBonus( oT );
                if ( iAttGrap > iDefGrap )
                {
                    //we will probably hit and probably win a grapple
                    iDo = TRUE;
                }
            }
        }
    }
    if ( GetIsObjectValid( oT ) && iDo )
    {
        //got a target, go for the brains
        SetLocalInt( oT, "#EXTRACTING", 1 );
        DelayCommand( 12.0, DeleteLocalInt( oT, "#EXTRACTING" ) ); //death redundancy
        if ( GetDistanceBetween( OBJECT_SELF, oT ) > 10.0 )
        {
            DoMoveToObject( oT, TRUE, 2.1 );
        }
        //ActionHeadSuck( oT );
        //ActionCastSpellAtObject( 1523, oT, METAMAGIC_ANY, TRUE );
        ActionCastSpellAtObject( CODI_BRAIN_EXTRACT, oT, METAMAGIC_ANY, TRUE );
        ActionDoCommand( DeleteLocalInt( oT, "#EXTRACTING" ) );
        return TRUE;
    }
    return FALSE;
}

int DoAvoidEnemies()
{
    object oE = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
    vector vE;
    vector vT;
    location lL;

    if ( GetIsObjectValid( oE ) && GetDistanceBetween( OBJECT_SELF, oE ) < 15.0 )
    {
        vE = GetHostileVector( 20.0 );
        vT = -10.0 * VectorNormalize( vE );
        lL = Location( GetArea( OBJECT_SELF ), GetPosition( OBJECT_SELF ) + vT, VectorToAngle( vT ) );
        DoMoveToLocation( lL, TRUE );
        /*XXX
        ActionDoCommand( DelayCommand( 1.0, DoCombat() ) );
        */
        return TRUE;
    }
    else
    {
        vE = GetHostileVector( 20.0 );
        if ( VectorMagnitude( vE ) > 0.0 )
        {
            vT = -10.0 * VectorNormalize( vE );
        }
        else
        {
            vT = 5.0 * VectorNormalize( AngleToVector( IntToFloat( Random( 360 ) ) ) );
        }
        lL = Location( GetArea( OBJECT_SELF ), GetPosition( OBJECT_SELF ) + vT, VectorToAngle( vT ) );
        DoMoveToLocation( lL, TRUE );
        /*XXX
        ActionDoCommand( DelayCommand( 1.0, DoCombat() ) );
        */
        return TRUE;
    }
    //should never get down here
    return FALSE;
}

int DoGrenade()
{
    return FALSE;
}

int DoBeholderRays()
{
    float fM = GetFacing( OBJECT_SELF );
    float fH;
    float fS = 5.5 / BEHOLDER_MAX_RAYS;
    int iRep = 95; //chance to use multiple rays on one target if enemies < rays
    int iH = GetHostileCount( 40.0 );
    int iC = 0;
    int iQ1 = 0;
    int iQ2 = 0;
    int iQ3 = 0;
    int iQ4 = 0;
    int iR = 0;
    int iS;
    int iM;
    object oT;

    InitializeBeholderRaySelection();

    if ( GetHasSpellEffect( SPELL_HASTE, OBJECT_SELF ) || GetHasSpellEffect( SPELL_MASS_HASTE, OBJECT_SELF ) && GetHasFeatEffect( FEAT_EPIC_BLINDING_SPEED, OBJECT_SELF ) )
    {
        fS *= 0.5;
    }

    oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, ++iC, CREATURE_TYPE_IS_ALIVE, TRUE );
    while ( iC <= iH && iR < BEHOLDER_MAX_RAYS )
    {
        iM = TRUE; //default is that we will not target multiple rays at individual targets
        if ( GetIsObjectValid( oT ) == FALSE )
        {
            //run out of targets unexpectedly
            break;
        }
        else if ( GetIsPerceived( oT, NO_PERCEPTION_SEEN ) == FALSE && GetIsPerceived( oT, NO_PERCEPTION_HEARD ) == FALSE )
        {
            //can't see or hear this creature, ignore it
            iC++;
        }
        else
        {
            SetLocalInt( OBJECT_SELF, "#EYERAYS", 1 ); //flag the beholder as being busy shooting eye rays
            //oT is valid, we can see or hear it
            fH = VectorToAngle( GetPosition( oT ) - GetPosition( OBJECT_SELF ) );
            fH = fH < fM ? fH + 360.0 : fH;
            fH -= fM;
            if ( fH > 315.0 || fH < 45.0 )
            {
                if ( iQ1 < 3 && GetIsCentralEyeOpen() == FALSE )
                {
                    //first quadrant target, still have rays available in this quadrant
                    iS = MatchRayToTarget( oT );
                    if ( iS != 0 )
                    {
                        iQ1++;
                        iR++;
                        RemoveBeholderRayFromSelection( iS );
                        DelayCommand( fS * iR, DoFireBeholderRay( iS, oT ) );
                        if ( iH - iC < BEHOLDER_MAX_RAYS - iR ) //we have more rays left to fire than enemies remaining to fire them at
                        {
                            if ( iQ1 < 3 && Random( 100 ) < iRep ) //we have rays left in this quadrant, random chance to shoot another at this target
                            {
                                iM = FALSE; //we will shoot more rays at this target, not moving on
                            }
                        }
                    }
                }
            }
            else if ( fH < 135.0 )
            {
                if ( iQ2 < 3 )
                {
                    //second quadrant target, still have rays available in this quadrant
                    iS = MatchRayToTarget( oT );
                    if ( iS != 0 )
                    {
                        iQ2++;
                        iR++;
                        RemoveBeholderRayFromSelection( iS );
                        DelayCommand( fS * iR, DoFireBeholderRay( iS, oT ) );
                        if ( iH - iC < BEHOLDER_MAX_RAYS - iR ) //we have more rays left to fire than enemies remaining to fire them at
                        {
                            if ( iQ2 < 3 && Random( 100 ) < iRep ) //we have rays left in this quadrant, random chance to shoot another at this target
                            {
                                iM = FALSE; //we will shoot more rays at this target, not moving on
                            }
                        }
                    }
                }
            }
            else if ( fH < 225.0 )
            {
                if ( iQ3 < 3 )
                {
                    //third quadrant target, still have rays available in this quadrant
                    iS = MatchRayToTarget( oT );
                    if ( iS != 0 )
                    {
                        iQ3++;
                        iR++;
                        RemoveBeholderRayFromSelection( iS );
                        DelayCommand( fS * iR, DoFireBeholderRay( iS, oT ) );
                        if ( iH - iC < BEHOLDER_MAX_RAYS - iR ) //we have more rays left to fire than enemies remaining to fire them at
                        {
                            if ( iQ3 < 3 && Random( 100 ) < iRep ) //we have rays left in this quadrant, random chance to shoot another at this target
                            {
                                iM = FALSE; //we will shoot more rays at this target, not moving on
                            }
                        }
                    }
                }
            }
            else if ( iQ4 < 3 )
            {
                //fourth quadrant target, still have rays available in this quadrant
                iS = MatchRayToTarget( oT );
                if ( iS != 0 )
                {
                    iQ4++;
                    iR++;
                    RemoveBeholderRayFromSelection( iS );
                    DelayCommand( fS * iR, DoFireBeholderRay( iS, oT ) );
                    if ( iH - iC < BEHOLDER_MAX_RAYS - iR ) //we have more rays left to fire than enemies remaining to fire them at
                    {
                        if ( iQ4 < 3 && Random( 100 ) < iRep ) //we have rays left in this quadrant, random chance to shoot another at this target
                        {
                            iM = FALSE; //we will shoot more rays at this target, not moving on
                        }
                    }
                }
            }
        }
        //we're either getting the same target again or moving onto the next target
        iC += iM; //if iM is true we are moving onto next target, iC is incremented, otherwise it stays where it is
        oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iC, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    DelayCommand( fS * ( iR + 1 ), DeleteLocalInt( OBJECT_SELF, "#EYERAYS" ) );

    ClearBeholderRaySelection();

    if ( iR > 0 )
    {
        //we have fired some rays
        return TRUE;
    }
    //we have not fired any rays
    return FALSE;
}

int DoBeholderCentralEye()
{
    int iSpell = SPELL_BEH_ANTIMAGIC_CONE;
    int iHostiles;
    float fRad = RADIUS_SIZE_MEDIUM;
    float fMinSearch = 2.5;
    float fMaxSearch = fRad;
    vector vT;
    object oT;
    location lMark;
    int iMeta= METAMAGIC_ANY;
    int iCheat = TRUE;

    if ( iSpell && GetLastAction() != "+CENTRALEYE" )
    {
        iHostiles = GetHostileCount( 50.0 );
        if ( iHostiles == 1 )
        {
            //we have a breath weapon ready to go, single target
            oT = GetTarget();
            if ( oT != OBJECT_INVALID )
            {
                //ActionCastSpellAtObject( iSpell, oT, iMeta, iCheat );
                NO_ActionCastSpellAtObject( iSpell, oT, iMeta, iCheat, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE, FALSE );
                SetIsCentralEyeOpen( TRUE );
                DoBeholderRays();
                SetIsCentralEyeOpen( FALSE );
                return TRUE;
            }
        }
        else if ( iHostiles > 1 )
        {
            //we have a breath weapon ready to go, multiple targets
            vT = GetAreaTarget( iSpell, fRad, fMinSearch, fMaxSearch );
            if ( VectorMagnitude( vT ) > 0.0 )
            {
                lMark = Location( GetArea( OBJECT_SELF ), GetPosition( OBJECT_SELF ) + vT, GetFacing( OBJECT_SELF ) );
                //ActionCastSpellAtLocation( iSpell, lMark );
                NO_ActionCastSpellAtLocation( iSpell, lMark, iMeta, iCheat, PROJECTILE_PATH_TYPE_DEFAULT, TRUE, FALSE );
                SetIsCentralEyeOpen( TRUE );
                DoBeholderRays();
                SetIsCentralEyeOpen( FALSE );
                return TRUE;
            }
        }
    }
    return FALSE;
}

int DoEN4Invis()
{
    int iEnemy = GetHostileCount( 40.0f );

    if ( iEnemy )
    {
        if (GetHasSpellEffect( SPELL_IMPROVED_INVISIBILITY ) || GetHasSpellEffect( SPELL_INVISIBILITY_SPHERE ) || GetHasSpellEffect( SPELL_INVISIBILITY ) || GetLocalInt(OBJECT_SELF,"EN4InvisEvent") == 1)
            return FALSE;

        if ( GetHasSpell( SPELL_IMPROVED_INVISIBILITY ))
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_IMPROVED_INVISIBILITY, OBJECT_SELF );
            SetLocalInt(OBJECT_SELF,"EN4InvisEvent",1);
            return TRUE;
        }

        if ( GetHasSpell( SPELL_INVISIBILITY_SPHERE ) )
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_INVISIBILITY_SPHERE, OBJECT_SELF );
            SetLocalInt(OBJECT_SELF,"EN4InvisEvent",1);
            return TRUE;
        }


        if ( GetHasSpell( SPELL_INVISIBILITY ) )
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_INVISIBILITY, OBJECT_SELF );
            SetLocalInt(OBJECT_SELF,"EN4InvisEvent",1);
            return TRUE;
        }

    }
    return FALSE;
}

int DoEN4DmgShield()
{
    int iEnemy = GetHostileCount( 40.0f );

    if ( iEnemy )
    {
        if (GetLocalInt(OBJECT_SELF,"EN4DmgShieldEvent") > 0)
            return FALSE;

        if ( GetHasSpell( SPELL_MESTILS_ACID_SHEATH ) && !GetHasSpellEffect( SPELL_MESTILS_ACID_SHEATH ))
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_MESTILS_ACID_SHEATH, OBJECT_SELF );
            SetLocalInt(OBJECT_SELF,"EN4DmgShieldEvent",1);
            return TRUE;
        }
        if ( GetHasSpell( SPELL_ELEMENTAL_SHIELD ) && !GetHasSpellEffect( SPELL_ELEMENTAL_SHIELD ))
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_ELEMENTAL_SHIELD, OBJECT_SELF );
            SetLocalInt(OBJECT_SELF,"EN4DmgShieldEvent",1);
            return TRUE;
        }
        if ( GetHasSpell( SPELL_WOUNDING_WHISPERS ) && !GetHasSpellEffect( SPELL_WOUNDING_WHISPERS ))
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_WOUNDING_WHISPERS, OBJECT_SELF );
            SetLocalInt(OBJECT_SELF,"EN4DmgShieldEvent",1);
            return TRUE;
        }
        if ( GetHasSpell( SPELL_DEATH_ARMOR ) && !GetHasSpellEffect( SPELL_DEATH_ARMOR ))
        {
            //ActionCastSpellAtObject( SPELL_TIME_STOP, OBJECT_SELF );
            NO_ActionCastSpellAtObject( SPELL_DEATH_ARMOR, OBJECT_SELF );
            SetLocalInt(OBJECT_SELF,"EN4DmgShieldEvent",1);
            return TRUE;
        }
    }
    return FALSE;
}

int DoUndeadHealSelf( object oT=OBJECT_INVALID )
{
int iDamage;
int iHeal;

iDamage = GetMaxHitPoints( oT ) - GetCurrentHitPoints( oT );

if (iDamage > GetMaxHitPoints( oT )/2)
    {
    iHeal = GetBestUndeadHeal( oT, iDamage );
    if (iHeal != 0)
        {
        NO_ActionCastSpellAtObject( iHeal, OBJECT_SELF );
        return TRUE;
        }
    }

return FALSE;
}

int DoSpellUndeadHeal( object oT=OBJECT_INVALID )
{
    //original heal code
    object oHurt;
    int iHeal, iCR;
    talent tHeal;
    int iMin = 8;

    if ( GetHasHealingAbility() )
    //if ( GetIsTalentValid( GetCreatureTalentBest( TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20 ) ) )
    {
        oHurt = ( GetIsObjectValid( oT ) ) ? oT : GetLowestHPAllyNoHealer( 30.0, iMin, OBJECT_SELF, TRUE );
        if ( GetIsObjectValid( oHurt ) )
        {
            /*
            // Need to use this hack with talents because GetHasSpell will pick up spontaneous casting ability
            // but ActionCastSpell* cannot do the spontaneous casting, which leaves the creature daydreaming
            // rather than acting
            */
            if (GetRacialType(oHurt) == RACIAL_TYPE_UNDEAD)
                iHeal = GetBestUndeadHeal( oHurt, iMin );
            else
                iHeal = GetBestHeal( oHurt, iMin );

            if (iHeal != 0)
                {
                tHeal = GetTalentSpell( TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, iHeal );
                //if ( iHeal )
                if ( GetIsTalentValid( tHeal ) )
                {
                    //PrintString( "HEAL: " + GetName( OBJECT_SELF ) + " -> " + GetName( oHurt ) + " (" + IntToString( iHeal ) + ")" );
                    SetLocalObject( oHurt, "#HEALER", OBJECT_SELF );
                    DelayCommand( 6.0, DeleteLocalObject( oHurt, "#HEALER" ) );
                    //ActionCastSpellAtObject( iHeal, oHurt );
                    //ActionUseTalentOnObject( tHeal, oHurt );
                    NO_ActionUseTalentOnObject( tHeal, oHurt );
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}

int GetBestUndeadHeal( object oEnt=OBJECT_SELF, int iMin=10 )
{
    int iDamage = 0;

    if ( GetIsObjectValid( oEnt ) )
    {
        iDamage = GetMaxHitPoints( oEnt ) - GetCurrentHitPoints( oEnt );
        if ( iDamage < iMin )
        {
            return 0;
        }
        if ( iDamage >= 60 && GetHasSpell( SPELL_HARM ) )
        {
            return SPELL_HARM;
        }
        if ( iDamage >= 40 )
        {
            if ( GetHasSpell( SPELL_INFLICT_CRITICAL_WOUNDS ) )
            {
                return SPELL_INFLICT_CRITICAL_WOUNDS;
            }
        }
        if ( iDamage >= 30 && GetHasSpell( SPELL_INFLICT_SERIOUS_WOUNDS ) )
        {
            return SPELL_INFLICT_SERIOUS_WOUNDS;
        }
        if ( iDamage >= 20 && GetHasSpell( SPELL_INFLICT_MODERATE_WOUNDS ) )
        {
            return SPELL_INFLICT_MODERATE_WOUNDS;
        }
        if ( iDamage >= 10 && GetHasSpell( SPELL_INFLICT_LIGHT_WOUNDS ) )
        {
            return SPELL_INFLICT_LIGHT_WOUNDS;
        }
    }
    return 0;
}

