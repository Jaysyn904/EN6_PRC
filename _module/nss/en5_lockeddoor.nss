#include "en5_misc"

void main()
{
object oPC;
object oArea;
int iMinLevel;
int iMaxLevel;
int iLevel;
int iDC;

int iRogue	= GetLevelByClass(CLASS_TYPE_ROGUE, oPC)
			+ GetLevelByClass(CLASS_TYPE_SCOUT, oPC)
			+ GetLevelByClass(CLASS_TYPE_BEGUILER, oPC)
			+ GetLevelByClass(CLASS_TYPE_NINJA, oPC)
			+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
			+ GetLevelByClass(CLASS_TYPE_PSYCHIC_ROGUE, oPC);

if (GetLocalInt(OBJECT_SELF,"Unlocked") == 1)
   return;

if (GetLocalInt(OBJECT_SELF,"LockCheck")==0)
    {
    if (Random(12)>0 && iRogue == 0)
        {
        SetLocalInt(OBJECT_SELF,"Unlocked",1);
        SetLocked(OBJECT_SELF,FALSE);
        AssignCommand(OBJECT_SELF,ActionOpenDoor(OBJECT_SELF));
        return;
        }

    if (Random(8)>0 && iRogue > 0)
        {
        SetLocalInt(OBJECT_SELF,"Unlocked",1);
        SetLocked(OBJECT_SELF,FALSE);
        AssignCommand(OBJECT_SELF,ActionOpenDoor(OBJECT_SELF));
        return;
        }
    SetLocalInt(OBJECT_SELF,"LockCheck",1);
    }

oPC = GetEnteringObject();

if (GetLocalInt(GetArea(OBJECT_SELF),"SpecialArea") == 1)
    {
    oArea=GetArea(GetObjectByTag(GetLocalString(GetArea(OBJECT_SELF),"Zone") + "_Enter"));
    iMinLevel = GetLocalInt(oArea,"MinLevel");
    iMaxLevel = GetLocalInt(oArea,"MaxLevel");
    } else {
    iMinLevel = GetLocalInt(GetArea(OBJECT_SELF),"MinLevel");
    iMaxLevel = GetLocalInt(GetArea(OBJECT_SELF),"MaxLevel");
    }

iLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;

if (iLevel<1)
    iLevel = GetHitDice(oPC);

iDC=GetLocalInt(OBJECT_SELF,"iDC");
if (iDC == 0)
    {
    iDC = iLevel + 8 + Random(10);
    SetLocalInt(OBJECT_SELF,"iDC",iDC);
    }

if (GetHasSkill(SKILL_OPEN_LOCK,oPC))
    if (GetHitDice(oPC) > GetLocalInt(OBJECT_SELF,GetName(oPC)))
        {
        if (GetIsSkillSuccessful(oPC,SKILL_OPEN_LOCK,iDC))
            {
            SetLocalInt(OBJECT_SELF,"Unlocked",1);
            SetLocked(OBJECT_SELF,FALSE);
            SendMessageToPC(oPC,"You have successfully picked the lock.");
            GiveXPToCreature(oPC,iDC*10);
            } else {
            SendMessageToPC(oPC,"You are unable to pick the lock.");
            SetLocalInt(OBJECT_SELF,GetName(oPC),GetHitDice(oPC));
            }
        } else {
        SendMessageToPC(oPC,"You have already tried to pick this lock and found it baffling.  Perhaps you should try when you have more experience.");
        }
}
