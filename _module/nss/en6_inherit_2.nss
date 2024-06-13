#include "en5_treasure"

void main()
{
object oPC;
int iRandom;

oPC=GetPCSpeaker();
iRandom=Random(4);

if (iRandom<1)
    {
    GiveGoldToCreature(oPC,500);
    }
else if (iRandom<2)
    {
    GiveGoldToCreature(oPC,1000);
    }
else if (iRandom<3)
    {
    if (Random(2)==0)
        GetMagicItem(oPC,1,1);
    else
        GetMagicItem(oPC,1,2);
    }
else
    {
        GetMagicItem(oPC,1,5);
    }

SetLocalInt(OBJECT_SELF,"G" + GetName(oPC),1);
}
