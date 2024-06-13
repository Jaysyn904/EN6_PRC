void main()
{
object oPC;
object oWP;
string sTag;

oPC=GetPlaceableLastClickedBy();

if (GetDistanceBetween(oPC,OBJECT_SELF) > 5.0)
    {
    SendMessageToPC(oPC,"You are too far away to touch the shaft of light.");
    AssignCommand(oPC,ClearAllActions());
    } else {
    if (GetIsInCombat(oPC))
        {
        SendMessageToPC(oPC,"You are too busy right now to touch the shaft of light.");
        AssignCommand(oPC,ClearAllActions());
        } else {
        AssignCommand(oPC,ClearAllActions());
        sTag=GetLocalString(GetArea(OBJECT_SELF),"Zone") + "_INFO";
        oWP=GetObjectByTag(sTag);
        AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
        }
    }

}
