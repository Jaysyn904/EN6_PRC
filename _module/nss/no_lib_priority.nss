#include "no_inc_ptypes"

//functions
void AddBehaviour( string sB, int iC, object oEnt=OBJECT_SELF )
{
	int iL = GetLocalInt( oEnt, "PRITOTAL" ) + 1;
	
	//update count
	SetLocalInt( oEnt, "PRITOTAL", iL );
	
	//make sure the chance is valid
	iC = iC < 0 ? 0 : iC;
	iC = iC > 100 ? 100 : iC;
	
	//set up the behaviour
	SetLocalString( oEnt, "PRID_" + IntToString( iL ), sB );
	SetLocalInt( oEnt, "PRIC_" + IntToString( iL ), iC );	
}

string GetPriority( int iP=1, object oEnt=OBJECT_SELF )
{
    //retrieve priority iP
    return GetLocalString( oEnt, "PRID_" + IntToString( iP ) );
}

int GetPriorityChance( int iP=1, object oEnt=OBJECT_SELF )
{
    //retrieve priority chance iP
    return GetLocalInt( oEnt, "PRIC_" + IntToString( iP ) );
}

void SetVoiceChat( int iV, int iC, object oE=OBJECT_SELF )
{
	if ( iC < 0 )
	{
		iC = -1;
	}
	else if ( iC > 100 )
	{
		iC = 100;
	}
	if ( iV == NO_VC_DEFAULT )
	{
		if ( iC == 0 )
		{
			//delete the config for default voicechat chance
			DeleteLocalInt( oE, "#VCC" );
		}
		else
		{
			//set the config for default voicechat chance
			SetLocalInt( oE, "#VCC", iC );
		}
	}
	else
	{
		if ( iC == 0 )
		{
			//delete the config for this voicechat chance
			DeleteLocalInt( oE, "#VCC_" + IntToString( iV ) );
		}
		else
		{
			//set the config for this voicechat chance
			SetLocalInt( oE, "#VCC_" + IntToString( iV ), iC );
		}
	}
}

float GetFollowDist( object oE=OBJECT_SELF )
{
	float fF = -1.0;
	
	if ( GetIsObjectValid( oE ) )
	{
		fF = GetLocalFloat( OBJECT_SELF, "#FOLLOWDIST" );
	
		if ( fF == 0.0 )
		{
			//default distance if none is set
			fF = 3.0;
		}
	}
	return fF;
}

void SetPerceptionRange( int iP, float fP=50.0, object oE=OBJECT_SELF )
{
	if ( iP == NO_PERCEPTION_SEEN )
	{
		SetLocalFloat( oE, "#PER_SEEN_RANGE", fP );
	}
	else if ( iP == NO_PERCEPTION_HEARD )
	{
		SetLocalFloat( oE, "#PER_HEARD_RANGE", fP );
	}
	else if ( iP == NO_PERCEPTION_VANISHED )
	{
		SetLocalFloat( oE, "#PER_VANISHED_RANGE", fP );
	}
}

void SetPerceptionRanges( float fS=50.0, float fH=50.0, float fV=50.0, object oE=OBJECT_SELF )
{
	if ( fS != -1.0  )
	{
		SetLocalFloat( oE, "#PER_SEEN_RANGE", fS );
	}
	if ( fH != -1.0 )
	{
		SetLocalFloat( oE, "#PER_HEARD_RANGE", fH );
	}
	if ( fV != -1.0 )
	{
		SetLocalFloat( oE, "#PER_VANISHED_RANGE", fV );
	}
}
	
float GetPerceptionRange( int iP, object oE=OBJECT_SELF )
{
	float fP = 0.0;
	
	if ( iP == NO_PERCEPTION_SEEN )
	{
		fP = GetLocalFloat( oE, "#PER_SEEN_RANGE" );
	}
	else if ( iP == NO_PERCEPTION_HEARD )
	{
		fP = GetLocalFloat( oE, "#PER_HEARD_RANGE" );
	}
	else if ( iP == NO_PERCEPTION_VANISHED )
	{
		fP = GetLocalFloat( oE, "#PER_VANISHED_RANGE" );
	}
	//set max range if no setting found
	if ( fP == 0.0 )
	{
		fP = 50.0;
	}
	return fP;
}

void SetReadyStatus( int iS=1, object oE=OBJECT_SELF )
{
	SetLocalInt( oE, "#READYTOACT", iS );
}

int IsReadyToAct( object oE=OBJECT_SELF )
{
	return GetLocalInt( oE, "#READYTOACT" );
}

int ShortAction( object oE=OBJECT_SELF )
{
	string sAct = GetLastAction( oE );
	
	if ( sAct == "+EVACAOE" || sAct == "+REGROUP" || sAct == "+AVOIDMELEE" || sAct == "+FLANK" || sAct == "+AVOIDENEMY" )
		//|| sAct == "+EYERAYS" )
	{
		return TRUE;
	}
	return FALSE;
}

