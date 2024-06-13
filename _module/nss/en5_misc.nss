#include "en5_include"
#include "x0_i0_anims"
#include "prc_inc_racial"

void GetError(string sError);
object GetMob(string sTag, string sEncounter, int iLevel=0, int iBoss=0);
int GetNPCClass(object oMob,int iLevel);
int GetNPCPackage(object oMob,int iLevel);
void SetupClass(object oMob,int iClass);
void LevelMob(object oMob,int iMobLevel,int iClass);
int GetMobClass(int iClass, int iLevel, int iClassPackage=1);
int GetRandomPackage(int iClass);
string GetClass(object oPC);
string GetClassByPos(object oPC, int iPos);
string GetRace(object oPC);
string GetMyZone(object oNPC=OBJECT_SELF);
void SetPartyString(object oPC,string sVariable, string sValue);
void SetPartyInt(object oPC,string sVariable, int iValue);
object GetRandomPC();
void SitInChairs(string sPrefix);
int GetItemLevel(int iLevel);
int ZoneLevel(object oArea);
string GetBoss(string sTag, int iNumber);
int ZoneMaxLevel(object oArea);
string GetZone(object oArea=OBJECT_SELF);
string GetAreaAccomplishment(object oPC);
int MaxObject(string sObject);
int GetNumberPCs();
void EquipItem(int iItemSlot,object oItem, object oCreature);
void GetTreasureOnMob(object oMob,int iLevel,int iBoss);
string ReplaceText(string sString,string sReplace,string sReplaceWith);
int GetMinLevel(string sZone);
int GetMaxLevel(string sZone);
int GetTrapType(int iLevel);
int HasRogue();
void ENSendMessageToParty(object oPC,string sMessage);
int GetNumOfHenchman(object oPC);
int GetAdjustedNumberPCs();
string ItS(int iInt);
void DBug(string sMessage);
int GetTwoHanded(string sTag);

void DBug(string sMessage)
{
DelayCommand(1.0,SendMessageToPC(GetFirstPC(),sMessage));
}

string ItS(int iInt)
{
string sString;

sString=IntToString(iInt);

return sString;
}

int GetMinLevel(string sZone)
{
int iReturn;
object oWP;

oWP=GetObjectByTag(sZone+"_INFO");
iReturn = GetLocalInt(oWP,"MinLevel");

if (iReturn<1)
    iReturn=1;

return iReturn;
}

int GetMaxLevel(string sZone)
{
	int iReturn;
	object oWP;

	oWP = GetObjectByTag(sZone+"_INFO");
	
	iReturn = GetLocalInt(oWP,"MaxLevel");

	if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    {
		iReturn++;
    
		if (iReturn > 9)
			iReturn++;
		
		if (iReturn > 22)
			iReturn++;
    }

	if (iReturn > 40)
		iReturn = 40;

	if (iReturn < 1)
		iReturn = 1;

	return iReturn;

}

void GetError(string sError)
{
	DelayCommand(0.1,SendMessageToPC(GetFirstPC(),sError));
}

object GetMob(string sTag, string sEncounter, int iLevel=0,int iBoss=0)
{
	object oMob;
	object oWP;

	oWP = GetObjectByTag(sEncounter);

	if (GetIsObjectValid(oWP))
	{
		oMob = CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(oWP),FALSE,sEncounter + "_S");
		
		if (GetLocalInt(GetModule(),"QuestSetup") == 1)
			SetLocalInt(GetModule(),sEncounter,1);
	}
	else
		GetError("Could not find location " + sEncounter);

	if (!GetIsObjectValid(oMob))
		GetError("Could not spawn mob " + sTag + " at " + sEncounter);

	//Debug Line
	//DelayCommand(0.1,SendMessageToPC(GetFirstPC(),"Spawned " + GetName(oMob) + " (" + sTag + ")."));

	if (Random(100)<GetLocalInt(GetModule(),"MobWander"))
	{
		AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS));
		AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS));
	}

	if (iBoss==TRUE)
	{
		SetLocalInt(oMob,"Boss",1);
		DelayCommand(0.1,AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY)));
	}

	if (iLevel==0)
		iLevel=GetHitDice(oMob);

	GetTreasureOnMob(oMob,iLevel,iBoss);

	return oMob;
}

void GetTreasureOnMob(object oMob,int iLevel,int iBoss)
{
	SetLocalInt(oMob,"EN5_iLevel",iLevel);
	SetLocalInt(oMob,"EN5_iBoss",iBoss);
	DelayCommand(0.5f,ExecuteScript("en5_getmobtreas",oMob));
}

void LevelHenchman(object oMob,int iMobLevel)
{
	int iIndex;
	int iClassType;
	int iPackage;
	int iLevelup;
	int iClass;

	iClass=GetLocalInt(oMob,"HenchmanClass");

	if (GetLocalInt(oMob,"SetupPackage") == 0)
	{
		SetupClass(oMob,iClass);
		SetLocalInt(oMob,"SetupPackage",1);
	}

	iIndex = 1;
	while (iIndex <= iMobLevel)
	{
		iClassType=GetNPCClass(oMob,iIndex);
		iPackage=GetNPCPackage(oMob,iIndex);
		iLevelup=LevelUpHenchman(oMob,iClassType,TRUE,iPackage);
		iIndex++;
	}
}

void LevelMob(object oMob,int iMobLevel,int iClass)
{
	int iIndex;
	int iClassType;
	int iPackage;
	int iLevelup;

	SetupClass(oMob,iClass);
	//GetError("Levelup " + GetName(oMob) + " iMobLevel=" + IntToString(iMobLevel) + " iClass=" + IntToString(iClass));
	iIndex = 1;
	while (iIndex <= iMobLevel)
	{
		iClassType 	= GetNPCClass(oMob,iIndex);
		iPackage 	= GetNPCPackage(oMob,iIndex);
		iLevelup	= LevelUpHenchman(oMob,iClassType,TRUE,iPackage);
		iIndex++;
		//WriteTimestampedLogEntry("Level " + GetName(oMob) + " as Class " + IntToString(iClassType) + " Package " + IntToString(iPackage));
	}

	if (GetSkillRank(SKILL_HIDE)>7 && GetLocalInt(oMob,"NPC") == 0)
	{
		AssignCommand(oMob,SetSpawnInCondition(NW_FLAG_STEALTH));
		DelayCommand(0.1,AssignCommand(oMob,UseStealthMode()));
	}
}

void SetClass(object oMob,int iClass,int iPackage)
{
	int iCount;
	iCount = GetLocalInt(oMob,"CLASS_Count");
	iCount++;
	SetLocalInt(oMob,"CLASS_Count",iCount);
	SetLocalInt(oMob,"CLASS" + IntToString(iCount),iClass);
	SetLocalInt(oMob,"PACKAGE" + IntToString(iCount),iPackage);
}

