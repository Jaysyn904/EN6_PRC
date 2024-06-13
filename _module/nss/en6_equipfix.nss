void DoubleCheck(object oNPC);
void EquipMobs();

void main()
{

EquipMobs();

/*
object oNPC;

oNPC = GetFirstObjectInArea();
while (GetIsObjectValid(oNPC))
    {
    if (GetObjectType(oNPC) == OBJECT_TYPE_CREATURE && GetLocalInt(oNPC,"Armor") ==1)
        {
        if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST,oNPC)))
            {
            AssignCommand(oNPC,ActionEquipMostEffectiveArmor());
            DelayCommand(1.0,DoubleCheck(oNPC));
            }
        }
    oNPC = GetNextObjectInArea();
    }
*/
}

void EquipMobs()
{
object oMob;
object oItem;
int iItemSlot;

oMob=GetFirstObjectInArea(OBJECT_SELF);
while (GetIsObjectValid(oMob))
    {
    if (GetLocalInt(oMob,"EN5_Equip") == 1)
        {
        if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oMob)) || !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST,oMob)))
            {
            oItem=GetFirstItemInInventory(oMob);
            while (GetIsObjectValid(oItem))
                {
                iItemSlot=GetLocalInt(oItem,"EN5_EQUIP");
                AssignCommand(oMob, ActionEquipItem(oItem, iItemSlot));
                oItem=GetNextItemInInventory(oMob);
                }
            }
        }
    DelayCommand(1.0,DoubleCheck(oMob));
    oMob=GetNextObjectInArea(OBJECT_SELF);
    }
}


void DoubleCheck(object oNPC)
{
object oItem;

if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST,oNPC)))
    {
    oItem=CreateItemOnObject("en6_dclothes",oNPC);
    SetDroppableFlag(oItem,FALSE);
    AssignCommand(oNPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));
    }
}
