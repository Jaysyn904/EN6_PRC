#include "no_inc_ptypes"

//functions
int GetBestMagicDefenseSelf( object oEnt=OBJECT_SELF )
{
    int iR;

    if (!GetHasSpellEffect( SPELL_LESSER_SPELL_MANTLE, oEnt ) &&
        !GetHasSpellEffect( SPELL_SPELL_MANTLE, oEnt ) &&
        !GetHasSpellEffect( SPELL_GREATER_SPELL_MANTLE, oEnt ) )
    {
        iR = Random( 3 ) + 1;
        if ( GetHasSpell( SPELL_LESSER_SPELL_MANTLE, oEnt ) && iR == 1 )
        {
            return SPELL_LESSER_SPELL_MANTLE;
        }
        if ( GetHasSpell( SPELL_SPELL_MANTLE, oEnt ) && iR == 2 )
        {
            return SPELL_SPELL_MANTLE;
        }
        if ( GetHasSpell( SPELL_GREATER_SPELL_MANTLE, oEnt ) && iR == 3 )
        {
            return SPELL_GREATER_SPELL_MANTLE;
        }
    }
    // Don't have mantles active or available
    // No reliable defense against high level spells available
    // Do the best we can with other spells
    // resistance from spells
    if ( !GetHasSpellEffect( SPELL_SPELL_RESISTANCE, oEnt ) )
    {
        if ( GetHasSpell( SPELL_SPELL_RESISTANCE, oEnt ) )
        {
            return SPELL_SPELL_RESISTANCE;
        }
    }
    // protection from spells
    if ( !GetHasSpellEffect( SPELL_PROTECTION_FROM_SPELLS, oEnt ) )
    {
        if ( GetHasSpell( SPELL_PROTECTION_FROM_SPELLS, oEnt ) )
        {
            return SPELL_PROTECTION_FROM_SPELLS;
        }
    }
    // Shadow Shield/Death Ward for negation of death effects
    if ( !GetHasSpellEffect( SPELL_SHADOW_SHIELD, oEnt ) &&
        !GetHasSpellEffect( SPELL_DEATH_WARD, oEnt ) )
    {
        if ( GetHasSpell( SPELL_SHADOW_SHIELD, oEnt ) )
        {
            return SPELL_SHADOW_SHIELD;
        }
        if ( GetHasSpell( SPELL_DEATH_WARD, oEnt ) )
        {
            return SPELL_DEATH_WARD;
        }
    }
    // Next go for elemental protection
    if (!GetHasSpellEffect( SPELL_ENDURE_ELEMENTS, oEnt ) &&
        !GetHasSpellEffect( SPELL_RESIST_ELEMENTS, oEnt ) &&
        !GetHasSpellEffect( SPELL_PROTECTION_FROM_ELEMENTS, oEnt ) &&
        !GetHasSpellEffect( SPELL_ENERGY_BUFFER, oEnt ) )
    {
        iR = Random( 4 ) + 1;
        if ( GetHasSpell( SPELL_ENDURE_ELEMENTS, oEnt ) && iR == 1 )
        {
            return SPELL_ENDURE_ELEMENTS;
        }
        if ( GetHasSpell( SPELL_RESIST_ELEMENTS, oEnt ) && iR == 2 )
        {
            return SPELL_RESIST_ELEMENTS;
        }
        if ( GetHasSpell( SPELL_PROTECTION_FROM_ELEMENTS, oEnt ) && iR == 3 )
        {
            return SPELL_PROTECTION_FROM_ELEMENTS;
        }
        if ( GetHasSpell( SPELL_ENERGY_BUFFER, oEnt ) && iR == 4 )
        {
            return SPELL_ENERGY_BUFFER;
        }
    }
    // Next go for elemental shield
    if ( !GetHasSpellEffect( SPELL_ELEMENTAL_SHIELD, oEnt ) )
    {
        if ( GetHasSpell( SPELL_ELEMENTAL_SHIELD, oEnt ) )
        {
            return SPELL_ELEMENTAL_SHIELD;
        }
    }
    // Next try any other defenses
    if (!GetHasSpellEffect( SPELL_LESSER_MIND_BLANK, oEnt ) &&
        !GetHasSpellEffect( SPELL_MIND_BLANK, oEnt ) )
    {
        // ramp up mind blanks
        // LATER: add check for allies, use mind blank appropriately
        if ( GetHasSpell( SPELL_LESSER_MIND_BLANK, oEnt ) )
        {
            return SPELL_LESSER_MIND_BLANK;
        }
        /* used in group stuff
        if ( GetHasSpell( SPELL_MIND_BLANK, oEnt ) )
        {
            return SPELL_MIND_BLANK;
        }
        */
    }
    // globes, biggest first
    if ( !GetHasSpellEffect( SPELL_GLOBE_OF_INVULNERABILITY, oEnt ) )
    {
        if ( GetHasSpell( SPELL_GLOBE_OF_INVULNERABILITY, oEnt ) )
        {
            return SPELL_GLOBE_OF_INVULNERABILITY;
        }
    }
    if ( !GetHasSpellEffect( SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oEnt ) )
    {
        if ( GetHasSpell( SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oEnt ) )
        {
            return SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
        }
    }
    // scraping the bottom of the barrel now
    if (!GetHasSpellEffect( SPELL_GLOBE_OF_INVULNERABILITY, oEnt ) &&
        !GetHasSpellEffect( SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oEnt ) &&
        !GetHasSpellEffect( SPELL_ETHEREAL_VISAGE, oEnt ) )
    {
        if ( GetHasSpell( SPELL_ETHEREAL_VISAGE, oEnt ) )
        {
            return SPELL_ETHEREAL_VISAGE;
        }
        if ( !GetHasSpellEffect( SPELL_GHOSTLY_VISAGE, oEnt ) && GetHasSpell( SPELL_GHOSTLY_VISAGE, oEnt ) )
        {
            return SPELL_GHOSTLY_VISAGE;
        }
    }
    return FALSE;
}

int GetBestMagicDefenseSingle( object oEnt=OBJECT_SELF, object oC=OBJECT_SELF )
{
    int iR;

    if ( !GetHasSpellEffect( SPELL_SPELL_RESISTANCE, oEnt ) )
    {
        if ( GetHasSpell( SPELL_SPELL_RESISTANCE, oC ) )
        {
            return SPELL_SPELL_RESISTANCE;
        }
    }
    // Shadow Shield/Death Ward for negation of death effects
    if ( !GetHasSpellEffect( SPELL_SHADOW_SHIELD, oEnt ) &&
        !GetHasSpellEffect( SPELL_DEATH_WARD, oEnt ) )
    {
        /*
        if ( GetHasSpell( SPELL_SHADOW_SHIELD, oC ) )
        {
            return SPELL_SHADOW_SHIELD;
        }
        */
        if ( GetHasSpell( SPELL_DEATH_WARD, oC ) )
        {
            return SPELL_DEATH_WARD;
        }
    }
    // Next go for elemental protection
    if (!GetHasSpellEffect( SPELL_ENDURE_ELEMENTS, oEnt ) &&
        !GetHasSpellEffect( SPELL_RESIST_ELEMENTS, oEnt ) &&
        !GetHasSpellEffect( SPELL_PROTECTION_FROM_ELEMENTS, oEnt ) &&
        !GetHasSpellEffect( SPELL_ENERGY_BUFFER, oEnt ) )
    {
        iR = 3;
        if ( oEnt == oC )
        {
            iR = 4;
        }
        iR = Random( iR ) + 1;
        if ( GetHasSpell( SPELL_ENDURE_ELEMENTS, oC ) && iR == 1 )
        {
            return SPELL_ENDURE_ELEMENTS;
        }
        if ( GetHasSpell( SPELL_RESIST_ELEMENTS, oC ) && iR == 2 )
        {
            return SPELL_RESIST_ELEMENTS;
        }
        if ( GetHasSpell( SPELL_PROTECTION_FROM_ELEMENTS, oC ) && iR == 3 )
        {
            return SPELL_PROTECTION_FROM_ELEMENTS;
        }
        if ( GetHasSpell( SPELL_ENERGY_BUFFER, oC ) && iR == 4 )
        {
            return SPELL_ENERGY_BUFFER;
        }
    }
    if (!GetHasSpellEffect( SPELL_LESSER_MIND_BLANK, oEnt ) &&
        !GetHasSpellEffect( SPELL_MIND_BLANK, oEnt ) )
    {
        if ( GetHasSpell( SPELL_LESSER_MIND_BLANK, oC ) )
        {
            return SPELL_LESSER_MIND_BLANK;
        }
    }
    return FALSE;
}

int GetBestPhysDefenseSelf( object oEnt=OBJECT_SELF )
{
    //function not finished
    //Epic warding and epic mage armour do not currently work for non PCs, GetCasterLevel() reports 0 for them
    if (//!GetHasSpellEffect( SPELL_EPIC_WARDING, oEnt ) &&
    	!GetHasSpellEffect( SPELL_STONESKIN, oEnt ) &&
        !GetHasSpellEffect( SPELL_GREATER_STONESKIN, oEnt ) &&
        !GetHasSpellEffect( SPELL_PREMONITION, oEnt ) )
    {
    	if ( GetHasSpell( SPELL_EPIC_WARDING, oEnt ) )
    	{
    		return SPELL_EPIC_WARDING;
    	}
        if ( GetHasSpell( SPELL_GREATER_STONESKIN, oEnt ) )
        {
            return SPELL_GREATER_STONESKIN;
        }
        if ( GetHasSpell( SPELL_PREMONITION, oEnt ) )
        {
            return SPELL_PREMONITION;
        }
        if ( GetHasSpell( SPELL_STONESKIN, oEnt ) )
        {
            return SPELL_STONESKIN;
        }
    }
    return FALSE;
}

int GetBestPhysDefenseSingle( object oEnt=OBJECT_SELF, object oC=OBJECT_SELF )
{
    //function not finished
    if (!GetHasSpellEffect( SPELL_STONESKIN, oEnt ) &&
        !GetHasSpellEffect( SPELL_GREATER_STONESKIN, oEnt ) &&
        !GetHasSpellEffect( SPELL_PREMONITION, oEnt ) )
    {
        if ( GetHasSpell( SPELL_STONESKIN, oC ) )
        {
            return SPELL_STONESKIN;
        }
    }
    return FALSE;
}

int GetBestGenericProtection( object oEnt=OBJECT_SELF )
{
    //TESTING FOR GATE PROTECTIONS
    //Currently not in use because of casting bugs
    if ( !GetHasSpellEffect( SPELL_HOLY_AURA, oEnt ) &&
        !GetHasSpellEffect( SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oEnt ) &&
        !GetHasSpellEffect( SPELL_PROTECTION_FROM_EVIL, oEnt ) )
    {
        if ( GetHasSpell( SPELL_HOLY_AURA, oEnt ) )
        {
            return SPELL_HOLY_AURA;
        }
        if ( GetHasSpell( SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oEnt ) )
        {
            return SPELL_MAGIC_CIRCLE_AGAINST_EVIL;
        }
        if ( GetHasSpell( SPELL_PROTECTION_FROM_EVIL, oEnt ) )
        {
            return SPELL_PROTECTION_FROM_EVIL;
        }
    }
    return FALSE;
}

struct sSpellDefStatus EvaluateSpellDefenses( object oTarget=OBJECT_SELF )
{
    struct sSpellDefStatus sDef;

