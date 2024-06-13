void main()
{
TakeGoldFromCreature(100,GetPCSpeaker(),TRUE);
object oWP=GetObjectByTag("NH1_Stable");
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
