void main()
{

object oWP=GetObjectByTag("TST_START");
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