    if ( GetHasSpellEffect( SPELL_GREATER_SPELL_MANTLE, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 9;
        sDef.iMantle = sDef.iMantle + 9;
    }
    if ( GetHasSpellEffect( SPELL_SPELL_MANTLE, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 7;
        sDef.iMantle = sDef.iMantle + 7;
    }
    if ( GetHasSpellEffect( SPELL_LESSER_SPELL_MANTLE, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 5;
        sDef.iMantle = sDef.iMantle + 5;
    }
    if ( GetHasSpellEffect( SPELL_ENERGY_BUFFER, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 5;
        sDef.iElem = sDef.iElem + 5;
    }
    if ( GetHasSpellEffect( SPELL_PROTECTION_FROM_ELEMENTS, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 3;
        sDef.iElem = sDef.iElem + 3;
    }
    if ( GetHasSpellEffect( SPELL_RESIST_ELEMENTS, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 2;
        sDef.iElem = sDef.iElem + 2;
    }
    if ( GetHasSpellEffect( SPELL_ENDURE_ELEMENTS, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 1;
        sDef.iElem = sDef.iElem + 1;
    }
    if ( GetHasSpellEffect( SPELL_SHADOW_SHIELD, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 7;
        sDef.iDeath = sDef.iDeath + 7;
    }
    if ( GetHasSpellEffect( SPELL_MIND_BLANK, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 8;
        sDef.iMind = sDef.iMind + 8;
    }
    if ( GetHasSpellEffect( SPELL_LESSER_MIND_BLANK, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 5;
        sDef.iMind = sDef.iMind + 5;
    }
    if ( GetHasSpellEffect( SPELL_CLARITY, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 3;
        sDef.iMind = sDef.iMind + 3;
    }
    if ( GetHasSpellEffect( SPELL_GHOSTLY_VISAGE, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 2;
        sDef.iMind = sDef.iBlocker + 2;
    }
    if ( GetHasSpellEffect( SPELL_ETHEREAL_VISAGE, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 6;
        sDef.iMind = sDef.iBlocker + 6;
    }
    if ( GetHasSpellEffect( SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 4;
        sDef.iMind = sDef.iBlocker + 4;
    }
    if ( GetHasSpellEffect( SPELL_GLOBE_OF_INVULNERABILITY, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 6;
        sDef.iMind = sDef.iBlocker + 6;
    }

    return sDef;
}

struct sPhysDefStatus EvaluatePhysicalDefenses( object oTarget=OBJECT_SELF )
{
    //function not finished
    struct sPhysDefStatus sDef;

    if ( GetHasSpellEffect( SPELL_STONESKIN, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 4;
        sDef.iDamred = sDef.iDamred + 4;
    }
    if ( GetHasSpellEffect( SPELL_GREATER_STONESKIN, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 6;
        sDef.iDamred = sDef.iDamred + 6;
    }
    if ( GetHasSpellEffect( SPELL_PREMONITION, oTarget ) )
    {
        sDef.iTotal = sDef.iTotal + 8;
        sDef.iDamred = sDef.iDamred + 8;
    }

    return sDef;
}

int GetBestHeal( object oEnt=OBJECT_SELF, int iMin=10 )
{
    int iDamage = 0;

    if ( GetIsObjectValid( oEnt ) )
    {
        iDamage = GetMaxHitPoints( oEnt ) - GetCurrentHitPoints( oEnt );
        if ( iDamage < iMin )
        {
            return 0;
        }
        if ( iDamage >= 60 && GetHasSpell( SPELL_HEAL ) )
        {
            return SPELL_HEAL;
        }
        if ( iDamage >= 40 )
        {
            if ( GetHasSpell( SPELL_CURE_CRITICAL_WOUNDS ) )
            {
                return SPELL_CURE_CRITICAL_WOUNDS;
            }
            if ( GetHasFeat( FEAT_LAY_ON_HANDS ) )
            {
                return FEAT_LAY_ON_HANDS;
            }
        }
        if ( iDamage >= 30 && GetHasSpell( SPELL_CURE_SERIOUS_WOUNDS ) )
        {
            return SPELL_CURE_SERIOUS_WOUNDS;
        }
        if ( iDamage >= 20 && GetHasSpell( SPELL_CURE_MODERATE_WOUNDS ) )
        {
            return SPELL_CURE_MODERATE_WOUNDS;
        }
        if ( iDamage >= 10 && GetHasSpell( SPELL_CURE_LIGHT_WOUNDS ) )
        {
            return SPELL_CURE_LIGHT_WOUNDS;
        }
    }
    return 0;
}

int GetGroupHealSpell( int iMinLvl=0, object oCaster=OBJECT_SELF )
{
    int iHeal = 0;

    if ( !iHeal || iMinLvl >= 5 )
    {
        if ( GetHasSpell( SPELL_HEALING_CIRCLE, oCaster ) )
        {
            return SPELL_HEALING_CIRCLE;
        }
    }
    if ( !iHeal || iMinLvl >= 8 )
    {
        if ( GetHasSpell( SPELL_MASS_HEAL, oCaster ) )
        {
            return SPELL_MASS_HEAL;
        }
    }
    return FALSE;
}

int GetGroupHealSpellAmount( int iH=0, object oCaster=OBJECT_SELF )
{
    int iHeal = 0;

    if ( iH == SPELL_HEALING_CIRCLE )
    {
        iHeal = 20;
    }
    else if ( iH == SPELL_MASS_HEAL )
    {
        iHeal = 60;
    }
    return iHeal;
}

float GetGroupHealSpellRadius( int iH=0 )
{
    float fRad = 0.0;

    if ( iH == SPELL_HEALING_CIRCLE )
    {
        fRad = RADIUS_SIZE_MEDIUM;
    }
    else if ( iH == SPELL_MASS_HEAL )
    {
        fRad = RADIUS_SIZE_LARGE;
    }
    return fRad;
}

int GetBestRaise( int iCombat=FALSE )
{
    //full resurrection is preference in combat situation
    if ( iCombat )
    {
        if ( GetHasSpell( SPELL_RESURRECTION ) )
        {
            return SPELL_RESURRECTION;
        }
        if ( GetHasSpell( SPELL_RAISE_DEAD ) )
        {
            return SPELL_RAISE_DEAD;
        }
    }
    else
    {
        if ( GetHasSpell( SPELL_RAISE_DEAD ) )
        {
            return SPELL_RAISE_DEAD;
        }
        if ( GetHasSpell( SPELL_RESURRECTION ) )
        {
            return SPELL_RESURRECTION;
        }
    }
    return 0;
}

int GetHasHealingAbility( object oCaster=OBJECT_SELF )
{
    int iHeal = 0;

    if ( GetHasSpell( SPELL_CURE_MINOR_WOUNDS, oCaster ) )
    {
        iHeal += 1;
    }
    if ( GetHasSpell( SPELL_CURE_LIGHT_WOUNDS, oCaster ) )
    {
        iHeal += 2;
    }
    if ( GetHasSpell( SPELL_CURE_MODERATE_WOUNDS, oCaster ) )
    {
        iHeal += 4;
    }
    if ( GetHasSpell( SPELL_CURE_SERIOUS_WOUNDS, oCaster ) )
    {
        iHeal += 8;
    }
    if ( GetHasFeat( FEAT_LAY_ON_HANDS, oCaster ) )
    {
        iHeal += 16;
    }
    if ( GetHasSpell( SPELL_CURE_CRITICAL_WOUNDS, oCaster ) )
    {
        iHeal += 32;
    }
    if ( GetHasSpell( SPELL_HEAL, oCaster ) )
    {
        iHeal += 64;
    }
    return iHeal;
}

int GetHasRaisingAbility( object oCaster=OBJECT_SELF )
{
    int iHeal = 0;

    if ( GetHasSpell( SPELL_RAISE_DEAD, oCaster ) )
    {
        iHeal += 1;
    }
    if ( GetHasSpell( SPELL_RESURRECTION, oCaster ) )
    {
        iHeal += 2;
    }
    return iHeal;
}

int GetHasHelpingAbility( object oCaster=OBJECT_SELF )
{
    int iHelp = 0;

    if ( !GetIsObjectValid( oCaster ) )
    {
        return 0;
    }

    if ( GetHasSpell( SPELL_REMOVE_FEAR, oCaster ) )
    {
        iHelp += 1;
    }
    if ( GetHasSpell( SPELL_LESSER_RESTORATION, oCaster ) )
    {
        iHelp += 2;
    }
    if ( GetHasSpell( SPELL_REMOVE_PARALYSIS, oCaster ) )
    {
        iHelp += 4;
    }
    if ( GetHasSpell( SPELL_CLARITY, oCaster ) )
    {
        iHelp += 8;
    }
    if ( GetHasSpell( SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oCaster ) )
    {
        iHelp += 16;
    }
    if ( GetHasSpell( SPELL_REMOVE_CURSE, oCaster ) )
    {
        iHelp += 32;
    }
    if ( GetHasSpell( SPELL_REMOVE_DISEASE, oCaster ) )
    {
        iHelp += 64;
    }
    if ( GetHasSpell( SPELL_FREEDOM_OF_MOVEMENT, oCaster ) )
    {
        iHelp += 128;
    }
    if ( GetHasSpell( SPELL_NEUTRALIZE_POISON, oCaster ) )
    {
        iHelp += 256;
    }
    if ( GetHasSpell( SPELL_LESSER_MIND_BLANK, oCaster ) )
    {
        iHelp += 512;
    }
    if ( GetHasSpell( SPELL_RESTORATION, oCaster ) )
    {
        iHelp += 1024;
    }
    if ( GetHasSpell( SPELL_GREATER_RESTORATION, oCaster ) )
    {
        iHelp += 2048;
    }
    return iHelp;
}

int GetBestHelp( object oEnt, object oCaster=OBJECT_SELF )
{
    int iEff = GetEffectsOnObject( oEnt );

    //PrintString( "GBH: " + GetName( oCaster ) + " -> " + GetName( oEnt ) + "(" + IntToString( iEff ) + ")" );
    //check effects for spell selection in priority
    if ( iEff & NO_EFFECT_PARALYZE ) //PARALYZE
    {
        if ( GetHasSpell( SPELL_REMOVE_PARALYSIS ) )
        {
            return SPELL_REMOVE_PARALYSIS;
        }
        if ( GetHasSpell( SPELL_FREEDOM_OF_MOVEMENT ) )
        {
            return SPELL_FREEDOM_OF_MOVEMENT;
        }
    }
    if ( iEff & NO_EFFECT_PETRIFY ) //PETRIFY
    {
    	if ( GetHasSpell( SPELL_STONE_TO_FLESH ) )
    	{
    		return SPELL_STONE_TO_FLESH;
    	}
    }
    if ( iEff & NO_EFFECT_STUNNED ) //STUNNED
    {
        if ( GetHasSpell( SPELL_CLARITY ) )
        {
            return SPELL_CLARITY;
        }
    }
    if ( iEff & NO_EFFECT_SLEEP ) //SLEEP
    {
        if ( GetHasSpell( SPELL_CLARITY ) )
        {
            return SPELL_CLARITY;
        }
    }
    if ( iEff & NO_EFFECT_CHARMED ) //CHARMED
    {
        if ( GetHasSpell( SPELL_CLARITY ) )
        {
            return SPELL_CLARITY;
        }
    }
    if ( iEff & NO_EFFECT_CONFUSED ) //CONFUSED
    {
        if ( GetHasSpell( SPELL_CLARITY ) )
        {
            return SPELL_CLARITY;
        }
    }
    if ( iEff & NO_EFFECT_FRIGHTENED ) //FRIGHTENED
    {
        if ( GetHasSpell( SPELL_REMOVE_FEAR ) )
        {
            return SPELL_REMOVE_FEAR;
        }
    }
    if ( iEff & NO_EFFECT_NEGATIVELEVEL ) //NEGATIVELEVEL
    {
        if ( GetHasSpell( SPELL_RESTORATION ) )
        {
            return SPELL_RESTORATION;
        }
        if ( GetHasSpell( SPELL_GREATER_RESTORATION ) )
        {
            return SPELL_GREATER_RESTORATION;
        }
    }
    if ( iEff & NO_EFFECT_BLINDNESS ) //BLINDNESS
    {
        if ( GetHasSpell( SPELL_REMOVE_BLINDNESS_AND_DEAFNESS ) )
        {
            return SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
        }
        if ( GetHasSpell( SPELL_RESTORATION ) )
        {
            return SPELL_RESTORATION;
        }
    }
    if ( iEff & NO_EFFECT_DEAF ) //DEAFNESS
    {
        if ( GetHasSpell( SPELL_REMOVE_BLINDNESS_AND_DEAFNESS ) )
        {
            return SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
        }
    }
    if ( iEff & NO_EFFECT_POISON ) //POISON
    {
        if ( GetHasSpell( SPELL_NEUTRALIZE_POISON ) )
        {
            return SPELL_NEUTRALIZE_POISON;
        }
    }
    if ( iEff & NO_EFFECT_CURSE ) //CURSE
    {
        if ( GetHasSpell( SPELL_REMOVE_CURSE ) )
        {
            return SPELL_REMOVE_CURSE;
        }
    }
    if ( iEff & NO_EFFECT_DISEASE ) //DISEASE
    {
        if ( GetHasSpell( SPELL_REMOVE_DISEASE ) )
        {
            return SPELL_REMOVE_DISEASE;
        }
    }
    if ( iEff & NO_EFFECT_GENERIC ) //ABILITY,AC,ATTACK,DAMAGE,SR,SAVE
    {
        if ( GetHasSpell( SPELL_LESSER_RESTORATION ) )
        {
            return SPELL_LESSER_RESTORATION;
        }
        if ( GetHasSpell( SPELL_RESTORATION ) )
        {
            return SPELL_RESTORATION;
        }
    }
    return 0;
}

int GetAreaSpell( vector vS, int iDisc=FALSE, int iMinLvl=0, float fR=40.0, object oCaster=OBJECT_SELF )
{
    int iCnt = 0;
    int iSpell;
    //float fS = 8.5 + 1.0;
    //float fM = 20.0 + 1.0;
    //float fL = 40.0 + 1.0;
    //testing some new ranges
    float fS = 20.0;
    float fM = 35.0;
    float fL = 50.0;
    int iM = GetAbilityModifier( ABILITY_INTELLIGENCE, oCaster );
    iM = iM < GetAbilityModifier( ABILITY_WISDOM, oCaster ) ? GetAbilityModifier( ABILITY_WISDOM, oCaster ) : iM;
    iM = iM < GetAbilityModifier( ABILITY_CHARISMA, oCaster ) ? GetAbilityModifier( ABILITY_CHARISMA, oCaster ) : iM;
    int iDC = 10 + 9 + iM;
    int iF = FloatToInt( vS.x );
    int iR = FloatToInt( vS.y );
    int iW = FloatToInt( vS.z );

	//EPIC SPELLS
	
	if ( !iCnt )
	{
		if ( !iDisc && GetHasSpell( SPELL_EPIC_HELLBALL, oCaster ) && fR < fM )
		{
			SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EPIC_HELLBALL );
		}
	}
    //9TH LEVEL CLR
    //if ( !iCnt || iMinLvl <=9 )
    if ( !iCnt )
    {
        if ( !iDisc && GetHasSpell( SPELL_IMPLOSION, oCaster ) && fR < fS && iF < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_IMPLOSION );
        }
        if ( !iDisc && GetHasSpell( SPELL_STORM_OF_VENGEANCE, oCaster ) && fR < fS && iR < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_STORM_OF_VENGEANCE );
        }
        //9TH LEVEL DRD
        //9TH LEVEL SOR/WIZ
        if ( !iDisc && GetHasSpell( SPELL_METEOR_SWARM, oCaster ) && fR < fS ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_METEOR_SWARM );
        }
        if ( !iDisc && GetHasSpell( SPELL_POWER_WORD_KILL, oCaster ) && fR < fS )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_POWER_WORD_KILL );
        }
        if ( GetHasSpell( SPELL_WAIL_OF_THE_BANSHEE, oCaster ) && fR < fS && iF < iDC)
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_WAIL_OF_THE_BANSHEE );
        }
        if ( GetHasSpell( SPELL_WEIRD, oCaster ) && fR < fS && iW < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_WEIRD );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <=8 )
    if ( !iCnt || iMinLvl < NO_LVL8_MIN_LVL )
    {
    	//8TH LEVEL CLR
    	if ( !iDisc && GetHasSpell( SPELL_EARTHQUAKE, oCaster ) && fR < fS ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EARTHQUAKE );
        }
        if ( !iDisc && GetHasSpell( SPELL_FIRE_STORM, oCaster ) && fR < fS ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FIRE_STORM );
        }
        if ( !iDisc && GetHasSpell( SPELL_SUNBEAM, oCaster ) && fR < fM ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUNBEAM );
        }
        //8TH LEVEL DRD
        if ( !iDisc && GetHasSpell( SPELL_BOMBARDMENT, oCaster ) && fR < fL ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BOMBARDMENT );
        }
        if ( !iDisc && GetHasSpell( SPELL_SUNBURST, oCaster ) && fR < fM ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUNBURST );
        }
        //8TH LEVEL SOR/WIZ
        if ( !iDisc && GetHasSpell( SPELL_HORRID_WILTING, oCaster ) && fR < fM ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HORRID_WILTING );
        }
        if ( !iDisc && GetHasSpell( SPELL_INCENDIARY_CLOUD, oCaster ) && fR < fL ) //no save check for half-damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INCENDIARY_CLOUD );
        }
        if ( GetHasSpell( SPELL_MASS_BLINDNESS_AND_DEAFNESS, oCaster ) && fR < fM && iF < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MASS_BLINDNESS_AND_DEAFNESS );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <=7 )
    if ( !iCnt || iMinLvl < NO_LVL7_MIN_LVL )
    {
        //7TH LEVEL CLR
        if ( GetHasSpell( SPELL_WORD_OF_FAITH, oCaster ) && fR < fM ) //spell is still useful for blindness, no save
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_WORD_OF_FAITH );
        }
        //7TH LEVEL DRD
        if ( !iDisc && GetHasSpell( SPELL_CREEPING_DOOM, oCaster ) && fR < fM ) //no save against this spell?
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CREEPING_DOOM );
        }
        //7TH LEVEL SOR/WIZ
        if ( !iDisc && GetHasSpell( SPELL_DELAYED_BLAST_FIREBALL, oCaster ) && fR < fM ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DELAYED_BLAST_FIREBALL );
        }
        if ( !iDisc && GetHasSpell( SPELL_GREAT_THUNDERCLAP, oCaster ) && fR < fM && ( iF < iDC || iR < iDC || iW < iDC ) ) //FIX: check this range
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GREAT_THUNDERCLAP );
        }
        if ( GetHasSpell( SPELL_PRISMATIC_SPRAY, oCaster ) && fR < fS ) //random and various saves, don't check
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PRISMATIC_SPRAY );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <=6 )
    if ( !iCnt || iMinLvl < NO_LVL6_MIN_LVL )
    {
        //6TH LEVEL CLR
        if ( !iDisc && GetHasSpell( SPELL_BLADE_BARRIER, oCaster ) && fR < fM ) //no save check, half damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BLADE_BARRIER );
        }
        //6TH LEVEL DRD
        if ( GetHasSpell( SPELL_STONEHOLD, oCaster ) && fR < fM )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_STONEHOLD );
        }
        //6TH LEVEL SOR/WIZ
        if ( !iDisc && GetHasSpell( SPELL_ACID_FOG, oCaster ) && fR < fL ) //no save vs the damage
        {
            //NOTE: SPELL_ACID_FOG == 0
            //SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ACID_FOG );
            //using temporary value for acid fog inside this function
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), -69 );

        }
        if ( GetHasSpell( SPELL_CHAIN_LIGHTNING, oCaster ) && fR < fL ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CHAIN_LIGHTNING );
        }
        if ( !iDisc && GetHasSpell( SPELL_CIRCLE_OF_DEATH, oCaster ) && fR < fM && iF < iDC &&
        	( !DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) || iMinLvl < 10 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CIRCLE_OF_DEATH );
        }
        if ( GetHasSpell( SPELL_ISAACS_GREATER_MISSILE_STORM, oCaster ) && fR < fL ) //no save
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ISAACS_GREATER_MISSILE_STORM );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <=5 )
    if ( !iCnt || iMinLvl < NO_LVL5_MIN_LVL )
    {
        //5TH LEVEL CLR
        if ( !iDisc && GetHasSpell( SPELL_FLAME_STRIKE, oCaster ) && fR < fM ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FLAME_STRIKE );
        }
        //5TH LEVEL DRD
        if ( !iDisc && GetHasSpell( SPELL_ICE_STORM, oCaster ) && fR < fL ) //no save
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ICE_STORM );
        }
        if ( !iDisc && GetHasSpell( SPELL_WALL_OF_FIRE, oCaster ) && fR < fM ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_WALL_OF_FIRE );
        }
        //5TH LEVEL SOR/WIZ
        if ( !iDisc && GetHasSpell( SPELL_CLOUDKILL, oCaster ) && fR < fL ) //saves vs death only, try it regardless
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CLOUDKILL );
        }
        if ( GetHasSpell( SPELL_CONE_OF_COLD, oCaster ) && fR < fS ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CONE_OF_COLD );
        }
        if ( GetHasSpell( SPELL_FIREBRAND, oCaster ) && fR < fM ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FIREBRAND );
        }
        if ( GetHasSpell( SPELL_MIND_FOG, oCaster ) && fR < fM && iW < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MIND_FOG );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <4 )
    if ( !iCnt || iMinLvl <= NO_LVL4_MIN_LVL )
    {
        //4TH LEVEL CLR
        if ( GetHasSpell( SPELL_HAMMER_OF_THE_GODS, oCaster ) && fR < fM ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HAMMER_OF_THE_GODS );
        }
        //4TH LEVEL DRD
        //4TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_CONFUSION, oCaster ) && fR < fM && iW < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CONFUSION );
        }
        if ( GetHasSpell( SPELL_EVARDS_BLACK_TENTACLES, oCaster ) && fR < fM ) //don't bother checking save
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EVARDS_BLACK_TENTACLES );
        }
        if ( GetHasSpell( SPELL_FEAR, oCaster ) && fR < fM && iW < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FEAR );
        }
        if ( GetHasSpell( SPELL_ISAACS_LESSER_MISSILE_STORM, oCaster ) && fR < fL ) //no save
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ISAACS_LESSER_MISSILE_STORM );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <=3 )
    if ( !iCnt || iMinLvl < NO_LVL3_MIN_LVL )
    {
        //3RD LEVEL CLR
        //3RD LEVEL DRD
        if ( GetHasSpell( SPELL_CALL_LIGHTNING, oCaster ) && fR < fL ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CALL_LIGHTNING );
        }
        if ( GetHasSpell( SPELL_SPIKE_GROWTH, oCaster ) && fR < fL ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SPIKE_GROWTH );
        }
        //3RD LEVEL SOR/WIZ
        if ( !iDisc && GetHasSpell( SPELL_FIREBALL, oCaster ) && fR < fL ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FIREBALL );
        }
        if ( !iDisc && GetHasSpell( SPELL_GUST_OF_WIND, oCaster ) && fR < fM && iF < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GUST_OF_WIND );
        }
        if ( !iDisc && GetHasSpell( SPELL_LIGHTNING_BOLT, oCaster ) && fR < fM ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_LIGHTNING_BOLT );
        }
        if ( !iDisc && GetHasSpell( SPELL_MESTILS_ACID_BREATH, oCaster ) && fR < fS )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MESTILS_ACID_BREATH );
        }
        if ( !iDisc && GetHasSpell( SPELL_NEGATIVE_ENERGY_BURST, oCaster ) && fR < fM ) //no save check, half damage potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_NEGATIVE_ENERGY_BURST );
        }
        if ( GetHasSpell( SPELL_SCINTILLATING_SPHERE, oCaster ) && fR < fM )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SCINTILLATING_SPHERE );
        }
        if ( GetHasSpell( SPELL_SLOW, oCaster ) && fR < fS && iW < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SLOW );
        }
        if ( !iDisc && GetHasSpell( SPELL_STINKING_CLOUD, oCaster ) && fR < fM && iF < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_STINKING_CLOUD );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <=2 )
    if ( !iCnt || iMinLvl < NO_LVL2_MIN_LVL )
    {
        //2ND LEVEL CLR
        if ( GetHasSpell( SPELL_DARKNESS, oCaster ) && fR < fL && //no save check
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && !( GetHasSpellEffect( SPELL_TRUE_SEEING, oCaster ) || GetHasSpellEffect( SPELL_DARKVISION, oCaster ) ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DARKNESS );
        }
        if ( !iDisc && GetHasSpell( SPELL_SOUND_BURST, oCaster ) && fR < fL ) //no save check
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SOUND_BURST );
        }
        //2ND LEVEL DRD
        //2ND LEVEL SOR/WIZ
        if ( !iDisc && GetHasSpell( SPELL_CLOUD_OF_BEWILDERMENT, oCaster ) && fR < fS )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CLOUD_OF_BEWILDERMENT );
        }
        if ( !iDisc && GetHasSpell( SPELL_GEDLEES_ELECTRIC_LOOP, oCaster ) && fR < fS ) //no save check
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GEDLEES_ELECTRIC_LOOP );
        }	
        if ( !iDisc && GetHasSpell( SPELL_WEB, oCaster ) && fR < fM ) //no save check, slow effect applies regardless
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_WEB );
        }
        if ( !iDisc && GetHasSpell( SPELL_BALAGARNSIRONHORN, oCaster ) && fR < fS ) //no save
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BALAGARNSIRONHORN );
        }
    }
    iDC--; //take DC down one level
    //if ( !iCnt || iMinLvl <=1 )
    if ( !iCnt || iMinLvl < NO_LVL1_MIN_LVL )
    {
        //1ST LEVEL CLR
        if ( GetHasSpell( SPELL_BANE, oCaster ) && fR < fL && iW < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BANE );
        }
        //1ST LEVEL DRD
        if ( GetHasSpell( SPELL_ENTANGLE, oCaster ) && fR < fL && iR < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ENTANGLE );
        }
        if ( !iDisc && GetHasSpell( SPELL_GREASE, oCaster ) && fR < fL ) //no save
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GREASE );
        }
        if ( GetHasSpell( SPELL_SLEEP, oCaster ) && fR < fM && iW < iDC && 
        	( !DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) || iMinLvl < 6 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SLEEP );
        }
        //1ST LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_BURNING_HANDS, oCaster ) && fR < fS ) //no save check, half dam potential
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BURNING_HANDS );
        }
        if ( GetHasSpell( SPELL_COLOR_SPRAY, oCaster ) && fR < fS && iW < iDC )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_COLOR_SPRAY );
        }
    }

	//SPELLABILITIES
	//if ( GetHasSpell( SPELLABILITY_DRAGON_WING_BUFFET, oCaster ) && fR < fM )
	/* Doesn't work? May need a custom script for this
	if ( GetRacialType( oCaster ) == RACIAL_TYPE_DRAGON && fR < fM )
	{
		SpeakString( "Wingbuff" );
       	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_WING_BUFFET );
    }
    */
    
    iDC--; //take DC down one level
    //still need to add DC check in here, haven't decided on it
    if ( !iCnt )
    {
    	//save DCs are pretty low, only use if we have no spells
    	//Cone spellabilities
    	if ( GetHasSpell( SPELLABILITY_CONE_ACID, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CONE_ACID );
	    }
	    if ( GetHasSpell( SPELLABILITY_CONE_COLD, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CONE_COLD );
    	}
    	if ( GetHasSpell( SPELLABILITY_CONE_DISEASE, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CONE_DISEASE );
	    }
	    if ( GetHasSpell( SPELLABILITY_CONE_FIRE, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CONE_FIRE );
    	}
    	if ( GetHasSpell( SPELLABILITY_CONE_LIGHTNING, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CONE_LIGHTNING );
	    }
	    if ( GetHasSpell( SPELLABILITY_CONE_POISON, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CONE_POISON );
    	}
    	if ( GetHasSpell( SPELLABILITY_CONE_SONIC, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CONE_SONIC );
	    }
	    //Howl spellabilities
	    if ( GetHasSpell( SPELLABILITY_HOWL_CONFUSE, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_CONFUSE );
    	}
    	if ( GetHasSpell( SPELLABILITY_HOWL_DAZE, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_DAZE );
	    }
	    if ( GetHasSpell( SPELLABILITY_HOWL_DEATH, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_DEATH );
    	}
    	if ( GetHasSpell( SPELLABILITY_HOWL_DOOM, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_DOOM );
	    }
	    if ( GetHasSpell( SPELLABILITY_HOWL_FEAR, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_FEAR );
    	}
    	if ( GetHasSpell( SPELLABILITY_HOWL_PARALYSIS, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_PARALYSIS );
	    }
	    if ( GetHasSpell( SPELLABILITY_HOWL_SONIC, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_SONIC );
    	}
    	if ( GetHasSpell( SPELLABILITY_HOWL_STUN, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HOWL_STUN );
	    }
	    //Pulse spellabilities
	    if ( GetHasSpell( SPELLABILITY_PULSE_ABILITY_DRAIN_CHARISMA, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_ABILITY_DRAIN_CHARISMA );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_ABILITY_DRAIN_CONSTITUTION, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_ABILITY_DRAIN_CONSTITUTION );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_ABILITY_DRAIN_DEXTERITY, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_ABILITY_DRAIN_DEXTERITY );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_ABILITY_DRAIN_INTELLIGENCE, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_ABILITY_DRAIN_INTELLIGENCE );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_ABILITY_DRAIN_STRENGTH, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_ABILITY_DRAIN_STRENGTH );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_ABILITY_DRAIN_WISDOM, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_ABILITY_DRAIN_WISDOM );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_COLD, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_COLD );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_DEATH, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_DEATH );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_DISEASE, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_DISEASE );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_DROWN, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_DROWN );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_FIRE, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_FIRE );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_HOLY, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_HOLY );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_LEVEL_DRAIN, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_LEVEL_DRAIN );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_LIGHTNING, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_LIGHTNING );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_NEGATIVE, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_NEGATIVE );
    	}
    	if ( GetHasSpell( SPELLABILITY_PULSE_POISON, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_POISON );
	    }
	    if ( GetHasSpell( SPELLABILITY_PULSE_SPORES, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_SPORES );
    	}
    	/*
    	if ( GetHasSpell( SPELLABILITY_PULSE_WHIRLWIND, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PULSE_WHIRLWIND );
	    }
	    */
	    //MISCELLANEOUS SPELLABILITIES
    	if ( GetHasSpell( SPELLABILITY_KRENSHAR_SCARE, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_KRENSHAR_SCARE );
	    }
	    if ( GetHasSpell( SPELLABILITY_GOLEM_BREATH_GAS, oCaster ) && fR < fS )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GOLEM_BREATH_GAS );
    	}
    	if ( GetHasSpell( SPELLABILITY_HELL_HOUND_FIREBREATH, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_HELL_HOUND_FIREBREATH );
	    }
	    if ( GetHasSpell( SPELLABILITY_BREATH_PETRIFY, oCaster ) && fR < fS )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BREATH_PETRIFY );
	    }
	    if ( GetHasSpell( SPELLABILITY_MINDBLAST, oCaster ) && fR < fS )
	    {
	    	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_MINDBLAST );
	    }
    }

    //return a random spell
    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );
    if ( iSpell == 0 )  //no spell
    {
        iSpell = -1;
    }
    else if ( iSpell == -69 )   //temp value for acid fog in this function
    {
        iSpell = 0;
    }
    //clear out the local ints
    while ( iCnt )
    {
        //PrintString( "AREACLR: " + GetName( oCaster ) + " (" + IntToString( GetLocalInt( oCaster, "#SPL_" + IntToString( iCnt ) ) ) + ")" );
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

float GetAreaSpellRadius( int iSpell )
{
    if ( IsDragonBreath( iSpell ) )
    {
    	return RADIUS_SIZE_LARGE;
    }
    if ( IsPulse( iSpell ) )
    {
    	return RADIUS_SIZE_LARGE;
    }
    if ( IsHowl( iSpell ) )
    {
    	return RADIUS_SIZE_COLOSSAL;
    }
    if ( IsCone( iSpell ) )
    {
    	return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELLABILITY_DRAGON_WING_BUFFET )
    {
    	return RADIUS_SIZE_GARGANTUAN;
    }
    if ( iSpell == SPELLABILITY_KRENSHAR_SCARE )
    {
    	return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELLABILITY_GOLEM_BREATH_GAS )
    {
    	return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELLABILITY_HELL_HOUND_FIREBREATH )
    {
    	return RADIUS_SIZE_MEDIUM;
    }
    //EPIC
    if ( iSpell == SPELL_EPIC_HELLBALL )
    {
    	return 20.0; //largest radius constant is 10.0, have to specify explicit value
    }
    //9TH LEVEL CLR
    if ( iSpell == SPELL_IMPLOSION )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELL_STORM_OF_VENGEANCE )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    //9TH LEVEL DRD
    //9TH LEVEL SOR/WIZ
    if ( iSpell == SPELL_METEOR_SWARM )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_POWER_WORD_KILL )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_WAIL_OF_THE_BANSHEE )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_WEIRD )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    //8TH LEVEL CLR
    if ( iSpell == SPELL_EARTHQUAKE )
    {
    	return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_FIRE_STORM )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_SUNBURST )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_SUNBEAM )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    //8TH LEVEL DRD
    if ( iSpell == SPELL_BOMBARDMENT )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_SUNBEAM )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    //8TH LEVEL SOR/WIZ
    if ( iSpell == SPELL_HORRID_WILTING  )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_INCENDIARY_CLOUD )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_MASS_BLINDNESS_AND_DEAFNESS )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    //7TH LEVEL CLR
    if ( iSpell == SPELL_WORD_OF_FAITH )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    //7TH LEVEL DRD
    if ( iSpell == SPELL_CREEPING_DOOM )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_FIRE_STORM )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    //7TH LEVEL SOR/WIZ
    if ( iSpell == SPELL_DELAYED_BLAST_FIREBALL )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_GREAT_THUNDERCLAP )
    {
    	return RADIUS_SIZE_GARGANTUAN;
    }
    if ( iSpell == SPELL_PRISMATIC_SPRAY )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    //6TH LEVEL CLR
    if ( iSpell == SPELL_BLADE_BARRIER )
    {
        return RADIUS_SIZE_HUGE;
    }
    //6TH LEVEL DRD
    if ( iSpell == SPELL_STONEHOLD )
    {
    	return RADIUS_SIZE_HUGE;
    }
    //6TH LEVEL SOR/WIZ
    if ( iSpell == SPELL_ACID_FOG )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_CHAIN_LIGHTNING )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_CIRCLE_OF_DEATH )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_ISAACS_GREATER_MISSILE_STORM )
    {
    	return RADIUS_SIZE_GARGANTUAN;
    }
    //5TH LEVEL CLR
    if ( iSpell == SPELL_FLAME_STRIKE )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    //5TH LEVEL DRD
    if ( iSpell == SPELL_ICE_STORM )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_WALL_OF_FIRE )
    {
        return RADIUS_SIZE_HUGE;
    }
    //5TH LEVEL SOR/WIZ
    if ( iSpell == SPELL_CLOUDKILL )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_CONE_OF_COLD )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELL_FIREBRAND )
    {
    	return RADIUS_SIZE_COLOSSAL;
    }
    //4TH LEVEL CLR
    if ( iSpell == SPELL_HAMMER_OF_THE_GODS )
    {
        return RADIUS_SIZE_HUGE;
    }
    //4TH LEVEL DRD
    if ( iSpell == SPELL_FLAME_STRIKE )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    //4TH LEVEL SOR/WIZ
    if ( iSpell == SPELL_CONFUSION )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_EVARDS_BLACK_TENTACLES )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_FEAR )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_ISAACS_LESSER_MISSILE_STORM )
    {
    	return RADIUS_SIZE_GARGANTUAN;
    }
    if ( iSpell == SPELL_ICE_STORM )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_WALL_OF_FIRE )
    {
        return RADIUS_SIZE_HUGE;
    }
    //3RD LEVEL CLR
    //3RD LEVEL DRD
    if ( iSpell == SPELL_CALL_LIGHTNING )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_SPIKE_GROWTH )
    {
        return RADIUS_SIZE_LARGE;
    }
    //3RD LEVEL SOR/WIZ
    if ( iSpell == SPELL_FIREBALL )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_GUST_OF_WIND )
    {
    	return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_LIGHTNING_BOLT )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_NEGATIVE_ENERGY_BURST )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_SLOW )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_STINKING_CLOUD )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_SCINTILLATING_SPHERE )
    {
    	return RADIUS_SIZE_HUGE;
    }
    //2ND LEVEL CLR
    if ( iSpell == SPELL_DARKNESS )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_SOUND_BURST )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELL_GEDLEES_ELECTRIC_LOOP )
    {
    	return RADIUS_SIZE_SMALL;
    }
    if ( iSpell == SPELL_CLOUD_OF_BEWILDERMENT )
    {
    	return RADIUS_SIZE_HUGE;
    }
    //2ND LEVEL DRD
    //2ND LEVEL SOR/WIZ
    if ( iSpell == SPELL_DARKNESS )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_WEB )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_BALAGARNSIRONHORN )
    {
    	return RADIUS_SIZE_COLOSSAL;
    }
    //1ST LEVEL CLR
    if ( iSpell == SPELL_BANE )
    {
    	return RADIUS_SIZE_COLOSSAL;
    }
    //1ST LEVEL DRD
    if ( iSpell == SPELL_ENTANGLE )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_GREASE )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELL_SLEEP )
    {
        return RADIUS_SIZE_HUGE;
    }
    //1ST LEVEL SOR/WIZ
    if ( iSpell == SPELL_COLOR_SPRAY )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELL_GREASE )
    {
        return RADIUS_SIZE_MEDIUM;
    }
    if ( iSpell == SPELL_SLEEP )
    {
        return RADIUS_SIZE_HUGE;
    }
    return 0.0;
}

