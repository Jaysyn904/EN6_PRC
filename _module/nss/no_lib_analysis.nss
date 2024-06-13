#include "no_inc_ptypes"

//functions
int GetAOEThreat( object oArea, object oEnt=OBJECT_SELF )
{
    string sArea;

    if ( GetIsObjectValid( oArea ) )
    {
        sArea = GetTag( oArea );
    }
    else
    {
        return 0;
    }


    if ( sArea == "VFX_PER_CREEPING_DOOM" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_DARKNESS" )
    {
        if ( GetHasSpellEffect( SPELL_TRUE_SEEING, oEnt ) || GetHasSpellEffect( SPELL_DARKVISION, oEnt ) )
        {
            return 0;
        }
        return 1;
    }
    if ( sArea == "VFX_PER_DELAYED_BLAST_FIREBALL" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_ENTANGLE" )
    {
        if ( GetIsEnemy( GetAreaOfEffectCreator( oArea ), oEnt ) )
        {
            return 1;
        }
        return 0;
    }
    if ( sArea == "VFX_PER_EVARDS_BLACK_TENTACLES" )
    {
        if ( GetIsEnemy( GetAreaOfEffectCreator( oArea ), oEnt ) )
        {
            return 1;
        }
        return 0;
    }
    if ( sArea == "VFX_PER_FOGACID" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_FOGFIRE" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_FOGKILL" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_FOGMIND" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_FOGSTINK" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_GREASE" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_STORM" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_WALLBLADE" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_WALLFIRE" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_WEB" )
    {
        return 1;
    }
    if ( sArea == "VFX_PER_FOGBEWILDERMENT" )
    {
    	return 1;
    }
    if ( sArea == "VFX_PER_STONEHOLD" )
    {
    	return 1;
    }
    return 0;
}

int GetAOECount( float fRad=10.0f, object oEnt=OBJECT_SELF )
{
    int iLoop = 1;
    int iCnt = 0;
    object oArea;

    oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    while ( GetIsObjectValid( oArea ) && GetDistanceBetween( oEnt, oArea ) <= fRad )
    {
        if ( GetAOEThreat( oArea ) )
        {
            iCnt++;
        }
        oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    }

    return iCnt;
}

vector GetAOEVector( float fRad=10.0f, object oEnt=OBJECT_SELF )
{
    int iLoop = 1;
    vector vU = GetPosition( oEnt );
    vector vT = Vector( 0.0, 0.0, 0.0 );
    object oArea;

    oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    while ( GetIsObjectValid( oArea ) && GetDistanceBetween( oEnt, oArea ) <= fRad )
    {
        if ( GetAOEThreat( oArea ) )
        {
            vT = vT + GetPosition( oArea ) - vU;
        }
        oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    }

    return vT;
}

int GetHostileAOECount( float fRad=10.0f, object oEnt=OBJECT_SELF )
{
    int iLoop = 1;
    int iCnt = 0;
    object oArea;

    oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    while ( GetIsObjectValid( oArea ) && GetDistanceBetween( oEnt, oArea ) <= fRad )
    {
        if ( GetIsEnemy( GetAreaOfEffectCreator( oArea ) ) )
        {
            iCnt++;
        }
        oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    }

    return iCnt;
}

vector GetHostileAOEVector( float fRad=10.0f, object oEnt=OBJECT_SELF )
{
    int iLoop = 1;
    vector vU = GetPosition( oEnt );
    vector vT = Vector( 0.0, 0.0, 0.0 );
    object oArea;

    oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    while ( GetIsObjectValid( oArea ) && GetDistanceBetween( oEnt, oArea ) <= fRad )
    {
        if ( GetIsEnemy( GetAreaOfEffectCreator( oArea ) ) )
        {
            vT = vT + GetPosition( oArea ) - vU;
        }
        oArea = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oEnt, iLoop++ );
    }

    return vT;
}

vector GetAOEEvacVector( vector vS, object oEnt=OBJECT_SELF )
{
    vector vU = GetPosition( oEnt );
    vector vT = Vector( 0.0, 0.0, 0.0 );

    if ( vS != Vector( 0.0, 0.0, 0.0 ) )
    {
        if ( GetLocalLocation( oEnt, "LASTLOC" ) == GetLocation( oEnt ) )
        {
            //we've had location flag set, if matches we haven't moved
            //probably stuck between wall and AOEs or paralyzed in AOEs
            vT = vU + 15.0 * VectorNormalize( vS );
        }
        else
        {
            //proceed away from AOEs
            vT = vU - 15.0 * VectorNormalize( vS );
        }
    }
    else
    {
        //we know there was at least 1 area, must be on self
        vT = vU + 15.0 * VectorNormalize( AngleToVector( IntToFloat( Random( 360 ) ) ) );
    }

    return vT;
}

object GetMostDamagedAlly( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE )
{
    //gives higher weighting to non-summoned allies
    object oSubject = oEnt;
    object oHurt = OBJECT_INVALID;
    int iCnt = 1;
    int iDamage = 0;

    while ( GetIsObjectValid( oSubject ) && GetDistanceBetween( oEnt, oSubject ) < fRad )
    {
        if ( GetObjectSeen( oSubject, oEnt ) >= iSee )
        {
            iDamage = GetMaxHitPoints( oSubject ) - GetCurrentHitPoints( oSubject );
            if ( iDamage )
            {
                if ( oHurt == OBJECT_INVALID )
                {
                    oHurt = oSubject;
                }
                else if ( ( GetMaxHitPoints( oHurt ) - GetCurrentHitPoints( oHurt ) ) < iDamage )
                {
                    if ( GetLocalInt( oHurt, "SUMMONED" ) || !GetLocalInt( oSubject, "SUMMONED" ) )
                    {
                        oHurt = oSubject;
                    }
                }
            }
        }
        oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++ );
    }
    return oHurt;
}

object GetLowestHPAlly( float fRad=15.0, int iLim=0, object oEnt=OBJECT_SELF, int iSee=FALSE )
{
	object oSub = oEnt;
	object oHurt = OBJECT_INVALID;
	int iCnt = 0;
	int iHP = 0;
	int iSubHP;
	int iDam;
	
	while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) < fRad )
	{
		iDam = GetMaxHitPoints( oSub ) - GetCurrentHitPoints( oSub );
		if ( GetObjectSeen( oSub, oEnt ) >= iSee && iDam >= iLim )
		{
			iSubHP = GetCurrentHitPoints( oSub );
			if ( !iHP || iSubHP < iHP )
			{
				//either we haven't got an oHurt yet, or we do and oSub is on less HP
				iHP = iSubHP;
				oHurt = oSub;
			}
		}
		oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, ++iCnt );
	}
	return oHurt;
}

object GetLowestHPAllyNoHealer( float fRad=15.0, int iLim=0, object oEnt=OBJECT_SELF, int iSee=FALSE, int iLive=TRUE )
{
	object oSub = oEnt;
	object oHurt = OBJECT_INVALID;
	int iCnt = 0;
	int iHP = 0;
	int iSubHP;
	int iDam;
	int iU;
	
	while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) < fRad )
	{
		iU = GetRacialType( oSub ) == RACIAL_TYPE_UNDEAD;
		if ( ( iLive || iU ) && ( !iLive || !iU ) )
		{
			iDam = GetMaxHitPoints( oSub ) - GetCurrentHitPoints( oSub );
			if ( !GetIsObjectValid( GetLocalObject( oSub, "#HEALER" ) ) && GetObjectSeen( oSub, oEnt ) >= iSee && iDam >= iLim )
			{
				iSubHP = GetCurrentHitPoints( oSub );
				if ( !iHP || iSubHP < iHP )
				{
					//either we haven't got an oHurt yet, or we do and oSub is on less HP
					iHP = iSubHP;
					oHurt = oSub;
				}
			}
		}
		oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, ++iCnt );
	}
	return oHurt;
}

object GetNearestDeadAlly( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE )
{
    int iCnt = 1;
    object oDead = OBJECT_INVALID;
    //object oSubject = GetNearestObject( OBJECT_TYPE_CREATURE, oEnt, iCnt++ );
    object oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, FALSE );

    while ( !GetIsObjectValid( oDead ) && GetIsObjectValid( oSubject ) && GetDistanceBetween( oEnt, oSubject ) <= fRad )
    {
        if ( GetObjectSeen( oSubject, oEnt ) >= iSee )
        {
            oDead = oSubject;
        }
        oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, FALSE );
    }
    return oDead;
}

object GetNearestDeadAllyNoRaiser( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE )
{
    int iCnt = 1;
    object oDead = OBJECT_INVALID;
    //object oSubject = GetNearestObject( OBJECT_TYPE_CREATURE, oEnt, iCnt++ );
    object oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, FALSE );

    while ( !GetIsObjectValid( oDead ) && GetIsObjectValid( oSubject ) && GetDistanceBetween( oEnt, oSubject ) <= fRad )
    {
        if ( GetObjectSeen( oSubject, oEnt ) >= iSee && !GetIsObjectValid( GetLocalObject( oSubject, "#RAISER" ) ) )
        {
            oDead = oSubject;
        }
        oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, FALSE );
    }
    return oDead;
}

object GetNearestPetrifiedAllyNoHelper( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE )
{
    int iCnt = 1;
    int iEff;
    object oPet = OBJECT_INVALID;
    //object oSubject = GetNearestObject( OBJECT_TYPE_CREATURE, oEnt, iCnt++ );
    object oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( !GetIsObjectValid( oPet ) && GetIsObjectValid( oSubject ) && GetDistanceBetween( oEnt, oSubject ) <= fRad )
    {
        if ( GetObjectSeen( oSubject, oEnt ) >= iSee && !GetIsObjectValid( GetLocalObject( oSubject, "#FLESHER" ) ) )
        {
        	if ( GetEffectsOnObject( oPet ) & 8192 ) //check for petrify effect
        	{
            	oPet = oSubject;
            }
        }
        oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return oPet;
}

int GetEffectsOnObject( object oEnt=OBJECT_SELF )
{
    int iTally = 0;
    int iType;
    effect eSubj;

    eSubj = GetFirstEffect( oEnt );
    while ( GetIsEffectValid( eSubj ) )
    {
    	if ( GetIsFriend( GetEffectCreator( eSubj ) ) )
    	{
    		//probably a side-effect or intentionally there, ignore it
    	}
    	else
    	{
        	iType = GetEffectType( eSubj );
        	if ( iType == EFFECT_TYPE_ABILITY_DECREASE ||
            	iType == EFFECT_TYPE_AC_DECREASE ||
            	iType == EFFECT_TYPE_ATTACK_DECREASE ||
            	iType == EFFECT_TYPE_DAMAGE_DECREASE ||
            	iType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
	            iType == EFFECT_TYPE_SAVING_THROW_DECREASE )
        	{
	            iTally += NO_EFFECT_GENERIC;
        	}
        	else if ( iType == EFFECT_TYPE_DISEASE )
        	{
	            iTally += NO_EFFECT_DISEASE;
        	}
        	else if ( iType == EFFECT_TYPE_CURSE )
        	{
	            iTally += NO_EFFECT_CURSE;
        	}
        	else if ( iType == EFFECT_TYPE_POISON )
        	{
	            iTally += NO_EFFECT_POISON;
        	}
        	else if ( iType == EFFECT_TYPE_DEAF )
        	{
	            iTally += NO_EFFECT_DEAF;
        	}
        	else if ( iType == EFFECT_TYPE_BLINDNESS )
        	{
	            iTally += NO_EFFECT_BLINDNESS;
        	}
        	else if ( iType == EFFECT_TYPE_SILENCE )
        	{
	        	iTally += NO_EFFECT_SILENCE;
        	}
        	else if ( iType == EFFECT_TYPE_NEGATIVELEVEL )
        	{
	            iTally += NO_EFFECT_NEGATIVELEVEL;
        	}
        	else if ( iType == EFFECT_TYPE_DAZED )
        	{
	        	iTally += NO_EFFECT_DAZED;
        	}
        	else if ( iType == EFFECT_TYPE_FRIGHTENED )
        	{
	            iTally += NO_EFFECT_FRIGHTENED;
        	}
        	else if ( iType == EFFECT_TYPE_CONFUSED )
        	{
	            iTally += NO_EFFECT_CONFUSED;
        	}
        	else if ( iType == EFFECT_TYPE_CHARMED )
        	{
	            iTally += NO_EFFECT_CHARMED;
        	}
        	else if ( iType == EFFECT_TYPE_SLEEP )
        	{
	            iTally += NO_EFFECT_SLEEP;
        	}
        	else if ( iType == EFFECT_TYPE_STUNNED )
        	{
	            iTally += NO_EFFECT_STUNNED;
        	}
        	else if ( iType == EFFECT_TYPE_DOMINATED )
        	{
	        	iTally += NO_EFFECT_DOMINATED;
       		}
        	else if ( iType == EFFECT_TYPE_PETRIFY )
        	{
	        	iTally += NO_EFFECT_PETRIFY;
        	}
        	else if ( iType == EFFECT_TYPE_PARALYZE )
        	{
	            iTally += NO_EFFECT_PARALYZE;
        	}
        }        
        eSubj = GetNextEffect( oEnt );
    }
    return iTally;
}

object GetMostHamperedAlly( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE )
{
    object oSubject = oEnt;
    object oHurt = OBJECT_INVALID;
    int iCnt = 1;
    int iEff = 0;

