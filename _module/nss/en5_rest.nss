#include "prc_x2_itemprop"
#include "en5_encounters"
#include "en5_misc"
#include "prc_class_const"

void RemoveTempProperties(object oPC);
void HenchmanGold(object oPC);
void HenchmanVariables(object oPC);
void ResetFaction(object oPC);

void main()
{
object oPC = GetLastPCRested();


if (GetLastRestEventType()==REST_EVENTTYPE_REST_STARTED)
    {
    GetWanderingMonster(oPC);
    }

if (GetLastRestEventType()==REST_EVENTTYPE_REST_FINISHED)
    {
    if (GetNumberPCs()<2)
        SetTime(GetTimeHour()+1,GetTimeMinute(),GetTimeSecond(),GetTimeMillisecond());
    HenchmanGold(oPC);
    HenchmanVariables(oPC);
    if (GetLocalInt(oPC,"TempPowers") == 1)
        RemoveTempProperties(oPC);

    ExecuteScript("en6_Special",oPC);
    ResetFaction(oPC);
    }
}

void ResetFaction(object oPC)
{
object oFaction;
int iFaction;

int iAnimal	= GetLevelByClass(CLASS_TYPE_DRUID, oPC)
			+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
			+ GetLevelByClass(CLASS_TYPE_HEALER, oPC)
			+ GetLevelByClass(CLASS_TYPE_RANGER, oPC)
			+ GetLevelByClass(CLASS_TYPE_SOULBORN, oPC)
			+ GetLevelByClass(CLASS_TYPE_TOTEMIST, oPC);

oFaction = GetObjectByTag("en6_commoner");
iFaction=GetReputation(oFaction,oPC);
if (iFaction<50)
    AdjustReputation(oPC,oFaction,50-iFaction);

oFaction = GetObjectByTag("en6_neutral");
iFaction=GetReputation(oFaction,oPC);
if (iFaction<50)
    AdjustReputation(oPC,oFaction,50-iFaction);

oFaction = GetObjectByTag("en6_merchant");
iFaction=GetReputation(oFaction,oPC);
if (iFaction<50)
    AdjustReputation(oPC,oFaction,50-iFaction);

if (iAnimal > 0)
    {
    oFaction = GetObjectByTag("en6_animal");
    iFaction=GetReputation(oFaction,oPC);
    if (iFaction<50)
        AdjustReputation(oPC,oFaction,50-iFaction);
    }

}

void HenchmanVariables(object oPC)
{
object oHenchman;
int iIndex;

iIndex=1;
oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,iIndex);
while (GetIsObjectValid(oHenchman))
    {
    SetLocalInt(oHenchman,"RESURRECTION",0);
    SetLocalInt(oHenchman,"RAISE_DEAD",0);
    SetLocalInt(oHenchman,"ANIMATE_DEAD",0);
    iIndex++;
    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,iIndex);
    }
}

void HenchmanGold(object oPC)
{
object oHenchman;
int iGold;
int iGoldShare;
int iGoldTake;
int iIndex;

iGold = GetGold(oPC)-GetLocalInt(oPC,"RestGold");
if (iGold<0)
    iGold=0;

iGoldShare = iGold/10;
iGoldTake = 0;

iIndex=1;
while (iIndex<11)
    {
    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,iIndex);
    if (GetIsObjectValid(oHenchman) && GetLocalInt(oHenchman,"Henchman") == 1)
        iGoldTake = iGoldTake + iGoldShare;
    iIndex++;
    }


if (iGoldTake > (iGold - iGoldShare))
    iGoldTake = iGold - iGoldShare;

if (iGoldTake>0)
    {
    SendMessageToPC(oPC,"Your henchman have taken their share of the spoils.  (" + IntToString(iGoldTake) + " gp)");
    TakeGoldFromCreature(iGoldTake,oPC,TRUE);
    }

SetLocalInt(oPC,"RestGold",GetGold(oPC));
}

void RemoveTempProperties(object oPC)
{
object oItem;

oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

//Removed until used.
//oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
//IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

SetLocalInt(oPC,"TempPowers",0);
}
