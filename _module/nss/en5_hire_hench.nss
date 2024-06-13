#include "en5_misc"

void main()
{
object oPC;

oPC=GetPCSpeaker();
if ((GetHitDice(OBJECT_SELF) - 1) < GetHitDice(oPC))
    LevelHenchman(OBJECT_SELF,GetHitDice(oPC)-GetHitDice(OBJECT_SELF)+1);
AddHenchman(oPC, OBJECT_SELF);
DelayCommand(1.0, AssignCommand(OBJECT_SELF,ActionForceFollowObject(oPC,5.0)));
SetLocalInt(OBJECT_SELF,"Henchman",1);
SetLocalInt(oPC,"RestGold",GetGold(oPC));
}