int GetDirectSpell( object oT, int iDisc=FALSE, int iMinLvl=0, object oCaster=OBJECT_SELF )
{
    int iCnt = 0;
    int iSpell;
    int iEffects = GetEffectsOnObject( oT );

	//EPIC
	if ( GetHasSpell( SPELL_EPIC_RUIN, oCaster ) && GetCurrentHitPoints( oT ) > 120 )
	{
		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EPIC_RUIN );
	}
	
    //9TH LEVEL CLR
    if ( !iCnt || iMinLvl <=9 )
    {
        if ( GetHasSpell( SPELL_ENERGY_DRAIN, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_NEGATIVE_LEVEL ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ENERGY_DRAIN );
        }
        //9TH LEVEL DRD
        //9TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_DOMINATE_MONSTER, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DOMINATE ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_DOMINATE_MONSTER, oT ) ) ) //FIX
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DOMINATE_MONSTER );
        }
        if ( GetHasSpell( SPELL_POWER_WORD_KILL, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetCurrentHitPoints( oT ) > 100 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_POWER_WORD_KILL );
        }
        if ( GetHasSpell( SPELL_BIGBYS_CRUSHING_HAND, oCaster ) && !GetHasSpellEffect( SPELL_BIGBYS_CRUSHING_HAND, oT ) && 
        	!( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BIGBYS_CRUSHING_HAND );
        }	
    }
    if ( !iCnt || iMinLvl <=8 )
    {
        //8TH LEVEL CLR
        //8TH LEVEL DRD
        if ( GetHasSpell( SPELL_FINGER_OF_DEATH, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FINGER_OF_DEATH );
        }
        //8TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_GREATER_PLANAR_BINDING, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && !GetLevelByClass( CLASS_TYPE_OUTSIDER, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_PARALYZE ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GREATER_PLANAR_BINDING );
        }
        if ( GetHasSpell( SPELL_BIGBYS_CLENCHED_FIST, oCaster ) && !GetHasSpellEffect( SPELL_BIGBYS_CLENCHED_FIST, oT ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BIGBYS_CLENCHED_FIST );
        }	
    }
    if ( !iCnt || iMinLvl <=7 )
    {
        //7TH LEVEL CLR
        if ( GetHasSpell( SPELL_DESTRUCTION, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DESTRUCTION );
        }
        //7TH LEVEL DRD
        //7TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_BIGBYS_GRASPING_HAND, oCaster ) && !GetHasSpellEffect( SPELL_BIGBYS_GRASPING_HAND, oT ) && 
        	!( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BIGBYS_GRASPING_HAND );
        }
        if ( GetHasSpell( SPELL_POWER_WORD_STUN, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_STUN ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetCurrentHitPoints( oT ) > 150 ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_STUNNED ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_POWER_WORD_STUN );
        }
    }
    if ( !iCnt || iMinLvl <=6 )
    {
        //6TH LEVEL CLR
        //6TH LEVEL DRD
        if ( GetHasSpell( SPELL_CRUMBLE, oCaster ) &&
        	( GetRacialType( oT ) == RACIAL_TYPE_CONSTRUCT || GetLevelByClass( CLASS_TYPE_CONSTRUCT, oT ) > 0 ) )
        	//this spell is only useful against constructs so no ability check should be made here
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CRUMBLE );
        }
        if ( GetHasSpell( SPELL_DROWN, oCaster ) ) //need to add check for non-affected types
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DROWN );
        }
        //6TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_BIGBYS_FORCEFUL_HAND, oCaster ) && !GetHasSpellEffect( SPELL_BIGBYS_FORCEFUL_HAND, oT ) && 
        	!( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_KNOCKDOWN ) ) && 
        	!( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DAZED ) ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BIGBYS_FORCEFUL_HAND );
        }
        if ( GetHasSpell( SPELL_FLESH_TO_STONE, oCaster ) && !GetHasSpellEffect( SPELL_FLESH_TO_STONE, oT ) && 
        	!( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && IsImmuneToPetrification( oT ) ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FLESH_TO_STONE );
        }
        if ( GetHasSpell( SPELL_PLANAR_BINDING, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && !GetLevelByClass( CLASS_TYPE_OUTSIDER, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_PARALYZE ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PLANAR_BINDING );
        }
        /* Spell/Talent Bug Problem
        if ( GetHasSpell( SPELL_SHADES_FIREBALL, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHADES_FIREBALL );
        }
        */
    }
    if ( !iCnt || iMinLvl <=5 )
    {
        //5TH LEVEL CLR
        if ( GetHasSpell( SPELL_SLAY_LIVING, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SLAY_LIVING );
        }
        //5TH LEVEL DRD
        if ( GetHasSpell( SPELL_INFERNO, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INFERNO );
        }
        //5TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_BALL_LIGHTNING, oCaster ) ) //FIX: ANY ADDITIONAL CHECKS NEEDED HERE?
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BALL_LIGHTNING );
        }
        if ( GetHasSpell( SPELL_BIGBYS_INTERPOSING_HAND, oCaster ) && !GetHasSpellEffect( SPELL_BIGBYS_INTERPOSING_HAND, oT ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BIGBYS_INTERPOSING_HAND );
        }
        if ( GetHasSpell( SPELL_DOMINATE_PERSON, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DOMINATE ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_DOMINATED ) ) //FIX: TAG WITH CHARMED
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DOMINATE_PERSON );
        }
        if ( GetHasSpell( SPELL_FEEBLEMIND, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && !GetLevelByClass( CLASS_TYPE_WIZARD, oT ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FEEBLEMIND );
        }
        /* Spell/Talent Bug
        if ( GetHasSpell( SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW );

        }
        */
        if ( GetHasSpell( SPELL_HOLD_MONSTER, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_PARALYZE ) ) //paralysis check
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HOLD_MONSTER );
        }
        if ( GetHasSpell( SPELL_LESSER_PLANAR_BINDING, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && !GetLevelByClass( CLASS_TYPE_OUTSIDER, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_PARALYZE ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_LESSER_PLANAR_BINDING );
        }
    }
    if ( !iCnt || iMinLvl <=4 )
    {
        //4TH LEVEL CLR
        //4TH LEVEL DRD
        //4TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_CHARM_MONSTER, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_CHARM ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_CHARMED ) ) //FIX: TAG WITH DOMINATED
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CHARM_MONSTER );
        }
        if ( GetHasSpell( SPELL_ENERVATION, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_NEGATIVE_LEVEL ) ) )
        {
            //return SPELL_ENERVATION;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ENERVATION );
        }
        /* Spell/Talent Bug
        if ( GetHasSpell( SPELL_SHADOW_CONJURATION_MAGIC_MISSILE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHADOW_CONJURATION_MAGIC_MISSILE );
        }
        */
        if ( GetHasSpell( SPELL_PHANTASMAL_KILLER, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PHANTASMAL_KILLER );
        }
    }
    if ( !iCnt || iMinLvl <=3 )
    {
    	/* These spellabilities do not register
    	if ( GetHasSpell( SPELLABILITY_BG_CONTAGION, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DISEASE ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_CONTAGION, oT ) ) && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_BG_CONTAGION, oT ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BG_CONTAGION );
        }
        */
        //3RD LEVEL CLR
        if ( GetHasSpell( SPELL_BLINDNESS_AND_DEAFNESS, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_BLINDNESS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_BLINDNESS ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BLINDNESS_AND_DEAFNESS );
        }
        if ( GetHasSpell( SPELL_CONTAGION, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DISEASE ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_CONTAGION, oT ) ) && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_BG_CONTAGION, oT ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CONTAGION );
        }
        if ( GetHasSpell( SPELL_SEARING_LIGHT, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SEARING_LIGHT );
        }
        //3RD LEVEL DRD
        if ( GetHasSpell( SPELL_HEALING_STING, oCaster ) && GetMaxHitPoints( oCaster ) - GetCurrentHitPoints( oCaster ) > 7 )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HEALING_STING );
        }
        if ( GetHasSpell( SPELL_INFESTATION_OF_MAGGOTS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD &&
        	( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INFESTATION_OF_MAGGOTS );
        }
        if ( GetHasSpell( SPELL_QUILLFIRE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_QUILLFIRE );
        }
        //3RD LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_FLAME_ARROW, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FLAME_ARROW );
        }
        if ( GetHasSpell( SPELL_HOLD_PERSON, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_PARALYZE ) ) //paralysis check
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HOLD_PERSON );
        }
    }
    if ( !iCnt || iMinLvl <=2 )
    {
        //2ND LEVEL CLR
        if ( GetHasSpell( SPELL_NEGATIVE_ENERGY_RAY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_NEGATIVE_ENERGY_RAY );
        }
        //2ND LEVEL DRD
        if ( GetHasSpell( SPELL_CHARM_PERSON_OR_ANIMAL, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_CHARM ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_CHARMED ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CHARM_PERSON_OR_ANIMAL );
        }
        if ( GetHasSpell( SPELL_FLAME_LASH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FLAME_LASH );
        }
        //2ND LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_COMBUST, oCaster ) &&
        	( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) == FALSE || !GetHasSpellEffect( SPELL_COMBUST, oT ) ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_COMBUST );
        }
        if ( GetHasSpell( SPELL_MELFS_ACID_ARROW, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MELFS_ACID_ARROW );
        }
        if ( GetHasSpell( SPELL_TASHAS_HIDEOUS_LAUGHTER, oCaster ) && !GetHasSpellEffect( SPELL_TASHAS_HIDEOUS_LAUGHTER, oT ) && 
        	!( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_KNOCKDOWN ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_TASHAS_HIDEOUS_LAUGHTER );
        }
    }
    if ( !iCnt || iMinLvl <=1 )
    {
        //1ST LEVEL CLR
        if ( GetHasSpell( SPELL_DOOM, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_DOOM, oT ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DOOM );
        }
        if ( GetHasSpell( SPELL_SCARE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_SCARE, oT ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SCARE );
        }
        //1ST LEVEL DRD
        //1ST LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_CHARM_PERSON, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_CHARM ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_CHARMED ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CHARM_PERSON );
        }
        if ( GetHasSpell( SPELL_HORIZIKAULS_BOOM, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HORIZIKAULS_BOOM );
        }
        if ( GetHasSpell( SPELL_MAGIC_MISSILE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MAGIC_MISSILE );
        }
        if ( GetHasSpell( SPELL_RAY_OF_ENFEEBLEMENT, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_RAY_OF_ENFEEBLEMENT );
        }
    }
    if ( !iCnt )
    {
        //0TH LEVEL CLR
        //0TH LEVEL DRD
        //0TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_ACID_SPLASH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ACID_SPLASH );
        }
        if ( GetHasSpell( SPELL_DAZE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DAZED ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_DAZE, oT ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DAZE );
        }
        if ( GetHasSpell( SPELL_ELECTRIC_JOLT, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ELECTRIC_JOLT );
        }
        if ( GetHasSpell( SPELL_FLARE, oCaster ) && !GetHasSpellEffect( SPELL_FLARE, oT ) && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ATTACK_DECREASE ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FLARE );
        }
        if ( GetHasSpell( SPELL_RAY_OF_FROST, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_RAY_OF_FROST );
        }
    }

    //SPELLABILITIES
    //BOLT ABILITIES
    if ( !iCnt )
    {
    	//save DCs on these are generally low, use them only if we have no spells
    	if ( GetHasSpell( SPELLABILITY_BOLT_ABILITY_DRAIN_CHARISMA, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_ABILITY_DRAIN_CHARISMA );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_ABILITY_DRAIN_CONSTITUTION, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_ABILITY_DRAIN_CONSTITUTION );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_ABILITY_DRAIN_DEXTERITY, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_ABILITY_DRAIN_DEXTERITY );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_ABILITY_DRAIN_INTELLIGENCE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_ABILITY_DRAIN_INTELLIGENCE );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_ABILITY_DRAIN_STRENGTH, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_ABILITY_DRAIN_STRENGTH );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_ABILITY_DRAIN_WISDOM, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_ABILITY_DECREASE ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_ABILITY_DRAIN_WISDOM );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_ACID, oCaster ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_ACID );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_CHARM, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_CHARM ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_CHARM );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_COLD, oCaster ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_COLD );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_CONFUSE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_CONFUSE );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_DAZE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DAZED ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_DAZE, oT ) ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_DAZE );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_DEATH, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_DEATH );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_DISEASE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DISEASE ) ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_DISEASE );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_DOMINATE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DOMINATE ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_DOMINATE );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_FIRE, oCaster ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_FIRE );
	    }
	    /*
	    if ( GetHasSpell( SPELLABILITY_BOLT_KNOCKDOWN, oCaster ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_KNOCKDOWN );
    	}
    	*/
    	if ( GetHasSpell( SPELLABILITY_BOLT_LEVEL_DRAIN, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_NEGATIVE_LEVEL ) ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_LEVEL_DRAIN );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_LIGHTNING, oCaster ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_LIGHTNING );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_PARALYZE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_PARALYZE ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_PARALYZE );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_POISON, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_POISON ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_POISON );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_SHARDS, oCaster ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_SHARDS );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_SLOW, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_SLOW );
    	}
    	if ( GetHasSpell( SPELLABILITY_BOLT_STUN, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_STUN ) ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_STUN );
	    }
	    if ( GetHasSpell( SPELLABILITY_BOLT_WEB, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BOLT_WEB );
    	}
    	//GAZE ABILITIES
    	if ( GetHasSpell( SPELLABILITY_GAZE_CHARM, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_GAZE_CHARM, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_CHARM ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_CHARM );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_CONFUSION, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_GAZE_CONFUSION, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_CONFUSION );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_DAZE, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_GAZE_DAZE, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DAZED ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_DAZE, oT ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DAZE );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_DEATH, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetHasSpellEffect( SPELLABILITY_GAZE_DEATH, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DEATH );
    	}
    	/* something weird going on here with compilation
    	if ( GasHasSpell( SPELLABILITY_GAZE_DESTROY_CHAOS, oCaster ) && GetAlignmentLawChaos( oT ) == ALIGNMENT_CHAOTIC )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DESTROY_CHAOS );
    	}
    	if ( GasHasSpell( SPELLABILITY_GAZE_DESTROY_EVIL, oCaster ) && GetAlignmentGoodEvil( oT ) == ALIGNMENT_EVIL )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DESTROY_EVIL );
    	}
    	if ( GasHasSpell( SPELLABILITY_GAZE_DESTROY_GOOD, oCaster ) && GetAlignmentGoodEvil( oT ) == ALIGNMENT_GOOD )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DESTROY_GOOD );
    	}
    	if ( GasHasSpell( SPELLABILITY_GAZE_DESTROY_LAW, oCaster ) && GetAlignmentLawChaos( oT ) == ALIGNMENT_LAWFUL )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DESTROY_CHAOS );
    	}
    	*/
    	if ( GetHasSpell( SPELLABILITY_GAZE_DOMINATE, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_GAZE_DOMINATE, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_DOMINATE ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DOMINATE );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_DOOM, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetHasSpellEffect( SPELLABILITY_GAZE_DOOM, oT ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_DOOM );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_FEAR, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_GAZE_FEAR, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELL_SCARE, oT ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_FEAR );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_PARALYSIS, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_GAZE_PARALYSIS, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && iEffects & NO_EFFECT_PARALYZE ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_PARALYSIS );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_PETRIFY, oCaster ) && 
    		!GetHasSpellEffect( SPELLABILITY_GAZE_PETRIFY, oT ) )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_PETRIFY );
    	}
    	if ( GetHasSpell( SPELLABILITY_GAZE_STUNNED, oCaster ) &&
	        !( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) && GetHasSpellEffect( SPELLABILITY_GAZE_STUNNED, oT ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_STUN ) ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_GAZE_STUNNED );
    	}
    	//MISCELLANEOUS SPELLABILITIES
    	if ( GetHasSpell( SPELLABILITY_MEPHIT_SALT_BREATH, oCaster ) )
    	{
	        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_MEPHIT_SALT_BREATH );
	    }
	    if ( GetHasSpell( SPELLABILITY_MEPHIT_STEAM_BREATH, oCaster ) )
	    {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_MEPHIT_STEAM_BREATH );
    	}
    	if ( GetHasSpell( SPELLABILITY_MANTICORE_SPIKES, oCaster ) )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_MANTICORE_SPIKES );
    	}
    	if ( GetHasSpell( SPELLABILITY_CHARMMONSTER, oCaster ) &&
    		( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) == FALSE || GetHasSpellEffect( SPELLABILITY_GAZE_CHARM, oT ) == FALSE ) &&
            ( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || GetIsImmune( oT, IMMUNITY_TYPE_CHARM ) == FALSE ) &&
            ( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || GetIsImmune( oT, IMMUNITY_TYPE_MIND_SPELLS ) == FALSE ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_CHARMMONSTER );
        }    		
    }

    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );
    if ( iSpell == 0 )
    {
        iSpell = -1;    //consistency with GetAreaSpell
    }
    while ( iCnt )
    {
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

int GetTouchSpell( object oT, int iMinLvl=0, object oCaster=OBJECT_SELF )
{
    int iCnt = 0;
    int iSpell;
    int iEffects = GetEffectsOnObject( oT );

	if ( !iCnt || iMinLvl <= 7 )
	{
		if ( GetHasSpell( SPELLABILITY_PM_DEATHLESS_MASTER_TOUCH, oCaster ) &&
			( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || GetIsImmune( oT, IMMUNITY_TYPE_DEATH ) ) )
		{
			SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PM_DEATHLESS_MASTER_TOUCH );
		}
	}
    if ( !iCnt || iMinLvl <= 6 )
    {
        //6TH LEVEL CLR
        if ( GetHasSpell( SPELL_HARM, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetCurrentHitPoints( oT ) > 60 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HARM );
        }
        //6TH LEVEL DRD
        //6TH LEVEL SOR/WIZ
    }
    if ( !iCnt || iMinLvl <=4 )
    {
    	//4TH LEVEL BLK
    	/* these spellabilities do not register
    	if ( GetHasSpell( SPELLABILITY_BG_INFLICT_CRITICAL_WOUNDS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetCurrentHitPoints( oT ) > 40 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BG_INFLICT_CRITICAL_WOUNDS );
        }
        */
        //4TH LEVEL CLR
        if ( GetHasSpell( SPELL_INFLICT_CRITICAL_WOUNDS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetCurrentHitPoints( oT ) > 40 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INFLICT_CRITICAL_WOUNDS );
        }
        if ( GetHasSpell( SPELL_POISON, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_POISON ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_POISON );
        }
        //4TH LEVEL DRD
        //4TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_BESTOW_CURSE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetIsImmune( oT, IMMUNITY_TYPE_CURSED ) ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetHasSpellEffect( SPELL_BESTOW_CURSE, oT ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BESTOW_CURSE );
        }
    }
    if ( !iCnt || iMinLvl <=3 )
    {
    	//3RD LEVEL BLK    	
    	/* these spellabilities do not register
        if ( GetHasSpell( SPELLABILITY_BG_INFLICT_SERIOUS_WOUNDS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetCurrentHitPoints( oT ) > 30 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BG_INFLICT_SERIOUS_WOUNDS );
        }
        */
        //3RD LEVEL CLR
        if ( GetHasSpell( SPELL_INFLICT_SERIOUS_WOUNDS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetCurrentHitPoints( oT ) > 30 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INFLICT_SERIOUS_WOUNDS );
        }
        //3RD LEVEL DRD
        //PALE MASTER
        if ( GetHasSpell( SPELLABILITY_PM_UNDEAD_GRAFT_2, oCaster ) ) //different style of check here, so we can fall back to graft 1
        {
        	if (
        		( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) == FALSE ) &&
        		( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) == FALSE || iEffects & NO_EFFECT_PARALYZE == FALSE ) ) //paralysis check
        	{
            	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PM_UNDEAD_GRAFT_2 );
            }
        }
        else if ( GetHasSpell( SPELLABILITY_PM_UNDEAD_GRAFT_1, oCaster ) )
        {
        	if (
        		( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) == FALSE || GetIsImmune( oT, IMMUNITY_TYPE_PARALYSIS ) == FALSE ) &&
        		( DoAbilityCheck( ABILITY_INTELLIGENCE, 5 ) == FALSE || iEffects & NO_EFFECT_PARALYZE == FALSE ) ) //paralysis check
        	{
            	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PM_UNDEAD_GRAFT_1 );
            }
        }
        //3RD LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_VAMPIRIC_TOUCH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_VAMPIRIC_TOUCH );
        }
    }
    if ( !iCnt || iMinLvl <=2 )
    {
        //2ND LEVEL CLR
        if ( GetHasSpell( SPELL_GHOUL_TOUCH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GHOUL_TOUCH );
        }
        if ( GetHasSpell( SPELL_INFLICT_MODERATE_WOUNDS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetCurrentHitPoints( oT ) > 20 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INFLICT_MODERATE_WOUNDS );
        }
        //2ND LEVEL DRD
        //2ND LEVEL SOR/WIZ
    }
    if ( !iCnt || iMinLvl <=1 )
    {
        //1ST LEVEL CLR
        if ( GetHasSpell( SPELL_INFLICT_LIGHT_WOUNDS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD && 
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) && GetCurrentHitPoints( oT ) > 10 ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INFLICT_LIGHT_WOUNDS );
        }
        //2ND LEVEL DRD
        //2ND LEVEL SOR/WIZ
    }
    if ( !iCnt || iMinLvl <=0 )
    {
        //0TH LEVEL CLR
        if ( GetHasSpell( SPELL_INFLICT_MINOR_WOUNDS, oCaster ) && GetRacialType( oT ) != RACIAL_TYPE_UNDEAD )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INFLICT_MINOR_WOUNDS );
        }
        //2ND LEVEL DRD
        //2ND LEVEL SOR/WIZ
    }
    
    //spellabilities
    if ( !iCnt )
    {
    	if ( GetHasSpell( SPELLABILITY_TOUCH_PETRIFY, oCaster ) &&
    		!GetHasSpellEffect( SPELLABILITY_TOUCH_PETRIFY, oT ) )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_TOUCH_PETRIFY );
    	}
    }    

    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );
    if ( iSpell == 0 )
    {
        iSpell = -1;    //consistency with GetAreaSpell
    }
    while ( iCnt )
    {
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

int GetSummonSpell( int iMinLvl=1, object oCaster=OBJECT_SELF )
{
    int iCnt = 0;
    int iSpell;

	//EPIC
	if ( GetHasSpell( SPELL_EPIC_DRAGON_KNIGHT, oCaster ) )
	{
		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EPIC_DRAGON_KNIGHT );
	}
	if ( GetHasSpell( SPELL_EPIC_MUMMY_DUST, oCaster ) )
	{
		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EPIC_MUMMY_DUST );
	}
		
    // Slowdown issues with balors and succubi?
    if ( GetHasSpell( SPELLABILITY_SUMMON_TANARRI, oCaster ) )
    {
        //return SPELLABILITY_SUMMON_TANARRI;
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_SUMMON_TANARRI );
    }
    
    if ( !iCnt || iMinLvl <=9 )
    {
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_IX, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_IX );
        }
        if ( GetHasSpell( SPELL_GATE, oCaster ) &&
            !( DoAbilityCheck( ABILITY_INTELLIGENCE, 10 ) &&
                !( GetHasSpellEffect( SPELL_PROTECTION_FROM_EVIL, oCaster ) ||
                    GetHasSpellEffect( SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oCaster ) ||
                    GetHasSpellEffect( SPELL_HOLY_AURA, oCaster ) ) ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GATE );
        }
        if ( GetHasSpell( SPELL_ELEMENTAL_SWARM, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ELEMENTAL_SWARM );
        }
        if ( GetHasSpell( SPELL_BLACK_BLADE_OF_DISASTER, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BLACK_BLADE_OF_DISASTER );
        }
    }
    if ( !iCnt || iMinLvl <=8 )
    {
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_VIII, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_VIII;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_VIII );
        }
        if ( GetHasSpell( SPELL_CREATE_GREATER_UNDEAD, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CREATE_GREATER_UNDEAD );
        }
        if ( GetHasSpell( SPELL_GREATER_PLANAR_BINDING, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GREATER_PLANAR_BINDING );
        }
    }
    if ( !iCnt || iMinLvl <=7 )
    {
    	/* these spellabilities do not register
    	if ( GetHasSpell( SPELLABILITY_BG_FIENDISH_SERVANT, oCaster ) )
        {
        	SpeakString( "Registering FS" );
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BG_FIENDISH_SERVANT );
        }
        */
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_VII, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_VII;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_VII );
        }
        if ( GetHasSpell( SPELL_MORDENKAINENS_SWORD, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MORDENKAINENS_SWORD );
        }        
        if ( GetHasSpell( SPELLABILITY_PM_SUMMON_GREATER_UNDEAD, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PM_SUMMON_GREATER_UNDEAD );
        }
    }
    if ( !iCnt || iMinLvl <=6 )
    {
    	if ( GetHasSpell( SPELL_CREATE_UNDEAD, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CREATE_UNDEAD );
        }
        /* these spellabilities do not register
        if ( GetHasSpell( SPELLABILITY_BG_CREATEDEAD, oCaster ) )
        {
        	SpeakString( "Registering CD" );
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BG_CREATEDEAD );
        }
        */
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_VI, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_VI;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_VI );
        }
        if ( GetHasSpell( SPELL_PLANAR_ALLY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PLANAR_ALLY );
        }
        if ( GetHasSpell( SPELL_PLANAR_BINDING, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PLANAR_BINDING );
        }
        /* Spell/Talent Bug
        if ( GetHasSpell( SPELL_SHADES_SUMMON_SHADOW, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHADES_SUMMON_SHADOW );
        }
        */
    }
    if ( !iCnt || iMinLvl <=5 )
    {
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_V, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_V;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_V );
        }
        if ( GetHasSpell( SPELL_ANIMATE_DEAD, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ANIMATE_DEAD );
        }
        /* Spell/Talent Bug
        if ( GetHasSpell( SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW );
        }
        */
        if ( GetHasSpell( SPELL_LESSER_PLANAR_BINDING, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_LESSER_PLANAR_BINDING );
        }
        if ( GetHasSpell( SPELLABILITY_PM_SUMMON_UNDEAD, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PM_SUMMON_UNDEAD );
        }
    }
    if ( !iCnt || iMinLvl <=4 )
    {
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_IV, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_IV;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_IV );
        }
        /* Spell/Talent Bug
        if ( GetHasSpell( SPELL_SHADOW_CONJURATION_SUMMON_SHADOW, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHADOW_CONJURATION_SUMMON_SHADOW );
        }
        */
        if ( GetHasSpell( SPELLABILITY_PM_ANIMATE_DEAD, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_PM_ANIMATE_DEAD );
        }
    }
    if ( !iCnt || iMinLvl <=3 )
    {
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_III, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_III;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_III );
        }
    }
    if ( !iCnt || iMinLvl <=2 )
    {
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_II, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_II;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_II );
        }
    }
    if ( !iCnt )
    {
        if ( GetHasSpell( SPELL_SUMMON_CREATURE_I, oCaster ) )
        {
            //return SPELL_SUMMON_CREATURE_I;
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SUMMON_CREATURE_I );
        }
        if ( GetHasSpell( SPELL_SHELGARNS_PERSISTENT_BLADE, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHELGARNS_PERSISTENT_BLADE );
        }
    }
    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );
    while ( iCnt )
    {
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

int GetEnhanceSpellSelf( int iMinLvl=1, object oCaster=OBJECT_SELF )
{
    int iCnt = 0;
    int iSpell = 0;

	//EPIC
	/* epic warding and epic mage armour do not currently work for non PCs, GetCasterLevel() returns 0
	if ( GetHasSpell( SPELL_EPIC_MAGE_ARMOR, oCaster ) && !GetHasSpellEffect( SPELL_EPIC_MAGE_ARMOR, oCaster ) )
	{
		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EPIC_MAGE_ARMOR );
	}
	*/
	
    //SPELLABILITIES
    //NOTE: these should be activated by DoFastBuffs() but might need to be recast
    if ( GetHasSpell( SPELLABILITY_DRAGON_FEAR, oCaster ) && !GetHasSpellEffect( SPELLABILITY_DRAGON_FEAR, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_FEAR );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_BLINDING, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_BLINDING, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_BLINDING );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_COLD, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_COLD, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_COLD );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_ELECTRICITY, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_ELECTRICITY, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_ELECTRICITY );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_FEAR, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_FEAR, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_FEAR );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_FIRE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_FIRE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_FIRE );
    }    
    if ( GetHasSpell( SPELLABILITY_AURA_MENACE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_MENACE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_MENACE );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_OF_COURAGE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_OF_COURAGE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_OF_COURAGE );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_PROTECTION, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_PROTECTION, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_PROTECTION );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_STUN, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_STUN, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_STUN );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_UNEARTHLY_VISAGE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_UNEARTHLY_VISAGE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_UNEARTHLY_VISAGE );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_UNNATURAL, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_UNNATURAL, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_AURA_UNNATURAL );
    }
    if ( GetHasSpell( SPELLABILITY_EMPTY_BODY, oCaster ) && !GetHasSpellEffect( SPELLABILITY_EMPTY_BODY, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_EMPTY_BODY );
    }
    if ( GetHasSpell( SPELLABILITY_TYRANT_FOG_MIST, oCaster ) && !GetHasSpellEffect( SPELLABILITY_TYRANT_FOG_MIST, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_TYRANT_FOG_MIST );
    }

    if ( GetHasSpell( SPELLABILITY_RAGE_5, oCaster ) && !GetHasSpellEffect( SPELLABILITY_RAGE_5, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_RAGE_5 );
    }
    else if ( GetHasSpell( SPELLABILITY_RAGE_4, oCaster ) && !GetHasSpellEffect( SPELLABILITY_RAGE_4, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_RAGE_4 );
    }
    else if ( GetHasSpell( SPELLABILITY_RAGE_3, oCaster ) && !GetHasSpellEffect( SPELLABILITY_RAGE_3, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_RAGE_3 );
    }

    if ( GetHasSpell( SPELLABILITY_FEROCITY_3, oCaster ) && !GetHasSpellEffect( SPELLABILITY_FEROCITY_3, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_FEROCITY_3 );
    }
    else if ( GetHasSpell( SPELLABILITY_FEROCITY_2, oCaster ) && !GetHasSpellEffect( SPELLABILITY_FEROCITY_2, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_FEROCITY_2 );
    }
    else if ( GetHasSpell( SPELLABILITY_FEROCITY_1, oCaster ) && !GetHasSpellEffect( SPELLABILITY_FEROCITY_1, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_FEROCITY_1 );
    }

    if ( GetHasSpell( SPELLABILITY_INTENSITY_3, oCaster ) && !GetHasSpellEffect( SPELLABILITY_INTENSITY_3, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_INTENSITY_3 );
    }
    else if ( GetHasSpell( SPELLABILITY_INTENSITY_2, oCaster ) && !GetHasSpellEffect( SPELLABILITY_INTENSITY_2, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_INTENSITY_2 );
    }
    else if ( GetHasSpell( SPELLABILITY_INTENSITY_1, oCaster ) && !GetHasSpellEffect( SPELLABILITY_INTENSITY_1, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_INTENSITY_1 );
    }
    
    //SELF-ENHANCING DOMAIN POWERS
    if ( GetHasSpell( SPELLABILITY_BATTLE_MASTERY, oCaster ) && !GetHasSpellEffect( SPELLABILITY_BATTLE_MASTERY, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BATTLE_MASTERY );
    }
    if ( GetHasSpell( SPELLABILITY_DIVINE_PROTECTION, oCaster ) && !GetHasSpellEffect( SPELLABILITY_DIVINE_PROTECTION, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_DIVINE_PROTECTION );
    }
    if ( GetHasSpell( SPELLABILITY_DIVINE_STRENGTH, oCaster ) && !GetHasSpellEffect( SPELLABILITY_DIVINE_STRENGTH, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_DIVINE_STRENGTH );
    }
    
    //DIVINE CHAMPION
    if ( GetHasSpell( SPELLABILITY_DC_DIVINE_WRATH, oCaster ) && !GetHasSpellEffect( SPELLABILITY_DC_DIVINE_WRATH, oCaster ) )
    {
    	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_DC_DIVINE_WRATH );
    }
    
    /* NOT DIRECTLY USEFUL IN COMBAT
    if ( GetHasSpell( SPELLABILITY_DIVINE_TRICKERY, oCaster ) && !GetHasSpellEffect( SPELLABILITY_DIVINE_TRICKERY, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_DIVINE_TRICKERY );
    }
    */

    if ( !iCnt || iMinLvl <= 7 )
    {
        //7TH LEVEL CLR
        if ( GetHasSpell( SPELL_REGENERATE, oCaster ) && !GetHasSpellEffect( SPELL_REGENERATE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_REGENERATE );
        }
        //7TH LEVEL DRD
    }
    if ( !iCnt || iMinLvl <= 6 )
    {
    	//6TH LEVEL BRD
    	if ( GetHasSpell( SPELL_DIRGE, oCaster ) && !GetHasSpellEffect( SPELL_DIRGE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DIRGE );
        }
    	//6TH LEVEL CLR
    	/*
        if ( GetHasSpell( SPELL_GREATER_SANCTUARY, oCaster ) && !GetHasSpellEffect( SPELL_GREATER_SANCTUARY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_GREATER_SANCTUARY );
        }
        */
        //6TH LEVEL DRD
    }
    if ( !iCnt || iMinLvl <= 5 )
    {
    	//5TH LEVEL CLR
    	if ( GetHasSpell( SPELL_BATTLETIDE, oCaster ) && !GetHasSpellEffect( SPELL_BATTLETIDE, oCaster ) )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BATTLETIDE );
    	}
    	if ( GetHasSpell( SPELL_MONSTROUS_REGENERATION, oCaster ) && !GetHasSpellEffect( SPELL_MONSTROUS_REGENERATION, oCaster ) )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MONSTROUS_REGENERATION );
    	}
    	//5TH LEVEL DRD
    	/* Seems to be missing a SPELL_* item? GREATER_OWLS_WISDOM?
    	if ( GetHasSpell( SPELL_OWLS_INSIGHT, oCaster ) && !GetHasSpellEffect( SPELL_OWLS_INSIGHT, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_OWLS_INSIGHT );
        }
        */
        //5TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_MESTILS_ACID_SHEATH, oCaster ) && !GetHasSpellEffect( SPELL_MESTILS_ACID_SHEATH, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MESTILS_ACID_SHEATH );
        }
    }
    if ( !iCnt || iMinLvl <= 4 )
    {
        //4TH LEVEL CLR
        if ( GetHasSpell( SPELL_DIVINE_POWER, oCaster ) && !GetHasSpellEffect( SPELL_DIVINE_POWER, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DIVINE_POWER );
        }
        //4TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_IMPROVED_INVISIBILITY, oCaster ) && !GetHasSpellEffect( SPELL_IMPROVED_INVISIBILITY, oCaster ) && !GetHasSpellEffect( SPELL_INVISIBILITY, oCaster ) &&
        	//make sure there is at least one enemy who does not have true seeing and see invisibility
        	GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, 1, CREATURE_TYPE_DOES_NOT_HAVE_SPELL_EFFECT, SPELL_TRUE_SEEING, CREATURE_TYPE_IS_ALIVE, TRUE ) != OBJECT_INVALID &&
        	GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, 1, CREATURE_TYPE_DOES_NOT_HAVE_SPELL_EFFECT, SPELL_SEE_INVISIBILITY, CREATURE_TYPE_IS_ALIVE, TRUE ) != OBJECT_INVALID )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_IMPROVED_INVISIBILITY );
        }
    }
    if ( !iCnt || iMinLvl <= 3 )
    {
    	//3RD LEVEL BRD
    	if ( GetHasSpell( SPELL_WOUNDING_WHISPERS, oCaster ) && !GetHasSpellEffect( SPELL_WOUNDING_WHISPERS, oCaster ) )
    	{
	    	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_WOUNDING_WHISPERS );
	    }
        //3RD LEVEL CLR
        //3RD LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_DISPLACEMENT, oCaster ) && !GetHasSpellEffect( SPELL_DISPLACEMENT, oCaster ) && !GetHasSpellEffect( SPELL_IMPROVED_INVISIBILITY, oCaster ) &&
        	//make sure there is at least one enemy who does not have true seeing and see invisibility
        	GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, 1, CREATURE_TYPE_DOES_NOT_HAVE_SPELL_EFFECT, SPELL_TRUE_SEEING, CREATURE_TYPE_IS_ALIVE, TRUE ) != OBJECT_INVALID )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DISPLACEMENT );
        }
        if ( GetHasSpell( SPELL_HASTE, oCaster ) && !GetHasSpellEffect( SPELL_HASTE, oCaster ) && !GetHasSpellEffect( SPELL_MASS_HASTE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HASTE );
        }
    }
    if ( !iCnt || iMinLvl <= 2 )
    {
    	//2ND LEVEL BLK
    	/* these spellabilities do not register
    	if ( GetHasSpell( SPELLABILITY_BG_BULLS_STRENGTH, oCaster ) && !GetHasSpellEffect( SPELL_BULLS_STRENGTH, oCaster ) && !GetHasSpellEffect( SPELLABILITY_BG_BULLS_STRENGTH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELLABILITY_BG_BULLS_STRENGTH );
        }
        */
        //2ND LEVEL CLR
        if ( GetHasSpell( SPELL_AID, oCaster ) && !GetHasSpellEffect( SPELL_AID, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_AID );
        }
        if ( GetHasSpell( SPELL_BULLS_STRENGTH, oCaster ) && !GetHasSpellEffect( SPELL_BULLS_STRENGTH, oCaster ) && !GetHasSpellEffect( SPELLABILITY_BG_BULLS_STRENGTH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BULLS_STRENGTH );
        }
        if ( GetHasSpell( SPELL_DEATH_ARMOR, oCaster ) && !GetHasSpellEffect( SPELL_DEATH_ARMOR, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DEATH_ARMOR );
        }
        if ( GetHasSpell( SPELL_ENDURANCE, oCaster ) && !GetHasSpellEffect( SPELL_ENDURANCE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ENDURANCE );
        }
        // Note: Currently allow invisibility to be cast on top of improved invisibility
        // This is to allow a creature with imp invis that has attacked and so is only retaining the concealment of imp invis
        // to become invisible with this spell. It may sometimes result in redundant castings if the creature has imp invis and
        // has not attacked.
        if ( GetHasSpell( SPELL_INVISIBILITY, oCaster ) && !GetHasSpellEffect( SPELL_INVISIBILITY, oCaster ) &&
        	//make sure there is at least one enemy who does not have true seeing and see invisibility
        	GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, 1, CREATURE_TYPE_DOES_NOT_HAVE_SPELL_EFFECT, SPELL_TRUE_SEEING, CREATURE_TYPE_IS_ALIVE, TRUE ) != OBJECT_INVALID &&
        	GetNearestCreature( CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oCaster, 1, CREATURE_TYPE_DOES_NOT_HAVE_SPELL_EFFECT, SPELL_SEE_INVISIBILITY, CREATURE_TYPE_IS_ALIVE, TRUE ) != OBJECT_INVALID )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_INVISIBILITY );
        }
        if ( GetHasSpell( SPELL_OWLS_WISDOM, oCaster ) && !GetHasSpellEffect( SPELL_OWLS_WISDOM, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_OWLS_WISDOM );
        }
        //2ND LEVEL DRD
        if ( GetHasSpell( SPELL_BLOOD_FRENZY, oCaster ) && !GetHasSpellEffect( SPELL_BLOOD_FRENZY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BLOOD_FRENZY );
        }
        //2ND LEVEL PAL
        if ( GetHasSpell( SPELL_AURAOFGLORY, oCaster ) && !GetHasSpellEffect( SPELL_AURAOFGLORY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_AURAOFGLORY );
        }
        //2ND LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_FOXS_CUNNING, oCaster ) && !GetHasSpellEffect( SPELL_FOXS_CUNNING, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FOXS_CUNNING );
        }
        if ( GetHasSpell( SPELL_STONE_BONES, oCaster ) && GetRacialType( oCaster ) == RACIAL_TYPE_UNDEAD && !GetHasSpellEffect( SPELL_STONE_BONES, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_STONE_BONES );
        }
    }
    if ( !iCnt || iMinLvl <= 1 )
    {
        //1ST LEVEL CLR
        if ( GetHasSpell( SPELL_DIVINE_FAVOR, oCaster ) && !GetHasSpellEffect( SPELL_DIVINE_FAVOR, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DIVINE_FAVOR );
        }
        if ( GetHasSpell( SPELL_ENTROPIC_SHIELD, oCaster ) && !GetHasSpellEffect( SPELL_ENTROPIC_SHIELD, oCaster ) && 
        	GetAttackerCount( 40.0 ) - GetAttackerCount( 5.0 ) > 0 )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ENTROPIC_SHIELD );
        }
        /*
        if ( GetHasSpell( SPELL_SANCTUARY, oCaster ) && !GetHasSpellEffect( SPELL_SANCTUARY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SANCTUARY );
        }
        */
        if ( GetHasSpell( SPELL_SHIELD_OF_FAITH, oCaster ) && !GetHasSpellEffect( SPELL_SHIELD_OF_FAITH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHIELD_OF_FAITH );
        }
        //1ST LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_EXPEDITIOUS_RETREAT, oCaster ) && !GetHasSpellEffect( SPELL_EXPEDITIOUS_RETREAT, oCaster ) && 
        	!GetHasSpell( SPELL_HASTE, oCaster ) && !GetHasSpellEffect( SPELL_HASTE, oCaster ) && !GetHasSpellEffect( SPELL_MASS_HASTE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_EXPEDITIOUS_RETREAT );
        }
        if ( GetHasSpell( SPELL_IRONGUTS, oCaster ) && !GetHasSpellEffect( SPELL_IRONGUTS, oCaster ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_IRONGUTS );
        }
        if ( GetHasSpell( SPELL_MAGE_ARMOR, oCaster ) && !GetHasSpellEffect( SPELL_MAGE_ARMOR, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MAGE_ARMOR );
        }
        //0TH LEVEL CLR
        if ( GetHasSpell( SPELL_SHIELD, oCaster ) && !GetHasSpellEffect( SPELL_SHIELD, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHIELD );
        }
    }
    if ( !iCnt )
    {
    	//0TH LEVEL CLR
    	/* inactive temporarily
        if ( GetHasSpell( SPELL_RESISTANCE, oCaster ) && !GetHasSpellEffect( SPELL_RESISTANCE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_RESISTANCE );
        }
        */
        //0TH LEVEL DRD
        /* DUPLICATE
        if ( GetHasSpell( SPELL_RESISTANCE, oCaster ) && !GetHasSpellEffect( SPELL_RESISTANCE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_RESISTANCE );
        }
        */
        //0TH LEVEL SOR/WIZ
        /* DUPLICATE
        if ( GetHasSpell( SPELL_RESISTANCE, oCaster ) && !GetHasSpellEffect( SPELL_RESISTANCE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_RESISTANCE );
        }
        */
    }

    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );
    while ( iCnt )
    {
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

int GetEnhanceSpellSingle( int iMinLvl=1, object oEnt=OBJECT_SELF, object oCaster=OBJECT_SELF )
{
    int iSpell = 0;
    int iCnt = 0;

    if ( !iCnt || iMinLvl <= 7 )
    {
        //7TH LEVEL CLR
        if ( GetHasSpell( SPELL_REGENERATE, oCaster ) && !GetHasSpellEffect( SPELL_REGENERATE, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_REGENERATE );
        }
        //7TH LEVEL DRD
    }
    if ( !iCnt || iMinLvl <= 6 )
    {
        //6TH LEVEL DRD
    }
    if ( !iCnt || iMinLvl <= 5 )
    {
    	//5TH LEVEL CLR
    	if ( GetHasSpell( SPELL_MONSTROUS_REGENERATION, oCaster ) && !GetHasSpellEffect( SPELL_MONSTROUS_REGENERATION, oEnt ) )
    	{
    		SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MONSTROUS_REGENERATION );
    	}
    }
    if ( !iCnt || iMinLvl <= 4 )
    {
        //4TH LEVEL CLR
        /* SELF ONLY?
        if ( GetHasSpell( SPELL_DIVINE_POWER, oCaster ) && !GetHasSpellEffect( SPELL_DIVINE_POWER, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DIVINE_POWER );
        }
        */
        //4TH LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_IMPROVED_INVISIBILITY, oCaster ) && !GetHasSpellEffect( SPELL_IMPROVED_INVISIBILITY, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_IMPROVED_INVISIBILITY );
        }
    }
    if ( !iCnt || iMinLvl <= 3 )
    {
        //3RD LEVEL CLR
        //3RD LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_DISPLACEMENT, oCaster ) && !GetHasSpellEffect( SPELL_DISPLACEMENT, oEnt ) && !GetHasSpellEffect( SPELL_IMPROVED_INVISIBILITY, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_DISPLACEMENT );
        }
        if ( GetHasSpell( SPELL_HASTE, oCaster ) && !GetHasSpellEffect( SPELL_HASTE, oEnt ) && !GetHasSpellEffect( SPELL_MASS_HASTE, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_HASTE );
        }
    }
    if ( !iCnt || iMinLvl <= 2 )
    {
        //2ND LEVEL CLR
        if ( GetHasSpell( SPELL_AID, oCaster ) && !GetHasSpellEffect( SPELL_AID, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_AID );
        }
        if ( GetHasSpell( SPELL_BULLS_STRENGTH, oCaster ) && !GetHasSpellEffect( SPELL_BULLS_STRENGTH, oEnt ) && !GetHasSpellEffect( SPELLABILITY_BG_BULLS_STRENGTH, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BULLS_STRENGTH );
        }
        if ( GetHasSpell( SPELL_ENDURANCE, oCaster ) && !GetHasSpellEffect( SPELL_ENDURANCE, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_ENDURANCE );
        }
        //2ND LEVEL DRD
        //2ND LEVEL SOR/WIZ
        /* not a good general buff
        if ( GetHasSpell( SPELL_FOXS_CUNNING, oCaster ) && !GetHasSpellEffect( SPELL_FOXS_CUNNING, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_FOXS_CUNNING );
        }
        */
        if ( GetHasSpell( SPELL_CATS_GRACE, oCaster ) && !GetHasSpellEffect( SPELL_CATS_GRACE, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CATS_GRACE );
        }
        if ( GetHasSpell( SPELL_STONE_BONES, oCaster ) && GetRacialType( oEnt ) == RACIAL_TYPE_UNDEAD && !GetHasSpellEffect( SPELL_STONE_BONES, oEnt ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_STONE_BONES );
        }
    }
    if ( !iCnt || iMinLvl <= 1 )
    {
        //1ST LEVEL CLR
        /*
        if ( GetHasSpell( SPELL_SANCTUARY, oCaster ) && !GetHasSpellEffect( SPELL_SANCTUARY, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SANCTUARY );
        }
        */
        if ( GetHasSpell( SPELL_IRONGUTS, oCaster ) && !GetHasSpellEffect( SPELL_IRONGUTS, oEnt ) )
        {
        	SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_IRONGUTS );
        }
        if ( GetHasSpell( SPELL_SHIELD_OF_FAITH, oCaster ) && !GetHasSpellEffect( SPELL_SHIELD_OF_FAITH, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_SHIELD_OF_FAITH );
        }
        //1ST LEVEL SOR/WIZ
        if ( GetHasSpell( SPELL_MAGE_ARMOR, oCaster ) && !GetHasSpellEffect( SPELL_MAGE_ARMOR, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MAGE_ARMOR );
        }
    }
    if ( !iCnt )
    {
        //0TH LEVEL CLR
        /* inactive temporarily
        if ( GetHasSpell( SPELL_RESISTANCE, oCaster ) && !GetHasSpellEffect( SPELL_RESISTANCE, oEnt ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_RESISTANCE );
        }
        */
        //0TH LEVEL DRD
        //0TH LEVEL SOR/WIZ
    }

    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );
    while ( iCnt )
    {
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

int GetBestBreach( int iLim=30, object oEnt=OBJECT_SELF )
{
    //dispels not returned here
    if ( iLim > 12 )
    {
        if ( GetHasSpell( SPELL_GREATER_SPELL_BREACH, oEnt ) )
        {
            return SPELL_GREATER_SPELL_BREACH;
        }
        if ( GetHasSpell( SPELL_MORDENKAINENS_DISJUNCTION, oEnt ) )
        {
            return SPELL_MORDENKAINENS_DISJUNCTION;
        }/*
        if ( GetHasSpell( SPELL_GREATER_DISPELLING, oEnt ) )
        {
            return SPELL_GREATER_DISPELLING;
        }
        */
    }
    if ( iLim > 7 )
    {
        if ( GetHasSpell( SPELL_LESSER_SPELL_BREACH, oEnt ) )
        {
            return SPELL_LESSER_SPELL_BREACH;
        }
        /*
        if ( GetHasSpell( SPELL_DISPEL_MAGIC, oEnt ) )
        {
            return SPELL_DISPEL_MAGIC;
        }
        */
    }
    /*
    if ( iLim > 5 )
    {
        if ( GetHasSpell( SPELL_LESSER_DISPEL, oEnt ) )
        {
            return SPELL_LESSER_DISPEL;
        }
    }
    */
    return 0;
}

int GetBestDispel( int iCLvl=20, int iDLvl=20, object oEnt=OBJECT_SELF )
{
    int iDispel = 0;
    int iSpell = 0;

    if ( GetHasSpell( SPELL_LESSER_DISPEL, oEnt ) )
    {
        iDispel = 1;
        iSpell = SPELL_LESSER_DISPEL;
    }
    if ( !iDispel || ( iCLvl > 5 && iDLvl > 5 ) )
    {
        if ( GetHasSpell( SPELL_DISPEL_MAGIC, oEnt ) )
        {
            iDispel = 1;
            iSpell = SPELL_DISPEL_MAGIC;
        }
    }
    if ( !iDispel || ( iCLvl > 10 && iDLvl > 10 ) )
    {
        if ( GetHasSpell( SPELL_GREATER_DISPELLING, oEnt ) )
        {
            iDispel = 1;
            iSpell = SPELL_GREATER_DISPELLING;
        }
    }

    return iSpell;
}

int GetIsDiscriminantSpell( int iSpell )
{
    if ( iSpell == SPELL_WAIL_OF_THE_BANSHEE ||
        iSpell == SPELL_WEIRD ||
        iSpell == SPELL_WORD_OF_FAITH ||
        iSpell == SPELL_CHAIN_LIGHTNING ||
        iSpell == SPELL_ISAACS_GREATER_MISSILE_STORM ||
        iSpell == SPELL_HAMMER_OF_THE_GODS ||
        iSpell == SPELL_CONFUSION ||
        iSpell == SPELL_EVARDS_BLACK_TENTACLES ||
        iSpell == SPELL_FEAR ||
        iSpell == SPELL_ISAACS_LESSER_MISSILE_STORM ||
        iSpell == SPELL_CALL_LIGHTNING ||
        iSpell == SPELL_SLOW ||
        iSpell == SPELL_ENTANGLE ||
        iSpell == SPELL_SLEEP ||
        iSpell == SPELL_DARKNESS || //testing inclusion of Darkness
        iSpell == -69 )  //mind blast
    {
        return TRUE;
    }
    return FALSE;
}

int GetBreathWeapon( object oEnt=OBJECT_SELF )
{
    int iCnt = 0;
    int iSpell = 0;

    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_ACID, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_ACID );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_COLD, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_COLD );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_FEAR, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_FEAR );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_FIRE, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_FIRE );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_GAS, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_GAS );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_LIGHTNING, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_LIGHTNING );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_NEGATIVE, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_NEGATIVE );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_PARALYZE, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_PARALYZE );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_SLEEP, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_SLEEP );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_SLOW, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_SLOW );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_WEAKEN, oEnt ) )
    {
        SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_WEAKEN );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_RDD, oEnt ) )
    {
    	SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_RDD );
    }
    if ( GetHasSpell( SPELLABILITY_DRAGON_BREATH_PRISMATIC, oEnt ) )
    {
    	SetLocalInt( oEnt, "#BRT_" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_BREATH_PRISMATIC );
    }

    if ( iCnt )
    {
        iSpell = GetLocalInt( oEnt, "#BRT_" + IntToString( Random( iCnt ) + 1 ) );
        while ( iCnt )
        {
            DeleteLocalInt( oEnt, "#BRT_" + IntToString( iCnt-- ) );
        }
    }
    return iSpell;
}

