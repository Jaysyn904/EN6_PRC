#include "qst_include"

void main()
{
object oWP;
int iMQ;
int iMQNumber;

iMQ=GetLocalInt(GetModule(),"MainQuest");
iMQNumber=GetLocalInt(GetModule(),"MQNumber");

if (iMQ==98)
    oWP=GetObjectByTag("MainQuest_F");
else
    oWP=GetObjectByTag("WP_MQ" + IntToString(iMQNumber) + "_" + IntToString(iMQ+1));

AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oWP)));
}