int GetNPCClass(object oMob,int iLevel)
{
	int iClass;
	int iLevelType;
	int iCount;
	int iMod;
	string sClass;

	iCount = GetLocalInt(oMob,"CLASS_Count");
	iLevelType = GetLocalInt(oMob,"CLASS_LevelType");

	if (iCount < 2)
		iClass = GetLocalInt(oMob,"CLASS1");
	
	else
	{
		if (iLevelType == 0)
		{
			iMod = (iLevel % 2) + 1;
			sClass = "CLASS" + IntToString(iMod);
			iClass = GetLocalInt(oMob,sClass);
		} 
		else 
		{
			if (iLevel<11)
				iClass = GetLocalInt(oMob,"CLASS1");
			else
				iClass = GetLocalInt(oMob,"CLASS2");
		}
	}

	return iClass;
}

int GetNPCPackage(object oMob,int iLevel)
{
	int iPackage;
	int iLevelType;
	int iCount;
	int iMod;
	string sClass;

	iCount = GetLocalInt(oMob,"CLASS_Count");
	iLevelType = GetLocalInt(oMob,"CLASS_LevelType");

	if (iCount<2)
		iPackage = GetLocalInt(oMob,"PACKAGE1");
	else
	{
		if (iLevelType == 0)
		{
			iMod = (iLevel % 2) + 1;
			sClass = "PACKAGE" + IntToString(iMod);
			iPackage = GetLocalInt(oMob,sClass);
		}
		else 
		{
			if (iLevel<11)
				iPackage = GetLocalInt(oMob,"PACKAGE1");
			else
				iPackage = GetLocalInt(oMob,"PACKAGE2");
		}
	}

	return iPackage;
}

void SetupClass(object oMob,int iClass)
{

//:: Setup Classes
	switch (iClass)
    {
		case EN5_CLASS_FIGHTER:
			SetClass(oMob,CLASS_TYPE_FIGHTER,GetRandomPackage(CLASS_TYPE_FIGHTER));
			break;
			
		case EN5_CLASS_BARBARIAN:
			SetClass(oMob,CLASS_TYPE_BARBARIAN,GetRandomPackage(CLASS_TYPE_BARBARIAN));
			break;
			
		case EN5_CLASS_RANGER:
			SetClass(oMob,CLASS_TYPE_RANGER,GetRandomPackage(CLASS_TYPE_RANGER));
			break;
			
		case EN5_CLASS_PALADIN:
			SetClass(oMob,CLASS_TYPE_PALADIN,GetRandomPackage(CLASS_TYPE_PALADIN));
			break;
			
		case EN5_CLASS_MONK:
			SetClass(oMob,CLASS_TYPE_MONK,GetRandomPackage(CLASS_TYPE_MONK));
			break;
			
		case EN5_CLASS_ROGUE:
			SetClass(oMob,CLASS_TYPE_ROGUE,GetRandomPackage(CLASS_TYPE_ROGUE));
			break;
			
		case EN5_CLASS_BARD:
			SetClass(oMob,CLASS_TYPE_BARD,GetRandomPackage(CLASS_TYPE_BARD));
			break;
			
		case EN5_CLASS_CLERIC:
			SetClass(oMob,CLASS_TYPE_CLERIC,GetRandomPackage(CLASS_TYPE_CLERIC));
			break;
			
		case EN5_CLASS_DRUID:
			SetClass(oMob,CLASS_TYPE_DRUID,GetRandomPackage(CLASS_TYPE_DRUID));
			break;
			
		case EN5_CLASS_WIZARD:
			SetClass(oMob,CLASS_TYPE_WIZARD,GetRandomPackage(CLASS_TYPE_WIZARD));
			break;
			
		case EN5_CLASS_SORCERER:
			SetClass(oMob,CLASS_TYPE_SORCERER,GetRandomPackage(CLASS_TYPE_SORCERER));
			break;
			
		case EN5_CLASS_FIGHTERROGUE:
			SetClass(oMob,CLASS_TYPE_FIGHTER,GetRandomPackage(CLASS_TYPE_FIGHTER));
			SetClass(oMob,CLASS_TYPE_ROGUE,GetRandomPackage(CLASS_TYPE_ROGUE));
			SetLocalInt(oMob,"CLASS_LevelType",0);
			break;
			
		case EN5_CLASS_FIGHTERCLERIC:
			SetClass(oMob,CLASS_TYPE_FIGHTER,GetRandomPackage(CLASS_TYPE_FIGHTER));
			SetClass(oMob,CLASS_TYPE_CLERIC,GetRandomPackage(CLASS_TYPE_CLERIC));
			SetLocalInt(oMob,"CLASS_LevelType",0);
			break;
			
		case EN5_CLASS_MONKSORCERER:
			SetClass(oMob,CLASS_TYPE_MONK,GetRandomPackage(CLASS_TYPE_MONK));
			SetClass(oMob,CLASS_TYPE_SORCERER,GetRandomPackage(CLASS_TYPE_SORCERER));
			SetLocalInt(oMob,"CLASS_LevelType",0);
			break;
			
		case EN5_CLASS_ASSASSIN:
			SetClass(oMob,CLASS_TYPE_ROGUE,GetRandomPackage(CLASS_TYPE_ROGUE));
			SetClass(oMob,CLASS_TYPE_ASSASSIN,PACKAGE_ASSASSIN);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_BLACKGUARD:
			SetClass(oMob,CLASS_TYPE_BARBARIAN,PACKAGE_BARBARIAN_BLACKGUARD);
			SetClass(oMob,CLASS_TYPE_BLACKGUARD,PACKAGE_BLACKGUARD);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_DIVINECHAMPION:
			if (Random(2)==0)
				SetClass(oMob,CLASS_TYPE_FIGHTER,GetRandomPackage(CLASS_TYPE_FIGHTER));
			else
				SetClass(oMob,CLASS_TYPE_CLERIC,GetRandomPackage(CLASS_TYPE_CLERIC));
			SetClass(oMob,CLASS_TYPE_DIVINECHAMPION,PACKAGE_DIVINE_CHAMPION);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_DRAGON_DISCIPLE:
			if (Random(2)==0)
				SetClass(oMob,CLASS_TYPE_BARD,PACKAGE_BARD_LOREMASTER);
			else
				SetClass(oMob,CLASS_TYPE_SORCERER,PACKAGE_SORCERER_DRAGONDISCIPLE);
			SetClass(oMob,CLASS_TYPE_DRAGON_DISCIPLE,PACKAGE_DRAGON_DISCIPLE);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_DWARVENDEFENDER:
			SetClass(oMob,EN5_CLASS_FIGHTER,GetRandomPackage(EN5_CLASS_FIGHTER));
			SetClass(oMob,EN5_CLASS_DWARVENDEFENDER,PACKAGE_DWARVEN_DEFENDER);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_PALEMASTER:
			SetClass(oMob,CLASS_TYPE_WIZARD,PACKAGE_WIZARD_PALEMASTER);
			SetClass(oMob,CLASS_TYPE_PALEMASTER,PACKAGE_PALE_MASTER);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_HARPER:
			SetClass(oMob,CLASS_TYPE_BARD,PACKAGE_BARD_HARPER);
			SetClass(oMob,CLASS_TYPE_HARPER,PACKAGE_HARPER);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_SHADOWDANCER:
			SetClass(oMob,CLASS_TYPE_ROGUE,PACKAGE_ROGUE_SHADOWDANCER);
			SetClass(oMob,CLASS_TYPE_SHADOWDANCER,PACKAGE_SHADOWDANCER);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_SHIFTER:
			SetClass(oMob,CLASS_TYPE_DRUID,PACKAGE_DRUID_SHIFTER);
			SetClass(oMob,CLASS_TYPE_SHIFTER,PACKAGE_SHIFTER);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_WEAPON_MASTER:
			SetClass(oMob,CLASS_TYPE_FIGHTER,PACKAGE_FIGHTER_WEAPONMASTER);
			SetClass(oMob,CLASS_TYPE_WEAPON_MASTER,PACKAGE_WEAPONMASTER);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
			
		case EN5_CLASS_ARCANE_ARCHER:
			SetClass(oMob,CLASS_TYPE_SORCERER,GetRandomPackage(CLASS_TYPE_SORCERER));
			SetClass(oMob,CLASS_TYPE_ARCANE_ARCHER,PACKAGE_ARCANE_ARCHER);
			SetLocalInt(oMob,"CLASS_LevelType",1);
			break;
		}

//:: Setup Alignments
	switch (iClass)
    {
		case EN5_CLASS_PALADIN:
			AdjustAlignment(oMob,ALIGNMENT_LAWFUL,100);
			AdjustAlignment(oMob,ALIGNMENT_GOOD,100);
        
			break;
		
		case EN5_CLASS_MONK:
			AdjustAlignment(oMob,ALIGNMENT_LAWFUL,100);
			
			break;
			
		case EN5_CLASS_MONKSORCERER:
			AdjustAlignment(oMob,ALIGNMENT_LAWFUL,100);
        
			break;

		case EN5_CLASS_BARBARIAN:
			AdjustAlignment(oMob,ALIGNMENT_CHAOTIC,100);
			
			break;
		
		case EN5_CLASS_DRUID:
			if (GetAlignmentLawChaos(oMob) == ALIGNMENT_LAWFUL)
				AdjustAlignment(oMob,ALIGNMENT_CHAOTIC,40);
			if (GetAlignmentLawChaos(oMob) == ALIGNMENT_CHAOTIC)
				AdjustAlignment(oMob,ALIGNMENT_LAWFUL,40);
			
			break;
		
		case EN5_CLASS_SHIFTER:
			if (GetAlignmentLawChaos(oMob) == ALIGNMENT_LAWFUL)
				AdjustAlignment(oMob,ALIGNMENT_CHAOTIC,40);
			if (GetAlignmentLawChaos(oMob) == ALIGNMENT_CHAOTIC)
				AdjustAlignment(oMob,ALIGNMENT_LAWFUL,40);
        
			break;
			
		case EN5_CLASS_ASSASSIN:
			AdjustAlignment(oMob,ALIGNMENT_EVIL,100);
			
			break;
			
		case EN5_CLASS_BLACKGUARD:
			AdjustAlignment(oMob,ALIGNMENT_EVIL,100);
        
			break;
			
		case EN5_CLASS_HARPER:
			if (GetAlignmentGoodEvil(oMob) == ALIGNMENT_EVIL)
			AdjustAlignment(oMob,ALIGNMENT_GOOD,50);
        
			break;
    
		case EN5_CLASS_DIVINECHAMPION :
			if (GetAlignmentGoodEvil(oMob) == ALIGNMENT_EVIL)
			AdjustAlignment(oMob,ALIGNMENT_GOOD,50);
			
			break;
		
		case EN5_CLASS_DWARVENDEFENDER :
			AdjustAlignment(oMob,ALIGNMENT_LAWFUL,100);
			
			break;
    }
}