int GetConeSpell( int iMinLvl = 1, object oCaster=OBJECT_SELF )
{
    //This function may be obsolete. Currently handling cones as area spells.
    int iCnt = 0;
    int iSpell;

    if ( !iCnt || iMinLvl <= 7 )
    {
        if ( GetHasSpell( SPELL_PRISMATIC_SPRAY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PRISMATIC_SPRAY );
        }
    }
    if ( !iCnt || iMinLvl <=5 )
    {
        if ( GetHasSpell( SPELL_CONE_OF_COLD, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_CONE_OF_COLD );
        }
    }
    if ( !iCnt || iMinLvl <=1 )
    {
        if ( GetHasSpell( SPELL_BURNING_HANDS, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BURNING_HANDS );
        }
        if ( GetHasSpell( SPELL_COLOR_SPRAY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_COLOR_SPRAY );
        }
    }
    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );

    while ( iCnt )
    {
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

int GetGroupEnhanceSpell( int iMinLvl = 1, object oCaster=OBJECT_SELF )
{
    int iCnt = 0;
    int iSpell;

	if ( !iCnt || iMinLvl <= 9 )
	{
		if ( GetHasSpell( SPELL_UNDEATHS_ETERNAL_FOE, oCaster ) )
		{
			SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_UNDEATHS_ETERNAL_FOE );
		}
	}
    if ( !iCnt || iMinLvl <= 8 )
    {
        if ( GetHasSpell( SPELL_MIND_BLANK, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MIND_BLANK );
        }
        if ( GetHasSpell( SPELL_NATURES_BALANCE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_NATURES_BALANCE );
        }
    }
    if ( !iCnt || iMinLvl <= 7 )
    {
        if ( GetHasSpell( SPELL_AURA_OF_VITALITY, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_AURA_OF_VITALITY );
        }
        if ( GetHasSpell( SPELL_PROTECTION_FROM_SPELLS, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PROTECTION_FROM_SPELLS );
        }
    }
    if ( !iCnt || iMinLvl <= 6 )
    {
        if ( GetHasSpell( SPELL_MASS_HASTE, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_MASS_HASTE );
        }
    }
    if ( !iCnt || iMinLvl <= 3 )
    {
        if ( GetHasSpell( SPELL_PRAYER, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_PRAYER );
        }
    }
    if ( !iCnt || iMinLvl <= 1 )
    {
        if ( GetHasSpell( SPELL_BLESS, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_" + IntToString( ++iCnt ), SPELL_BLESS );
        }
    }
    iSpell = GetLocalInt( oCaster, "#SPL_" + IntToString( Random( iCnt ) + 1 ) );

    while ( iCnt )
    {
        DeleteLocalInt( oCaster, "#SPL_" + IntToString( iCnt-- ) );
    }
    return iSpell;
}

float GetGroupEnhanceSpellRadius( int iSpell )
{
	if ( iSpell == SPELL_UNDEATHS_ETERNAL_FOE )
	{
		return RADIUS_SIZE_MEDIUM;
	}
    if ( iSpell == SPELL_MIND_BLANK )
    {
        return RADIUS_SIZE_HUGE;
    }
    if ( iSpell == SPELL_NATURES_BALANCE )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_AURA_OF_VITALITY )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_PROTECTION_FROM_SPELLS )
    {
        return RADIUS_SIZE_LARGE;   //NOT SURE, NEED TO CHECK
    }
    if ( iSpell == SPELL_MASS_HASTE )
    {
        return RADIUS_SIZE_LARGE;
    }
    if ( iSpell == SPELL_PRAYER )
    {
        return RADIUS_SIZE_COLOSSAL;
    }
    if ( iSpell == SPELL_BLESS )
    {
        return RADIUS_SIZE_GARGANTUAN;
    }
    return 0.0;
}

