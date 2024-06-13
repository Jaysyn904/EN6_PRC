//constants

//can broadcasting use DM channel
const int NO_CAN_USE_DM_CHANNEL     = 1;

//broadcast constants
const int BC_FIGHTING               = 699;

//effect weights
const int NO_EFFECT_GENERIC         = 1;
const int NO_EFFECT_DISEASE         = 2;
const int NO_EFFECT_CURSE           = 4;
const int NO_EFFECT_POISON          = 8;
const int NO_EFFECT_DEAF            = 16;
const int NO_EFFECT_BLINDNESS       = 32;
const int NO_EFFECT_SILENCE         = 64;
const int NO_EFFECT_NEGATIVELEVEL   = 128;
const int NO_EFFECT_DAZED           = 256;
const int NO_EFFECT_FRIGHTENED      = 512;
const int NO_EFFECT_CONFUSED        = 1024;
const int NO_EFFECT_CHARMED         = 2048;
const int NO_EFFECT_SLEEP           = 4096;
const int NO_EFFECT_STUNNED         = 8192;
const int NO_EFFECT_DOMINATED       = 16384;
const int NO_EFFECT_PETRIFY         = 32768;
const int NO_EFFECT_PARALYZE        = 65536;

//spell level cut offs
const int NO_LVL8_MIN_LVL           = 24;
const int NO_LVL7_MIN_LVL           = 21;
const int NO_LVL6_MIN_LVL           = 18;
const int NO_LVL5_MIN_LVL           = 15;
const int NO_LVL4_MIN_LVL           = 12;
const int NO_LVL3_MIN_LVL           = 9;
const int NO_LVL2_MIN_LVL           = 6;
const int NO_LVL1_MIN_LVL           = 3;

//associate orders
const int NO_ORDER_ATTACK           = 1;
const int NO_ORDER_FOLLOW           = 2;
const int NO_ORDER_GUARD            = 4;
const int NO_ORDER_HEAL             = 8;
const int NO_ORDER_STANDGROUND      = 16;

//voice chat defines
const int NO_VC_DEFAULT             = 1000;
const int NO_VC_MELEE               = 1001;
const int NO_VC_RANGED              = 1003;
const int NO_VC_MELEEASSIST         = 1004;

//perception types
const int NO_PERCEPTION_SEEN        = 1;
const int NO_PERCEPTION_HEARD       = 2;
const int NO_PERCEPTION_VANISHED    = 4;

//special attack minimum hit dice ratios
const float NO_THRESH_SMITE             = 0.75;
const float NO_THRESH_STUNNING_FIST     = 0.5;
const float NO_THRESH_QUIVERING_PALM    = 0.75;
const float NO_THRESH_ARROW_SLAYING     = 0.75;
const float NO_THRESH_KI_DAMAGE         = 0.5;

//illithid abilities
const int CODI_MIND_BLAST           = 1522;
const int CODI_BRAIN_EXTRACT        = 1523;

//beholder constants
const int BEHOLDER_MAX_RAYS                 = 10;
const int SPELL_BEHRAY_FINGER_OF_DEATH      = 776;
const int SPELL_BEHRAY_TELEKINESIS          = 777;
const int SPELL_BEHRAY_FLESH_TO_STONE       = 778;
const int SPELL_BEHRAY_CHARM                = 779;
const int SPELL_BEHRAY_SLOW                 = 780;
const int SPELL_BEHRAY_INFLICT_WOUNDS       = 783;
const int SPELL_BEHRAY_FEAR                 = 784;
const int SPELL_BEH_ANTIMAGIC_CONE          = 727;

//missing epic spell definition
const int SPELL_EPIC_WARDING                = 695;

//miscellaneous missing constants
const int SPELLABILITY_DRAGON_BREATH_RDD        = 690;
const int SPELLABILITY_DRAGON_BREATH_PRISMATIC  = 771;
const int SPELLABILITY_DEFLECTING_FORCE         = 774;

//string constants
const string s_BEHOLDER_CENTRAL_EYE_FLAG        = "#BEHCENEYE";

//Master prototype list