int GetMobClass(int iClass, int iLevel, int iClassPackage=1)
{
	int iClassType;
	int iPackage;
	int iReturn;

	iClassType 	= CLASS_TYPE_FIGHTER;
	iPackage 	= GetRandomPackage(iClassType);

	//SendMessageToPC(GetFirstPC(),"iClass = " + IntToString(iClass));
	//SendMessageToPC(GetFirstPC(),"FIGHTER = " + IntToString(iClassType));

	switch (iClass)
    {
		case EN5_CLASS_FIGHTER: iClassType=CLASS_TYPE_FIGHTER; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_BARBARIAN: iClassType=CLASS_TYPE_BARBARIAN; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_RANGER: iClassType=CLASS_TYPE_RANGER; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_PALADIN: iClassType=CLASS_TYPE_PALADIN; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_MONK: iClassType=CLASS_TYPE_MONK; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_ROGUE: iClassType=CLASS_TYPE_ROGUE; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_BARD: iClassType=CLASS_TYPE_BARD; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_CLERIC: iClassType=CLASS_TYPE_CLERIC; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_DRUID: iClassType=CLASS_TYPE_DRUID; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_WIZARD: iClassType=CLASS_TYPE_WIZARD; iPackage = GetRandomPackage(iClassType); break;
		case EN5_CLASS_SORCERER: iClassType=CLASS_TYPE_SORCERER; iPackage = GetRandomPackage(iClassType); break;
		
		case EN5_CLASS_FIGHTERROGUE:
			if (iLevel % 2 == 0)
				iClassType=CLASS_TYPE_FIGHTER;
			else
				iClassType=CLASS_TYPE_ROGUE;
			iPackage = GetRandomPackage(iClassType);
			break;
		
		case EN5_CLASS_FIGHTERCLERIC:
			if (iLevel % 2 == 0)
				iClassType=CLASS_TYPE_FIGHTER;
			else
				iClassType=CLASS_TYPE_CLERIC;
			iPackage = GetRandomPackage(iClassType);
			break;
		
		case EN5_CLASS_MONKSORCERER:
			if (iLevel % 2 == 0)
				iClassType=CLASS_TYPE_MONK;
			else
				iClassType=CLASS_TYPE_SORCERER;
			iPackage = GetRandomPackage(iClassType);
			break;
		
		case EN5_CLASS_ASSASSIN:
			if (iLevel < 11)
				iClassType=CLASS_TYPE_ROGUE;
			else
				iClassType=CLASS_TYPE_ASSASSIN;
				iPackage = GetRandomPackage(iClassType);
			break;
		
		case EN5_CLASS_BLACKGUARD:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_BARBARIAN;
				iPackage = PACKAGE_BARBARIAN_BLACKGUARD;
				}
			else
				{
				iClassType=CLASS_TYPE_BLACKGUARD;
				iPackage = PACKAGE_BLACKGUARD;
				}
			break;
		
		case EN5_CLASS_DIVINECHAMPION:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_FIGHTER;
				iPackage = GetRandomPackage(iClassType);
				}
			else
				{
				iClassType=CLASS_TYPE_DIVINECHAMPION;
				iPackage = PACKAGE_DIVINE_CHAMPION;
				}
			break;
		
		case EN5_CLASS_DRAGON_DISCIPLE:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_BARD;
				iPackage = PACKAGE_BARD_LOREMASTER;
				}
			else
				{
				iClassType=CLASS_TYPE_DRAGON_DISCIPLE;
				iPackage = PACKAGE_DRAGON_DISCIPLE;
				}
			break;
		
		case EN5_CLASS_DWARVENDEFENDER:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_FIGHTER;
				iPackage = GetRandomPackage(iClassType);
				}
			else
				{
				iClassType=CLASS_TYPE_DWARVENDEFENDER;
				iPackage = PACKAGE_DWARVEN_DEFENDER;
				}
			break;
		
		case EN5_CLASS_PALEMASTER:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_WIZARD;
				iPackage = PACKAGE_WIZARD_PALEMASTER;
				}
			else
				{
				iClassType=CLASS_TYPE_PALEMASTER;
				iPackage = PACKAGE_PALE_MASTER;
				}
			break;
		
		case EN5_CLASS_HARPER:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_BARD;
				iPackage = PACKAGE_BARD_HARPER;
				}
			else
				{
				iClassType=CLASS_TYPE_HARPER;
				iPackage = PACKAGE_HARPER;
				}
			break;
		
		case EN5_CLASS_SHADOWDANCER:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_BARD;
				iPackage = PACKAGE_ROGUE_SHADOWDANCER;
				}
			else
				{
				iClassType=CLASS_TYPE_SHADOWDANCER;
				iPackage = PACKAGE_SHADOWDANCER;
				}
			break;
		
		case EN5_CLASS_SHIFTER:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_DRUID;
				iPackage = PACKAGE_DRUID_SHIFTER;
				}
			else
				{
				iClassType=CLASS_TYPE_SHIFTER;
				iPackage = PACKAGE_SHIFTER;
				}
			break;
		
		case EN5_CLASS_WEAPON_MASTER:
			if (iLevel < 11)
				{
				iClassType=CLASS_TYPE_FIGHTER;
				iPackage = PACKAGE_FIGHTER_WEAPONMASTER;
				}
			else
				{
				iClassType=CLASS_TYPE_WEAPON_MASTER;
				iPackage = PACKAGE_WEAPONMASTER;
				}
			break;
		
		case EN5_CLASS_ARCANE_ARCHER: //Not Working
			if (iLevel < 11)
				{
				//GetError("Trying S");
				iClassType=CLASS_TYPE_SORCERER;
				iPackage = GetRandomPackage(iClassType);
				}
			else
				{
				//GetError("Trying AA");
				iClassType=CLASS_TYPE_ARCANE_ARCHER;
				iPackage = PACKAGE_ARCANE_ARCHER;
				}
			break;
    }

	//SendMessageToPC(GetFirstPC(),"iClassType=" + IntToString(iClassType));
	if (iClassPackage == 1)
		iReturn = iClassType;
	else
		iReturn = iPackage;

	return iReturn;
}

