void main()
{
object oDuke;
object oThrone;

ExecuteScript("en6_sit_enter",OBJECT_SELF);

if (GetLocalInt(GetModule(),"MainQuest") >=99 && GetLocalInt(OBJECT_SELF,"DoDukeOnce") == 0)
    {
    SetLocalInt(OBJECT_SELF,"DoDukeOnce",1);
    oDuke=CreateObject(OBJECT_TYPE_CREATURE,"en6_duke",GetLocation(GetObjectByTag("NC_Duke")));
    oThrone=GetObjectByTag("NC_Throne");
    DelayCommand(1.0f,AssignCommand(oDuke,ClearAllActions()));
    DelayCommand(2.0f,AssignCommand(oDuke,ActionSit(oThrone)));
    }
}