// NO_LIB_ACTIONS
// support functions
void NO_ActionCastSpellAtLocation( int iSpell, location lTargetLocation, int iMetaMagic=METAMAGIC_ANY, int iCheat=FALSE, int iProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int iInstantSpell=FALSE, int iDefensive=TRUE );
void NO_ActionCastSpellAtObject( int iSpell, object oTarget, int iMetaMagic=METAMAGIC_ANY, int iCheat=FALSE, int iDomainLevel=0, int iProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int iInstantSpell=FALSE, int iDefensive=TRUE );
void NO_ActionUseTalentAtLocation( talent tChosenTalent, location lTargetLocation, int iDefensive=TRUE );
void NO_ActionUseTalentOnObject( talent tChosenTalent, object oTarget, int iDefensive=TRUE );
void ActivateCombatMode( int iMode=0, object oE=OBJECT_SELF );
void DeactivateCombatModes( int iException=0, object oE=OBJECT_SELF );
int DoHideInPlainSight( object oE=OBJECT_SELF );
void DoFireBeholderRay( int iS, object oT );
void DoMoveToLocation( location lDest, int bRun=FALSE );
void DoMoveToObject( object oDest, int bRun=FALSE, float fDist=1.0f );
void DoTeleport( location lLoc );
object GetTarget();
float DotProduct( vector v1, vector v2 );
location GetFlankLoc( object oT, location lL );
void DoEquipMelee( object oT );
talent GetTalentSpell( int iCat, int iD );
void DoFightBroadcast();
int GetTimeSinceLastCombat();
void DoConditionalRestart( float fT=6.0 );
void DoQueueShutdown( float fT=0.0 );
void DoQueueCombat( float fD=6.0, float fT=6.0 );
void InitCombat( object oE=OBJECT_INVALID );
void DoVoiceChat( int iV=-1 );
void DoMainCombatLoop();
void DoCombat();
// action functions
int DoAttackMelee( object oT=OBJECT_INVALID );
int DoAttackRanged( object oT=OBJECT_INVALID );
int DoCounterSpell( object oT=OBJECT_INVALID );
int DoEvacAOE();
int DoRegroup( object oT=OBJECT_INVALID );
int DoDefendSelf();
int DoDefendSingle( object oT=OBJECT_INVALID );
int DoEnhanceSelf();
int DoEnhanceSingle( object oT=OBJECT_INVALID );
int DoSpellHelp( object oT=OBJECT_INVALID );
int DoSpellHeal( object oT=OBJECT_INVALID );
int DoSpellRaise( object oT=OBJECT_INVALID );
int DoSpellBreach( object oT=OBJECT_INVALID );
int DoSpellDirect( object oT=OBJECT_INVALID );
int DoTouch( object oT=OBJECT_INVALID );
int DoSpellArea();
int DoSpellSummon();
int DoSpellCharm();
int DoFeatEnhance();
int DoAvoidMelee();
int DoTimeStop();
int DoVision();
int DoBreathWeapon();
int DoTurning();
int DoSpellCone();
int DoHealSelf();
int DoSpellGroupEnhance();
int DoSpellGroupHeal();
int DoDispelPersAOE();
int DoDispelSingle();
int DoDismissal();
int DoFastBuffs();
int DoMeleeAssist();
int DoFlank( object oE=OBJECT_INVALID );
int DoMindBlast();
int DoBrainExtraction();
int DoAvoidEnemies();
int DoGrenade();
int DoBeholderRays();
int DoBeholderCentralEye();

