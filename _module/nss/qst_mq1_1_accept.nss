#include "qst_include"

void main()
{
object oPC;
object oHenchman;
object oObject;
string sDescription;

oPC=GetPCSpeaker();

object oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    SetLocalString(oPartyMember,"QuestNPC",GetTag(OBJECT_SELF));
    SetLocalString(oPartyMember,"QuestName","Cleansing the Land");
    SetLocalInt(oPartyMember,"OnQuest",1);
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }

SetLocalInt(OBJECT_SELF,"QuestStep",1);
SetLocalInt(OBJECT_SELF,"QuestStep1Type",6);
SetLocalString(OBJECT_SELF,"QuestStep1Item","en6_mq1item");
sDescription="I have promised " + GetName(OBJECT_SELF) + " I would investigate the abandoned tower east of the road in the Western Black Forest";
SetDescription(OBJECT_SELF,sDescription);
SetStepDone(OBJECT_SELF,"I have found a strange letter.  This might be what " + GetName(OBJECT_SELF) + " was looking for.  I should return to him at the woodsman cottage in the Black Forest.");
SetJournalEntry(oPC,sDescription);
SetLocalInt(OBJECT_SELF,"QuestAccepted",1);
SetLocalInt(OBJECT_SELF,"MainQuestNPC",1);

oHenchman=CreateObject(OBJECT_TYPE_CREATURE,"en6_human_hm",GetLocation(oPC),FALSE,"mq1_1_scout");
SetLocalInt(oHenchman,"HenchmanClass",EN5_CLASS_RANGER);
ChangeFaction(oHenchman,GetObjectByTag("en6_defender"));
SetName(oHenchman,"Scout Randolf");
LevelHenchman(oHenchman,20);

oObject = CreateItemOnObject("en5_start_rogue",oHenchman);
DelayCommand(1.0,AssignCommand(oHenchman,ActionEquipItem(oObject,INVENTORY_SLOT_CHEST)));
oObject = CreateItemOnObject("en3_lsword",oHenchman);
oObject = CreateItemOnObject("en3_longbow",oHenchman);
DelayCommand(1.0,AssignCommand(oHenchman,ActionEquipItem(oObject,INVENTORY_SLOT_RIGHTHAND)));
oObject = CreateItemOnObject("NW_WAMMAR003",oHenchman,99);
DelayCommand(1.0,AssignCommand(oHenchman,ActionEquipItem(oObject,INVENTORY_SLOT_ARROWS)));

AddHenchman(oPC, oHenchman);
DelayCommand(2.0, AssignCommand(oHenchman,ActionForceFollowObject(oPC,5.0)));

}