    while ( GetIsObjectValid( oSubject ) && GetDistanceBetween( oEnt, oSubject ) <= fRad )
    {
        //if ( GetObjectSeen( oSubject, oEnt ) >= iSee && !GetIsObjectValid( GetLocalObject( oHurt, "HELPER" ) ) )
        if ( GetObjectSeen( oSubject, oEnt ) >= iSee && !GetIsObjectValid( GetLocalObject( oSubject, "HELPER" ) ) )
        {
            iEff = GetEffectsOnObject( oSubject );
            if ( iEff )
            {
                if ( GetIsObjectValid( oHurt ) )
                {
                    if ( GetEffectsOnObject( oHurt ) < iEff )
                    {
                        oHurt = oSubject;
                    }
                }
                else
                {
                    oHurt = oSubject;
                }
            }
        }
        oSubject = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++ );
    }
    return oHurt;
}

vector GetAreaTarget( int iS, float fRad, float fMinRad=7.5, float fMaxRad=30.0, int iEffChk=TRUE, object oCaster=OBJECT_SELF )
{
    vector vU = GetPosition( oCaster );
    vector vS = Vector( 0.0, 0.0, 0.0 );
    vector vT = Vector( 0.0, 0.0, 0.0 );
    object oSub1 = OBJECT_INVALID;
    object oSub2 = OBJECT_INVALID;
    int iCnt1 = 0;
    int iCnt2 = 0;
    int iCnt3 = 0;
    int iBestCnt = 0;
    float fMinSearchRad = fMinRad;
    float fMaxSearchRad = fMaxRad;

    oSub1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    //first pad out to fMinSearchRad
    while ( GetIsObjectValid( oSub1 ) && GetDistanceBetween( oCaster, oSub1 ) <= fMinSearchRad )
    {
        oSub1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    //now scan from 7.5 out to 40.0
    while ( GetIsObjectValid( oSub1 ) && GetDistanceBetween( oCaster, oSub1 ) <= fMaxSearchRad )
    {
        iCnt2 = 0;
        iCnt3 = 0;
        //don't count them as target if they're on the move
        if ( GetCurrentAction( oSub1 ) != ACTION_MOVETOPOINT && ( !iEffChk || !GetHasSpellEffect( iS, oSub1 ) ) )
        {
        	iCnt3 = 1; //starts at 1 to count oSub1
        	vT = GetPosition ( oSub1 ) - vU;
        
        	//oSub2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oSub1, ++iCnt2, CREATURE_TYPE_IS_ALIVE, TRUE );
        	oSub2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oSub1, ++iCnt2, CREATURE_TYPE_IS_ALIVE, TRUE );
        	//this should not pick up dead creatures
        	while ( GetIsObjectValid( oSub2 ) && GetDistanceBetween( oSub1, oSub2 ) <= fRad )
        	{
	        	//SpeakString( "TH: " + GetName( oSub1 ) + " -> " + GetName( oSub2 ) );
        		//don't count them as target if they're on the move
            	if ( GetObjectSeen( oSub2, oCaster ) && GetCurrentAction( oSub2 ) != ACTION_MOVETOPOINT && ( !iEffChk || !GetHasSpellEffect( iS, oSub2 ) ) )
            	{
	                iCnt3++;
                	vT = vT + GetPosition( oSub2 ) - vU;
            	}
            	//oSub2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oSub1, ++iCnt2, CREATURE_TYPE_IS_ALIVE, TRUE );
            	oSub2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oSub1, ++iCnt2, CREATURE_TYPE_IS_ALIVE, TRUE );
        	}
        }
        if ( iCnt3 > iBestCnt )
        {
            vS = VectorNormalize( vT ) * ( VectorMagnitude( vT ) / IntToFloat( iCnt3 ) );
            iBestCnt = iCnt3;
        }
        oSub1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    //vS should now be averaged central vector to densest concentration of enemies
    //iBestCnt is count of enemies within radius of spell at this point
    if ( iBestCnt > 1 )
    //if ( iBestCnt )
    {
        return vS;
    }
    return Vector( 0.0, 0.0, 0.0 );
}

vector GetFriendlyAreaTarget( float fRad, int iSpell=0, int iType=0, object oCaster=OBJECT_SELF )
{
    vector vU = GetPosition( oCaster );
    vector vS = Vector( 0.0, 0.0, 0.0 );
    vector vT = Vector( 0.0, 0.0, 0.0 );
    object oSub1 = OBJECT_INVALID;
    object oSub2 = OBJECT_INVALID;
    int iCnt1 = 0;
    int iCnt2 = 0;
    int iCnt3 = 0;
    int iBestCnt = 0;
    float fMaxSearchRad = 30.0;

    oSub1 = oCaster;
    while ( GetIsObjectValid( oSub1 ) && GetDistanceBetween( oCaster, oSub1 ) <= fMaxSearchRad )
    {
    	if ( ( !iType && !GetHasSpellEffect( iSpell, oSub1 ) ) || ( iType && !GetHasFeatEffect( iSpell, oSub1 ) ) )
    	{
        	iCnt2 = 0;
        	iCnt3 = 0;
        	//don't count them as target if they're on the move
        	//if ( GetCurrentAction( oSub1 ) != ACTION_MOVETOPOINT )
        	//temp for goblin test
        	if ( TRUE )
        	{
        		iCnt3 = 1; //starts at 1 to count oSub1
	        	vT = GetPosition ( oSub1 ) - vU;
        	}
        	oSub2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oSub1, ++iCnt2, CREATURE_TYPE_IS_ALIVE, TRUE );
        	//this should not pick up dead creatures
        	while ( GetIsObjectValid( oSub2 ) && GetDistanceBetween( oSub1, oSub2 ) <= fRad )
        	{
        		//don't count them as target if they're on the move
            	//if ( GetObjectSeen( oSub2, oCaster ) && GetCurrentAction( oSub2 ) != ACTION_MOVETOPOINT )
            	if ( GetObjectSeen( oSub2, oCaster ) && 
            		( ( !iType && !GetHasSpellEffect( iSpell, oSub2 ) ) || ( iType && !GetHasFeatEffect( iSpell, oSub2 ) ) ) )
            	{
                	iCnt3++;
	                vT = vT + GetPosition( oSub2 ) - vU;
            	}
	            oSub2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oSub1, ++iCnt2, CREATURE_TYPE_IS_ALIVE, TRUE );
        	}
        	if ( iCnt3 > iBestCnt )
        	{
            	vS = vT / IntToFloat( iCnt3 );
	            iBestCnt = iCnt3;
        	}
        }
        oSub1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oCaster, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    //vS should now be averaged central vector to densest concentration of enemies
    //iBestCnt is count of enemies within radius
    //if ( iBestCnt > 1 )
    if ( iBestCnt )
    {
        return vS;
    }
    return Vector( 0.0, 0.0, 0.0 );
}

int CanAct( object oSelf=OBJECT_SELF )
{
    int iType;
    effect eEff = GetFirstEffect( oSelf );

	if ( GetIsDead( oSelf ) || GetLocalInt( OBJECT_SELF, "DRAGONFLIGHTDEL" ) )
	{
		return FALSE;
	}
	
    while ( GetIsEffectValid( eEff ) )
    {
        iType = GetEffectType( eEff );
        if ( iType == EFFECT_TYPE_CONFUSED ||
            iType == EFFECT_TYPE_DAZED ||
            iType == EFFECT_TYPE_FRIGHTENED ||
            iType == EFFECT_TYPE_PARALYZE ||
            iType == EFFECT_TYPE_PETRIFY || 
            iType == EFFECT_TYPE_SLEEP ||
            iType == EFFECT_TYPE_STUNNED ||
          	iType == EFFECT_TYPE_TURNED ||
          	GetLocalInt( oSelf, "DRAGONFLIGHTDEL" ) == TRUE 
            )
        {
            return FALSE;
        }
        eEff = GetNextEffect( oSelf );
    }
    return TRUE;
}

int GetIsWeapon( object oWeapon )
{
    int iType;

    if ( GetIsObjectValid( oWeapon ) && ( iType = GetBaseItemType( oWeapon ) )  != BASE_ITEM_INVALID )
    {
        if (
        	iType == BASE_ITEM_BASTARDSWORD ||
            iType == BASE_ITEM_BATTLEAXE ||
            iType == BASE_ITEM_CLUB ||
            iType == BASE_ITEM_DAGGER ||
            iType == BASE_ITEM_DART ||
            iType == BASE_ITEM_DIREMACE ||
            iType == BASE_ITEM_DOUBLEAXE ||
            iType == BASE_ITEM_GREATAXE ||
            iType == BASE_ITEM_GREATSWORD ||
            iType == BASE_ITEM_HALBERD ||
            iType == BASE_ITEM_HANDAXE ||
            iType == BASE_ITEM_HEAVYCROSSBOW ||
            iType == BASE_ITEM_HEAVYFLAIL ||
            iType == BASE_ITEM_KAMA ||
            iType == BASE_ITEM_KATANA ||
            iType == BASE_ITEM_KUKRI ||
            iType == BASE_ITEM_LIGHTFLAIL ||
            iType == BASE_ITEM_LIGHTHAMMER ||
            iType == BASE_ITEM_LIGHTMACE ||
            iType == BASE_ITEM_LONGBOW ||
            iType == BASE_ITEM_LONGSWORD ||
            iType == BASE_ITEM_MAGICSTAFF ||
            iType == BASE_ITEM_MORNINGSTAR ||
            iType == BASE_ITEM_QUARTERSTAFF ||
            iType == BASE_ITEM_RAPIER ||
            iType == BASE_ITEM_SCIMITAR ||
            iType == BASE_ITEM_SCYTHE ||
            iType == BASE_ITEM_SHORTBOW ||
            iType == BASE_ITEM_SHORTSPEAR ||
            iType == BASE_ITEM_SHORTSWORD ||
            iType == BASE_ITEM_SHURIKEN ||
            iType == BASE_ITEM_SICKLE ||
            iType == BASE_ITEM_SLING ||
            iType == BASE_ITEM_THROWINGAXE ||
            iType == BASE_ITEM_TORCH ||
            iType == BASE_ITEM_TWOBLADEDSWORD ||
            iType == BASE_ITEM_WARHAMMER
            )
        {
            return TRUE;
        }
    }
    return FALSE;
}

