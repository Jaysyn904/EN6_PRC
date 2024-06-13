void main()
{
object oPC;
object oWP;

oPC = GetPCSpeaker();
TakeGoldFromCreature(100,oPC,TRUE);

oWP = GetObjectByTag("BH1_Spawn");
AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
}
