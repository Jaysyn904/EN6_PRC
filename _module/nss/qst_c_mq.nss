int StartingConditional()
{
int iResult;
int iQType;
int iNPC;
int iMQ;

iResult = FALSE;

iQType = GetLocalInt(OBJECT_SELF,"QuestType");
iNPC = GetLocalInt(OBJECT_SELF,"QuestNPCNumber");
iMQ = GetLocalInt(GetModule(),"MainQuest");

if (iQType == 1 && iMQ+1 < iNPC)
    iResult=TRUE;

return iResult;
}
