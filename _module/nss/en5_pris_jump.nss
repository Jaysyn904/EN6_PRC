void main()
{
object oWP;
string sZone;

sZone=GetLocalString(OBJECT_SELF,"Zone");
oWP=GetObjectByTag(sZone + "_Town");
if (GetIsObjectValid(oWP))
    DelayCommand(10.0,AssignCommand(OBJECT_SELF,JumpToLocation(GetLocation(oWP))));
else
    {
    oWP=GetObjectByTag(sZone + "_INFO");
    if (GetIsObjectValid(oWP))
        DelayCommand(10.0,AssignCommand(OBJECT_SELF,JumpToLocation(GetLocation(oWP))));
    }
}
