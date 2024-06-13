#include "no_inc_ptypes"

//functions
int GetBestRangedSpecial( object oTarget, int iPenalty=0, int iChance=50, object oEnt=OBJECT_SELF )
{
	int iCnt = 0;
	int iFeat;
	int iMyAtk;
	int iEnemyAtk;
	int iMyAC;
	int iEnemyAC;
	int iF1;
	int iF2;
	int iD;
	int iT;

	if ( !GetIsObjectValid( oTarget ) || Random( 100 ) > iChance )
	{
		return 0;
	}

	iD = GetSkillRank( SKILL_DISCIPLINE, oTarget ) + GetAbilityModifier( ABILITY_STRENGTH, oTarget ) + 3 * GetHasFeat( FEAT_SKILL_FOCUS_DISCIPLINE, oTarget );	
    iMyAtk = EstimateAttackBonus( oEnt ) + iPenalty; //include penalty from active combat mode if any
    //iEnemyAtk = EstimateAttackBonus( oTarget );
    //iMyAC = GetAC( oEnt ) - 10;
    iEnemyAC = GetAC( oTarget ) - 10;
    
    //use either my intelligence or BAB to check for creature knowledge on some of these, whichever is better
	//if iT == TRUE we will use BAB, otherwise use intelligence modifier
	iT = GetBaseAttackBonus( OBJECT_SELF ) < GetAbilityModifier( ABILITY_INTELLIGENCE ) ? FALSE : TRUE;
    
    //CALLED SHOT
    if ( GetHasFeat( FEAT_CALLED_SHOT, oEnt ) )
    {
        iFeat = 0;
        if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || ( iMyAtk - 4 >= iEnemyAC && iMyAtk - 4 > iD ) )
        {
        	iFeat = FEAT_CALLED_SHOT;
        }
        if ( iFeat )
        {
        	SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
        }
    }
    
    //SEEKER ARROW
    // Arcane Archer feats are not defined in nwscript?
    // FIX: They are in HotU but not SoU. When updating these for HotU update this block and add the rest.
    iF1 = GetHasFeat( FEAT_PRESTIGE_SEEKER_ARROW_1, oEnt );
    iF2 = GetHasFeat( FEAT_PRESTIGE_SEEKER_ARROW_2, oEnt );
    if ( iF1 || iF2 )
    {
    	iFeat = 0;
    	if ( iMyAtk + 8 < iEnemyAC ) //if I can't hit even with a high roll use a seeker arrow
    	{
    		if ( iF2 )
    		{
    			iFeat = FEAT_PRESTIGE_SEEKER_ARROW_2;
    		}
    		else
    		{
    			iFeat = FEAT_PRESTIGE_SEEKER_ARROW_1;
    		}
    	}
    	if ( iFeat )
    	{
    		SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    	}
    }
    
    //IMBUE ARROW
    if ( GetHasFeat( FEAT_PRESTIGE_IMBUE_ARROW, oEnt ) )
    {
    	iFeat = 0;
    	if ( GetAllyCount( RADIUS_SIZE_HUGE, oTarget, oEnt ) > GetHostileCount( RADIUS_SIZE_HUGE, oTarget, oEnt ) )
    	{
    		iFeat = FEAT_PRESTIGE_IMBUE_ARROW;
    	}
    	if ( iFeat )
    	{
    		SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    	}
    }
    
    //HAIL OF ARROWS
    if ( GetHasFeat( FEAT_PRESTIGE_HAIL_OF_ARROWS, oEnt ) )
    {
    	iFeat = 0;
    	if ( GetHostileCount( 30.0 ) > GetBaseAttackBonus( oEnt ) / 10 )
    	{
    		iFeat = FEAT_PRESTIGE_HAIL_OF_ARROWS;
    	}
    	if ( iFeat )
    	{
    		SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    	}
    }
    
    //ARROW OF SLAYING
    if ( GetHasFeat( FEAT_PRESTIGE_ARROW_OF_DEATH, oEnt ) )
    {
    	iFeat = 0;
    	if ( FloatToInt( NO_THRESH_ARROW_SLAYING * GetHitDice( oEnt ) ) < GetHitDice( oTarget ) &&
    		( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || GetIsImmune( oTarget, IMMUNITY_TYPE_DEATH ) == FALSE ) )
    	{
    		//target has sufficient hit dice to warrant use of an arrow of death
    		//either oEnt failed its intelligence check or it passed and determined that target is not immune to death effects
    		iFeat = FEAT_PRESTIGE_ARROW_OF_DEATH;
    	}
    	if ( iFeat )
    	{
    		SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    	}
    }
    	
    //randomly select one of the feats that was deemed suitable for use
    iFeat = GetLocalInt( oEnt, "#FEAT" + IntToString( Random( iCnt ) + 1 ) );
    while ( iCnt )
    {
    	DeleteLocalInt( oEnt, "#FEAT" + IntToString( iCnt-- ) );
    }
    return iFeat;    
}

int SelectRangedCombatModes( object oT, int iC=50, object oEnt=OBJECT_SELF )
{
	int iPenalty = 0; //accumulate penalty from attack modes
	int iMyAtk;
	//int iEnemyAtk;
	//int iMyAC;
	int iEnemyAC;
	int iF1;
	int iF2;
	int iCnt = 0;
	int iMode;
	int iT;
	
	if ( !GetIsObjectValid( oT ) || Random( 100 ) > iC )
	{
		return 0;
	}
	
	iMyAtk = EstimateAttackBonus( oEnt );
	//iEnemyAtk = EstimateAttackBonus( oT );
	//iMyAC = GetAC( oEnt ) - 10;
	iEnemyAC = GetAC( oT ) - 10;
	
	//use either my intelligence or BAB to check for creature knowledge on some of these, whichever is better
	//if iT == TRUE we will use BAB, otherwise use intelligence modifier
	iT = GetBaseAttackBonus( OBJECT_SELF ) < GetAbilityModifier( ABILITY_INTELLIGENCE ) ? FALSE : TRUE;
		
	//RAPID SHOT
	if ( GetHasFeat( FEAT_RAPID_SHOT, oEnt ) )
	{
		iMode = 0;
		if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || ( iMyAtk - 2 >= iEnemyAC ) )
		{
			iMode = FEAT_RAPID_SHOT;
		}
		if ( iMode )
		{
			SetLocalInt( oEnt, "#COMBATMODE" + IntToString( ++iCnt ), iMode );
		}
	}
		
	iMode = GetLocalInt( oEnt, "#COMBATMODE" + IntToString( Random( iCnt ) + 1 ) );
	while ( iCnt )
	{
		DeleteLocalInt( oEnt, "#COMBATMODE" + IntToString( iCnt-- ) );
	}
	return iMode;
}