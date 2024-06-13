void main()
{

object oWP=GetObjectByTag("NH1_Spawn");
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