int GetDispelSpell( object oEnt=OBJECT_SELF )
{
    if ( GetHasSpell( SPELL_LESSER_DISPEL, oEnt ) )
    {
        return SPELL_LESSER_DISPEL;
    }
    if ( GetHasSpell( SPELL_DISPEL_MAGIC, oEnt ) )
    {
        return SPELL_DISPEL_MAGIC;
    }
    if ( GetHasSpell ( SPELL_GREATER_DISPELLING, oEnt ) )
    {
        return SPELL_GREATER_DISPELLING;
    }
    if ( GetHasSpell( SPELL_MORDENKAINENS_DISJUNCTION, oEnt ) )
    {
        return SPELL_MORDENKAINENS_DISJUNCTION;
    }
    return 0;
}

int GetMaxDispelCasterLevel( object oEnt=OBJECT_SELF )
{
    //NOTE: this function may return some bad results if creatures with innate dispel abilities
    //also have levels in standard caster levels, where those levels are lower than their innate ones
    //Should be compensated for by GetBestDispel()
    int iL = 0;
    int iT = 0;
    int iC = 0;

    iL = GetLevelByClass( CLASS_TYPE_BARD, oEnt );
    iC += iL;
    if ( ( iT = GetLevelByClass( CLASS_TYPE_CLERIC, oEnt ) ) > iL )
    {
        iL = iT;
    }
    iC += iT;
    if ( ( iT = GetLevelByClass( CLASS_TYPE_DRUID, oEnt ) ) > iL )
    {
        iL = iT;
    }
    iC += iT;
    if ( ( iT = GetLevelByClass( CLASS_TYPE_PALADIN, oEnt ) ) > iL )
    {
        iL = iT;
    }
    iC += iT;
    if ( ( iT = GetLevelByClass( CLASS_TYPE_SORCERER, oEnt ) ) > iL )
    {
        iL = iT;
    }
    iC += iT;
    if ( ( iT = GetLevelByClass( CLASS_TYPE_WIZARD, oEnt ) ) > iL )
    {
        iL = iT;
    }
    iC += iT;
    if ( !iC )
    {
        //no standard caster levels, check for innate abilities
        if ( GetHasSpell( SPELL_LESSER_DISPEL, oEnt ) ||
            GetHasSpell( SPELL_DISPEL_MAGIC, oEnt ) ||
            GetHasSpell( SPELL_GREATER_DISPELLING, oEnt ) ||
            GetHasSpell( SPELL_MORDENKAINENS_DISJUNCTION, oEnt ) )
        {
            iL = 20; //pad out to max for safety, use the best
        }
    }
    return iL;
}

