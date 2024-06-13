#include "en5_treasure"

void main()
{
int iRandom;
string sTag;
location lLoc;
object oMob;

ExecuteScript("en6_areaenter",OBJECT_SELF);

if (GetLocalInt(OBJECT_SELF,"DoOnce")==0)
    {
    SetLocalInt(OBJECT_SELF,"DoOnce",1);
    iRandom=Random(4)+1;
    if (iRandom==1)
        sTag="en6_ebony";
    if (iRandom==2)
        sTag="EN5_Flame";
    if (iRandom==3)
        sTag="en6_lightbane";
    if (iRandom==4)
        sTag="en6_kaer";

    lLoc=GetLocation(GetObjectByTag("RC1_Lair"));
    oMob=CreateObject(OBJECT_TYPE_CREATURE,sTag,lLoc);
    CreateItemOnObject("RC1_KEY",oMob);
    GetMagicItem(oMob,5);
    }

}
