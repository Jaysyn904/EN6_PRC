#include "en5_treasure"

object GetLastOpener();

void main()
{
int iRandom;
int iItemLevel;
int iLevel;
int iAreaMinLevel;
int iAreaMaxLevel;
object oLastOpener;

oLastOpener = GetLastOpener();

if (GetLocalInt(OBJECT_SELF,GetName(oLastOpener)) != 0)
   return;
SetLocalInt(OBJECT_SELF,GetName(oLastOpener),1);


iLevel = GetHitDice(oLastOpener);
iRandom=GetLocalInt(oLastOpener,"HC1_CHEST");
if (iRandom==0)
    iRandom=Random(100);

if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    iRandom++;
if (GetLocalInt(oLastOpener,"PCRacePower") > 0)
    iRandom++;

if (iRandom<1)
    GetMagicItem(OBJECT_SELF,2,0,oLastOpener);
else if (iRandom<3)
    GetArtifact(OBJECT_SELF);
else if (iRandom<6)
    GetMagicItem(OBJECT_SELF,Random(4)+3,0,oLastOpener);
else if (iRandom<13)
    GetMagicItem(OBJECT_SELF,Random(6)+1,0,oLastOpener);
else if (iRandom<50)
    GetMagicItem(OBJECT_SELF,3,0,oLastOpener);
else
    GetMagicItem(OBJECT_SELF,2,0,oLastOpener);

CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF, Random(900)+100);

}


object GetLastOpener()
{
    if (GetIsObjectValid(GetLastOpenedBy()) == TRUE)
    {
        //dbSpeak("LastOpener: GetLastOpenedBy " + GetTag(GetLastOpenedBy()));
        return GetLastOpenedBy();
    }
    else
    if (GetIsObjectValid(GetLastKiller()) == TRUE)
    {
        //dbSpeak("LastOpener: GetLastAttacker");
        return GetLastKiller();
    }
    //dbSpeak("LastOpener: The Object is Invalid you weenie!");
    return OBJECT_INVALID;
}
