void main()
{
object oNPC;
object oChair;

if (GetLocalInt(OBJECT_SELF,"DoOnce") > 0)
    return;
if (GetIsPC(GetEnteringObject()))
    {
    SetLocalInt(OBJECT_SELF,"DoOnce",1);

    oNPC = GetFirstObjectInArea();
    while (GetIsObjectValid(oNPC))
        {
        if (GetObjectType(oNPC) == OBJECT_TYPE_CREATURE)
            {
            oChair = GetObjectByTag(GetTag(oNPC) + "_chair");
            if (GetIsObjectValid(oChair))
                {
                SetLocalInt(oNPC,"Sit",1);
                DelayCommand(0.1f,AssignCommand(oNPC,ActionSit(oChair)));
                //SendMessageToPC(GetFirstPC(),GetName(oNPC) + " run to " + GetTag(GetArea(oChair)));
                }
            }
        oNPC = GetNextObjectInArea();
        }

    ExecuteScript("en5_ae",OBJECT_SELF);
    DelayCommand(3.0,ExecuteScript("en5_ae",OBJECT_SELF));
    }
}