int GetIsLightWeapon( object oWeapon, int iCanBeInvalid=FALSE )
{
    int iType;

    if ( GetIsObjectValid( oWeapon ) && ( iType = GetBaseItemType( oWeapon ) )  != BASE_ITEM_INVALID )
    {
        if (
        	//iType == BASE_ITEM_BASTARDSWORD ||
            //iType == BASE_ITEM_BATTLEAXE ||
            iType == BASE_ITEM_CLUB ||
            iType == BASE_ITEM_DAGGER ||
            //iType == BASE_ITEM_DART ||
            //iType == BASE_ITEM_DIREMACE ||
            //iType == BASE_ITEM_DOUBLEAXE ||
            //iType == BASE_ITEM_GREATAXE ||
            //iType == BASE_ITEM_GREATSWORD ||
            //iType == BASE_ITEM_HALBERD ||
            iType == BASE_ITEM_HANDAXE ||
            //iType == BASE_ITEM_HEAVYCROSSBOW ||
            //iType == BASE_ITEM_HEAVYFLAIL ||
            iType == BASE_ITEM_KAMA ||
            //iType == BASE_ITEM_KATANA ||
            iType == BASE_ITEM_KUKRI ||
            iType == BASE_ITEM_LIGHTFLAIL ||
            iType == BASE_ITEM_LIGHTHAMMER ||
            iType == BASE_ITEM_LIGHTMACE ||
            //iType == BASE_ITEM_LONGBOW ||
            //iType == BASE_ITEM_LONGSWORD ||
            //iType == BASE_ITEM_MAGICSTAFF ||
            //iType == BASE_ITEM_MORNINGSTAR ||
            //iType == BASE_ITEM_QUARTERSTAFF ||
            iType == BASE_ITEM_RAPIER ||
            //iType == BASE_ITEM_SCIMITAR ||
            //iType == BASE_ITEM_SCYTHE ||
            //iType == BASE_ITEM_SHORTBOW ||
            //iType == BASE_ITEM_SHORTSPEAR ||
            iType == BASE_ITEM_SHORTSWORD ||
            //iType == BASE_ITEM_SHURIKEN ||
            iType == BASE_ITEM_SICKLE //||
            //iType == BASE_ITEM_SLING ||
            //iType == BASE_ITEM_THROWINGAXE ||
            //iType == BASE_ITEM_TORCH ||
            //iType == BASE_ITEM_TWOBLADEDSWORD ||
            //iType == BASE_ITEM_WARHAMMER
            )
        {
            return TRUE;
        }
    }
    else if ( !GetIsObjectValid( oWeapon ) && iCanBeInvalid )
    {
    	//special case for unarmed
    	return TRUE;
    }
    return FALSE;
}

int GetIsDoubleWeapon( object oWeapon )
{
    int iType;

    if ( GetIsObjectValid( oWeapon ) && ( iType = GetBaseItemType( oWeapon ) )  != BASE_ITEM_INVALID )
    {
        if (
        	//iType == BASE_ITEM_BASTARDSWORD ||
            //iType == BASE_ITEM_BATTLEAXE ||
            //iType == BASE_ITEM_CLUB ||
            //iType == BASE_ITEM_DAGGER ||
            //iType == BASE_ITEM_DART ||
            iType == BASE_ITEM_DIREMACE ||
            iType == BASE_ITEM_DOUBLEAXE ||
            //iType == BASE_ITEM_GREATAXE ||
            //iType == BASE_ITEM_GREATSWORD ||
            //iType == BASE_ITEM_HALBERD ||
            //iType == BASE_ITEM_HANDAXE ||
            //iType == BASE_ITEM_HEAVYCROSSBOW ||
            //iType == BASE_ITEM_HEAVYFLAIL ||
            //iType == BASE_ITEM_KAMA ||
            //iType == BASE_ITEM_KATANA ||
            //iType == BASE_ITEM_KUKRI ||
            //iType == BASE_ITEM_LIGHTFLAIL ||
            //iType == BASE_ITEM_LIGHTHAMMER ||
            //iType == BASE_ITEM_LIGHTMACE ||
            //iType == BASE_ITEM_LONGBOW ||
            //iType == BASE_ITEM_LONGSWORD ||
            //iType == BASE_ITEM_MAGICSTAFF ||
            //iType == BASE_ITEM_MORNINGSTAR ||
            //iType == BASE_ITEM_QUARTERSTAFF ||
            //iType == BASE_ITEM_RAPIER ||
            //iType == BASE_ITEM_SCIMITAR ||
            //iType == BASE_ITEM_SCYTHE ||
            //iType == BASE_ITEM_SHORTBOW ||
            //iType == BASE_ITEM_SHORTSPEAR ||
            //iType == BASE_ITEM_SHORTSWORD ||
            //iType == BASE_ITEM_SHURIKEN ||
            //iType == BASE_ITEM_SICKLE ||
            //iType == BASE_ITEM_SLING ||
            //iType == BASE_ITEM_THROWINGAXE ||
            //iType == BASE_ITEM_TORCH ||
            iType == BASE_ITEM_TWOBLADEDSWORD //||
            //iType == BASE_ITEM_WARHAMMER
            )
        {
            return TRUE;
        }
    }
    return FALSE;
}

int GetCasterCount( float fRad=5.0, object oEnt=OBJECT_SELF )
{
    int iCnt = 1;
    int iCast = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );

    while ( GetIsObjectValid( oSub ) )
    {
        if ( !GetIsDead( oSub ) && GetIsCaster( oSub ) )
        {
            iCast++;
        }
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
    }
    return iCast;
}

int GetAttackerCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF )
{
    int iCnt = 1;
    int iAtk = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
        if ( GetAttackTarget( oSub ) == oEnt )
        {
        	if ( GetObjectSeen( oSub, oS ) || GetObjectHeard( oSub, oS ) )
        	{
            	iAtk++;
            }
        }
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return iAtk;
}

int GetHostileCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF )
{
    int iCnt = 1;
    int iEnemy = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
    	if ( GetObjectSeen( oSub, oS ) || GetObjectHeard( oSub, oS ) )
    	{
        	iEnemy++;
        }
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return iEnemy;
}

int GetOmniscientHostileCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF )
{
    int iCnt = 1;
    int iEnemy = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
        iEnemy++;
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return iEnemy;
}

int GetAllyCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF )
{
    int iCnt = 1;
    int iAlly = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
    	if ( GetObjectSeen( oSub, oS ) || GetObjectHeard( oSub, oS ) )
    	{
	        iAlly++;
	    }
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return iAlly;
}

int GetAttackerHD( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF )
{
    int iCnt = 1;
    int iAtk = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
        if ( GetAttackTarget( oSub ) == oEnt )
        {
        	if ( GetObjectSeen( oSub, oS ) || GetObjectHeard( oSub, oS ) )
        	{
            	iAtk += GetHitDice( oSub );
            }
        }
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return iAtk;
}

int GetHostileHD( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF )
{
    int iCnt = 1;
    int iEnemy = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
    	if ( GetObjectSeen( oSub, oS ) || GetObjectHeard( oSub, oS ) )
    	{
        	iEnemy += GetHitDice( oSub );
        }
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return iEnemy;
}

int GetAllyHD( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF )
{
    int iCnt = 1;
    int iAlly = 0;
    object oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
    	if ( GetObjectSeen( oSub, oS ) || GetObjectHeard( oSub, oS ) )
    	{
	        iAlly += GetHitDice( oSub );
	    }
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return iAlly;
}

vector GetHostileVector( float fRad=10.0f, object oEnt=OBJECT_SELF )
{
    int iCnt = 1;
    int iNum = 0;
    vector vU = GetPosition( oEnt );
    vector vT = Vector( 0.0, 0.0, 0.0 );
    object oSub;

    oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    while ( GetIsObjectValid( oSub ) && GetDistanceBetween( oEnt, oSub ) <= fRad )
    {
    	iNum++;
        vT = vT + GetPosition( oSub ) - vU;
        oSub = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    
    if ( iNum )
    {
    	vT = vT / IntToFloat( iNum );
    }
    return vT;
}

vector GetHostileEvacVector( vector vS, object oEnt=OBJECT_SELF )
{
    vector vU = GetPosition( oEnt );
    vector vT = Vector( 0.0, 0.0, 0.0 );
    int iR = GetLocalInt( oEnt, "#LASTHSRETRIES" );

    if ( VectorMagnitude( vS ) > 0.0 )
    {
        if ( GetLocalLocation( oEnt, "#LASTHOTSPOT" ) == GetLocation( oEnt ) )
        {
        	if ( !iR )
        	{
        		iR++;
            	vT = 10.0 * VectorNormalize( AngleToVector( GetLocalFloat( oEnt, "#LASTAMANGLE" ) - 90.0 + 180.0 * IntToFloat( Random( 2 ) ) ) );
            }
            else
            {
            	iR--;
            }
        }
        else
        {
            
            vT = 10.0 * VectorNormalize( vS );
        }
    }
    else
    {
        vT = 10.0 * VectorNormalize( AngleToVector( IntToFloat( Random( 360 ) ) ) );
    }
    if ( iR )
    {
    	SetLocalInt( oEnt, "#LASTHSRETRIES", iR );
    }
    else
    {
    	DeleteLocalInt( oEnt, "#LASTHSRETRIES" );
    }
    return vT;
}

int GetIsCaster( object oEnt=OBJECT_SELF )
{
    int iCnt = 0;

    if ( GetLevelByClass( CLASS_TYPE_BARD, oEnt ) ||
        GetLevelByClass( CLASS_TYPE_CLERIC, oEnt ) ||
        GetLevelByClass( CLASS_TYPE_DRUID, oEnt ) ||
        GetLevelByClass( CLASS_TYPE_PALADIN, oEnt ) > 4 ||
        GetLevelByClass( CLASS_TYPE_RANGER, oEnt ) > 4 ||
        GetLevelByClass( CLASS_TYPE_SORCERER, oEnt ) ||
        GetLevelByClass( CLASS_TYPE_WIZARD, oEnt ) ||
        GetLocalInt( oEnt, "#CASTER" ) )
    {
        return TRUE;
    }
    return FALSE;
}

int DoAbilityCheck( int iAbil, int iDC, object oEnt=OBJECT_SELF )
{
    if ( d20() + GetAbilityModifier( iAbil, oEnt ) >= iDC )
    {
        return TRUE;
    }
    return FALSE;
}

int DoCombatKnowledgeCheck( int iBAB=FALSE, int iDC=10, object oE=OBJECT_SELF )
{
	int iM = iBAB == TRUE ? GetBaseAttackBonus( oE ) : GetAbilityModifier( ABILITY_INTELLIGENCE, oE );
	
	if ( d20() + iM >= iDC )
	{
		return TRUE;
	}
	return FALSE;
}	

float GetFriendFoeRatio( location lLoc, float fRad, object oEnt=OBJECT_SELF )
{
    object oSub;
    int iEnemies = 0;
    int iFriends = 0;

    oSub = GetFirstObjectInShape( SHAPE_SPHERE, fRad, lLoc );
    while ( GetIsObjectValid( oSub ) )
    {
        if ( !GetIsDead( oSub ) )
        {
            if ( GetIsEnemy( oSub ) )
            {
                iEnemies++;
            }
            else if ( !GetIsReactionTypeFriendly( oSub, oEnt ) && !GetIsObjectValid( GetMaster( oSub ) ) )
            {
                iFriends++;
            }
        }
        oSub = GetNextObjectInShape( SHAPE_SPHERE, fRad, lLoc );
    }
    if ( !iFriends )
    {
        //no friends in area, ensure that this will be considered a good choice
        return 100.0;
    }
    return IntToFloat( iEnemies ) / iFriends;
}

float GetFriendFoeTolerance( object oEnt=OBJECT_SELF )
{
    float fTol = 2.0;
    int iGE = GetAlignmentGoodEvil( oEnt );
    int iLC = GetAlignmentLawChaos( oEnt );

    if ( iGE == ALIGNMENT_GOOD )
    {
        fTol *= 2.0;
    }
    else if ( iGE == ALIGNMENT_EVIL )
    {
        fTol *= 0.5;
    }

    if ( iLC == ALIGNMENT_LAWFUL )
    {
        fTol *= 2.0;
    }
    else if ( iLC == ALIGNMENT_CHAOTIC )
    {
        fTol *= 0.5;
    }

    return fTol;
}

object GetNearestEnemyCaster( int iMaxLvl=20, int iMinLvl=1, object oEnt=OBJECT_SELF )
{
    int iCnt = 1;
    object oC = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oC ) )
    {
        if ( GetIsCaster( oC ) )
        {
            break;
        }
        oC = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return oC;
}

