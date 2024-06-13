#include "qst_include"

void main()
{
object oPC;
string sDescription;
string sMobName;
string sTarget;
string sLocation;
string sQS;
string sItem;
string sNPC;
string sWeapon;
int iStep;
int iBonus;

iStep=GetLocalInt(OBJECT_SELF,"QuestStep");
if (iStep<1)
    iStep=1;
sQS="QuestStep" + IntToString(iStep);

sTarget=GetLocalString(GetModule(),"T3Mobs");
sMobName = "leader of the " + sTarget;
SetLocalString(OBJECT_SELF,sQS + "MobName",sMobName);
//sMobName=GetLocalString(OBJECT_SELF,sQS + "MobName");
sLocation="in a nearby cave";
SetLocalString(OBJECT_SELF,sQS + "Location",sLocation);
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
sDescription="I have promised " + GetName(OBJECT_SELF) + " I would take care of the " + sMobName + " located " + sLocation + ".";
SetDescription(OBJECT_SELF,sDescription);
SetStepDone(OBJECT_SELF,"I have taken care of the " + sMobName + ". I should return to " + GetName(OBJECT_SELF) + " " + GetLocalString(OBJECT_SELF,"Location") + ".");
SetJournalEntry(oPC,sDescription);
SetLocalInt(OBJECT_SELF,"QuestAccepted",1);
}
