void main()
{
object oPC;
object oWP;

oPC = GetPCSpeaker();
TakeGoldFromCreature(100,oPC,TRUE);

oWP = GetObjectByTag("MH_Dock");
AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
}