int GetAverageEnemyLevel( float fRad=60.0, object oEnt=OBJECT_SELF )
{
    int iNum = 0;
    int iHD = 0;
    int iCnt = 1;
    object oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oT ) && GetDistanceBetween( oEnt, oT ) <= fRad )
    {
        iHD += GetHitDice( oT );
        iNum++;
        oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }

    if ( iNum )
    {
        return iHD / iNum;
    }
    return 0;
}

int GetSafeAverageEnemyLevel( float fRad=40.0, object oEnt=OBJECT_SELF )
{
    int iNum = 0;
    int iHD = 0;
    int iHDTotal = 0;
    int iMin = 100;
    int iMax = 0;
    int iCnt = 0;
    int iLvl = 0;
    float fHD;
    float fLower, fUpper;
    float fAvg = 0.0;
    float fStd = 0.0;
    object oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );

	//build list of enemy hit dice
	while ( GetIsObjectValid( oT ) && GetDistanceBetween( oEnt, oT ) <= fRad )
	{
		iHD = GetHitDice( oT );
		iHDTotal += iHD;
		iNum++;
		if ( iHD < iMin )
        {
        	iMin = iHD;
        }
		if ( iHD > iMax )
        {
        	iMax = iHD;
        }
        //record the value
		SetLocalInt( OBJECT_SELF, "#SAELDATA_" + IntToString( iNum ), iHD );
		oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	
    if ( iNum < 1 )
    {
    	//if we didn't count any enemies bail out here
    	iLvl = 0;
    }
    else
    {
		fAvg = IntToFloat( iHDTotal ) / iNum;
		iLvl = FloatToInt( fAvg );
	
		//check to see if pruning is necessary
		if ( iMax - iMin > 5 )
		{
			//wide range, may need some pruning
			//get std dev
			iCnt = 0;
			iHD = GetLocalInt( OBJECT_SELF, "#SAELDATA_" + IntToString( ++iCnt ) );
			while ( iHD )
			{
				fStd += pow( IntToFloat( iHD ) - fAvg, 2.0 );
				iHD = GetLocalInt( OBJECT_SELF, "#SAELDATA_" + IntToString( ++iCnt ) );
			}
			fStd = sqrt( fStd / iNum );
			fLower = fAvg - fStd;
			fUpper = fAvg + fStd;
			iHDTotal = 0;
			iCnt = 0;
			iNum = 0;
			iHD = GetLocalInt( OBJECT_SELF, "#SAELDATA_" + IntToString( ++iCnt ) );
			while ( iHD )
			{
				fHD = IntToFloat( iHD );
				if ( fHD > fLower && fHD <= fUpper )
				{
					iNum++;
					iHDTotal += iHD;
				}
				iHD = GetLocalInt( OBJECT_SELF, "#SAELDATA_" + IntToString( ++iCnt ) );
			}
			if ( !iNum )
			{
				iLvl = iMax;
			}
			else
			{
				fAvg = IntToFloat( iHDTotal ) / iNum;
				iLvl = FloatToInt( fAvg );
			}
		}
	}
	//clean up local vars
	iCnt = 0;
	while ( GetLocalInt( OBJECT_SELF, "#SAELDATA_" + IntToString( ++iCnt ) ) )
	{
		DeleteLocalInt( OBJECT_SELF, "#SAELDATA_" + IntToString( iCnt ) );
	}
	if ( iLvl == 0 )
	{
		return iMax;
	}
    return iLvl;
}

object GetLeastMagicDefendedEnemy( float fRad=5.0, object oEnt=OBJECT_SELF )
{
	struct sSpellDefStatus strMDef;
    object oS;
    object oC;
    int iCnt = 0;
    int iDef = 100000;
    
    oC = OBJECT_INVALID;
    oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    while ( GetIsObjectValid( oS ) )
    {
    	strMDef = EvaluateSpellDefenses( oS );
    	if ( strMDef.iTotal < iDef )
    	{
    		oC = oS;
    		iDef = strMDef.iTotal;
    	}
    	oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    return oC;
}

vector GetTurningVector( object oEnt=OBJECT_SELF )
{
	int iCnt1, iCnt2, iCnt3, iBestCnt;
	float fRad = 20.0;
	vector vT = Vector( 0.0, 0.0, 0.0 );
	vector vS = Vector( 0.0, 0.0, 0.0 );
	vector vU = GetPosition( oEnt );
	object oT1, oT2;
	int iTurnLvl = GetTurningLevel( oEnt );
	
	iCnt1 = 0;
	iBestCnt = 0;
	oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	//PrintString( "TU: " + GetName( oT1 ) );
	while ( GetIsObjectValid( oT1 ) && GetDistanceBetween( oEnt, oT1 ) <= 40.0f )
    {
        iCnt2 = 0;
        iCnt3 = 0;
        if ( GetIsValidTurnTarget( oT1, iTurnLvl ) )
        {
        	//PrintString( "TUV: " + GetName( oT1 ) );
        	if ( GetHasFeatEffect( FEAT_TURN_UNDEAD, oT1 ) == FALSE && GetCurrentAction( oT1 ) != ACTION_MOVETOPOINT )
        	{
	        	iCnt3 = 1; //starts at 1 to count oSub1
        		vT = GetPosition ( oT1 ) - vU;
        	}
        	//oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	//this should not pick up dead creatures
        	while ( GetIsObjectValid( oT2 ) && GetDistanceBetween( oT1, oT2 ) <= fRad )
        	{
	        	//don't count them as target if they're on the move
            	if ( GetHasFeatEffect( FEAT_TURN_UNDEAD, oT2 ) == FALSE && GetCurrentAction( oT2 ) != ACTION_MOVETOPOINT )
            	{
	            	if ( GetIsValidTurnTarget( oT2, iTurnLvl ) )
            		{
	                	iCnt3++;
                		vT = vT + GetPosition( oT2 ) - vU;
                	}
            	}
            	//oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
            	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	}
        	if ( iCnt3 > iBestCnt )
        	{
	            vS = vT / IntToFloat( iCnt3 );
            	iBestCnt = iCnt3;
        	}
        }
        oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    if ( iBestCnt )
    {
    	return vS;
    }
    return Vector( 0.0, 0.0, 0.0 );
}

int GetIsValidTurnTarget( object oT, int iL=0, object oEnt=OBJECT_SELF )
{
	int iElemental;
	int iVermin;
	int iConstructs;
	int iOutsider;
	int iRace;
	int iTurn = 0;
	
	//compare hit dice of this target to my turning level, if hd > turning level +4 we can't turn it, abort
	if ( GetHitDice( oT ) > iL + 4 )
	{
		return 0;
	}
	
	iElemental = GetHasFeat( FEAT_AIR_DOMAIN_POWER ) + GetHasFeat( FEAT_EARTH_DOMAIN_POWER ) + GetHasFeat( FEAT_FIRE_DOMAIN_POWER ) + GetHasFeat( FEAT_WATER_DOMAIN_POWER );
	iVermin = GetHasFeat( FEAT_PLANT_DOMAIN_POWER ) + GetHasFeat( FEAT_ANIMAL_COMPANION );
	iConstructs = GetHasFeat( FEAT_DESTRUCTION_DOMAIN_POWER );
	iOutsider = GetHasFeat( FEAT_GOOD_DOMAIN_POWER ) + GetHasFeat( FEAT_EVIL_DOMAIN_POWER );
	iRace = GetRacialType( oT );
	
	if ( iRace == RACIAL_TYPE_UNDEAD )
	{
		iTurn = 1;
	}
	else if ( iRace == RACIAL_TYPE_ELEMENTAL && iElemental )
	{
		iTurn = 1;
	}
	else if ( iRace == RACIAL_TYPE_VERMIN && iVermin )
	{
		iTurn = 1;
	}
	else if ( iRace == RACIAL_TYPE_CONSTRUCT && iConstructs)
	{
		iTurn = 1;
	}
	else if ( iRace == RACIAL_TYPE_OUTSIDER && iOutsider )
	{
		 iTurn = 1;
	}
	
	return iTurn;
}

int GetPotionHealAmount( object oP )
{
	int iHeal = 0;
	string sP = GetResRef( oP );
	
	if ( sP == "nw_it_mpotion002" )
	{
		//cure light wounds
		iHeal = 10;
	}
	else if ( sP == "nw_it_mpotion021" )
	{
		//cure moderate wounds
		iHeal = 20;
	}
	else if ( sP == "nw_it_mpotion003" )
	{
		//cure serious wounds
		iHeal = 30;
	}
	else if ( sP == "nw_it_mpotion004" )
	{
		//cure critical wounds
		iHeal = 40;
	}
	else if ( sP == "nw_it_mpotion013" )
	{
		//heal
		iHeal = 60;
	}
	return iHeal;
}

int GetTalentPotionHealAmount( talent tP )
{
	int iHeal = 0;
	int iP = GetIdFromTalent( tP );
	
	if ( iP ==  32 )
	{
		//cure light wounds
		iHeal = 10;
	}
	else if ( iP == 34 )
	{
		//cure moderate wounds
		iHeal = 20;
	}
	else if ( iP == 35 )
	{
		//cure serious wounds
		iHeal = 30;
	}
	else if ( iP == 31 )
	{
		//cure critical wounds
		iHeal = 40;
	}
	else if ( iP == 79 )
	{
		//heal
		iHeal = 60;
	}
	return iHeal;
}

/*
====================
GetAreaHealTarget:

Looks for a suitable group of allies to cast a particular group healing spell on.
====================
*/
vector GetAreaHealTarget( float fRad=0.0, int iH=0, object oEnt=OBJECT_SELF )
{
	int iCnt1, iCnt2, iCnt3, iBestCnt, iDam;
	vector vT = Vector( 0.0, 0.0, 0.0 );
	vector vS = Vector( 0.0, 0.0, 0.0 );
	vector vU = GetPosition( oEnt );
	object oT1, oT2;
	float fMaxSearchRad = 30.0;
	
	iCnt1 = 0;
	iBestCnt = 0;
	oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	while ( GetIsObjectValid( oT1 ) && GetDistanceBetween( oEnt, oT1 ) <= fMaxSearchRad )
    {
        iCnt2 = 0;
        iCnt3 = 0;
        iDam = GetMaxHitPoints( oT1 ) - GetCurrentHitPoints( oT1 );
        if ( iDam >= iH )
        {
        	if ( GetCurrentAction( oT1 ) != ACTION_MOVETOPOINT )
        	{
	        	iCnt3 = 1; //starts at 1 to count oSub1
        		vT = GetPosition ( oT1 ) - vU;
        	}
        	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	//this should not pick up dead creatures
        	while ( GetIsObjectValid( oT2 ) && GetDistanceBetween( oT1, oT2 ) <= fRad )
        	{
	        	//don't count them as target if they're on the move
            	if ( GetCurrentAction( oT2 ) != ACTION_MOVETOPOINT )
            	{
            		iDam = GetMaxHitPoints( oT2 ) - GetCurrentHitPoints( oT2 );
	            	if ( iDam <= iH )
            		{
	                	iCnt3++;
                		vT = vT + GetPosition( oT2 ) - vU;
                	}
            	}
            	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	}
        	if ( iCnt3 > iBestCnt )
        	{
	            vS = vT / IntToFloat( iCnt3 );
            	iBestCnt = iCnt3;
        	}
        }
        oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    if ( iBestCnt )
    {
    	return vS;
    }
    return Vector( 0.0, 0.0, 0.0 );
}

float GetAllyDamageStats( location lT, float fRad=0.0, object oEnt=OBJECT_SELF )
{
	int iCnt = 0;
	int iDam = 0;
	float fDam = 0.0;
	object oS = GetNearestObjectToLocation( OBJECT_TYPE_CREATURE, lT, ++iCnt );
	
	while ( GetIsObjectValid( oS ) && GetDistanceBetween( oEnt, oS ) < fRad )
	{
		iDam += GetMaxHitPoints( oS ) - GetCurrentHitPoints( oS );
		oS = GetNearestObjectToLocation( OBJECT_TYPE_CREATURE, lT, ++iCnt );
	}
	iCnt--;
	if ( iCnt )
	{
		fDam = IntToFloat( iDam ) / IntToFloat( iCnt );
	}
	return fDam;
}

object GetMostBuffedEnemy( float fRad=10.0, object oEnt=OBJECT_SELF )
{
	int iBuffs;
	int iMax = 0;
	int iCnt = 0;
	object oT;
	object oM = OBJECT_INVALID;
	effect eT;
	
	oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	while ( GetIsObjectValid( oT ) && GetDistanceBetween( OBJECT_SELF, oT ) < fRad )
	{
		iBuffs = 0;
		eT = GetFirstEffect( oT );
		while ( GetIsEffectValid( eT ) )
		{
			//try this to narrow down to actual "buffs"
			if ( GetEffectSubType( eT ) == SUBTYPE_MAGICAL && GetEffectDurationType( eT ) == DURATION_TYPE_TEMPORARY )
			{
				iBuffs += GetIsBuffEffect( eT );
			}
			eT = GetNextEffect( oT );
		}
		iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_SUMMONED, oT ) );
		iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_DOMINATED, oT ) );
		iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_FAMILIAR, oT ) );
		iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_ANIMALCOMPANION, oT ) );
		if ( iBuffs > iMax )
		{
			iMax = iBuffs;
			oM = oT;
		}
		
		oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	return oM;
}

