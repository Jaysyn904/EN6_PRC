void main()
{
string sCorpse;
string sTag;
object oWP;
int iCampSpot;
location lLoc;

iCampSpot=GetLocalInt(OBJECT_SELF,"QuestStep1CampSpot");
sTag=GetLocalString(OBJECT_SELF,"QuestZone") + "_C" + IntToString(iCampSpot) + "_Treasure";
sCorpse="en6_corpse";
oWP=GetObjectByTag(sTag);
lLoc=GetLocation(oWP);

CreateObject(OBJECT_TYPE_PLACEABLE,sCorpse,lLoc);

}
