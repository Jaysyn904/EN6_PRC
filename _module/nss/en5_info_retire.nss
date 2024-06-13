void main()
{
location lPurg;

lPurg = GetLocation(GetObjectByTag("spawn_purgatory"));
AssignCommand(GetPCSpeaker(),JumpToLocation(lPurg));
}
