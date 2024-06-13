void main()
{
object oPC;
object oNPC;
int iMQ;
int i;

oPC=GetEnteringObject();
iMQ=GetLocalInt(GetModule(),"MQNumber");

if (GetIsPC(oPC) && iMQ==3)
    {
    oNPC=GetObjectByTag("en6_mq3_s");
    if (GetLocalInt(oNPC,"TalkOnce") == 0 && GetLocalInt(OBJECT_SELF,"Random") < 4)
        {
        SetLocalInt(oNPC,"TalkOnce",1);
        AssignCommand(oNPC,ClearAllActions());
        AssignCommand(oNPC,ActionStartConversation(oPC));
        }
    }
}