object GetLeastBuffedAlly( float fRad=10.0, int iMelee=FALSE, object oEnt=OBJECT_SELF )
{
	int iBuffs;
	int iMin = 100;
	int iCnt = 0;
	object oT;
	object oM = OBJECT_INVALID;
	effect eT;
	
	oT = oEnt; //start with self
	while ( GetIsObjectValid( oT ) && GetDistanceBetween( OBJECT_SELF, oT ) < fRad )
	{
		if ( !GetIsObjectValid( GetMaster( oT ) ) )
		{
			//don't consider associates
			if ( iMelee && ( GetDistanceBetween( oEnt, oT ) < 7.5 || !GetHostileCount( 5.0, oT ) ) )
			{
				//don't buff those in the thick of melee
				iBuffs = 0;
				eT = GetFirstEffect( oT );
				while ( GetIsEffectValid( eT ) )
				{
					//try this to narrow down to actual "buffs"
					if ( GetEffectSubType( eT ) == SUBTYPE_MAGICAL && GetEffectDurationType( eT ) == DURATION_TYPE_TEMPORARY )
					{
						iBuffs += GetIsBuffEffect( eT );
					}
					eT = GetNextEffect( oT );
				}
				iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_SUMMONED, oT ) );
				iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_DOMINATED, oT ) );
				iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_FAMILIAR, oT ) );
				iBuffs += GetIsObjectValid( GetAssociate( ASSOCIATE_TYPE_ANIMALCOMPANION, oT ) );
				if ( iBuffs < iMin )
				{
					iMin = iBuffs;
					oM = oT;
				}
			}
		}
		oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	return oM;
}

int GetIsBuffEffect( effect eT )
{
	if ( GetEffectSpellId( eT ) == -1 )
	{
		return FALSE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_GREATER_SPELL_MANTLE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PREMONITION )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MIND_BLANK )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_SPELL_MANTLE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_SHADOW_SHIELD )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PROTECTION_FROM_SPELLS )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_TRUE_SEEING )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_TENSERS_TRANSFORMATION )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MASS_HASTE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_GREATER_STONESKIN )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_GLOBE_OF_INVULNERABILITY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_ETHEREAL_VISAGE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_LESSER_SPELL_MANTLE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_LESSER_MIND_BLANK )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_ENERGY_BUFFER )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_ELEMENTAL_SHIELD )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_STONESKIN )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_POLYMORPH_SELF )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MINOR_GLOBE_OF_INVULNERABILITY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_IMPROVED_INVISIBILITY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PROTECTION_FROM_ELEMENTS )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MAGIC_CIRCLE_AGAINST_GOOD )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MAGIC_CIRCLE_AGAINST_EVIL )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MAGIC_CIRCLE_AGAINST_CHAOS )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MAGIC_CIRCLE_AGAINST_LAW )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_INVISIBILITY_SPHERE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_HASTE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_CLARITY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_SEE_INVISIBILITY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_RESIST_ELEMENTS )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_OWLS_WISDOM )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_INVISIBILITY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_GHOSTLY_VISAGE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_FOXS_CUNNING )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_ENDURANCE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_EAGLE_SPLEDOR )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_DARKVISION )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_CATS_GRACE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_BULLS_STRENGTH )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PROTECTION_FROM_GOOD )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PROTECTION_FROM_EVIL )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PROTECTION__FROM_CHAOS )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PROTECTION_FROM_LAW )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_MAGE_ARMOR )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_FREEDOM_OF_MOVEMENT )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_DEATH_WARD )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_PRAYER )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_AID )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_VIRTUE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_BLESS )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_SHAPECHANGE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_NATURES_BALANCE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_AURA_OF_VITALITY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_REGENERATE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_SPELL_RESISTANCE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_AWAKEN )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_BARKSKIN )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_RESISTANCE )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_HOLY_AURA )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_UNHOLY_AURA )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_DIVINE_POWER )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_NEGATIVE_ENERGY_PROTECTION )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_SANCTUARY )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_REMOVE_FEAR )
	{
		return TRUE;
	}
	if ( GetEffectSpellId( eT ) == SPELL_WAR_CRY )
	{
		return TRUE;
	}
	return FALSE;
}

int GetAverageEffectCasterLevel( object oT=OBJECT_SELF )
{
	int iT = 0;
	int iC = 0;
	int iL = 0;
	object oE;
	object oB = OBJECT_INVALID;
	effect eT = GetFirstEffect( oT );
	
	while ( GetIsEffectValid( eT ) )
	{
		//try this to narrow down to actual "buffs"
		if ( GetEffectSubType( eT ) == SUBTYPE_MAGICAL && GetEffectDurationType( eT ) == DURATION_TYPE_TEMPORARY )
		{
			if ( GetIsBuffEffect( eT ) )
			{
				iC += 1;
				//try this to reduce redundant checking
				oE = GetEffectCreator( eT );
				if ( GetIsObjectValid( oE ) )
				{
					if ( oE != oB )
					{
						//new caster
						iL = GetMaxDispelCasterLevel( oE );
						oB = oE;
					}
					iT += iL;
					iC += 1;
				}
				else
				{
					//something has happened to effect creator, assume the worst
					iT += 20;
					iC += 1;
				}
			}
		}
		eT = GetNextEffect( oT );
	}
	if ( iC )
	{
		return iT / iC;
	}
	return 0;
}

object GetStrongestEnemySummonedAssociateOwner( float fRad=10.0, object oEnt=OBJECT_SELF )
{
	object oT, oC, oD, oM;
	int iCnt = 0;
	int iHD = 0;
	int iT;
	
