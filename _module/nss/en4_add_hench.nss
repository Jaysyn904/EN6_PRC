//#include "x0_i0_henchman"
#include "rd_level"

void main()
{
object oPC;

oPC = GetPCSpeaker();
AddHenchman(oPC, OBJECT_SELF);
if (GetHitDice(OBJECT_SELF) < GetHitDice(oPC))
    LevelMob(OBJECT_SELF,GetHitDice(oPC)-GetHitDice(OBJECT_SELF));

DelayCommand(1.0, AssignCommand(OBJECT_SELF,ActionForceFollowObject(oPC,5.0)));
//SetLocalString(oPC,"Henchman",GetTag(OBJECT_SELF));
//SetLocalInt(oPC,"RestGold",GetGold(oPC));
}
