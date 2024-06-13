#include "no_inc_ptypes"

//functions
int GetEnhanceFeat( object oEnt=OBJECT_SELF )
{
	int iCnt = 0;
	int iFeat = 0;
	
    if ( GetHasFeat( FEAT_EMPTY_BODY, oEnt ) && !GetHasFeatEffect( FEAT_EMPTY_BODY, oEnt ) )
    {
        SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_EMPTY_BODY );
    }
    if ( GetHasFeat( FEAT_MIGHTY_RAGE, oEnt ) )
    {
    	if ( !GetHasFeatEffect( FEAT_MIGHTY_RAGE, oEnt ) )
    	{
    		SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_MIGHTY_RAGE );
    	}
    }
    else if ( GetHasFeat( FEAT_BARBARIAN_RAGE, oEnt ) && !GetHasFeatEffect( FEAT_BARBARIAN_RAGE, oEnt ) )
    {
        SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_BARBARIAN_RAGE );
    }
    if ( GetHasFeat( FEAT_BARD_SONGS, oEnt ) && !GetHasFeatEffect( FEAT_BARD_SONGS, oEnt ) )
    {
        SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_BARD_SONGS );
    }
    if ( GetHasFeat( FEAT_CURSE_SONG, oEnt ) && !GetHasFeatEffect( FEAT_CURSE_SONG, oEnt ) )
    {
        SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_CURSE_SONG );
    }    
    if ( GetHasFeat( FEAT_DIVINE_WRATH, oEnt ) && GetAbilityModifier( ABILITY_CHARISMA, oEnt ) > 0 && !GetHasFeatEffect( FEAT_DIVINE_WRATH, oEnt ) )
    {
    	SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_DIVINE_WRATH );
    }
    if ( GetHasFeat( FEAT_DWARVEN_DEFENDER_DEFENSIVE_STANCE, oEnt ) && !GetHasFeatEffect( FEAT_DWARVEN_DEFENDER_DEFENSIVE_STANCE, oEnt ) )
    {
    	SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_DWARVEN_DEFENDER_DEFENSIVE_STANCE );
    }
    if ( GetHasFeat( FEAT_EPIC_BLINDING_SPEED, oEnt ) && !GetHasFeatEffect( FEAT_EPIC_BLINDING_SPEED, oEnt ) && 
    	!GetHasSpellEffect( SPELL_HASTE, oEnt ) && !GetHasSpellEffect( SPELL_MASS_HASTE, oEnt ) )
    {
    	SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_EPIC_BLINDING_SPEED );
    }
    if ( GetHasFeat( FEAT_SHADOW_EVADE, oEnt ) && !GetHasFeatEffect( FEAT_SHADOW_EVADE, oEnt ) )
    {
    	SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_SHADOW_EVADE );
    }
    if ( GetHasFeat( FEAT_DIVINE_MIGHT, oEnt ) && GetHasFeat( FEAT_TURN_UNDEAD, oEnt ) && !GetHasFeatEffect( FEAT_DIVINE_MIGHT, oEnt ) )
    {
    	SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_DIVINE_MIGHT );
    }
    if ( GetHasFeat( FEAT_DIVINE_SHIELD, oEnt ) && GetHasFeat( FEAT_TURN_UNDEAD, oEnt ) && !GetHasFeatEffect( FEAT_DIVINE_SHIELD, oEnt ) )
    {
    	SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_DIVINE_SHIELD );
    }
    if ( GetHasFeat( FEAT_TYMORAS_SMILE, oEnt ) && !GetHasFeatEffect( FEAT_TYMORAS_SMILE, oEnt ) )
    {
    	SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_TYMORAS_SMILE );
    }
    
    iFeat = GetLocalInt( oEnt, "#FEAT_" + IntToString( Random( iCnt ) + 1 ) );
    while ( iCnt )
    {
    	DeleteLocalInt( oEnt, "#FEAT_" + IntToString( iCnt-- ) );
    }
    return iFeat;
}

int GetGroupEnhanceFeat( object oEnt=OBJECT_SELF )
{
	int iCnt = 0;
	int iFeat = 0;

    if ( GetHasFeat( FEAT_BARD_SONGS, oEnt ) && !GetHasFeatEffect( FEAT_BARD_SONGS, oEnt ) )
    {
        SetLocalInt( oEnt, "#FEAT_" + IntToString( ++iCnt ), FEAT_BARD_SONGS );
    }
    
    iFeat = GetLocalInt( oEnt, "#FEAT_" + IntToString( Random( iCnt ) + 1 ) );
    while ( iCnt )
    {
    	DeleteLocalInt( oEnt, "#FEAT_" + IntToString( iCnt-- ) );
    }
    return iFeat;
}

float GetGroupEnhanceFeatRadius( int iFeat )
{
    if ( iFeat == FEAT_BARD_SONGS )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    return 0.0;
}