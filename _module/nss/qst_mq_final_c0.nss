int StartingConditional()
{
int iResult;
int iQType;
int iNPC;
int iMQ;

iResult = FALSE;

iQType = GetLocalInt(OBJECT_SELF,"QuestType");
iNPC = GetLocalInt(OBJECT_SELF,"NPCNumber");
iMQ = GetLocalInt(GetModule(),"MainQuest");

if (iMQ < 98)
    iResult=TRUE;

return iResult;
}