	oM = OBJECT_INVALID;
	oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	while ( GetIsObjectValid( oT ) && GetDistanceBetween( oEnt, oT ) < fRad )
	{
		if ( GetIsObjectValid( oC = GetAssociate( ASSOCIATE_TYPE_SUMMONED, oT ) ) )
		{
			if ( ( iT = GetHitDice( oC ) ) > iHD )
			{
				oD = oC;
				iHD = iT;
			}
		}
		oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	if ( GetIsObjectValid( oD ) )
	{
		oM = GetMaster( oD );
	}
	return oM;
}

vector GetEnemySummonedAssociatesVector( float fRad=10.0, object oEnt=OBJECT_SELF )
{
	int iCnt1, iCnt2, iCnt3, iBestCnt;
	float fRad = 20.0;
	vector vT = Vector( 0.0, 0.0, 0.0 );
	vector vS = Vector( 0.0, 0.0, 0.0 );
	vector vU = GetPosition( oEnt );
	object oT1, oT2, oM;
	
	iCnt1 = 0;
	iBestCnt = 0;
	oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	//PrintString( "GES: " + GetName( oT1 ) );
	while ( GetIsObjectValid( oT1 ) && GetDistanceBetween( oEnt, oT1 ) <= 30.0f )
    {
        iCnt2 = 0;
        iCnt3 = 0;
        oM = GetMaster( oT1 );
        if ( GetIsObjectValid( oM ) && GetAssociate( ASSOCIATE_TYPE_SUMMONED, oM ) == oT1 )
        {
        	//PrintString( "GESV: " + GetName( oT1 ) );
        	if ( GetCurrentAction( oT1 ) != ACTION_MOVETOPOINT )
        	{
	        	iCnt3 = 1; //starts at 1 to count oSub1
        		vT = GetPosition ( oT1 ) - vU;
        	}
        	//oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	//this should not pick up dead creatures
        	while ( GetIsObjectValid( oT2 ) && GetDistanceBetween( oT1, oT2 ) <= fRad )
        	{
	        	//don't count them as target if they're on the move
            	if ( GetCurrentAction( oT2 ) != ACTION_MOVETOPOINT )
            	{
            		oM = GetMaster( oT2 );
	            	if ( GetIsObjectValid( oM ) && GetAssociate( ASSOCIATE_TYPE_SUMMONED, oM ) == oT2 )
            		{
	                	iCnt3++;
                		vT = vT + GetPosition( oT2 ) - vU;
                	}
            	}
            	//oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
            	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	}
        	if ( iCnt3 > iBestCnt )
        	{
	            vS = vT / IntToFloat( iCnt3 );
            	iBestCnt = iCnt3;
        	}
        }
        oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    if ( iBestCnt )
    {
    	return vS;
    }
    return Vector( 0.0, 0.0, 0.0 );
}

vector GetEnemyPlanarVector( float fRad=10.0, object oEnt=OBJECT_SELF )
{
	int iCnt1, iCnt2, iCnt3, iBestCnt;
	float fRad = 20.0;
	vector vT = Vector( 0.0, 0.0, 0.0 );
	vector vS = Vector( 0.0, 0.0, 0.0 );
	vector vU = GetPosition( oEnt );
	object oT1, oT2, oM;
	
	iCnt1 = 0;
	iBestCnt = 0;
	oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	//PrintString( "GEP: " + GetName( oT1 ) );
	while ( GetIsObjectValid( oT1 ) && GetDistanceBetween( oEnt, oT1 ) <= 30.0f )
    {
        iCnt2 = 0;
        iCnt3 = 0;
        if ( GetRacialType( oT1 ) == RACIAL_TYPE_OUTSIDER || GetRacialType( oT1 ) == RACIAL_TYPE_ELEMENTAL )
        {
        	//PrintString( "GEPV: " + GetName( oT1 ) );
        	if ( GetCurrentAction( oT1 ) != ACTION_MOVETOPOINT )
        	{
	        	iCnt3 = 1; //starts at 1 to count oSub1
        		vT = GetPosition ( oT1 ) - vU;
        	}
        	//oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	//this should not pick up dead creatures
        	while ( GetIsObjectValid( oT2 ) && GetDistanceBetween( oT1, oT2 ) <= fRad )
        	{
	        	//don't count them as target if they're on the move
            	if ( GetCurrentAction( oT2 ) != ACTION_MOVETOPOINT )
            	{
	            	if ( GetRacialType( oT2 ) == RACIAL_TYPE_OUTSIDER || GetRacialType( oT2 ) == RACIAL_TYPE_ELEMENTAL )
            		{
	                	iCnt3++;
                		vT = vT + GetPosition( oT2 ) - vU;
                	}
            	}
            	//oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
            	oT2 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT1, ++iCnt2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
        	}
        	if ( iCnt3 > iBestCnt )
        	{
	            vS = vT / IntToFloat( iCnt3 );
            	iBestCnt = iCnt3;
        	}
        }
        oT1 = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, ++iCnt1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }
    if ( iBestCnt )
    {
    	return vS;
    }
    return Vector( 0.0, 0.0, 0.0 );
}

object GetVisionDeprived( float fRad=10.0, object oT=OBJECT_SELF )
{
	object oS = oT;
	object oA;
	object oP;
	int iCnt = 0;
	int iSpell = 0;
	
	while ( GetIsObjectValid( oS ) && GetDistanceBetween( oT, oS ) < fRad && !GetIsObjectValid( oP ) )
	{
		if ( !GetIsObjectValid( GetLocalObject( oS, "#VISION" ) ) && ( iSpell = GetVisionSpellNeeded( oS ) ) )
		{
			if ( GetIsObjectValid( GetMaster( oS ) ) )
			{
				//associates
				oA = oS;
			}
			else
			{
				//"real" allies
				oP = oS;
			}
		}
		oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oT, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	if ( GetIsObjectValid( oP ) )
	{
		//"real" allies take preference over associates
		return oP;
	}
	return oA;
}

object GetLeastDefendedAlly( float fRad=10.0, object oC=OBJECT_SELF )
{
	object oT, oS;
	int iD;
	int iMinD;
	int iCnt = 0;
	struct sPhysDefStatus strP;
	struct sSpellDefStatus strM;
	
	iMinD = 100;
	oS = oC; //start with the caster
	while ( GetIsObjectValid( oS ) && GetDistanceBetween( oC, oS ) < fRad )
	{
		if ( !GetIsObjectValid( GetMaster( oS ) ) )
		{
			//don't defend associates
			strP = EvaluatePhysicalDefenses( oS );
			strM = EvaluateSpellDefenses( oS );
			iD = strM.iTotal < strP.iTotal ? strM.iTotal : strP.iTotal;
			oT = iD < iMinD ? oS : oT;
			iMinD = iD < iMinD ? iD : iMinD;
		}
		oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oC, ++iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	return oT;
}

int GetHasRangedCapability( object oEnt=OBJECT_SELF )
{
	object oI = GetFirstItemInInventory();
	int iR = 0;
	
	while ( GetIsObjectValid( oI ) && !iR )
	{
		iR = GetIsRangedWeapon( oI );
		oI = GetNextItemInInventory();
	}
	return iR;
}

int GetIsRangedWeapon( object oW )
{
	int iS;
	
	if ( GetIsObjectValid( oW ) )
	{
		iS = GetBaseItemType( oW );
		if ( iS == BASE_ITEM_DART || iS == BASE_ITEM_HEAVYCROSSBOW || iS == BASE_ITEM_LIGHTCROSSBOW ||
			iS == BASE_ITEM_LONGBOW || iS == BASE_ITEM_SHORTBOW || iS == BASE_ITEM_SHURIKEN ||
			iS == BASE_ITEM_SLING || iS == BASE_ITEM_THROWINGAXE )
		{
			return TRUE;
		}
	}
	return FALSE;
}

object GetMostDistantEnemy( float fR=30.0, int iS=TRUE, object oC=OBJECT_SELF )
{
	int iCnt = 1;
	object oD = OBJECT_INVALID;
	object oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oC, iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
	
	while ( GetIsObjectValid( oT ) && GetDistanceBetween( oC, oT ) <= fR )
	{
		if ( GetObjectSeen( oT, oC ) >= iS )
		{
			oD = oT;
		}
		oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oC, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	return oD;
}

vector GetSaves( object oT=OBJECT_SELF )
{
	vector vS = Vector( 0.0, 0.0, 0.0 );
	//int iC1, iC2, iC3, iL1, iL2, iL3;
	//int iCon, iDex, iWis;
	
	/*
	iC1 = GetClassByPosition( 1, oT );
	iC2 = GetClassByPosition( 2, oT );
	iC3 = GetClassByPosition( 3, oT );
	iL1 = GetLevelByPosition( 1, oT );
	iL2 = GetLevelByPosition( 2, oT );
	iL3 = GetLevelByPosition( 3, oT );	
	iCon = GetAbilityModifier( ABILITY_CONSTITUTION, oT );
	iDex = GetAbilityModifier( ABILITY_DEXTERITY, oT );
	iWis = GetAbilityModifier( ABILITY_WISDOM, oT );
	*/
	/*	
	vS += GetSavesByClass( iC1, iL1 );
	vS += GetSavesByClass( iC2, iL2 );
	vS += GetSavesByClass( iC3, iL3 );
	
	vS.x += iCon + 2 * GetHasFeat( FEAT_GREAT_FORTITUDE, oT );
	vS.y += iDex + 2 * GetHasFeat( FEAT_LIGHTNING_REFLEXES, oT );
	vS.z += iWis + 2 * GetHasFeat( FEAT_IRON_WILL, oT );
	*/
	vS.x = IntToFloat( GetFortitudeSavingThrow( oT ) );
	vS.y = IntToFloat( GetReflexSavingThrow( oT ) );
	vS.z = IntToFloat( GetWillSavingThrow( oT ) );
	
	return vS;
}

vector GetBaseSavesByClass( int iC, int iL )
{
	vector vS = Vector( 0.0, 0.0, 0.0 );
	
	if ( iC != CLASS_TYPE_INVALID )
	{
		//fort save
		if ( iC == CLASS_TYPE_ANIMAL || iC == CLASS_TYPE_BARBARIAN || iC == CLASS_TYPE_BEAST || 
			iC == CLASS_TYPE_CLERIC || iC == CLASS_TYPE_DRAGON || iC == CLASS_TYPE_DRUID || iC == CLASS_TYPE_FIGHTER || 
			iC == CLASS_TYPE_GIANT || iC == CLASS_TYPE_HUMANOID || iC == CLASS_TYPE_MAGICAL_BEAST  || 
			iC == CLASS_TYPE_MONK || iC == CLASS_TYPE_OUTSIDER || iC == CLASS_TYPE_PALADIN || iC == CLASS_TYPE_RANGER || 
			iC == CLASS_TYPE_SHAPECHANGER || iC == CLASS_TYPE_VERMIN )
		{
			vS.x += 2.0 + IntToFloat( iL / 2 );
		}
		else
		{
			vS.x += IntToFloat( iL / 3 );
		}
		//reflex save
		if ( iC == CLASS_TYPE_ANIMAL || iC == CLASS_TYPE_BARD || iC == CLASS_TYPE_BEAST || iC == CLASS_TYPE_DRAGON || 
			iC == CLASS_TYPE_FEY || iC == CLASS_TYPE_MAGICAL_BEAST || iC == CLASS_TYPE_MONK || iC == CLASS_TYPE_MONSTROUS || 
			iC == CLASS_TYPE_OUTSIDER || iC == CLASS_TYPE_ROGUE || iC == CLASS_TYPE_SHAPECHANGER )
		{
			vS.y += 2.0 + IntToFloat( iL / 2 );
		}
		else
		{
			vS.y += IntToFloat( iL / 3 );
		}
		//will save
		if ( iC == CLASS_TYPE_ABERRATION || iC == CLASS_TYPE_BARD || iC == CLASS_TYPE_CLERIC || iC == CLASS_TYPE_DRAGON || 
			iC == CLASS_TYPE_DRUID || iC == CLASS_TYPE_ELEMENTAL || iC == CLASS_TYPE_FEY || iC == CLASS_TYPE_MONK || 
			iC == CLASS_TYPE_MONSTROUS || iC == CLASS_TYPE_OUTSIDER || iC == CLASS_TYPE_SHAPECHANGER || 
			iC == CLASS_TYPE_SORCERER || iC == CLASS_TYPE_WIZARD )
		{
			vS.z += 2.0 + IntToFloat( iL / 2 );
		}
		else
		{
			vS.z += IntToFloat( iL / 3 );
		}
	}
	
	return vS;
}

vector GetAverageEnemySaveInArea( vector vP, float fR=5.0, object oC=OBJECT_SELF )
{
	vector vS = Vector( 0.0, 0.0, 0.0 );
	location lL = Location( GetArea( oC ), GetPosition( oC ) + vP, VectorToAngle( vP ) );
	int iCnt = 0;
	object oT;
	
	oT = GetFirstObjectInShape( SHAPE_SPHERE, fR, lL );
	while ( GetIsObjectValid( oT ) )
	{
		if ( GetIsEnemy( oT ) && ( GetObjectSeen( oT, oC ) || GetObjectHeard( oT, oC ) ) )
		{
			iCnt++;
			vS += GetSaves( oT );
		}
		oT = GetNextObjectInShape( SHAPE_SPHERE, fR, lL );
	}
	if ( iCnt )
	{
		vS.x = vS.x / IntToFloat( iCnt );
		vS.y = vS.y / IntToFloat( iCnt );
		vS.z = vS.z / IntToFloat( iCnt );
	}
	return vS;
}

//Function imported from SoU x0_i0_spells
int IsImmuneToPetrification(object oCreature)
{
    int nAppearance = GetAppearanceType(oCreature);
    int bFlesh = FALSE;
    switch (nAppearance)
    {
    case APPEARANCE_TYPE_BASILISK:
    case APPEARANCE_TYPE_COCKATRICE:
    case APPEARANCE_TYPE_MEDUSA:
    case APPEARANCE_TYPE_ALLIP:
    case APPEARANCE_TYPE_ELEMENTAL_AIR:
    case APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER:
    case APPEARANCE_TYPE_ELEMENTAL_EARTH:
    case APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER:
    case APPEARANCE_TYPE_ELEMENTAL_FIRE:
    case APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER:
    case APPEARANCE_TYPE_ELEMENTAL_WATER:
    case APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER:
    case APPEARANCE_TYPE_GOLEM_STONE:
    case APPEARANCE_TYPE_GOLEM_IRON:
    case APPEARANCE_TYPE_GOLEM_CLAY:
    case APPEARANCE_TYPE_GOLEM_BONE:
    case APPEARANCE_TYPE_GORGON:
    case APPEARANCE_TYPE_HEURODIS_LICH:
    case APPEARANCE_TYPE_LANTERN_ARCHON:
    case APPEARANCE_TYPE_SHADOW:
    case APPEARANCE_TYPE_SHADOW_FIEND:
    case APPEARANCE_TYPE_SHIELD_GUARDIAN:
    case APPEARANCE_TYPE_SKELETAL_DEVOURER:
    case APPEARANCE_TYPE_SKELETON_CHIEFTAIN:
    case APPEARANCE_TYPE_SKELETON_COMMON:
    case APPEARANCE_TYPE_SKELETON_MAGE:
    case APPEARANCE_TYPE_SKELETON_PRIEST:
    case APPEARANCE_TYPE_SKELETON_WARRIOR:
    case APPEARANCE_TYPE_SKELETON_WARRIOR_1:
    case APPEARANCE_TYPE_SPECTRE:
    case APPEARANCE_TYPE_WILL_O_WISP:
    case APPEARANCE_TYPE_WRAITH:
    case APPEARANCE_TYPE_BAT_HORROR:

        bFlesh = TRUE;
    }
    return bFlesh;
}

object GetNearestAddledEnemy( float fRange=10.0, object oE=OBJECT_SELF )
{
	object oS = OBJECT_INVALID;
	int iCnt = 0;
	int iEff = 0;
	
	oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oE, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
	while ( GetIsObjectValid( oS ) && GetDistanceBetween( oE, oS ) < fRange )
	{
		iEff = GetEffectsOnObject( oS );
		//can't extract from petrified enemies
		if ( ( iEff & NO_EFFECT_PETRIFY ) == 0 )
		{
			if ( iEff & NO_EFFECT_STUNNED || iEff & NO_EFFECT_DAZED || iEff & NO_EFFECT_PARALYZE || iEff & NO_EFFECT_SLEEP || 
				iEff & NO_EFFECT_CONFUSED )
			{
				//creature is an addled enemy
				return oS;
			}
		}
		oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oE, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
	}
	return OBJECT_INVALID;
}

object GetNearestAddledEnemyNoExtractor( float fRange=10.0, object oE=OBJECT_SELF )
{
	object oS = OBJECT_INVALID;
	int iCnt = 0;
	int iEff = 0;
	
	oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oE, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
	while ( GetIsObjectValid( oS ) && GetDistanceBetween( oE, oS ) < fRange )
	{
		iEff = GetEffectsOnObject( oS );
		//can't extract from petrified enemies
		if ( IsBrainExtractable( oS ) )
		{
			if ( iEff & NO_EFFECT_STUNNED || iEff & NO_EFFECT_DAZED || iEff & NO_EFFECT_PARALYZE || iEff & NO_EFFECT_SLEEP )
			{
				//creature is an addled enemy
				return oS;
			}
		}
		oS = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oE, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN );
	}
	return OBJECT_INVALID;
}

int IsBrainExtractable( object oT )
{
	int iEff, iR;
	int iE = TRUE;
	
	if ( GetIsObjectValid( oT ) )
	{
		iEff = GetEffectsOnObject( oT );
		iR = GetRacialType( oT );
		
		if ( iEff & NO_EFFECT_PETRIFY || GetLocalInt( oT, "#EXTRACTING" ) || 
			iR == RACIAL_TYPE_CONSTRUCT || iR == RACIAL_TYPE_ELEMENTAL || iR == RACIAL_TYPE_UNDEAD || iR == RACIAL_TYPE_VERMIN )
		{
			iE = FALSE;
		}
	}
	return iE;
}

int GetCreatureAttackBonus( object oC=OBJECT_SELF )
{
	int iA = GetBaseAttackBonus( oC );
	if ( GetHasFeat( FEAT_WEAPON_FINESSE, oC ) )
	{
		iA += GetAbilityModifier( ABILITY_DEXTERITY, oC );
	}
	else
	{
		iA += GetAbilityModifier( ABILITY_STRENGTH, oC );
	}
	iA += GetHasFeat( FEAT_WEAPON_FOCUS_CREATURE, oC );
	return iA;
}

int GetGrappleBonus( object oC=OBJECT_SELF )
{
	return GetBaseAttackBonus( oC ) + GetAbilityModifier( ABILITY_STRENGTH, oC ) + 4 * ( GetCreatureSize( oC ) - CREATURE_SIZE_MEDIUM );
}

int GetIsMaster( object oM, object oE=OBJECT_SELF )
{
	if ( GetIsObjectValid( oM ) && GetMaster( oE ) == oM )
	{
		return TRUE;
	}
	return FALSE;
}

int GetIsPerceived( object oP, int iP=0, object oE=OBJECT_SELF )
{
	float fR = 0.0;
	int iR = FALSE;
	
	if ( !GetIsObjectValid( oP ) )
	{
		return FALSE;
	}
	
	if ( iP == NO_PERCEPTION_SEEN || iP == 0 )
	{
		fR = GetPerceptionRange( NO_PERCEPTION_SEEN );
		if ( GetObjectSeen( oP ) && GetDistanceBetween( oE, oP ) < fR )
		{
			iR = TRUE;
		}
	}
	if ( iP == NO_PERCEPTION_HEARD || iP == 0 )
	{
		fR = GetPerceptionRange( NO_PERCEPTION_HEARD );
		if ( GetObjectHeard( oP ) && GetDistanceBetween( oE, oP ) < fR )
		{
			iR = TRUE;
		}
	}
	if ( iP == NO_PERCEPTION_VANISHED || iP == 0 )
	{
		fR = GetPerceptionRange( NO_PERCEPTION_VANISHED );
		if ( !GetIsPerceived( oP, NO_PERCEPTION_SEEN ) && !GetIsPerceived( oP, NO_PERCEPTION_HEARD ) && GetDistanceBetween( oE, oP ) < fR )
		{
			iR = TRUE;
		}
	}
	//return TRUE;
	return iR;
}

object GetNearestPerceivedCreature( int iP=NO_PERCEPTION_SEEN, object oE=OBJECT_SELF )
{
	object oP;
	
	//NOT FINISHED
	
	return oP;
}

object GetNearestActiveAlly( object oE=OBJECT_SELF )
{
	int iCnt = 0;
	object oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
	
	while ( GetIsObjectValid( oT ) && !GetLocalInt( oT, "#ACTIVE" ) )
	{
		oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	return oT;
}

object GetFurthestActiveAlly( float fD=50.0, object oE=OBJECT_SELF )
{
	int iCnt = 0;
	object oA;
	object oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oE, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
	
	while ( GetIsObjectValid( oT ) && GetDistanceBetween( oE, oT ) < fD )
	{
		if ( GetLocalInt( oT, "#ACTIVE" ) )
		{
			oA = oT;
		}
		oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oE, ++iCnt, CREATURE_TYPE_IS_ALIVE, TRUE );
	}
	return oA;
}

int EstimateAttackBonus( object oC=OBJECT_SELF )
{
	int iA = GetBaseAttackBonus( oC );
	object oR = GetItemInSlot( INVENTORY_SLOT_RIGHTHAND );
	object oL = GetItemInSlot( INVENTORY_SLOT_LEFTHAND );
	
	//weapon focus
	iA += GetHasWeaponFocus( oR );
	
	//strength bonus or weapon finesse
	if ( GetHasFeat( FEAT_WEAPON_FINESSE, oC ) && GetIsLightWeapon( oR, TRUE ) )
	{
		iA += GetAbilityModifier( ABILITY_DEXTERITY, oC );
	}
	else
	{
		iA += GetAbilityModifier( ABILITY_STRENGTH, oC );
	}
	
	//dual wielding modifiers
	if ( ( GetIsWeapon( oR ) && GetIsWeapon( oL ) ) || GetIsDoubleWeapon( oR ) )
	{
		//dual wielding
		iA += GetDualWieldingPenalty( oC, oL );
	}
	
	return iA;
}

int GetDualWieldingPenalty( object oC=OBJECT_SELF, object oR=OBJECT_INVALID, object oL=OBJECT_INVALID )
{
	int iL = GetIsLightWeapon( oL );
	int iA = GetHasFeat( FEAT_AMBIDEXTERITY, oC );
	int iT = GetHasFeat( FEAT_TWO_WEAPON_FIGHTING, oC );
	int iP = 0;
	
	if ( !GetIsObjectValid( oL ) )
	{
		//no weapon in left hand
		if ( GetIsDoubleWeapon( oR ) )
		{
			//right hand weapon is double weapon, effectively light offhand
			iL = 1;
		}
		else
		{
			//not wielding an offhand weapon, not dual wielding, no penalty, finish here
			return 0;
		}
	}
	
	if ( iA && iT )
	{
		//ambidex, two weapon fighting
		if ( iL )
		{
			//light offhand
			iP = -2;
		}
		else
		{
			//non-light offhand
			iP = -4;
		}
	}
	else if ( iA ) //no iT
	{
		//ambidex, no two weapon
		if ( iL )
		{
			//light offhand
			iP = -4;
		}
		else
		{
			//non-light offhand
			iP = -6;
		}
	}
	else if ( iT ) //no iA
	{
		//two weapon, no ambidex
		if ( iL )
		{
			//light offhand
			iP = -2;
		}
		else
		{
			//non-light offhand
			-4;
		}
	}
	else //no iA, no iT
	{
		//no two weapon, no ambidex
		if ( iL )
		{
			//light offhand
			iP = -4;
		}
		else
		{
			//non-light offhand
			iP = -6;
		}
	}
	return iP;
}

int GetHasWeaponFocus( object oR, object oC=OBJECT_SELF )
{
	int iF = 0;
	
	switch ( GetBaseItemType( oR ) )
	{
		case BASE_ITEM_BASTARDSWORD:
			iF = GetHasFeat( FEAT_WEAPON_FOCUS_BASTARD_SWORD, oC );
			break;
        case BASE_ITEM_BATTLEAXE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_BATTLE_AXE, oC );
			break;
        case BASE_ITEM_CLUB:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_CLUB, oC );
			break;
        case BASE_ITEM_DAGGER:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_DAGGER, oC );
			break;
        case BASE_ITEM_DART:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_DART, oC );
			break;
        case BASE_ITEM_DIREMACE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_DIRE_MACE, oC );
			break;
        case BASE_ITEM_DOUBLEAXE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_DOUBLE_AXE, oC );
			break;
        case BASE_ITEM_GREATAXE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_GREAT_AXE, oC );
			break;
        case BASE_ITEM_GREATSWORD:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_GREAT_SWORD, oC );
			break;
        case BASE_ITEM_HALBERD:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_HALBERD, oC );
			break;
        case BASE_ITEM_HANDAXE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_HAND_AXE, oC );
			break;
        case BASE_ITEM_HEAVYCROSSBOW:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW, oC );
			break;
        case BASE_ITEM_HEAVYFLAIL:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_HEAVY_FLAIL, oC );
			break;
        case BASE_ITEM_KAMA:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_KAMA, oC );
			break;
        case BASE_ITEM_KATANA:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_KATANA, oC );
			break;
        case BASE_ITEM_KUKRI:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_KUKRI, oC );
			break;
        case BASE_ITEM_LIGHTFLAIL:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_LIGHT_FLAIL, oC );
			break;
        case BASE_ITEM_LIGHTHAMMER:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_LIGHT_HAMMER, oC );
			break;
        case BASE_ITEM_LIGHTMACE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_LIGHT_MACE, oC );
			break;
        case BASE_ITEM_LONGBOW:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_LONGBOW, oC );
			break;
        case BASE_ITEM_LONGSWORD:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_LONG_SWORD, oC );
			break;
        case BASE_ITEM_MORNINGSTAR:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_MORNING_STAR, oC );
			break;
        case BASE_ITEM_QUARTERSTAFF:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_STAFF, oC );
			break;
        case BASE_ITEM_RAPIER:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_RAPIER, oC );
			break;
        case BASE_ITEM_SCIMITAR:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SCIMITAR, oC );
			break;
        case BASE_ITEM_SCYTHE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SCYTHE, oC );
			break;
        case BASE_ITEM_SHORTBOW:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SHORTBOW, oC );
			break;
        case BASE_ITEM_SHORTSPEAR:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SPEAR, oC );
			break;
        case BASE_ITEM_SHORTSWORD:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SHORT_SWORD, oC );
			break;
        case BASE_ITEM_SHURIKEN:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SHURIKEN, oC );
			break;
        case BASE_ITEM_SICKLE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SICKLE, oC );
			break;
        case BASE_ITEM_SLING:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_SLING, oC );
			break;
        case BASE_ITEM_THROWINGAXE:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_THROWING_AXE, oC );
			break;
        case BASE_ITEM_TWOBLADEDSWORD:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD, oC );
			break;
        case BASE_ITEM_WARHAMMER:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_WAR_HAMMER, oC );
			break;
		case BASE_ITEM_CBLUDGWEAPON:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_CREATURE, oC );
			break;
		case BASE_ITEM_CPIERCWEAPON:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_CREATURE, oC );
			break;
		case BASE_ITEM_CSLASHWEAPON:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_CREATURE, oC );
			break;
		case BASE_ITEM_CSLSHPRCWEAP:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_CREATURE, oC );
			break;
		case BASE_ITEM_INVALID:
        	iF = GetHasFeat( FEAT_WEAPON_FOCUS_UNARMED_STRIKE, oC ) || GetHasFeat( FEAT_WEAPON_FOCUS_CREATURE, oC );
			break;	
	}
	return iF;
}