// NO_LIB_ANALYSIS
int GetAOEThreat( object oArea, object oEnt=OBJECT_SELF );
int GetAOECount( float fRad=10.0f, object oEnt=OBJECT_SELF );
vector GetAOEVector( float fRad=10.0f, object oEnt=OBJECT_SELF );
int GetHostileAOECount( float fRad=10.0f, object oEnt=OBJECT_SELF );
vector GetHostileAOEVector( float fRad=10.0f, object oEnt=OBJECT_SELF );
vector GetAOEEvacVector( vector vS, object oEnt=OBJECT_SELF );
object GetMostDamagedAlly( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE );
object GetLowestHPAlly( float fRad=15.0, int iLim=0, object oEnt=OBJECT_SELF, int iSee=FALSE );
object GetLowestHPAllyNoHealer( float fRad=15.0, int iLim=0, object oEnt=OBJECT_SELF, int iSee=FALSE, int iLive=TRUE );
object GetNearestDeadAlly( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE );
object GetNearestDeadAllyNoRaiser( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE );
object GetNearestPetrifiedAllyNoHelper( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE );
int GetEffectsOnObject( object oEnt=OBJECT_SELF );
object GetMostHamperedAlly( float fRad=15.0f, object oEnt=OBJECT_SELF, int iSee=FALSE );
vector GetAreaTarget( int iS, float fRad, float fMinRad=7.5, float fMaxRad=30.0, int iEffChk=TRUE, object oCaster=OBJECT_SELF );
vector GetFriendlyAreaTarget( float fRad, int iSpell=0, int iType=0, object oCaster=OBJECT_SELF );
int CanAct( object oSelf=OBJECT_SELF );
int GetIsWeapon( object oWeapon );
int GetIsLightWeapon( object oWeapon, int iCanBeInvalid=FALSE );
int GetIsDoubleWeapon( object oWeapon );
int GetCasterCount( float fRad=5.0, object oEnt=OBJECT_SELF );
int GetAttackerCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF );
int GetHostileCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF );
int GetOmniscientHostileCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF );
int GetAllyCount( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF );
int GetAttackerHD( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF );
int GetHostileHD( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF );
int GetAllyHD( float fRad=5.0, object oEnt=OBJECT_SELF, object oS=OBJECT_SELF );
vector GetHostileVector( float fRad=10.0f, object oEnt=OBJECT_SELF );
vector GetHostileEvacVector( vector vS, object oEnt=OBJECT_SELF );
int GetIsCaster( object oEnt=OBJECT_SELF );
int DoAbilityCheck( int iAbil, int iDC, object oEnt=OBJECT_SELF );
int DoCombatKnowledgeCheck( int iBAB=FALSE, int iDC=10, object oE=OBJECT_SELF );
float GetFriendFoeRatio( location lLoc, float fRad, object oEnt=OBJECT_SELF );
float GetFriendFoeTolerance( object oEnt=OBJECT_SELF );
object GetNearestEnemyCaster( int iMaxLvl=20, int iMinLvl=1, object oEnt=OBJECT_SELF );
int GetAverageEnemyLevel( float fRad=60.0, object oEnt=OBJECT_SELF );
int GetSafeAverageEnemyLevel( float fRad=40.0, object oEnt=OBJECT_SELF );
object GetLeastMagicDefendedEnemy( float fRad=5.0, object oEnt=OBJECT_SELF );
vector GetTurningVector( object oEnt=OBJECT_SELF );
int GetIsValidTurnTarget( object oT, int iL=0, object oEnt=OBJECT_SELF );
int GetPotionHealAmount( object oP );
int GetTalentPotionHealAmount( talent tP );
vector GetAreaHealTarget( float fRad=0.0, int iH=0, object oEnt=OBJECT_SELF );
float GetAllyDamageStats( location lT, float fRad=0.0, object oEnt=OBJECT_SELF );
object GetMostBuffedEnemy( float fRad=10.0, object oEnt=OBJECT_SELF );
object GetLeastBuffedAlly( float fRad=10.0, int iMelee=FALSE, object oEnt=OBJECT_SELF );
int GetIsBuffEffect( effect eT );
int GetAverageEffectCasterLevel( object oT=OBJECT_SELF );
object GetStrongestEnemySummonedAssociateOwner( float fRad=10.0, object oEnt=OBJECT_SELF );
vector GetEnemySummonedAssociatesVector( float fRad=10.0, object oEnt=OBJECT_SELF );
vector GetEnemyPlanarVector( float fRad=10.0, object oEnt=OBJECT_SELF );
object GetVisionDeprived( float fRad=10.0, object oT=OBJECT_SELF );
object GetLeastDefendedAlly( float fRad=10.0, object oC=OBJECT_SELF );
int GetHasRangedCapability( object oEnt=OBJECT_SELF );
int GetIsRangedWeapon( object oW=OBJECT_INVALID );
object GetMostDistantEnemy( float fR=30.0, int iS=TRUE, object oC=OBJECT_SELF );
vector GetSaves( object oT=OBJECT_SELF );
vector GetBaseSavesByClass( int iC, int iL );
vector GetAverageEnemySaveInArea( vector vP, float fR=5.0, object oC=OBJECT_SELF );
int IsImmuneToPetrification(object oCreature);
object GetNearestAddledEnemy( float fRange=10.0, object oE=OBJECT_SELF );
object GetNearestAddledEnemyNoExtractor( float fRange=10.0, object oE=OBJECT_SELF );
int IsBrainExtractable( object oT );
int GetCreatureAttackBonus( object oC=OBJECT_SELF );
int GetGrappleBonus( object oC=OBJECT_SELF );
int GetIsMaster( object oM, object oE=OBJECT_SELF );
int GetIsPerceived( object oP, int iP=0, object oE=OBJECT_SELF );
object GetNearestPerceivedCreature( int iP=NO_PERCEPTION_SEEN, object oE=OBJECT_SELF );
object GetNearestActiveAlly( object oE=OBJECT_SELF );
object GetFurthestActiveAlly( float fD=50.0, object oE=OBJECT_SELF );
int EstimateAttackBonus( object oC=OBJECT_SELF );
int GetDualWieldingPenalty( object oC=OBJECT_SELF, object oR=OBJECT_INVALID, object oL=OBJECT_INVALID );
int GetHasWeaponFocus( object oR, object oC=OBJECT_SELF );
int GetIsArmed( object oEnt=OBJECT_SELF );
int GetRelativeEnemyWeaponSize( object oT, object oEnt=OBJECT_SELF );
int GetWeaponSize( object oEnt=OBJECT_SELF );
float GetAverageDistanceToEnemy( float fRad=60.0, object oEnt=OBJECT_SELF );
int GetCombatModeModifier( int iMode=0 );
int GetCombatConcentration( object oE=OBJECT_SELF );
int GetTurningLevel( object oC=OBJECT_SELF );
void SetIsCentralEyeOpen( int iS=FALSE, object oB=OBJECT_SELF );
int GetIsCentralEyeOpen( object oB=OBJECT_SELF );

