void main()
{
object oMob;
object oItem;
int iItemSlot;
string sTag;

oMob=OBJECT_SELF;
ClearAllActions();

oItem=GetFirstItemInInventory(oMob);
while (GetIsObjectValid(oItem))
    {
    iItemSlot=GetLocalInt(oItem,"EN5_EQUIP");
    AssignCommand(oMob, ActionEquipItem(oItem, iItemSlot));
    oItem=GetNextItemInInventory(oMob);
    }

sTag=GetLocalString(oMob,"EN6_ARMOR");
if (sTag != "")
    {
    oItem=GetItemPossessedBy(oMob,sTag);
    AssignCommand(oMob, ActionEquipItem(oItem, iItemSlot));
    }
}