int GetRandomPackage(int iClass)
{
	int iPackage;
	int iRandom;

	iPackage = PACKAGE_INVALID;
	switch (iClass)
    {
    case CLASS_TYPE_SORCERER:
        iRandom=Random(10)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_SORCERER; break;
            case 2: iPackage = PACKAGE_SORCERER_ABJURATION; break;
            case 3: iPackage = PACKAGE_SORCERER_CONJURATION; break;
            case 4: iPackage = PACKAGE_SORCERER_DIVINATION; break;
            case 5: iPackage = PACKAGE_SORCERER_DRAGONDISCIPLE; break;
            case 6: iPackage = PACKAGE_SORCERER_ENCHANTMENT; break;
            case 7: iPackage = PACKAGE_SORCERER_EVOCATION; break;
            case 8: iPackage = PACKAGE_SORCERER_ILLUSION; break;
            case 9: iPackage = PACKAGE_SORCERER_NECROMANCY; break;
            case 10: iPackage = PACKAGE_SORCERER_TRANSMUTATION; break;
            }
        break;
    case CLASS_TYPE_CLERIC:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_CLERIC; break;
            case 2: iPackage = PACKAGE_CLERIC_BATTLE_PRIEST; break;
            case 3: iPackage = PACKAGE_CLERIC_DEADWALKER; break;
            case 4: iPackage = PACKAGE_CLERIC_DIVINE; break;
            case 5: iPackage = PACKAGE_CLERIC_ELEMENTALIST; break;
            case 6: iPackage = PACKAGE_CLERIC_SHAMAN; break;
            }
        break;
    case CLASS_TYPE_DRUID:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_DRUID; break;
            case 2: iPackage = PACKAGE_DRUID_DEATH; break;
            case 3: iPackage = PACKAGE_DRUID_GRAY; break;
            case 4: iPackage = PACKAGE_DRUID_HAWKMASTER; break;
            case 5: iPackage = PACKAGE_DRUID_INTERLOPER; break;
            case 6: iPackage = PACKAGE_DRUID_SHIFTER; break;
            }
        break;
    case CLASS_TYPE_BARD:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_BARD; break;
            case 2: iPackage = PACKAGE_BARD_BLADE; break;
            case 3: iPackage = PACKAGE_BARD_GALLANT; break;
            case 4: iPackage = PACKAGE_BARD_HARPER; break;
            case 5: iPackage = PACKAGE_BARD_JESTER; break;
            case 6: iPackage = PACKAGE_BARD_LOREMASTER; break;
            }
        break;
    case CLASS_TYPE_BARBARIAN:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_BARBARIAN; break;
            case 2: iPackage = PACKAGE_BARBARIAN_BLACKGUARD; break;
            case 3: iPackage = PACKAGE_BARBARIAN_BRUTE; break;
            case 4: iPackage = PACKAGE_BARBARIAN_ORCBLOOD; break;
            case 5: iPackage = PACKAGE_BARBARIAN_SAVAGE; break;
            case 6: iPackage = PACKAGE_BARBARIAN_SLAYER; break;
            }
        break;
    case CLASS_TYPE_FIGHTER:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_FIGHTER; break;
            case 2: iPackage = PACKAGE_FIGHTER_COMMANDER; break;
            case 3: iPackage = PACKAGE_FIGHTER_FINESSE; break;
            case 4: iPackage = PACKAGE_FIGHTER_GLADIATOR; break;
            case 5: iPackage = PACKAGE_FIGHTER_PIRATE; break;
            case 6: iPackage = PACKAGE_FIGHTER_WEAPONMASTER; break;
            }
        break;
    case CLASS_TYPE_MONK:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_MONK; break;
            case 2: iPackage = PACKAGE_MONK_ASSASSIN; break;
            case 3: iPackage = PACKAGE_MONK_DEVOUT; break;
            case 4: iPackage = PACKAGE_MONK_GIFTED; break;
            case 5: iPackage = PACKAGE_MONK_PEASANT; break;
            case 6: iPackage = PACKAGE_MONK_SPIRIT; break;
            }
        break;
    case CLASS_TYPE_RANGER:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_RANGER; break;
            case 2: iPackage = PACKAGE_RANGER_ARCANEARCHER; break;
            case 3: iPackage = PACKAGE_RANGER_GIANTKILLER; break;
            case 4: iPackage = PACKAGE_RANGER_MARKSMAN; break;
            case 5: iPackage = PACKAGE_RANGER_STALKER; break;
            case 6: iPackage = PACKAGE_RANGER_WARDEN; break;
            }
        break;
    case CLASS_TYPE_ROGUE:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_ROGUE; break;
            case 2: iPackage = PACKAGE_ROGUE_BANDIT; break;
            case 3: iPackage = PACKAGE_ROGUE_GYPSY; break;
            case 4: iPackage = PACKAGE_ROGUE_SCOUT; break;
            case 5: iPackage = PACKAGE_ROGUE_SHADOWDANCER; break;
            case 6: iPackage = PACKAGE_ROGUE_SWASHBUCKLER; break;
            }
        break;
    case CLASS_TYPE_WIZARD:
        iRandom=Random(10)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_WIZARD_ABJURATION; break;
            case 2: iPackage = PACKAGE_WIZARD_CONJURATION; break;
            case 3: iPackage = PACKAGE_WIZARD_DIVINATION; break;
            case 4: iPackage = PACKAGE_WIZARD_ENCHANTMENT; break;
            case 5: iPackage = PACKAGE_WIZARD_EVOCATION; break;
            case 6: iPackage = PACKAGE_WIZARD_ILLUSION; break;
            case 7: iPackage = PACKAGE_WIZARD_NECROMANCY; break;
            case 8: iPackage = PACKAGE_WIZARD_PALEMASTER; break;
            case 9: iPackage = PACKAGE_WIZARD_TRANSMUTATION; break;
            case 10: iPackage = PACKAGE_WIZARDGENERALIST; break;
            }
        break;
    }

