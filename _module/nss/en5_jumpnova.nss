void main()
{

object oWP=GetObjectByTag("NC1_Stable");
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
