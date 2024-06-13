#include "en5_misc"

void EquipMobs();
void UnequipWeapons(object oMob);
void MQEffects(object oArea);

void main()
{
object oPC;

oPC = GetEnteringObject();

if (GetIsPC(oPC))
    {
    EquipMobs();
    MQEffects(GetArea(oPC));
    }
}

void EquipMobs()
{
object oMob;
object oItem;
int iItemSlot;

oMob=GetFirstObjectInArea(OBJECT_SELF);
while (GetIsObjectValid(oMob))
    {
    if (GetObjectType(oMob) == OBJECT_TYPE_CREATURE && !GetIsPC(oMob) && GetLocalInt(oMob,"Sit") == 0)
        {
        if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST,oMob)) || !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oMob)))
            DelayCommand(0.1,ExecuteScript("en6_equip",oMob));
        if (GetLocalInt(oMob,"EN6_DISARM") == 1)
            {
            DelayCommand(1.0,UnequipWeapons(oMob));
            }
        }
    oMob=GetNextObjectInArea(OBJECT_SELF);
    }
}

void UnequipWeapons(object oMob)
{

AssignCommand(oMob,ClearAllActions());
AssignCommand(oMob,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oMob)));
AssignCommand(oMob,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oMob)));
AssignCommand(oMob,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_HEAD,oMob)));

}

void MQEffects(object oArea)
{
int iMQ;
int iMQNumber;
int iFogAmount;
int iFA;
int iFC;

iMQNumber=GetLocalInt(GetModule(),"MQNumber");
iMQ=GetLocalInt(GetModule(),"MainQuest");

if (iMQNumber == 3)
    {
    iFogAmount=GetMaxLevel(GetLocalString(OBJECT_SELF,"Zone"))/4;
    if (iFogAmount>10)
        iFogAmount=10;
    if (iFogAmount<1)
        iFogAmount=1;
    if (iMQ<4 && !GetIsAreaInterior(oArea) && GetLocalInt(oArea,"MQ_Fog") == 0)
        {
        SetLocalInt(oArea,"MQ_Fog",1);

        iFA=GetFogAmount(FOG_TYPE_SUN,oArea);
        iFC=GetFogColor(FOG_TYPE_SUN,oArea);
        SetLocalInt(oArea,"SUN_FA",iFA);
        SetLocalInt(oArea,"SUN_FC",iFC);

        iFA=GetFogAmount(FOG_TYPE_MOON,oArea);
        iFC=GetFogColor(FOG_TYPE_MOON,oArea);
        SetLocalInt(oArea,"MOON_FA",iFA);
        SetLocalInt(oArea,"MOON_FC",iFC);

        SetFogColor(FOG_TYPE_ALL,FOG_COLOR_GREEN,oArea);
        SetFogAmount(FOG_TYPE_ALL,iFogAmount);
        }
    if (iMQ>3 && !GetIsAreaInterior(oArea) && GetLocalInt(oArea,"MQ_Fog") == 1)
        {
        SetLocalInt(oArea,"MQ_Fog",0);
        SetFogAmount(FOG_TYPE_SUN,GetLocalInt(oArea,"SUN_FA"));
        SetFogColor(FOG_TYPE_SUN,GetLocalInt(oArea,"SUN_FC"));
        SetFogAmount(FOG_TYPE_MOON,GetLocalInt(oArea,"MOON_FA"));
        SetFogColor(FOG_TYPE_MOON,GetLocalInt(oArea,"MOON_FC"));
        }
    }
if (iMQNumber == 4)
    {
    if (iMQ<99 && !GetIsAreaInterior(oArea) && GetLocalInt(oArea,"MQ4_DoWeather")==0)
        {
        SetLocalInt(oArea,"MQ4_DoWeather",1);
        SetWeather(oArea,WEATHER_RAIN);
        } else {
        if (GetWeather(oArea) == WEATHER_RAIN)
            SetWeather(oArea,WEATHER_USE_AREA_SETTINGS);
        }
    }

}