return iPackage;
}

string GetClass(object oPC)
{
string sClass;

sClass = GetClassByPos(oPC,1);
if (GetLevelByPosition(2,oPC) > 0)
    {
    sClass = sClass + " (" + IntToString(GetLevelByPosition(1,oPC)) + ") ";
    sClass = sClass + "/" + GetClassByPos(oPC,2);
    sClass = sClass + " (" + IntToString(GetLevelByPosition(2,oPC)) + ") ";
    }
if (GetLevelByPosition(3,oPC) > 0)
    {
    sClass = sClass + "/" + GetClassByPos(oPC,3);
    sClass = sClass + " (" + IntToString(GetLevelByPosition(3,oPC)) + ") ";
    }

return sClass;
}

string GetClassByPos(object oPC, int iPos)
{
	string sClass;

	sClass = "Other";

	switch (GetClassByPosition(iPos,oPC))
    {
		case CLASS_TYPE_BARBARIAN: sClass = "Barbarian"; break;
		case CLASS_TYPE_FIGHTER: sClass = "Fighter"; break;
		case CLASS_TYPE_RANGER: sClass = "Ranger"; break;
		case CLASS_TYPE_PALADIN: sClass = "Paladin"; break;
		case CLASS_TYPE_ROGUE: sClass = "Rogue"; break;
		case CLASS_TYPE_BARD: sClass = "Bard"; break;
		case CLASS_TYPE_MONK: sClass = "Monk"; break;
		case CLASS_TYPE_CLERIC: sClass = "Cleric"; break;
		case CLASS_TYPE_DRUID: sClass = "Druid"; break;
		case CLASS_TYPE_WIZARD: sClass = "Wizard"; break;
		case CLASS_TYPE_SORCERER: sClass = "Sorcerer"; break;
		case CLASS_TYPE_DRAGONDISCIPLE: sClass = "Dragon Disciple"; break;
		case CLASS_TYPE_DWARVENDEFENDER: sClass = "Dwarven Defender"; break;
		case CLASS_TYPE_PALEMASTER: sClass = "Pale Master"; break;
		case CLASS_TYPE_SHIFTER: sClass = "Shifter"; break;
		case CLASS_TYPE_WEAPON_MASTER: sClass = "Weaponmaster"; break;
		case CLASS_TYPE_DIVINECHAMPION: sClass = "Champion of Torm"; break;
		case CLASS_TYPE_BLACKGUARD: sClass = "Blackguard"; break;
		case CLASS_TYPE_ARCANE_ARCHER: sClass = "Arcane Archer"; break;
		case CLASS_TYPE_ASSASSIN: sClass = "Assassin"; break;
		case CLASS_TYPE_HARPER: sClass = "Harper"; break;
		case CLASS_TYPE_SHADOWDANCER: sClass = "Shadowdancer"; break;
    }
	
	return sClass;
}

/* string GetRace(object oPC)
{
string sRace;

sRace = GetSubRace(oPC);

if (sRace == "")
    {
    switch (GetRacialType(oPC))
        {
        case RACIAL_TYPE_HUMAN: sRace = "Human"; break;
        case RACIAL_TYPE_ELF: sRace = "Elf"; break;
        case RACIAL_TYPE_DWARF: sRace = "Dwarf"; break;
        case RACIAL_TYPE_HALFELF: sRace = "Half-Elf"; break;
        case RACIAL_TYPE_HALFORC: sRace = "Half-Orc"; break;
        case RACIAL_TYPE_HALFLING: sRace = "Halfling"; break;
        case RACIAL_TYPE_GNOME: sRace = "Gnome"; break;
        }
    }

return sRace;
} */

