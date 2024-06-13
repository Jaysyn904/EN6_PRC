#include "qst_include"

void main()
{
object oPC;
object oHenchman;
object oObject;
string sDescription;

oPC=GetPCSpeaker();

AcceptQuest(oPC,OBJECT_SELF);

oHenchman=CreateObject(OBJECT_TYPE_CREATURE,"en6_human_hm",GetLocation(oPC),FALSE,"mq1_1_scout");
SetLocalInt(oHenchman,"HenchmanClass",EN5_CLASS_RANGER);
ChangeFaction(oHenchman,GetObjectByTag("en6_defender"));
SetName(oHenchman,"Scout Randolf");
LevelHenchman(oHenchman,20+Random(3));

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
