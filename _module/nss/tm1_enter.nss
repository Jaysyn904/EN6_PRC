void main()
{
object oTrap;

if (GetLocalInt(OBJECT_SELF,"RunOnce") == 0)
    {
    oTrap=GetObjectByTag("TM1_Teleport" + IntToString(Random(2)+1));
    SetLocalInt(oTrap,"Active",1);
    SetLocalInt(OBJECT_SELF,"RunOnce",1);
    }
ExecuteScript("en6_areaenter",OBJECT_SELF);
}
