#include "no_inc_ptypes"

//functions
int GetBestMeleeSpecial( object oTarget, int iPenalty=0, int iChance=50, object oEnt=OBJECT_SELF )
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
	
	//get target's discipline skill as it opposes some melee specials
	iD = GetSkillRank( SKILL_DISCIPLINE, oTarget ) + GetAbilityModifier( ABILITY_STRENGTH, oTarget ) + 3 * GetHasFeat( FEAT_SKILL_FOCUS_DISCIPLINE, oTarget );
	
	//use either my intelligence or BAB to check for creature knowledge on some of these, whichever is better
	//if iT == TRUE we will use BAB, otherwise use intelligence modifier
	iT = GetBaseAttackBonus( OBJECT_SELF ) < GetAbilityModifier( ABILITY_INTELLIGENCE ) ? FALSE : TRUE;
	
    iMyAtk = EstimateAttackBonus( oEnt ) + iPenalty; //include penalty from active combat mode if any
    //iEnemyAtk = EstimateAttackBonus( oTarget );
    //iMyAC = GetAC( oEnt ) - 10;
    iEnemyAC = GetAC( oTarget ) - 10;
    
    //KNOCKDOWN
    iF1 = GetHasFeat( FEAT_KNOCKDOWN, oEnt );
    iF2 = GetHasFeat( FEAT_IMPROVED_KNOCKDOWN, oEnt );
    if ( iF1 || iF2 )
    {
    	iFeat = 0;
    	if ( !GetHasFeatEffect( FEAT_KNOCKDOWN, oTarget ) && !GetHasFeatEffect( FEAT_IMPROVED_KNOCKDOWN, oTarget ) )
    	{
    		//figure out target's discipline
    		
    		if ( iF2 ) //improved knockdown
    		{
	    		//compare my improved knockdown attack roll to target's AC and Discipline check
    			if ( iMyAtk >= iEnemyAC && iMyAtk > iD )
    			{
	    			iFeat = FEAT_IMPROVED_KNOCKDOWN;
    			}
    		}
    		else //no iF2 means we must have iF1
    		{
    			//compare my knockdown attack roll to target's AC and Discipline check
	    		if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || ( iMyAtk - 4 >= iEnemyAC && iMyAtk - 4 > iD ) )
    			{
	    			iFeat = FEAT_KNOCKDOWN;
    			}
    		}
    	}
    	if ( iFeat )
    	{
    		SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    	}
    }
    
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
    
    //DISARM
    iF1 = GetHasFeat( FEAT_DISARM, oEnt );
    iF2 = GetHasFeat( FEAT_IMPROVED_DISARM, oEnt );
    if ( iF1 || iF2 )
    {
    	int iMod = 4 * GetRelativeEnemyWeaponSize( oTarget );
    	iFeat = 0;
        if ( GetIsArmed( oTarget) )
        {
        	if ( iF2 ) //improved disarm
        	{
        		if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || ( iMyAtk - 4 + iMod >= iEnemyAC && iMyAtk - 4 + iMod > iD ) )
        		{
        			iFeat = FEAT_IMPROVED_DISARM;
        		}
        	}
        	else //disarm
        	{
        		if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || ( iMyAtk - 6 + iMod >= iEnemyAC && iMyAtk - 6 + iMod > iD ) )
        		{
        			iFeat = FEAT_DISARM;
        		}
        	}
        }
        if ( iFeat )
        {
            SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
        }
    }
    
    //STUNNING FIST
    if ( GetHasFeat( FEAT_STUNNING_FIST, oEnt ) &&  !GetHasFeatEffect( FEAT_STUNNING_FIST, oTarget ) &&
    	FloatToInt( NO_THRESH_STUNNING_FIST * GetHitDice( oEnt ) ) < GetHitDice( oTarget ) &&
    	( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || !GetIsImmune( oTarget, IMMUNITY_TYPE_STUN ) ) )
    {
        iFeat = 0;
        if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || iMyAtk - 4 >= iEnemyAC )
        {
        	iFeat = FEAT_STUNNING_FIST;
        }
        if ( iFeat )
        {
        	SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
        }
    }
    
    //QUIVERING PALM
    if ( GetHasFeat( FEAT_QUIVERING_PALM, oEnt ) &&
    	FloatToInt( NO_THRESH_QUIVERING_PALM * GetHitDice( oEnt ) ) < GetHitDice( oTarget ) &&
    	( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || !GetIsImmune( oTarget, IMMUNITY_TYPE_DEATH ) ) )
    {
        iFeat = FEAT_QUIVERING_PALM;
        SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    }
    
    //SMITE EVIL
    if ( GetHasFeat( FEAT_SMITE_EVIL, oEnt ) && FloatToInt( NO_THRESH_SMITE * GetHitDice( oEnt ) ) < GetHitDice( oTarget ) &&
    	( DoAbilityCheck( ABILITY_INTELLIGENCE, 2 ) == FALSE || GetAlignmentGoodEvil( oTarget ) == ALIGNMENT_EVIL ) )
    {
    	iFeat = FEAT_SMITE_EVIL;
    	SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    }
    
    //SMITE GOOD
    //This feat definition was missing in nwscript pre-HotU, now it's in, uncommenting this block
    if ( GetHasFeat( FEAT_SMITE_GOOD, oEnt ) && FloatToInt( NO_THRESH_SMITE * GetHitDice( oEnt ) ) < GetHitDice( oTarget ) &&
    	( DoAbilityCheck( ABILITY_INTELLIGENCE, 2 ) == FALSE || GetAlignmentGoodEvil( oTarget ) == ALIGNMENT_GOOD ) )
    {
    	iFeat = FEAT_SMITE_GOOD;
    	SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    }
    
    //WHIRLWIND
    iF1 = GetHasFeat( FEAT_WHIRLWIND_ATTACK, oEnt );
    iF2 = GetHasFeat( FEAT_IMPROVED_WHIRLWIND, oEnt );
    if ( iF1 || iF2 )
    {
    	iFeat = 0;
        
       	if ( iF2 ) //improved whirlwind
       	{
       		//check to see if there are multiple enemies in melee range
       		//if so, check to see if there are at least as many as our number of attacks divided by 2
       		//tail end attacks probably miss anyway, so only count the top end of the attack sequence
       		//if there are enough, use whirlwind as we get full BAB on every attack with whirlwind
       		if ( GetHostileCount( 3.0 ) > GetBaseAttackBonus( oEnt ) / 10 )
       		{
       			iFeat = FEAT_IMPROVED_WHIRLWIND;
       		}
       	}
       	else //whirlwind
       	{
       		if ( GetHostileCount( 3.0 ) > GetBaseAttackBonus( oEnt ) / 10 )
       		{
       			iFeat = FEAT_WHIRLWIND_ATTACK;
       		}
       	}
        if ( iFeat )
        {
            SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
        }
    }
    
    //KI DAMAGE
    if ( GetHasFeat( FEAT_KI_DAMAGE, oEnt ) && FloatToInt( NO_THRESH_KI_DAMAGE * GetHitDice( oEnt ) ) < GetHitDice( oTarget ) )
    {
    	iFeat = FEAT_KI_DAMAGE;
    	SetLocalInt( oEnt, "#FEAT" + IntToString( ++iCnt ), iFeat );
    }
    
    iFeat = GetLocalInt( oEnt, "#FEAT" + IntToString( Random( iCnt ) + 1 ) );
    while ( iCnt )
    {
    	DeleteLocalInt( oEnt, "#FEAT" + IntToString( iCnt-- ) );
    }
    return iFeat;    
}