int GetVisionSpellNeeded( object oS=OBJECT_SELF, object oC=OBJECT_SELF )
{
    int iT = GetHasSpellEffect( SPELL_TRUE_SEEING, oS );
    int iS = GetHasSpellEffect( SPELL_SEE_INVISIBILITY, oS );
    int iU = GetHasSpellEffect( SPELL_DARKVISION, oS );
    int iD = GetLocalInt( oS, "#DARKNESS" ) || GetHasSpell( SPELL_DARKNESS, oS );
    int iV = GetLocalInt( oS, "#VANISHED" );
    int iP = GetIsPC( oS ) && GetHasSpellEffect( SPELL_DARKNESS, oS );
    int iSU = GetHasSpell( SPELL_DARKVISION, oC );
    int iSS = GetHasSpell( SPELL_SEE_INVISIBILITY, oC );
    int iST = GetHasSpell( SPELL_TRUE_SEEING, oC );
    object oA;
    int iCnt = 0;
    float fRad = 20.0;

    if ( iV && !iD )
    {
        oA = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oS, ++iCnt );
        while ( !iD && GetIsObjectValid( oA ) && GetDistanceBetween( oS, oA ) < fRad )
        {
            if ( GetTag( oA ) == "VFX_PER_DARKNESS" )
            {
                //there is darkness in the area, could be messing with things
                //PrintString( "DARKNESS: " + GetName( oC ) + " sees Darkness in range of " + GetName( oS ) );
                iD = 1;
            }
            oA = GetNearestObject( OBJECT_TYPE_AREA_OF_EFFECT, oS, ++iCnt );
        }
    }

    if ( ( iD && !( iU || iT ) ) || iP )
    {
        //darkness, no ultravision, no true seeing
        if ( iSU )
        {
            return SPELL_DARKVISION;
        }
        if ( iST )
        {
            return SPELL_TRUE_SEEING;
        }
    }
    //Now: !iD || !( iSU || iST )
    if ( iV && !iD && !( iS || iT ) )
    {
        //vanished enemy, no darkness, no see invis, no true seeing
        if ( iST )
        {
            return SPELL_TRUE_SEEING;
        }
        if ( iSS )
        {
            return SPELL_SEE_INVISIBILITY;
        }        
    }
    return 0;
}