// NO_LIB_FEAT
int GetEnhanceFeat( object oEnt=OBJECT_SELF );
int GetGroupEnhanceFeat( object oEnt=OBJECT_SELF );
float GetGroupEnhanceFeatRadius( int iFeat );

// NO_LIB_MAGIC
int GetBestMagicDefenseSelf( object oEnt=OBJECT_SELF );
int GetBestMagicDefenseSingle( object oEnt=OBJECT_SELF, object oC=OBJECT_SELF );
int GetBestPhysDefenseSelf( object oEnt=OBJECT_SELF );
int GetBestPhysDefenseSingle( object oEnt=OBJECT_SELF, object oC=OBJECT_SELF );
int GetBestGenericProtection( object oEnt=OBJECT_SELF );
struct sSpellDefStatus EvaluateSpellDefenses( object oTarget=OBJECT_SELF );
struct sPhysDefStatus EvaluatePhysicalDefenses( object oTarget=OBJECT_SELF );
int GetBestHeal( object oEnt=OBJECT_SELF, int iMin=10 );
int GetGroupHealSpell( int iMinLvl=0, object oCaster=OBJECT_SELF );
int GetGroupHealSpellAmount( int iH=0, object oCaster=OBJECT_SELF );
float GetGroupHealSpellRadius( int iH=0 );
int GetBestRaise( int iCombat=FALSE );
int GetHasHealingAbility( object oCaster=OBJECT_SELF );
int GetHasRaisingAbility( object oCaster=OBJECT_SELF );
int GetHasHelpingAbility( object oCaster=OBJECT_SELF );
int GetBestHelp( object oEnt, object oCaster=OBJECT_SELF );
int GetAreaSpell( vector vS, int iDisc=FALSE, int iMinLvl=0, float fR=40.0, object oCaster=OBJECT_SELF );
float GetAreaSpellRadius( int iSpell );
int GetDirectSpell( object oT, int iDisc=FALSE, int iMinLvl=0, object oCaster=OBJECT_SELF );
int GetTouchSpell( object oT, int iMinLvl=0, object oCaster=OBJECT_SELF );
int GetSummonSpell( int iMinLvl=1, object oCaster=OBJECT_SELF );
int GetEnhanceSpellSelf( int iMinLvl=1, object oCaster=OBJECT_SELF );
int GetEnhanceSpellSingle( int iMinLvl=1, object oEnt=OBJECT_SELF, object oCaster=OBJECT_SELF );
int GetBestBreach( int iLim=30, object oEnt=OBJECT_SELF );
int GetBestDispel( int iCLvl=20, int iDLvl=20, object oEnt=OBJECT_SELF );
int GetIsDiscriminantSpell( int iSpell );
int GetBreathWeapon( object oEnt=OBJECT_SELF );
int GetConeSpell( int iMinLvl = 1, object oCaster=OBJECT_SELF );
int GetGroupEnhanceSpell( int iMinLvl = 1, object oCaster=OBJECT_SELF );
float GetGroupEnhanceSpellRadius( int iSpell );
int GetDispelSpell( object oEnt=OBJECT_SELF );
int GetMaxDispelCasterLevel( object oEnt=OBJECT_SELF );
int GetVisionSpellNeeded( object oS=OBJECT_SELF, object oC=OBJECT_SELF );
int GetHasVisionSpells( object oC=OBJECT_SELF );
int GenerateFastBuffList( object oC=OBJECT_SELF );
float GetSpellRange( int iS );
int IsCone( int iS=0 );
int IsDragonBreath( int iS=0 );
int IsHowl( int iS=0 );
int IsPulse( int iS=0 );
void InitializeBeholderRaySelection( object oB=OBJECT_SELF );
void ClearBeholderRaySelection( object oB=OBJECT_SELF );
void RemoveBeholderRayFromSelection( int iS=0, object oB=OBJECT_SELF );
int MatchRayToTarget( object oT, object oB=OBJECT_SELF );

