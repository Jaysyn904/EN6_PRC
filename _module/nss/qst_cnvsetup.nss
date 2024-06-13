#include "qst_convo"
#include "en5_rankings"

int StartingConditional()
{
int iResult;
int iExecute;
int iNPCNumber;
int iMQ;
string sSpeak;
string sAccomplishment;
string sText;
string sName;
string sLocation;

iExecute=GetLocalInt(OBJECT_SELF,"QuestExecute");
if (iExecute == 1 && GetLocalInt(OBJECT_SELF,"Implement") == 0)
    {
    ExecuteScript("qst_implement",OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"Implement",1);
    }

AdvanceQuestConvo(0);
sSpeak=GetLocalString(OBJECT_SELF,"QuestOneLiner");
if (sSpeak != "")
    SetCustomToken(109,sSpeak);

if (GetLocalInt(OBJECT_SELF,"QuestType")==1)
    {
    iNPCNumber=GetLocalInt(OBJECT_SELF,"QuestNPCNumber");
    iMQ = GetLocalInt(GetModule(),"MainQuest");
    if (iMQ+1<iNPCNumber)
        {
        sName=GetLocalString(GetModule(),"MQ_NPC" + IntToString(iMQ+1) + "Name");
        sLocation=GetLocalString(GetModule(),"MQ_NPC" + IntToString(iMQ+1) + "Location");
        SetCustomToken(108,sName + " " + sLocation);
        }

    }


SetLocalInt(OBJECT_SELF,"Brag",0);
sAccomplishment = GetLocalString(GetPCSpeaker(),GetMyZone()+ "_Accomplishment");
if (sAccomplishment != "")
    {
    sText = "I heard you " + sAccomplishment + ".  You have my thanks.  How may I help you?";
    SetLocalInt(OBJECT_SELF,"Brag",1);
    SetCustomToken(400,sText);
    }
sAccomplishment=GetMajorAccomplishment(GetPCSpeaker());
if (sAccomplishment == "")
    sAccomplishment = "did nothing special";
sText = "I heard you " + sAccomplishment;
SetCustomToken(401,sText);

iResult = FALSE;
return iResult;
}