int SelectMeleeCombatModes( object oT, int iC=50, object oEnt=OBJECT_SELF )
{
	int iPenalty = 0; //accumulate penalty from attack modes
	int iMyAtk;
	int iEnemyAtk;
	int iMyAC;
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
	iEnemyAtk = EstimateAttackBonus( oT );
	iMyAC = GetAC( oEnt ) - 10;
	iEnemyAC = GetAC( oT ) - 10;
	
	//use either my intelligence or BAB to check for creature knowledge on some of these, whichever is better
	//if iT == TRUE we will use BAB, otherwise use intelligence modifier
	iT = GetBaseAttackBonus( OBJECT_SELF ) < GetAbilityModifier( ABILITY_INTELLIGENCE ) ? FALSE : TRUE;
	
	//POWER ATTACK, IMPROVED POWER ATTACK
	iF1 = GetHasFeat( FEAT_POWER_ATTACK, oEnt );
	iF2 = GetHasFeat( FEAT_IMPROVED_POWER_ATTACK, oEnt );
	if ( iF1 || iF2 )
	{
		iMode = 0;
		if ( iF2 ) //improved power attack
		{
			if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || iMyAtk - 10 >= iEnemyAC )
			{
				iMode = FEAT_IMPROVED_POWER_ATTACK;
			}
		}
		if ( iF1 && iMode == 0 ) //we don't have or didn't choose improved power attack
		{
			if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || iMyAtk - 5 >= iEnemyAC )
			{
				iMode = FEAT_POWER_ATTACK;
			}
		}
		if ( iMode )
		{
			SetLocalInt( oEnt, "#COMBATMODE" + IntToString( ++iCnt ), iMode );
		}
	}
	
	//FLURRY OF BLOWS
	if ( GetHasFeat( FEAT_FLURRY_OF_BLOWS, oEnt ) )
	{
		iMode = 0;
		if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || iMyAtk - 2 >= iEnemyAC )
		{
			iMode = FEAT_FLURRY_OF_BLOWS;
		}
		if ( iMode )
		{
			SetLocalInt( oEnt, "#COMBATMODE" + IntToString( ++iCnt ), iMode );
		}
	}
	
	//EXPERTISE, IMPROVED EXPERTISE
	iF1 = GetHasFeat( FEAT_EXPERTISE, oEnt );
	iF2 = GetHasFeat( FEAT_IMPROVED_EXPERTISE, oEnt );
	if ( iF1 || iF2 )
	{
		iMode = 0;
		if ( iF2 ) //improved expertise
		{
			//check if I can afford a -10 on attack, and if my enemy has a high enough attack to bother
			if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || ( iMyAtk - 10 >= iEnemyAC && iEnemyAtk >= iMyAC ) )
			{
				iMode = FEAT_IMPROVED_EXPERTISE;
			}
		}
		if ( iF1 && iMode == 0 ) //we don't have or didn't choose improved expertise
		{
			//check if I can afford a -5 on attack, and if my enemy has a high enough attack to bother
			if ( DoCombatKnowledgeCheck( iT, 10 ) == FALSE || ( iMyAtk - 5 >= iEnemyAC && iEnemyAtk >= iMyAC ) )
			{
				iMode = FEAT_EXPERTISE;
			}
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