// NO_LIB_MELEE
int GetBestMeleeSpecial( object oTarget, int iPenalty=0, int iChance=50, object oEnt=OBJECT_SELF );
int SelectMeleeCombatModes( object oT, int iC=50, object oEnt=OBJECT_SELF );

// NO_LIB_RANGED
int GetBestRangedSpecial( object oTarget, int iPenalty=0, int iChance=50, object oEnt=OBJECT_SELF );
int SelectRangedCombatModes( object oT, int iC=50, object oEnt=OBJECT_SELF );

// NO_LIB_PRIORITY
void AddBehaviour( string sB, int iC, object oEnt=OBJECT_SELF );
string GetPriority( int iP=1, object oEnt=OBJECT_SELF );
int GetPriorityChance( int iP=1, object oEnt=OBJECT_SELF );
void SetVoiceChat( int iV, int iC, object oE=OBJECT_SELF );
float GetFollowDist( object oE=OBJECT_SELF );
void SetPerceptionRange( int iP, float fP=50.0, object oE=OBJECT_SELF );
void SetPerceptionRanges( float fS=50.0, float fH=50.0, float fV=50.0, object oE=OBJECT_SELF );
float GetPerceptionRange( int iP, object oE=OBJECT_SELF );
void SetReadyStatus( int iS=1, object oE=OBJECT_SELF );
int IsReadyToAct( object oE=OBJECT_SELF );
int ShortAction( object oE=OBJECT_SELF );
int IsActive( object oE=OBJECT_SELF );
void SetActive( object oE=OBJECT_SELF );
void SetIsActive( int iA=TRUE, object oE=OBJECT_SELF );
float GetResponseRange( int iT, object oE=OBJECT_SELF );
void SetResponseRange( int iT, float fR=50.0, object oE=OBJECT_SELF );
void SetIsTeleporter( object oE=OBJECT_SELF );
int GetIsTeleporter( object oE=OBJECT_SELF );
void SetIsFastBuffer( int iS, object oE=OBJECT_SELF );
int GetIsFastBuffer( object oE=OBJECT_SELF );
void SetIsFastBuffed( int iS, object oE=OBJECT_SELF );
int GetIsFastBuffed( object oE=OBJECT_SELF );
void AddFastBuff( int iS, object oE=OBJECT_SELF );
int CountFastBuffs( object oE=OBJECT_SELF );
void SetLastAction( string sA, object oE=OBJECT_SELF );
string GetLastAction( object oE=OBJECT_SELF );
void SetLastActionTimestamp( object oE=OBJECT_SELF );
int GetLastActionTimestamp( object oE=OBJECT_SELF );
void SetCorpseDelay( int iT=60, object oC=OBJECT_SELF );
void SetIsFlier( int iF=FALSE, object oF=OBJECT_SELF );
int GetIsFlier( object oF=OBJECT_SELF );

