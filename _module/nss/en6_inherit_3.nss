#include "en5_treasure"

void main()
{
object oPC;
object oChest;
int iRandom;
int iCampSpot;
string sZone;
string sTag;

oPC=GetPCSpeaker();

sZone=GetLocalString(OBJECT_SELF,"QuestZone");
iCampSpot=GetLocalInt(OBJECT_SELF,"QuestStep1CampSpot");
sTag=sZone + "_C" + IntToString(iCampSpot) + "_Treasure_S";
oChest=GetObjectByTag(sTag);
if (!GetIsObjectValid(oChest))
    {
    sTag=GetLocalString(OBJECT_SELF,"QuestStep1MobTag");
    oChest=GetObjectByTag(sTag);
    }

iRandom=Random(4);

if (iRandom<1)
    {
    CreateItemOnObject("NW_IT_GOLD001", oChest, 500);
    }
else if (iRandom<2)
    {
    CreateItemOnObject("NW_IT_GOLD001", oChest, 1000);
    }
else if (iRandom<3)
    {
    if (Random(2)==0)
        GetMagicItem(oChest,1,1,oPC);
    else
        GetMagicItem(oChest,1,2,oPC);
    }
else
    {
        GetMagicItem(oChest,1,5,oPC);
    }

SetLocalInt(OBJECT_SELF,"QuestComplete",1);
SetLocalInt(OBJECT_SELF,"QuestLine",0);
SetLocalInt(OBJECT_SELF,"QuestStep",1);
SetLocalInt(OBJECT_SELF,"QuestLineStart",100);

}