int GetHasVisionSpells( object oC=OBJECT_SELF )
{
    if ( GetHasSpell( SPELL_DARKVISION, oC ) )
    {
        return TRUE;
    }
    if ( GetHasSpell( SPELL_SEE_INVISIBILITY, oC ) )
    {
        return TRUE;
    }
    if ( GetHasSpell( SPELL_TRUE_SEEING, oC ) )
    {
        return TRUE;
    }
    return FALSE;
}

int GenerateFastBuffList( object oCaster=OBJECT_SELF )
{
    int iCnt = 0;
    int iCnt2 = 0;
    int iS = -1;

    if ( GetHasSpell( SPELLABILITY_DRAGON_FEAR, oCaster ) && !GetHasSpellEffect( SPELLABILITY_DRAGON_FEAR, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_DRAGON_FEAR );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_BLINDING, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_BLINDING, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_BLINDING );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_COLD, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_COLD, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_COLD );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_ELECTRICITY, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_ELECTRICITY, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_ELECTRICITY );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_FEAR, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_FEAR, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_FEAR );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_FIRE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_FIRE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_FIRE );
    }    
    if ( GetHasSpell( SPELLABILITY_AURA_MENACE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_MENACE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_MENACE );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_OF_COURAGE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_OF_COURAGE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_OF_COURAGE );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_PROTECTION, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_PROTECTION, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_PROTECTION );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_STUN, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_STUN, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_STUN );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_UNEARTHLY_VISAGE, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_UNEARTHLY_VISAGE, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_UNEARTHLY_VISAGE );
    }
    if ( GetHasSpell( SPELLABILITY_AURA_UNNATURAL, oCaster ) && !GetHasSpellEffect( SPELLABILITY_AURA_UNNATURAL, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_AURA_UNNATURAL );
    }
    if ( GetHasSpell( SPELLABILITY_EMPTY_BODY, oCaster ) && !GetHasSpellEffect( SPELLABILITY_EMPTY_BODY, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_EMPTY_BODY );
    }
    if ( GetHasSpell( SPELLABILITY_TYRANT_FOG_MIST, oCaster ) && !GetHasSpellEffect( SPELLABILITY_TYRANT_FOG_MIST, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_TYRANT_FOG_MIST );
    }

    if ( GetHasSpell( SPELLABILITY_RAGE_5, oCaster ) && !GetHasSpellEffect( SPELLABILITY_RAGE_5, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_RAGE_5 );
    }
    else if ( GetHasSpell( SPELLABILITY_RAGE_4, oCaster ) && !GetHasSpellEffect( SPELLABILITY_RAGE_4, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_RAGE_4 );
    }
    else if ( GetHasSpell( SPELLABILITY_RAGE_3, oCaster ) && !GetHasSpellEffect( SPELLABILITY_RAGE_3, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_RAGE_3 );
    }

    if ( GetHasSpell( SPELLABILITY_FEROCITY_3, oCaster ) && !GetHasSpellEffect( SPELLABILITY_FEROCITY_3, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_FEROCITY_3 );
    }
    else if ( GetHasSpell( SPELLABILITY_FEROCITY_2, oCaster ) && !GetHasSpellEffect( SPELLABILITY_FEROCITY_2, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_FEROCITY_2 );
    }
    else if ( GetHasSpell( SPELLABILITY_FEROCITY_1, oCaster ) && !GetHasSpellEffect( SPELLABILITY_FEROCITY_1, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_FEROCITY_1 );
    }

    if ( GetHasSpell( SPELLABILITY_INTENSITY_3, oCaster ) && !GetHasSpellEffect( SPELLABILITY_INTENSITY_3, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_INTENSITY_3 );
    }
    else if ( GetHasSpell( SPELLABILITY_INTENSITY_2, oCaster ) && !GetHasSpellEffect( SPELLABILITY_INTENSITY_2, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_INTENSITY_2 );
    }
    else if ( GetHasSpell( SPELLABILITY_INTENSITY_1, oCaster ) && !GetHasSpellEffect( SPELLABILITY_INTENSITY_1, oCaster ) )
    {
        SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), SPELLABILITY_INTENSITY_1 );
    }

    iCnt2 = 1;
    while ( ( iS = GetLocalInt( oCaster, "#SPN_FB" + IntToString( iCnt2++ ) ) ) )
    {
        //cater for Acid Fog value even though creatures should not be
        //fast buffing this spell
        if ( iS == 10000 ) //temp value for acid fog
        {
            iS = SPELL_ACID_FOG;
        }
        if ( GetHasSpell( iS, oCaster ) )
        {
            SetLocalInt( oCaster, "#SPL_FB" + IntToString( ++iCnt ), iS );
        }
    }

    return iCnt;
}

