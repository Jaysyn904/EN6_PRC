void main()
{
SetLocalInt(GetModule(),"MainQuest",2);
object oWP=GetObjectByTag("en6_mq1npc3");
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
