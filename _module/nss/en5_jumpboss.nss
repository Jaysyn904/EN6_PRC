#include "qst_include"

void main()
{

object oWP=GetObjectByTag(GetOverallBossTag());
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
