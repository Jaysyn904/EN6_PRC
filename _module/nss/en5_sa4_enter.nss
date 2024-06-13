void main()
{
string sTag;
object oChest;

if (GetLocalInt(OBJECT_SELF,"EN5_DoOnce") == 0)
    {
    sTag="SA4_TREASURE" + IntToString(Random(2)+1);
    oChest=GetObjectByTag(sTag);
    CreateItemOnObject("SA4_Key",oChest);
    SetLocalInt(OBJECT_SELF,"EN5_DoOnce",1);
    }
ExecuteScript("en5_unlockdoors",OBJECT_SELF);
}
