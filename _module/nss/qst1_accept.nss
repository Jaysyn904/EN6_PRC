#include "qst_include"

void main()
{
object oPC;
object oItem;
string sDescription;
string sMobName;
string sTarget;
string sLocation;
string sQS;
string sItem;
string sNPC;
string sWeapon;
int iStep;
itemproperty ip;
int iBonus;

iStep=GetLocalInt(OBJECT_SELF,"QuestStep");
if (iStep<1)
    iStep=1;
sQS="QuestStep" + IntToString(iStep);

sMobName=GetLocalString(OBJECT_SELF,sQS + "MobName");
sTarget=GetLocalString(OBJECT_SELF,sQS + "Mob");
sLocation=GetLocalString(OBJECT_SELF,sQS + "Location");
sItem=GetLocalString(OBJECT_SELF,sQS + "ItemName");
sNPC=GetLocalString(OBJECT_SELF,sQS + "NPCName");

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
SetLocalInt(OBJECT_SELF,"QuestStep1Type",1);
sDescription="I have promised " + GetName(OBJECT_SELF) + " I would take care of a " + sMobName + " located " + sLocation + ".";
SetDescription(OBJECT_SELF,sDescription);
SetStepDone(OBJECT_SELF,"I have taken care of the " + sMobName + ". I should return to " + GetName(OBJECT_SELF) + " " + GetLocalString(OBJECT_SELF,"Location") + ".");
SetJournalEntry(oPC,sDescription);
SetLocalInt(OBJECT_SELF,"QuestAccepted",1);

oPartyMember = GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oPartyMember) == TRUE)
    {
    GetWeaponType(oPartyMember);
    sWeapon = "en3_" + GetWeaponTag(oPartyMember);
    oItem=CreateItemOnObject(sWeapon,oPartyMember);
    if (GetLocalInt(OBJECT_SELF,"QuestLevel") <6)
        iBonus=1;
    else
        iBonus=2;
    if (sWeapon=="en3_monkgloves")
        {
        ip=ItemPropertyAttackBonus(iBonus);
        IPSafeAddItemProperty(oItem,ip);
        if (iBonus==1)
            ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1);
        else
            ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_2);
        IPSafeAddItemProperty(oItem,ip);
        SetName(oItem,"+" + IntToString(iBonus) + " " + GetName(oItem));
        } else {
        if (sWeapon=="en3_longbow" || sWeapon=="en3_sbow" || sWeapon=="en3_lxbow" || sWeapon=="en3_hxbow" || sWeapon=="en3_sling")
            {
            if (FeatCheck(FEAT_WEAPON_PROFICIENCY_MARTIAL,oPartyMember))
                sWeapon="en3_lsword";
            else
                sWeapon="en3_club";
            }
        ip=ItemPropertyEnhancementBonus(iBonus);
        IPSafeAddItemProperty(oItem,ip);
        SetName(oItem,"+" + IntToString(iBonus) + " " + GetName(oItem));
        }
    oPartyMember = GetNextFactionMember(oPC, TRUE);
    }

}
