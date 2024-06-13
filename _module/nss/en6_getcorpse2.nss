void main()
{
string sCorpse;
string sTag;
string sMob;
object oWP;
int iCampSpot;
location lLoc;
object oCorpse;
object oMob;
object oItemToTake;

iCampSpot=GetLocalInt(OBJECT_SELF,"QuestStep1CampSpot");
sTag=GetLocalString(OBJECT_SELF,"QuestZone") + "_C" + IntToString(iCampSpot) + "_Treasure";
sCorpse="en6_corpse2";
oWP=GetObjectByTag(sTag);
lLoc=GetLocation(oWP);

oCorpse=CreateObject(OBJECT_TYPE_PLACEABLE,sCorpse,lLoc);
CreateItemOnObject("en3_scabbard",oCorpse);

sMob=GetLocalString(OBJECT_SELF,"QuestStep1MobTag");
oMob=GetObjectByTag(sMob);
oItemToTake = GetItemPossessedBy(oMob, "en3_scabbard");
if(GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);
}
