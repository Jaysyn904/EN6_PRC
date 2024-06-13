void main()
{
//SetLocalInt(GetModule(),"MainQuest",1);
//SetLocalInt(GetPCSpeaker(),"MQ6ItemMade",1);
object oWP=GetObjectByTag("RD1_1_Enter");
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