int GetIsArmed( object oEnt=OBJECT_SELF )
{
	if ( GetIsObjectValid( GetItemInSlot( INVENTORY_SLOT_RIGHTHAND, oEnt ) ) || GetIsObjectValid( GetItemInSlot( INVENTORY_SLOT_LEFTHAND, oEnt ) ) )
	{
		return TRUE;
	}
	return FALSE;
}

int GetRelativeEnemyWeaponSize( object oT, object oEnt=OBJECT_SELF )
{
	int iM = GetWeaponSize( oEnt );
	int iT = GetWeaponSize( oT );
	int iR = 0;
	
	if ( iM > iT )
	{
		iR = 1;
	}
	else if ( iM < iT )
	{
		iR = -1;
	}
	return iR;
}

int GetWeaponSize( object oEnt=OBJECT_SELF )
{
	//0=small, 1=medium, 2=large
	int iS = 0;
	int iType;
	object oR = GetItemInSlot( INVENTORY_SLOT_RIGHTHAND );
	
    if ( GetIsObjectValid( oR ) && ( iType = GetBaseItemType( oR ) )  != BASE_ITEM_INVALID )
    {
        if (
        	iType == BASE_ITEM_CLUB ||
            iType == BASE_ITEM_DAGGER ||
            iType == BASE_ITEM_DART ||
            iType == BASE_ITEM_KAMA ||
            iType == BASE_ITEM_HANDAXE ||
            iType == BASE_ITEM_KUKRI ||
            iType == BASE_ITEM_LIGHTFLAIL ||
            iType == BASE_ITEM_LIGHTHAMMER ||
            iType == BASE_ITEM_LIGHTMACE ||
            iType == BASE_ITEM_RAPIER ||
            iType == BASE_ITEM_SHORTSWORD ||
            iType == BASE_ITEM_SHURIKEN ||
            iType == BASE_ITEM_SICKLE ||
            iType == BASE_ITEM_SLING ||
            iType == BASE_ITEM_THROWINGAXE ||
            iType == BASE_ITEM_TORCH 
            )
		{
			iS = 0;
		}
		else if (            
        	iType == BASE_ITEM_BASTARDSWORD ||
            iType == BASE_ITEM_BATTLEAXE ||
            iType == BASE_ITEM_KATANA ||
            iType == BASE_ITEM_LONGSWORD ||
            iType == BASE_ITEM_MORNINGSTAR ||
            iType == BASE_ITEM_SCIMITAR ||
            iType == BASE_ITEM_SHORTBOW ||
            iType == BASE_ITEM_SHORTSPEAR ||
            iType == BASE_ITEM_WARHAMMER
            )
		{
			iS = 1;
		}
		else if (            
            iType == BASE_ITEM_DIREMACE ||
            iType == BASE_ITEM_DOUBLEAXE ||
            iType == BASE_ITEM_GREATAXE ||
            iType == BASE_ITEM_GREATSWORD ||
            iType == BASE_ITEM_HALBERD ||
            iType == BASE_ITEM_HEAVYCROSSBOW ||
            iType == BASE_ITEM_HEAVYFLAIL ||
            iType == BASE_ITEM_LONGBOW ||
            iType == BASE_ITEM_QUARTERSTAFF ||
            iType == BASE_ITEM_SCYTHE ||
            iType == BASE_ITEM_TWOBLADEDSWORD            
            )
		{
			iS = 2;
		}
	}
	return iS;
}

