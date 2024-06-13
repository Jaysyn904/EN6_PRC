#include "en5_treasure"
#include "en5_misc"
#include "nw_i0_tool"

void GiveXPToParty(object oPC,int iXP,int iPartyCount,int iCR,int iBonus);
int GetHighestLevel(object oPC);
int GetPartyCount(object oPC);
int GetAssociates(object oPC);
int GetNumberOfHenchman(object oPC);
void MakeEvil(object oPC,int iMovement);

void main()
{
	object oPC;
	object oMob;
	int iLevel;
	int iLevelMod;
	int iCR;
	int iBonus;
	float fCR;
	int iXPValue;
	string sCR;
	string sXPValue;

	oPC = GetLastKiller();
	if (!GetAssociateType(oPC) == ASSOCIATE_TYPE_NONE)
		oPC =GetMaster(oPC);

	oMob = OBJECT_SELF;

	iLevel = GetHighestLevel(oPC);
	fCR = GetChallengeRating(oMob);

	iCR = FloatToInt(fCR);
	if (iCR > 40)
		sCR = "C40";
	else
		sCR = "C" + IntToString(iCR);

	sXPValue = Get2DAString("xptable",sCR,iLevel-1);
	iXPValue = StringToInt(sXPValue);
	iBonus=GetLocalInt(oMob,"BonusXP");

	GiveXPToParty(oPC,iXPValue,GetPartyCount(oPC),iCR,iBonus);

	if (GetFactionEqual(oMob,GetObjectByTag("en6_neutral")))
		MakeEvil(oPC,20);
	if (GetFactionEqual(oMob,GetObjectByTag("en6_defender")))
		MakeEvil(oPC,15);
	if (GetFactionEqual(oMob,GetObjectByTag("en6_good")))
		MakeEvil(oPC,10);
	if (GetFactionEqual(oMob,GetObjectByTag("en6_commoner")))
		MakeEvil(oPC,20);
	if (GetFactionEqual(oMob,GetObjectByTag("en6_merchant")))
		MakeEvil(oPC,10);

	if (GetHitDice(oPC) <= GetLocalInt(oMob,"MagicItemLevel"))
		{
		GetMagicItem(oMob,GetItemLevel(iCR),0,oPC);
		}

	if (GetLocalInt(oMob,"MainBoss") == 1)
		{
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY),GetLocation(oMob),3.0);
		SendMessageToParty(oPC,"You recieve bonus experience for defeating " + GetName(oMob) + ".");
		RewardPartyXP(10000, oPC);
		}
}

void GiveXPToParty(object oPC,int iXP,int iPartyCount, int iCR,int iBonus)
{
	int iXPValue;
	int iXPBonus;
	int iAssociates;
	int iLvlMod;
	int iHighestLvl;
	int iBonusXPValue;

	iHighestLvl=GetHighestLevel(oPC);
	if (iHighestLvl<GetHitDice(oPC))
		iHighestLvl=GetHitDice(oPC);

	object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	while (GetIsObjectValid(oPartyMember) == TRUE)
	{
		if (GetAssociateType(oPartyMember) == ASSOCIATE_TYPE_NONE && GetArea(oPartyMember) == GetArea(oPC))
			{
			iXPValue = iXP*10/iPartyCount;

			iAssociates=GetNumberOfHenchman(oPartyMember);
			if (iAssociates>4)
				iAssociates=4;
			iXPValue = iXPValue - iXPValue * iAssociates/5;

			iAssociates = GetAssociates(oPartyMember);
			iAssociates--;
			if (iAssociates>5)
				iAssociates=5;
			iXPValue = iXPValue - iXPValue * iAssociates/8;

			if (iXPValue<iXP/iPartyCount)
				iXPValue=iXP/iPartyCount;


			//bonus for killing higher lvl mobs
			if (iCR>= iHighestLvl && iCR <iHighestLvl+2)
				iLvlMod=8;
			if (iCR> iHighestLvl +1)
				iLvlMod=15;
			iLvlMod=iLvlMod + (GetHitDice(oPartyMember)/2);
			if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
				iLvlMod = iLvlMod - 10;

			iBonusXPValue =  iXPValue * (100 - 35 - iLvlMod)/100;
			iXPValue=iXPValue * (35 + iLvlMod)/100;

			GiveXPToCreature(oPartyMember,iXPValue);
			if (iBonus>0)
				{
				SendMessageToPC(oPartyMember,"You gain bonus experience.");
				GiveXPToCreature(oPartyMember,iBonusXPValue);
				}
			}
		oPartyMember = GetNextFactionMember(oPC, TRUE);
	}
}

int GetAssociates(object oPC)
{
	int iIndex;
	int iCount;

	iIndex=1;
	iCount=0;
	while (iIndex<11)
		{
		if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,iIndex)))
			iCount++;
		iIndex++;
		}
	return iCount;
}


int GetNumberOfHenchman(object oPC)
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

int GetHighestLevel(object oPC)
{
	object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	int iLevel;
	int iHighestLevel;

	iHighestLevel = 1;
	while (GetIsObjectValid(oPartyMember) == TRUE)
		{
		iLevel = GetHitDice(oPartyMember) + GetLocalInt(oPartyMember,"PCLevelMod");
		if (iLevel > iHighestLevel)
			iHighestLevel = iLevel;
		oPartyMember = GetNextFactionMember(oPC, TRUE);
		}
	return iHighestLevel;
}

int GetPartyCount(object oPC)
{
	object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	int iCount;

	iCount = 0;
	while (GetIsObjectValid(oPartyMember) == TRUE)
		{
		if (GetAssociateType(oPartyMember) == ASSOCIATE_TYPE_NONE && GetArea(oPartyMember) == GetArea(oPC))
			iCount++;
		oPartyMember = GetNextFactionMember(oPC, TRUE);
		}
	return iCount;
}

void MakeEvil(object oPC,int iMovement)
{
	object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	while (GetIsObjectValid(oPartyMember) == TRUE)
	{
		if (GetGoodEvilValue(oPartyMember)>30)
			AdjustAlignment(oPartyMember,ALIGNMENT_EVIL,iMovement);
		
		oPartyMember = GetNextFactionMember(oPC, TRUE);
	}
}