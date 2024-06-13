#include "en5_treasure"

string GetRandomName(object oHenchman);
void EquipHenchman(object oHenchman);

void main()
{
object oHenchman;
object oPC;
string sName;
string sTag;
string sPostTag;
int iClass;
int iGold;
int iHench;

oPC=GetPCSpeaker();
iGold=GetLocalInt(OBJECT_SELF,"Cost");
TakeGoldFromCreature(iGold,oPC,TRUE);

sTag=GetLocalString(OBJECT_SELF,"HenchTag");
iHench=GetLocalInt(oPC,"HenchmenBought");
iHench++;
SetLocalInt(oPC,"HenchmenBought",iHench);
sPostTag=sTag + "_P" + IntToString(GetLocalInt(oPC,"PCNumber")) + "_" + IntToString(iHench);
SetLocalString(oPC,"Henchman" + IntToString(iHench),sPostTag);

oHenchman=CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(oPC),FALSE,sPostTag);
iClass=GetLocalInt(OBJECT_SELF,"HenchmanClass");
SetLocalInt(oHenchman,"HenchmanClass",iClass);

if (iClass == EN5_CLASS_BLACKGUARD || iClass == EN5_CLASS_ASSASSIN || iClass == EN5_CLASS_PALEMASTER)
    AdjustAlignment(oPC,ALIGNMENT_EVIL,30);
if (iClass == EN5_CLASS_PALADIN || iClass == EN5_CLASS_DIVINECHAMPION)
    AdjustAlignment(oPC,ALIGNMENT_GOOD,30);

ChangeFaction(oHenchman,GetObjectByTag("en6_defender"));

sName=GetLocalString(OBJECT_SELF,"HenchName");
if (sName=="RANDOM")
    sName=GetRandomName(oHenchman);
SetName(oHenchman,sName);

if ((GetHitDice(oHenchman) - 1) < GetHitDice(oPC))
    LevelHenchman(oHenchman,GetHitDice(oPC)-GetHitDice(oHenchman)+1);

EquipHenchman(oHenchman);
AddHenchman(oPC, oHenchman);
DelayCommand(2.0, AssignCommand(oHenchman,ActionForceFollowObject(oPC,3.0)));

//Lootable henchmen means they lose inventory when rez'd.
//DelayCommand(2.0,SetLootable(oHenchman,TRUE));

SetLocalInt(oHenchman,"Henchman",1);
SetLocalString(oHenchman,"Master",GetName(oPC));

iGold=GetLocalInt(oPC,"RestGold");
if (iGold==0)
    SetLocalInt(oPC,"RestGold",GetGold(oPC));

}

string GetRandomName(object oHenchman)
{
string sFirst;
string sLast;
string sName;
int iRace;
int iGender;
int iFirst;
int iLast;
int iRandom;

iRace=GetRacialType(oHenchman);
iGender=GetGender(oHenchman);

if (iGender==GENDER_MALE)
    {
    switch (iRace)
        {
        case RACIAL_TYPE_DWARF: iFirst=NAME_FIRST_DWARF_MALE; iLast=NAME_LAST_DWARF; break;
        case RACIAL_TYPE_ELF: iFirst=NAME_FIRST_ELF_MALE; iLast=NAME_LAST_ELF; break;
        case RACIAL_TYPE_GNOME: iFirst=NAME_FIRST_GNOME_MALE; iLast=NAME_LAST_GNOME; break;
        case RACIAL_TYPE_HALFLING: iFirst=NAME_FIRST_HALFLING_MALE; iLast=NAME_LAST_HALFLING; break;
        case RACIAL_TYPE_HUMAN: iFirst=NAME_FIRST_HUMAN_MALE; iLast=NAME_LAST_HUMAN; break;
        case RACIAL_TYPE_HALFORC: iFirst=NAME_FIRST_HALFORC_MALE; iLast=NAME_LAST_HALFORC; break;
        }
    } else {
    switch (iRace)
        {
        case RACIAL_TYPE_DWARF: iFirst=NAME_FIRST_DWARF_FEMALE; iLast=NAME_LAST_DWARF; break;
        case RACIAL_TYPE_ELF: iFirst=NAME_FIRST_ELF_FEMALE; iLast=NAME_LAST_ELF; break;
        case RACIAL_TYPE_GNOME: iFirst=NAME_FIRST_GNOME_FEMALE; iLast=NAME_LAST_GNOME; break;
        case RACIAL_TYPE_HALFLING: iFirst=NAME_FIRST_HALFLING_FEMALE; iLast=NAME_LAST_HALFLING; break;
        case RACIAL_TYPE_HUMAN: iFirst=NAME_FIRST_HUMAN_FEMALE; iLast=NAME_LAST_HUMAN; break;
        case RACIAL_TYPE_HALFORC: iFirst=NAME_FIRST_HALFORC_FEMALE; iLast=NAME_LAST_HALFORC; break;
        }
    }

sFirst=RandomName(iFirst);
sLast=RandomName(iLast);
sName=sFirst + " " + sLast;

return sName;
}

void EquipHenchman(object oHenchman)
{
object oObject;
string sTag;

if (GetLevelByClass(CLASS_TYPE_ROGUE,oHenchman)>0 || GetLevelByClass(CLASS_TYPE_RANGER,oHenchman)>0)
    oObject = CreateItemOnObject("en5_start_rogue",oHenchman);
else if (GetLevelByClass(CLASS_TYPE_SORCERER,oHenchman)>0 || GetLevelByClass(CLASS_TYPE_WIZARD,oHenchman)>0)
    oObject = CreateItemOnObject("en5_start_sorc",oHenchman);
else if (GetLevelByClass(CLASS_TYPE_MONK,oHenchman)>0)
    oObject = CreateItemOnObject("en5_start_monk",oHenchman);
else
    oObject = CreateItemOnObject("en5_start_chain",oHenchman);

//Equip twice to try and defeat the PRC in a duel of equipping stuff
DelayCommand(0.1,AssignCommand(oHenchman,ClearAllActions()));
DelayCommand(0.1,AssignCommand(oHenchman,ActionEquipItem(oObject,INVENTORY_SLOT_CHEST)));
DelayCommand(1.5,AssignCommand(oHenchman,ActionEquipItem(oObject,INVENTORY_SLOT_CHEST)));

GetWeaponType(oHenchman);
sTag = "en3_" + GetWeaponTag(oHenchman);
oObject = CreateItemOnObject(sTag,oHenchman);
DelayCommand(1.0,AssignCommand(oHenchman,ActionEquipItem(oObject,INVENTORY_SLOT_RIGHTHAND)));

}
