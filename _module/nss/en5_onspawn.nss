#include "x0_i0_treasure"
#include "x0_i0_anims"
#include "x2_inc_switches"

#include "en5_misc"

void GiveSpecialItems();

void main()
{
	//Made this random after making treasure system on GetMob

	//if (Random(20)==0)
	//    CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF);
	//if (Random(20)==0)
	//    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
	if (GetLevelByClass(CLASS_TYPE_WIZARD,OBJECT_SELF) > 0 ||
		GetLevelByClass(CLASS_TYPE_SORCERER,OBJECT_SELF) > 0 ||
		GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF) > 0 ||
		GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF) > 0)
		{
		if (Random(100) < GetHitDice(OBJECT_SELF)*3)
			SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);
		}

	if (GetLevelByClass(CLASS_TYPE_WIZARD,OBJECT_SELF) > 0 ||
		GetLevelByClass(CLASS_TYPE_SORCERER,OBJECT_SELF) > 0)
		{
		if (Random(2) == 0)
			SetLocalInt(OBJECT_SELF,CREATURE_VAR_RANDOMIZE_SPELLUSE,1);

		//RANGED CAUSES SPECIAL CONVO FLAG THINGY
		//if (Random(4) > 0)
		//    SetSpawnInCondition(X0_COMBAT_FLAG_RANGED);
		}

	if (FindSubString(GetTag(OBJECT_SELF),"boss")>1)
		SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);

	if (Random(20)==0)
		SetCombatCondition(X0_COMBAT_FLAG_DEFENSIVE);

	SetIsDestroyable(TRUE, FALSE, TRUE);
	DelayCommand(1.0,SetLootable(OBJECT_SELF,TRUE));
	GiveSpecialItems();
}

void GiveSpecialItems()
{

	if (GetResRef(OBJECT_SELF)=="EN5_BEHOLDER2")
		if (Random(2)==0)
			CreateItemOnObject("en3_beye",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_BEHOLDER")
		if (Random(2)==0)
			CreateItemOnObject("en3_beye",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_RUSTMONSTER")
		if (Random(2)==0)
			CreateItemOnObject("en3_rscale",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_GELCUBE")
		if (Random(2)==0)
			CreateItemOnObject("en4_cubeooze",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_SALANOB")
		if (Random(2)==0)
			CreateItemOnObject("en3_salskin",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_WENDIGO")
		if (Random(2)==0)
			CreateItemOnObject("en3_wessence",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_MERILITH2")
		if (Random(2)==0)
			CreateItemOnObject("en4_mheart",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_GORGON")
		if (Random(2)==0)
			CreateItemOnObject("en4_gheart",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="en5_mindfdark")
		if (Random(2)==0)
			CreateItemOnObject("en4_mfstalk",OBJECT_SELF);
	if (GetResRef(OBJECT_SELF)=="EN5_GARGOYLE")
		if (Random(2)==0)
			CreateItemOnObject("NW_IT_MSMLMISC14",OBJECT_SELF);
}
