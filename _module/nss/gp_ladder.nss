void main()
{
object oPC;
oPC=GetPlaceableLastClickedBy();

if (GetDistanceBetween(oPC,OBJECT_SELF) > 4.0)
    {
    SendMessageToPC(oPC,"You are too far away to climb the ladder.");
    AssignCommand(oPC,ClearAllActions());
    }
else
    {
    if (GetIsInCombat(oPC))
        {
        SendMessageToPC(oPC,"You are too busy to climb the ladder.");
        AssignCommand(oPC,ClearAllActions());
        } else {
        object oWP=GetObjectByTag("CC2_GP_Exit");
        AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
        }

    }
}