string GetRace(object oPC)
{
    string sRace = GetSubRace(oPC);
    
    if (sRace == "")
    {
        sRace = GetStringByStrRef(StringToInt(Get2DAString("racialtypes", "Name", GetRacialType(oPC))));
    }
    
    return sRace;
}

string GetMyZone(object oNPC=OBJECT_SELF)
{
	string sZone;

	sZone = GetLocalString(GetArea(oNPC),"Zone");
	if (sZone == "")
		sZone = "NH1";

	return sZone;
}

string GetZone(object oArea=OBJECT_SELF)
{
	string sZone;
	if (GetObjectType(oArea) == OBJECT_TYPE_CREATURE)
		oArea = GetArea(oArea);

	sZone = GetLocalString(oArea,"Zone");
	if (sZone == "")
		sZone = "NH1";

	return sZone;
}

void SetPartyString(object oPC,string sVariable, string sValue)
{
	object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	
	while (GetIsObjectValid(oPartyMember) == TRUE)
    {
		SetLocalString(oPartyMember,sVariable,sValue);
		oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

void SetPartyInt(object oPC,string sVariable, int iValue)
{
	object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	
	while (GetIsObjectValid(oPartyMember) == TRUE)
    {
		SetLocalInt(oPartyMember,sVariable,iValue);
		oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

object GetRandomPC()
{
	int iCount;
	int iFlag;
	int iIndex;
	object oPC;
	object oLastPC;

	oPC=GetFirstPC();
	iCount = 0;
	iFlag = 0;

	while (iFlag == 0)
	{
		iCount++;
		oLastPC = oPC;
		oPC = GetNextPC();

		if (GetName(oLastPC) == GetName(oPC))
		{
			iFlag = 1;
		}
		if (iCount>65)
		{
			iFlag = 1;
		}
	}
	iCount--;
	for (iIndex=1; iIndex <= iCount; iIndex++)
	{
		if (iIndex == 1)
		{
			oPC = GetFirstPC();
		}
		else
		{
			oPC = GetNextPC();
		}
	}

	return oPC;
}

int GetNumberPCs()
{
	object oPC;
	int iIndex;

	oPC = GetFirstPC();
	iIndex=0;
	while (GetIsObjectValid(oPC))
	{
		iIndex++;
		oPC = GetNextPC();
	}

	return iIndex;
}

int GetAdjustedNumberPCs()
{
	object oPC;
	int iIndex;
	int iHench;

	oPC = GetFirstPC();
	iIndex=0;
	while (GetIsObjectValid(oPC))
	{
		iIndex++;
		iHench=iHench + GetNumOfHenchman(oPC);
		oPC = GetNextPC();
	}

	return iIndex + iHench/2;
}

int GetNumOfHenchman(object oPC)
{
	int iIndex;
	int iCount;
	object oHenchman;

	iIndex=1;
	iCount=0;
	while (iIndex<11)
	{
		oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,iIndex);
	//    if (GetIsObjectValid(oHenchman) && GetLocalInt(oHenchman,"Henchman") == 1)
		if (GetIsObjectValid(oHenchman))
			iCount++;
		iIndex++;
	}

	return iCount;
}

void SitInChairs(string sPrefix)
{
	int iCount;
	string sTag;
	object oNPC;
	object oChair;

	iCount=1;
	sTag = sPrefix + "_sit" + IntToString(iCount);
	oNPC = GetObjectByTag(sTag);
	//SendMessageToPC(GetFirstPC(),"NPC sitting - first = " + sTag);
	while (GetIsObjectValid(oNPC))
	{
		sTag = sPrefix + "_chair" + IntToString(iCount);
		//SendMessageToPC(GetFirstPC(),"Try to Sit in Chair " + sTag);
		oChair = GetObjectByTag(sTag);
		if (GetIsObjectValid(oChair))
		{
			DelayCommand(0.5f,AssignCommand(oNPC,ActionSit(oChair)));
			//SendMessageToPC(GetFirstPC(),"Sit in Chair " + sTag);
		}
		iCount++;
		sTag = sPrefix + "_sit" + IntToString(iCount);
		oNPC = GetObjectByTag(sTag);
	}
}

int GetItemLevel(int iLevel)
{
	int iItemLevel;
	int iRandom;

	if (iLevel < 20)
	{
		iItemLevel = iLevel/4;
		
		if (Random(10)<iLevel % 4 + 1)
			iItemLevel++;
		
		else if (Random(10)<4-(iLevel %4))
			iItemLevel--;
	}
	else
	{		
		iRandom = Random(100);
		
		if (iRandom<(iLevel-20) * 4)
			iItemLevel = 6;
	
		else if (iRandom< 75 + (iLevel-20))
			iItemLevel = 5;
		
		else
			iItemLevel = 4;
	}

	if (Random(100)==0)
		iItemLevel=Random(6)+1;

	if (GetLocalInt(GetModule(),"MagicLevel")==3)
		if (Random(100)<25)
			iItemLevel=Random(6)+1;

	if (GetLocalInt(GetModule(),"MagicLevel")>1)
		if (Random(10)==0)
			iItemLevel++;

	if (iItemLevel < 1)
		iItemLevel =1;
	
	if (iItemLevel > 6)
		iItemLevel =6;

	return iItemLevel;
}

int ZoneLevel(object oArea)
{
	int iZoneLevel;
	int iMinLevel;
	int iMaxLevel;

	if (GetObjectType(oArea) == OBJECT_TYPE_CREATURE)
		oArea = GetArea(oArea);

	iMinLevel =GetMinLevel(GetLocalString(oArea,"Zone"));
	iMaxLevel=GetMaxLevel(GetLocalString(oArea,"Zone"));
	iZoneLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;

	if (iZoneLevel < iMinLevel)
		iZoneLevel = iMinLevel;
	
	if (iZoneLevel > iMaxLevel)
		iZoneLevel = iMaxLevel;
	
	if (iZoneLevel < 1)
		iZoneLevel = 1;

	return iZoneLevel;
}

int ZoneMaxLevel(object oArea)
{
	int iMaxLevel;

	iMaxLevel = GetMaxLevel(GetLocalString(oArea,"Zone"));

	return iMaxLevel;
}

string GetBoss(string sTag, int iNumber)
{
	string sBoss;
	int iBoss;
	int iIndex;

	iBoss = Random(iNumber)+1;
	sBoss = sTag + IntToString(iBoss);

	if (GetLocalInt(GetModule(),sBoss) == 1)
	{
		iBoss=0;
		while (GetLocalInt(GetModule(),sBoss) == 1)
		{
			iBoss++;
			sBoss = sTag + IntToString(iBoss);
		}
		if (iBoss<=iNumber)
		{
			SetLocalInt(GetModule(),sBoss,1);
			SetLocalInt(GetModule(),"EN5_BossNamed",1);
		}
		else
			sBoss = sTag;
	} 
	else 
	{
		SetLocalInt(GetModule(),sBoss,1);
		SetLocalInt(GetModule(),"EN5_BossNamed",1);
	}

	return sBoss;
}

int MaxObject(string sObject)
{
	int iCount;
	string sTag;
	object oObject;

	iCount=1;
	sTag = sObject + IntToString(iCount);
	oObject = GetObjectByTag(sTag);
	
	while (GetIsObjectValid(oObject))
	{
		iCount++;
		sTag = sObject + IntToString(iCount);
		oObject = GetObjectByTag(sTag);
	}
	iCount--;

	return iCount;
}

string GetAreaAccomplishment(object oPC)
{
	int iRandom;
	int iAccomplishments;
	string sAccomplishment;

	sAccomplishment = GetLocalString(oPC,GetMyZone(oPC)+ "_Accomplishment");
	if (sAccomplishment == "")
	{
		if (GetMyZone(oPC) == "NC1")
			sAccomplishment = GetLocalString(oPC,"MV1_Accomplishment");
		if (GetMyZone(oPC) == "MV1")
			sAccomplishment = GetLocalString(oPC,"NC1_Accomplishment");

		if (GetMyZone(oPC) == "SF1")
			sAccomplishment = GetLocalString(oPC,"NSF1_Accomplishment");
		if (GetMyZone(oPC) == "NSF1")
			sAccomplishment = GetLocalString(oPC,"SF1_Accomplishment");

		if (GetMyZone(oPC)  == "EF1")
			sAccomplishment = GetLocalString(oPC,"SEF1_Accomplishment");
		if (GetMyZone(oPC)  == "SEF1")
			sAccomplishment = GetLocalString(oPC,"EF1_Accomplishment");

		if (GetMyZone(oPC)  == "MH1")
			sAccomplishment = GetLocalString(oPC,"NMH1_Accomplishment");
		if (GetMyZone(oPC)  == "NMH1")
			sAccomplishment = GetLocalString(oPC,"MH1_Accomplishment");

		if (GetMyZone(oPC)  == "BS1")
			sAccomplishment = GetLocalString(oPC,"WBS1_Accomplishment");
		if (GetMyZone(oPC)  == "WBS1")
			sAccomplishment = GetLocalString(oPC,"BS1_Accomplishment");

		if (GetMyZone(oPC)  == "AR1")
			sAccomplishment = GetLocalString(oPC,"AG1_Accomplishment");

		if (GetMyZone(oPC)  == "AP1")
			sAccomplishment = GetLocalString(oPC,"AW2_Accomplishment");
		if (GetMyZone(oPC)  == "AW2")
			sAccomplishment = GetLocalString(oPC,"AP1_Accomplishment");

		if (GetMyZone(oPC)  == "AG1")
			sAccomplishment = GetLocalString(oPC,"AW2_Accomplishment");
			if (sAccomplishment == "")
				sAccomplishment = GetLocalString(oPC,"AP1_Accomplishment");

		if (GetMyZone(oPC)  == "RD1")
			sAccomplishment = GetLocalString(oPC,"SRD1_Accomplishment");

		if (GetMyZone(oPC)  == "BH1")
			sAccomplishment = GetLocalString(oPC,"BM1_Accomplishment");
		if (GetMyZone(oPC)  == "BM1")
			sAccomplishment = GetLocalString(oPC,"BH1_Accomplishment");

		if (GetMyZone(oPC)  == "SRD1")
			sAccomplishment = GetLocalString(oPC,"BM1_Accomplishment");
			if (sAccomplishment == "")
				sAccomplishment = GetLocalString(oPC,"BH1_Accomplishment");

		if (sAccomplishment == "")
		{
			iAccomplishments = GetLocalInt(oPC,"MajorAccomplishments");
			if (iAccomplishments > 0)
			{
				iRandom=Random(iAccomplishments)+1;
				sAccomplishment = GetLocalString(oPC,"MajorAccomplishment" + IntToString(iRandom));
			}
		}
	}

	return sAccomplishment;
}

void EquipItem(int iItemSlot,object oItem, object oCreature)
{
object oOldItem;
int iQuestItem;

oOldItem = GetItemInSlot(iItemSlot,oCreature);

iQuestItem = GetLocalInt(oOldItem,"QuestItem");

if (iQuestItem == 0)
    {
    SetLocalInt(oItem,"EN5_EQUIP",iItemSlot);
    AssignCommand(oCreature,ActionDoCommand(SetAILevel(OBJECT_SELF, AI_LEVEL_NORMAL)));
    AssignCommand(oCreature,ActionUnequipItem(oOldItem));
    AssignCommand(oCreature, ActionEquipItem(oItem, iItemSlot));
    DestroyObject(oOldItem,0.1);
    AssignCommand(oCreature,ActionDoCommand(SetAILevel(OBJECT_SELF, AI_LEVEL_DEFAULT)));
    }
}


string ReplaceText(string sString,string sReplace,string sReplaceWith)
{
int iPos;
int iLength;
int iStringLength;

iLength=GetStringLength(sReplace);
iPos=FindSubString(sString,sReplace);
iStringLength=GetStringLength(sString);

//SendMessageToPC(GetFirstPC(),"Position of " + sReplace + " in " + sString + " is " + IntToString(iPos));

while (iPos>0)
    {
    sString=GetStringLeft(sString,iPos) + sReplaceWith + GetStringRight(sString,iStringLength-iPos-iLength);
    iPos=FindSubString(sString,sReplace);
    iStringLength=GetStringLength(sString);
//SendMessageToPC(GetFirstPC(),"Position of " + sReplace + " is " + IntToString(iPos));

    }

return sString;
}

int GetTrapType(int iLevel)
{
int iTrap;
int iRandom;


if (iLevel<6)
    {
    iRandom=Random(11)+1;
    switch (iRandom)
        {
        case 1: iTrap=TRAP_BASE_TYPE_MINOR_ACID; break;
        case 2: iTrap=TRAP_BASE_TYPE_MINOR_ACID_SPLASH; break;
        case 3: iTrap=TRAP_BASE_TYPE_MINOR_ELECTRICAL; break;
        case 4: iTrap=TRAP_BASE_TYPE_MINOR_FIRE; break;
        case 5: iTrap=TRAP_BASE_TYPE_MINOR_FROST; break;
        case 6: iTrap=TRAP_BASE_TYPE_MINOR_GAS; break;
        case 7: iTrap=TRAP_BASE_TYPE_MINOR_HOLY; break;
        case 8: iTrap=TRAP_BASE_TYPE_MINOR_NEGATIVE; break;
        case 9: iTrap=TRAP_BASE_TYPE_MINOR_SONIC; break;
        case 10: iTrap=TRAP_BASE_TYPE_MINOR_SPIKE; break;
        case 11: iTrap=TRAP_BASE_TYPE_MINOR_TANGLE; break;
        }
    }
else if (iLevel<11)
    {
    iRandom=Random(11)+1;
    switch (iRandom)
        {
        case 1: iTrap=TRAP_BASE_TYPE_AVERAGE_ACID; break;
        case 2: iTrap=TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH; break;
        case 3: iTrap=TRAP_BASE_TYPE_AVERAGE_ELECTRICAL; break;
        case 4: iTrap=TRAP_BASE_TYPE_AVERAGE_FIRE; break;
        case 5: iTrap=TRAP_BASE_TYPE_AVERAGE_FROST; break;
        case 6: iTrap=TRAP_BASE_TYPE_AVERAGE_GAS; break;
        case 7: iTrap=TRAP_BASE_TYPE_AVERAGE_HOLY; break;
        case 8: iTrap=TRAP_BASE_TYPE_AVERAGE_NEGATIVE; break;
        case 9: iTrap=TRAP_BASE_TYPE_AVERAGE_SONIC; break;
        case 10: iTrap=TRAP_BASE_TYPE_AVERAGE_SPIKE; break;
        case 11: iTrap=TRAP_BASE_TYPE_AVERAGE_TANGLE; break;
        }
    }
else if (iLevel<16)
    {
    iRandom=Random(11)+1;
    switch (iRandom)
        {
        case 1: iTrap=TRAP_BASE_TYPE_STRONG_ACID; break;
        case 2: iTrap=TRAP_BASE_TYPE_STRONG_ACID_SPLASH; break;
        case 3: iTrap=TRAP_BASE_TYPE_STRONG_ELECTRICAL; break;
        case 4: iTrap=TRAP_BASE_TYPE_STRONG_FIRE; break;
        case 5: iTrap=TRAP_BASE_TYPE_STRONG_FROST; break;
        case 6: iTrap=TRAP_BASE_TYPE_STRONG_GAS; break;
        case 7: iTrap=TRAP_BASE_TYPE_STRONG_HOLY; break;
        case 8: iTrap=TRAP_BASE_TYPE_STRONG_NEGATIVE; break;
        case 9: iTrap=TRAP_BASE_TYPE_STRONG_SONIC; break;
        case 10: iTrap=TRAP_BASE_TYPE_STRONG_SPIKE; break;
        case 11: iTrap=TRAP_BASE_TYPE_STRONG_TANGLE; break;
        }
    }
else if (iLevel<25)
    {
    iRandom=Random(11)+1;
    switch (iRandom)
        {
        case 1: iTrap=TRAP_BASE_TYPE_DEADLY_ACID; break;
        case 2: iTrap=TRAP_BASE_TYPE_DEADLY_ACID_SPLASH; break;
        case 3: iTrap=TRAP_BASE_TYPE_DEADLY_ELECTRICAL; break;
        case 4: iTrap=TRAP_BASE_TYPE_DEADLY_FIRE; break;
        case 5: iTrap=TRAP_BASE_TYPE_DEADLY_FROST; break;
        case 6: iTrap=TRAP_BASE_TYPE_DEADLY_GAS; break;
        case 7: iTrap=TRAP_BASE_TYPE_DEADLY_HOLY; break;
        case 8: iTrap=TRAP_BASE_TYPE_DEADLY_NEGATIVE; break;
        case 9: iTrap=TRAP_BASE_TYPE_DEADLY_SONIC; break;
        case 10: iTrap=TRAP_BASE_TYPE_DEADLY_SPIKE; break;
        case 11: iTrap=TRAP_BASE_TYPE_DEADLY_TANGLE; break;
        }
    }
else if (iLevel<41)
    {
    iRandom=Random(4)+1;
    switch (iRandom)
        {
        case 1: iTrap=TRAP_BASE_TYPE_EPIC_ELECTRICAL; break;
        case 2: iTrap=TRAP_BASE_TYPE_EPIC_FIRE; break;
        case 3: iTrap=TRAP_BASE_TYPE_EPIC_FROST; break;
        case 4: iTrap=TRAP_BASE_TYPE_EPIC_SONIC; break;
        }
    }
else
    iTrap=TRAP_BASE_TYPE_MINOR_SPIKE;

return iTrap;
}

int HasRogue()
{
object oPC;
int iResult;
int iRogue	= GetLevelByClass(CLASS_TYPE_ROGUE, oPC)
			+ GetLevelByClass(CLASS_TYPE_SCOUT, oPC)
			+ GetLevelByClass(CLASS_TYPE_BEGUILER, oPC)
			+ GetLevelByClass(CLASS_TYPE_NINJA, oPC)
			+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
			+ GetLevelByClass(CLASS_TYPE_PSYCHIC_ROGUE, oPC);

iResult=FALSE;

oPC=GetFirstPC();
while (GetIsObjectValid(oPC))
    {
    if (iRogue >= 1)
        iResult=TRUE;
    oPC=GetNextPC();
    }

return iResult;
}

void ENSendMessageToParty(object oPC, string sMessage)
{
object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    SendMessageToPC(oPartyMember,sMessage);
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

int GetTwoHanded(string sTag)
{
int iTwoHanded;

iTwoHanded = FALSE;

if (sTag == "en3_greataxe")
    iTwoHanded = TRUE;
if (sTag == "en3_greatsword")
    iTwoHanded = TRUE;
if (sTag == "en3_spear")
    iTwoHanded = TRUE;
if (sTag == "en3_staff")
    iTwoHanded = TRUE;
if (sTag == "en3_halberd")
    iTwoHanded = TRUE;
if (sTag == "en3_hflail")
    iTwoHanded = TRUE;
if (sTag == "en3_tblsword")
    iTwoHanded = TRUE;
if (sTag == "en3_diremace")
    iTwoHanded = TRUE;
if (sTag == "en3_doubleaxe")
    iTwoHanded = TRUE;
if (sTag == "en3_hxbow")
    iTwoHanded = TRUE;
if (sTag == "en3_lxbow")
    iTwoHanded = TRUE;
if (sTag == "en3_longbow")
    iTwoHanded = TRUE;
if (sTag == "en3_scythe")
    iTwoHanded = TRUE;
if (sTag == "en3_sbow")
    iTwoHanded = TRUE;
if (sTag == "en3_falchion")
    iTwoHanded = TRUE;
if (sTag == "en3_maul")
    iTwoHanded = TRUE;

return iTwoHanded;
}

//::void main (){}