float GetSpellRange( int iS )
{
	//NOTE: currently only includes area spells
	
    if ( iS < 0 )
    {
        //not valid
        return -1.0;
    }

    if ( iS == SPELL_ACID_FOG || iS == SPELL_CALL_LIGHTNING || iS == SPELL_CHAIN_LIGHTNING ||
        iS == SPELL_CLOUDKILL || iS == SPELL_DARKNESS || iS == SPELL_ENTANGLE || iS == SPELL_FIREBALL ||
        iS == SPELL_GREASE || iS == SPELL_INCENDIARY_CLOUD || iS == SPELL_MIND_FOG || iS == SPELL_SOUND_BURST ||
        iS == SPELL_ICE_STORM || iS == SPELL_BANE || iS == SPELL_SPIKE_GROWTH || iS == SPELL_BOMBARDMENT || 
        iS == SPELL_ISAACS_LESSER_MISSILE_STORM || iS == SPELL_ISAACS_GREATER_MISSILE_STORM )
    {
        return 40.0;
    }
    else if ( iS == SPELL_BLADE_BARRIER || iS == SPELL_CIRCLE_OF_DEATH || iS == SPELL_CIRCLE_OF_DOOM || iS == SPELL_CONFUSION || 
        iS == SPELL_DELAYED_BLAST_FIREBALL || iS == SPELL_FLAME_STRIKE || iS == SPELL_HAMMER_OF_THE_GODS ||
        iS == SPELL_LIGHTNING_BOLT || iS == SPELL_MASS_BLINDNESS_AND_DEAFNESS || //iS == SPELL_MASS_DOMINATION ||
        iS == SPELL_SLEEP || iS == SPELL_STINKING_CLOUD || iS == SPELL_SUNBEAM || iS == SPELL_WALL_OF_FIRE ||
        iS == SPELL_WEB || iS == SPELL_WORD_OF_FAITH || iS == SPELL_CREEPING_DOOM || iS == SPELL_HORRID_WILTING ||
        iS == SPELL_NEGATIVE_ENERGY_BURST || iS == SPELL_EVARDS_BLACK_TENTACLES || iS == SPELL_FEAR || 
        iS == SPELL_GUST_OF_WIND || iS == SPELL_SUNBURST || iS == SPELL_FIREBRAND )
    {
        return 20.0;
    }
    else if ( iS == SPELL_IMPLOSION || iS == SPELL_MASS_CHARM || iS == SPELL_POWER_WORD_KILL ||
        iS == SPELL_POWER_WORD_STUN || iS == SPELL_SLOW || iS == SPELL_WAIL_OF_THE_BANSHEE || iS == SPELL_WEIRD ||
        iS == SPELL_PRISMATIC_SPRAY || iS == SPELL_CONE_OF_COLD || iS == SPELL_BURNING_HANDS || iS == SPELL_COLOR_SPRAY || 
        IsCone( iS ) )
    {
        return 8.5;
    }
    else
    {
        //personal ranges
        return 0.0;
    }
}

int IsCone( int iS=0 )
{
	if ( iS == SPELLABILITY_CONE_ACID )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_CONE_COLD )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_CONE_DISEASE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_CONE_FIRE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_CONE_POISON )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_CONE_SONIC )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_GOLEM_BREATH_GAS )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_BREATH_PETRIFY )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_MINDBLAST )
	{
		return TRUE;
	}
	if ( iS == SPELL_PRISMATIC_SPRAY )
	{
		return TRUE;
	}
	if ( iS == SPELL_CONE_OF_COLD )
	{
		return TRUE;
	}
	if ( iS == SPELL_MESTILS_ACID_BREATH )
	{
		return TRUE;
	}
	if ( iS == SPELL_BURNING_HANDS )
	{
		return TRUE;
	}
	if ( iS == SPELL_COLOR_SPRAY )
	{
		return TRUE;
	}
	if ( iS = SPELL_BEH_ANTIMAGIC_CONE )
	{
		return TRUE;
	}
	return FALSE;
}

int IsDragonBreath( int iS=0 )
{
	if ( iS == SPELLABILITY_DRAGON_BREATH_ACID )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_COLD )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_FEAR )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_FIRE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_GAS )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_LIGHTNING )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_NEGATIVE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_PARALYZE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_SLEEP )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_SLOW )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_WEAKEN )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_RDD )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_DRAGON_BREATH_PRISMATIC )
	{
		return TRUE;
	}
	return FALSE;
}

int IsHowl( int iS=0 )
{
	if ( iS == SPELLABILITY_HOWL_CONFUSE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_HOWL_DAZE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_HOWL_DEATH )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_HOWL_DOOM )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_HOWL_FEAR )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_HOWL_PARALYSIS )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_HOWL_SONIC )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_HOWL_STUN )
	{
		return TRUE;
	}
	return FALSE;
}

int IsPulse( int iS=0 )
{
	if ( iS == SPELLABILITY_PULSE_ABILITY_DRAIN_CHARISMA )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_ABILITY_DRAIN_CONSTITUTION )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_ABILITY_DRAIN_DEXTERITY )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_ABILITY_DRAIN_INTELLIGENCE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_ABILITY_DRAIN_STRENGTH )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_ABILITY_DRAIN_WISDOM )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_COLD )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_DEATH )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_DISEASE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_DROWN )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_FIRE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_HOLY )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_LEVEL_DRAIN )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_LIGHTNING )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_NEGATIVE )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_POISON )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_SPORES )
	{
		return TRUE;
	}
	if ( iS == SPELLABILITY_PULSE_WHIRLWIND )
	{
		return TRUE;
	}
	return FALSE;
}

void InitializeBeholderRaySelection( object oB=OBJECT_SELF )
{
	int iC = BEHOLDER_MAX_RAYS;
	int iR;
	int iT;
	
	SetLocalInt( oB, "BRTMP1", SPELL_BEHRAY_FINGER_OF_DEATH );
	SetLocalInt( oB, "BRTMP2", SPELL_BEHRAY_TELEKINESIS );
	SetLocalInt( oB, "BRTMP3", SPELL_BEHRAY_FLESH_TO_STONE );
	SetLocalInt( oB, "BRTMP4", SPELL_BEHRAY_CHARM );
	SetLocalInt( oB, "BRTMP5", SPELL_BEHRAY_SLOW );
	SetLocalInt( oB, "BRTMP6", SPELL_BEHRAY_INFLICT_WOUNDS );
	SetLocalInt( oB, "BRTMP7", SPELL_BEHRAY_FEAR );
	//adding 3 additional rays for 10 per round
	//adding an additional inflict wounds, telekinesis and slow
	if ( iC > 7 )
	{
		SetLocalInt( oB, "BRTMP8", SPELL_BEHRAY_TELEKINESIS );
		SetLocalInt( oB, "BRTMP9", SPELL_BEHRAY_SLOW );
		SetLocalInt( oB, "BRTMP10", SPELL_BEHRAY_INFLICT_WOUNDS );
	}
	
	while ( iC > 0 )
	{
		iR = Random( iC ) + 1;
		SetLocalInt( oB, "#BEHRAY" + IntToString( iC ), GetLocalInt( oB, "BRTMP" + IntToString( iR ) ) );
		for ( iT = iR; iT < iC; iT++ )
		{
			SetLocalInt( oB, "BRTMP" + IntToString( iT ), GetLocalInt( oB, "BRTMP" + IntToString( iT + 1 ) ) );
		}
		DeleteLocalInt( oB, "BRTMP" + IntToString( iT ) );
		iC--;
	}
}

void ClearBeholderRaySelection( object oB=OBJECT_SELF )
{
	int iC;
	
	for ( iC = 1; iC < BEHOLDER_MAX_RAYS + 1; iC++ )
	{
		DeleteLocalInt( oB, "#BEHRAY" + IntToString( iC ) );
	}
}

void RemoveBeholderRayFromSelection( int iS=0, object oB=OBJECT_SELF )
{
	int iC = 0;
	int iR = -1;
	
	while ( iR != iS && iC < BEHOLDER_MAX_RAYS + 1 )
	{
		iR = GetLocalInt( oB, "#BEHRAY" + IntToString( ++iC ) );
	}
	if ( iR == iS )
	{
		while ( ( iR = GetLocalInt( oB, "#BEHRAY" + IntToString( iC + 1 ) ) ) != 0 )
		{
			SetLocalInt( oB, "#BEHRAY" + IntToString( iC++ ), iR );
		}
		DeleteLocalInt( oB, "#BEHRAY" + IntToString( iC ) );
	}
}

//currently just grabs a random ray
//more intelligence matching of rays to targets will be added in the near future
int MatchRayToTarget( object oT, object oB=OBJECT_SELF )
{
	int iC;
	int iR;
	int iT = 0;
	
	while ( GetLocalInt( oB, "#BEHRAY" + IntToString( ++iT ) ) != 0 )
	{
		iC++;
	}
	iR = Random( iC ) + 1;
	iR = GetLocalInt( oB, "#BEHRAY" + IntToString( iR ) );
	
	return iR;
}