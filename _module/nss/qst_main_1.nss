#include "qst_include"

void main()
{
location lLoc;
object oTransfer;
object oBoss;
object oChest;
object oNPC;

lLoc=GetLocation(GetObjectByTag("MainQuest_1_1"));
CreateObject(OBJECT_TYPE_CREATURE,"en6_mq1npc1",lLoc);

lLoc=GetLocation(GetObjectByTag("MainQuest_1_2"));
CreateObject(OBJECT_TYPE_CREATURE,"en6_mq1npc2",lLoc);

lLoc=GetLocation(GetObjectByTag("MainQuest_F"));
oNPC=CreateObject(OBJECT_TYPE_CREATURE,"en6_mq1npc3",lLoc);
SetLocalString(oNPC,"Tie-In","It was no minor feat for you to recover the Orb of Attraction, but I am afraid your work is not done.");

//MainQuest Step 1 Setup
/*
oTransfer=GetObjectByTag("BF1_SPECIAL_1");
SetLocalString(oTransfer,"Area","TOWER4_Enter");
oTransfer=GetObjectByTag("TOWER4_Exit");
SetLocalString(oTransfer,"Area","BF1_1_Enter");
SetLocalInt(GetModule(),"TOWER4",1);
SetLocalInt(GetObjectByTag("BF1_INFO"),"SA",1);
SetLocalInt(GetModule(),"BF1_SPECIAL_1",1);

SetLocalString(GetModule(),"SPAWN_Zone","TOWER4");
SetLocalString(GetModule(),"SPAWN_CampType","Q");
SetLocalInt(GetModule(),"SPAWN_Camp",1);
SetLocalInt(GetModule(),"SPAWN_Boss",3);
oBoss=GetQuestCamp(1,24 + Random(3));
CreateItemOnObject("en6_mq1item",oBoss);
SetLocalString(GetModule(),"SPAWN_CampType","C");
*/

//MainQuest Step 2 Setup
/*
oChest=GetObjectByTag("DM1_Chest8");
CreateItemOnObject("en6_mq2item",oChest);
*/
}