int IsActive( object oE=OBJECT_SELF )
{
	return GetLocalInt( oE, "#ACTIVE" );
}

void SetActive( object oE=OBJECT_SELF )
{
	SetLocalInt( OBJECT_SELF, "#ACTIVE", 1 );
}

void SetIsActive( int iA=TRUE, object oE=OBJECT_SELF )
{
	if ( iA == TRUE )
	{
		SetLocalInt( oE, "#ACTIVE", 1 );
	}
	else
	{
		DeleteLocalInt( oE, "#ACTIVE" );
	}
}

float GetResponseRange( int iT, object oE=OBJECT_SELF )
{
	float fR = GetLocalFloat( oE, "#RESPOND_RANGE_" + IntToString( iT ) );
	
	if ( fR == 0.0 )
	{
		//default range
		fR = 50.0;
	}
	return fR;
}

void SetResponseRange( int iT, float fR=50.0, object oE=OBJECT_SELF )
{
	float fRange = fR > 0.0 ? fR : 0.0;
	
	SetLocalFloat( oE, "#RESPOND_RANGE_" + IntToString( iT ), fRange );
}

void SetIsTeleporter( object oE=OBJECT_SELF )
{
	SetLocalInt( OBJECT_SELF, "TELEPORTER", 1 );
}

int GetIsTeleporter( object oE=OBJECT_SELF )
{
	return GetLocalInt( OBJECT_SELF, "TELEPORTER" );
}

void SetIsFastBuffer( int iS, object oE=OBJECT_SELF )
{
	if ( iS == 1 )
	{
		SetLocalInt( oE, "#FASTBUFFER", 1 );
	}
	else
	{
		DeleteLocalInt( oE, "#FASTBUFFER" );
	}
}

int GetIsFastBuffer( object oE=OBJECT_SELF )
{
	return GetLocalInt( oE, "#FASTBUFFER" );
}

void SetIsFastBuffed( int iS, object oE=OBJECT_SELF )
{
	if ( iS == 1 )
	{
		SetLocalInt( oE, "#FASTBUFFED", 1 );
	}
	else
	{
		DeleteLocalInt( oE, "#FASTBUFFED" );
	}
}

int GetIsFastBuffed( object oE=OBJECT_SELF )
{
	return GetLocalInt( oE, "#FASTBUFFED" );
}

void AddFastBuff( int iS, object oE=OBJECT_SELF )
{
	int iC = CountFastBuffs( oE ) + 1;
	
	SetLocalInt( oE, "#SPN_FB" + IntToString( iC ), iS );
}

int CountFastBuffs( object oE=OBJECT_SELF )
{
	int iC = 0;
	int iS = 1;
	
	while ( GetLocalInt( oE, "#SPN_FB" + IntToString( iS++ ) ) != 0 )
	{
		iC++;
	}
	
	return iC;
}

void SetLastAction( string sA, object oE=OBJECT_SELF )
{
	SetLocalString( oE, "#LASTACTION", sA );
}

string GetLastAction( object oE=OBJECT_SELF )
{
	return GetLocalString( oE, "#LASTACTION" );
}

void SetLastActionTimestamp( object oE=OBJECT_SELF )
{
	SetLocalInt( oE, "#LASTACTIONTIME", GetTimeSecond() );
}

int GetLastActionTimestamp( object oE=OBJECT_SELF )
{
	int iS = GetLocalInt( oE, "#LASTACTIONTIME" );
	int iT = GetTimeSecond();
	int iL = iT < iS ? iT + 60 : iT;
	
	return iL - iS;
}

void SetCorpseDelay( int iT=60, object oC=OBJECT_SELF )
{
	if ( GetRacialType( oC ) != RACIAL_TYPE_UNDEAD && GetStringLeft( GetTag( oC ), 6 ) != "NO_AI_" &&
        GetName( GetItemInSlot( INVENTORY_SLOT_CARMOUR, oC ) ) != "Gargoyle Properties" )
    {
        //not summoned, not undead, default decay time
        AssignCommand( oC, SetIsDestroyable( FALSE, TRUE, TRUE ) );
        SetLocalFloat( oC, "#DECAYDELAY", 60.0 ); //default corpse decay time
    }
}

void SetIsFlier( int iF=FALSE, object oF=OBJECT_SELF )
{
    if ( iF == TRUE || GetRacialType( oF ) == RACIAL_TYPE_DRAGON )
    {
        SetLocalInt( oF, "FLIER", 1 );
    }
    else
    {
    	DeleteLocalInt( oF, "FLIER" );
    }
}

int GetIsFlier( object oF=OBJECT_SELF )
{
	return GetLocalInt( oF, "FLIER" );
}