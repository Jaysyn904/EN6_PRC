#include "en5_spawnzone"

void main()
{
int iLevel;
object oPC;

oPC = GetEnteringObject();

if (GetIsPC(oPC) && GetLocalInt(OBJECT_SELF,"Entered")==0)
    {
    SetLocalInt(OBJECT_SELF,"Entered",1);
    iLevel=GetLocalInt(oPC,"QuestLevel");
    if (iLevel==0)
        iLevel=GetHitDice(oPC);
    SetLocalInt(OBJECT_SELF,"MinLevel",iLevel);
    SetLocalInt(OBJECT_SELF,"MaxLevel",iLevel);
    ExecuteScript("en5_areaenter",OBJECT_SELF);
    }
}