// NO_LIB_BIO
void SetSpawnInCondition(int nCondition, int bValid = TRUE);
int GetSpawnInCondition(int nCondition);
void SetSpawnInLocals(int nCondition);
void SetListeningPatterns();
void WalkWayPoints(int nRun = FALSE, float fPause = 1.0);
void RunNextCircuit(int nRun = FALSE, float fPause = 1.0);
void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0);
int CheckWayPoints(object oWalker = OBJECT_SELF);
int GetIsPostOrWalking(object oWalker = OBJECT_SELF);
//void SetBehaviorState(int nCondition, int bValid = TRUE);
//int GetBehaviorState(int nCondition);
void PlayMobileAmbientAnimations();
//void PlayImmobileAmbientAnimations();
void DetermineSpecialBehavior(object oIntruder = OBJECT_INVALID);
void ClearActions(int nClearConstant=0, int bClearCombat=FALSE);
//SoU animation craziness
void AnimDebug(string sMsg);
int GetAnimationCondition(int nCondition, object oCreature=OBJECT_SELF);
void SetAnimationCondition(int nCondition, int bValid=TRUE, object oCreature=OBJECT_SELF);
int GetIsBusyWithAnimation(object oCreature);
object GetRandomFriend(float fMaxDistance);
object GetRandomObjectByTag(string sTag, float fMaxDistance);
object GetRandomObjectByType(int nObjType, float fMaxDistance);
object GetRandomStop(float fMaxDistance);
void SetCreatureHomeWaypoint();
object GetCreatureHomeWaypoint();
void SetCurrentFriend(object oFriend);
object GetCurrentFriend();
void SetCurrentInteractionTarget(object oTarget);
object GetCurrentInteractionTarget();
void CheckIsCivilized();
void CheckCurrentModes();
int CheckIsAnimActive(object oCreature);
int CheckCurrentAction();
void AnimInitialization();
void PlayMobileAmbientAnimations_NonAvian();
void PlayMobileAmbientAnimations_Avian();
void PlayImmobileAmbientAnimations();
void AnimActionPlayRandomImmobile();
void AnimActionPlayRandomCloseRange();
void AnimActionPlayRandomMobile();
void AnimActionPlayRandomUncivilized();
void AnimActionStartInteracting(object oPlaceable);
void AnimActionStopInteracting();
void AnimActionStartTalking(object oFriend, int nHDiff=0);
void AnimActionStopTalking(object oFriend, int nHDiff=0);
void AnimActionPlayRandomGreeting(int nHDiff=0);
void AnimActionPlayRandomGoodbye(int nHDiff);
void AnimActionRandomMoveAway(object oSource, float fDistance);
void AnimActionShakeHead();
void AnimActionLookAround();
void AnimActionTurnAround();
void AnimActionGoThroughDoor(object oDoor);
int AnimActionCloseRandomDoor();
int AnimActionSitInChair(float fMaxDistance);
int AnimActionGetUpFromChair();
int AnimActionGoInside();
int AnimActionGoOutside();
int AnimActionGoToStop(float fMaxDistance);
int AnimActionFindFriend(float fMaxDistance);
int AnimActionFindPlaceable(float fMaxDistance);
int AnimActionRest();
int AnimActionGoHome();
int AnimActionLeaveHome();
int AnimActionChallengeIntruder();
void AnimActionPlayRandomInteractAnimation(object oPlaceable);
void AnimActionPlayRandomTalkAnimation(int nHDiff);
void AnimActionPlayRandomBasicAnimation();
void AnimActionPlayRandomAnimation();

int DoEN4Invis();
int DoEN4DmgShield();
int GetBestUndeadHeal( object oEnt=OBJECT_SELF, int iMin=10 );
int DoSpellUndeadHeal( object oT=OBJECT_INVALID );
int DoUndeadHealSelf( object oT=OBJECT_INVALID );