float GetAverageDistanceToEnemy( float fRad=60.0, object oEnt=OBJECT_SELF )
{
    int iNum = 0;
    float fDist = 0.0;
    int iCnt = 1;
    object oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );

    while ( GetIsObjectValid( oT ) && GetDistanceBetween( oEnt, oT ) <= fRad )
    {
        fDist += GetDistanceBetween( oEnt, oT );
        iNum++;
        oT = GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oEnt, iCnt++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE );
    }

    if ( iNum )
    {
        return fDist / iNum;
    }
    return 0.0;
}

int GetCombatModeModifier( int iMode=0 )
{
	int iMod = 0;
	
	if ( iMode > 0 )
	{
		switch ( iMode )
		{
			case FEAT_POWER_ATTACK:
				iMod = -5;
				break;
			case FEAT_IMPROVED_POWER_ATTACK:
				iMod = -10;
				break;
			case FEAT_FLURRY_OF_BLOWS:
				iMod = -2;
				break;
			case FEAT_EXPERTISE:
				iMod = -5;
				break;
			case FEAT_IMPROVED_EXPERTISE:
				iMod = -10;
				break;
			case FEAT_RAPID_SHOT:
				iMod = -2;
				break;
		}
	}
	return iMod;
}

int GetCombatConcentration( object oE=OBJECT_SELF )
{
	int iC =	GetSkillRank( SKILL_CONCENTRATION, oE )							//RANKS
				+ GetAbilityModifier( ABILITY_CONSTITUTION, oE )				//CONSTITUTION MODIFIER
				+ 2 * GetHasFeat( FEAT_SKILL_AFFINITY_CONCENTRATION, oE )		//SKILL AFFINITY FOR CONCENTRATION
				- 4 * ( 1 - GetHasFeat( FEAT_COMBAT_CASTING, oE ) )				//COMBAT CASTING NEGATES -4 PENALTY
				+ 3 * GetHasFeat( FEAT_SKILL_FOCUS_CONCENTRATION, oE )			//SKILL FOCUS CONCENTRATION
				+ 10 * GetHasFeat( FEAT_EPIC_SKILL_FOCUS_CONCENTRATION, oE );	//EPIC SKILL FOCUS CONCENTRATION
				
	return iC;
}

int GetTurningLevel( object oC=OBJECT_SELF )
{
	int iC = GetLevelByClass( CLASS_TYPE_CLERIC, oC );
	int iP = GetLevelByClass( CLASS_TYPE_PALADIN, oC );
	int iB = GetLevelByClass( CLASS_TYPE_BLACKGUARD, oC );
	//get the higher of the levels out of BLK and PAL, subtract 2 for effective turning level
	int iA = iB > iP ? iB - 2 : iP - 2;
	//add this to turning level if it is > 0
	iC += iA > 0 ? iA : 0;
	
	return iC;
}

void SetIsCentralEyeOpen( int iS=FALSE, object oB=OBJECT_SELF )	
{
	SetLocalInt( oB, s_BEHOLDER_CENTRAL_EYE_FLAG, iS );
}

int GetIsCentralEyeOpen( object oB=OBJECT_SELF )
{
	return GetLocalInt( oB, s_BEHOLDER_CENTRAL_EYE_FLAG );
}