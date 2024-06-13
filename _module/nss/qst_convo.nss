#include "nw_i0_tool"
#include "qst_include"

void AdvanceQuestConvo(int iResponse);
int CheckResponse(int iResponse);
void LineDone();
object GetConvoQuestNPC(object oQuestNPC=OBJECT_SELF);
void StepDone(object oPC,object oQuestNPC);
int GetHasQuestLine(object oQuestNPC);

void AdvanceQuestConvo(int iResponse)
{
object oQuestNPC;
object oItemToTake;
string sString;
string sLine;
string sScript;
string sCheck;
string sResponse;
string sItem;
int iIndex;
int iLine;
int iStep;
int iAccept;
int iDestroyItem;
int iStepDone;
int iLineStart;
int iStop;


oQuestNPC=GetConvoQuestNPC();

iStep=GetLocalInt(oQuestNPC,"QuestStep");
iLine=GetLocalInt(oQuestNPC,"QuestLine");
if (iStep<1)
    iStep=1;
sResponse="QuestStep" + IntToString(iStep) + "Line" +  IntToString(iLine) + "Response" + IntToString(iResponse);


if (iResponse>0)
    {
    sScript=GetLocalString(oQuestNPC,sResponse + "Script");
    if (sScript!="")
        ExecuteScript(sScript,oQuestNPC);
    iIndex=GetLocalInt(oQuestNPC,sResponse + "Goto");
    iAccept=GetLocalInt(oQuestNPC,sResponse + "Accept");
    iStepDone=GetLocalInt(oQuestNPC,sResponse + "StepDone");
    //iLineStart=GetLocalInt(oQuestNPC,sResponse + "LineStart");
    iDestroyItem=GetLocalInt(oQuestNPC,sResponse + "DeleteItem");
    iStop=GetLocalInt(oQuestNPC,sResponse + "Stop");
    if (iDestroyItem>0)
        {
        sItem=GetLocalString(oQuestNPC,"QuestStep" + IntToString(iStep) + "Item");
        oItemToTake = GetItemPossessedBy(GetPCSpeaker(), sItem);
        DestroyObject(oItemToTake);
        }
    if (iAccept > 0)
        {
        AcceptQuest(GetPCSpeaker(),oQuestNPC);
        //SetLocalInt(oQuestNPC,"QuestLineStart",iAccept);
        }
    if (iStepDone > 0)
        {
        StepDone(GetPCSpeaker(),oQuestNPC);
        iStep++;
        SetLocalInt(oQuestNPC,"QuestLineStart",1);
        iIndex=1;
        }
    if (iStop > 0)
        {
        SetLocalInt(oQuestNPC,"QuestLineStart",iIndex);
        iIndex=0;
        }
    }
else
    {
    if (GetHasQuestLine(oQuestNPC))
        {
        iIndex=GetLocalInt(oQuestNPC,"QuestLineStart");
        if (iIndex<1)
            iIndex=1;
        }
    }

SetLocalInt(oQuestNPC,"QuestLine",iIndex);

//Make sure that if we are talking to a quest npc acting as a quest helper we end dialogue
//at last line instead of carrying on into that quest npc's quest dialogue.

//if (iIndex==0 && GetTag(oQuestNPC) != GetTag(OBJECT_SELF))
//    SetLocalInt(OBJECT_SELF,"ExitConvo",1);

sLine="QuestStep" + IntToString(iStep) + "Line" + IntToString(iIndex);

sString=GetLocalString(oQuestNPC,sLine);
sString=FixResponse(oQuestNPC,sString);
SetCustomToken(100,sString);

iIndex=1;
while (iIndex<=5)
    {
    sString=GetLocalString(oQuestNPC,sLine + "Response" + IntToString(iIndex));
    sString=FixResponse(oQuestNPC,sString);
    SetCustomToken(100+iIndex,sString);

    iIndex++;
    }
}

int CheckResponse(int iResponse)
{
object oQuestNPC;
string sString;
string sLine;
string sItem;
int iStep;
int iIndex;
int iResult;
int iCheck;
int iLine;
int iBossOnly;

oQuestNPC=GetConvoQuestNPC();
iResult = TRUE;

/*
if (GetLocalInt(OBJECT_SELF,"ExitConvo") ==1)
    {
    iResult = FALSE;
    SetLocalInt(OBJECT_SELF,"ExitConvo",0);
    }
*/

iStep=GetLocalInt(oQuestNPC,"QuestStep");
if (iStep<1)
    iStep=1;
iIndex=GetLocalInt(oQuestNPC,"QuestLine");
sLine="QuestStep" + IntToString(iStep) + "Line" + IntToString(iIndex);

if (iResponse==0)
    iResult=GetHasQuestLine(oQuestNPC);

//iCheck 1=Mob 2=Item 3=Mob+Item
iCheck=GetLocalInt(oQuestNPC,sLine + "Response" + IntToString(iResponse) + "Check");
if (iResponse>0 && iCheck>0)
    {
    if (iCheck==1)
        {
        iResult=CheckMobs(oQuestNPC);
        }
    if (iCheck==2)
        {
        sItem=GetLocalString(oQuestNPC,"QuestStep" + IntToString(iStep) + "Item");
        if (!HasItem(GetPCSpeaker(),sItem))
            iResult=FALSE;
        }
    if (iCheck==3)
        {
        iResult=CheckMobs(oQuestNPC);
        sItem=GetLocalString(oQuestNPC,"QuestStep" + IntToString(iStep) + "Item");
        if (!HasItem(GetPCSpeaker(),sItem))
            iResult=FALSE;
        }
    }

//Start with 2 because 1 is allowed to be blank.
if (iResponse>1)
    {
    sString=GetLocalString(oQuestNPC,sLine + "Response" + IntToString(iResponse));
    if (sString=="")
        iResult=FALSE;
    }

if (iResponse == 0 && iResult == FALSE && GetLocalInt(oQuestNPC,"QuestLine") == 0)
   SetLocalInt(oQuestNPC,"QuestLine",GetLocalInt(oQuestNPC,"QuestLineStart"));


return iResult;
}


int GetHasQuestLine(object oQuestNPC)
{
int iResult;
int iStep;
int iIndex;
int iLineStart;
string sString;
string sLine;

iResult=TRUE;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
iIndex=GetLocalInt(oQuestNPC,"QuestLine");
iLineStart = GetLocalInt(oQuestNPC,"QuestLineStart");


if (iStep<1)
    iStep=1;

sLine="QuestStep" + IntToString(iStep) + "Line" + IntToString(iIndex);
sString=GetLocalString(oQuestNPC,sLine);
//Detects if PC on quest, if NPC is not quest giver or quest npc target.
if (GetLocalInt(GetPCSpeaker(),"OnQuest")>0 && GetLocalInt(oQuestNPC,sLine+"NPC")==0 && GetLocalString(GetPCSpeaker(),"QuestNPC") != GetTag(OBJECT_SELF))
    iResult=FALSE;


//Detects if PC is supposed to talk to quest helper and whether or not this is the helper.
if (GetLocalInt(oQuestNPC,sLine+"NPC")>0 && GetLocalString(GetPCSpeaker(),"QuestTarget") != GetTag(OBJECT_SELF))
    iResult=FALSE;

//Detects quest helper on first line of their dialogue before linestart has been set.
if (iLineStart>iIndex)
    {
    sLine="QuestStep" + IntToString(iStep) + "Line" + IntToString(iLineStart);

    if (GetLocalInt(oQuestNPC,sLine+"NPC")>0 && GetLocalString(GetPCSpeaker(),"QuestTarget") != GetTag(OBJECT_SELF))
        iResult=FALSE;

    if (GetLocalInt(oQuestNPC,sLine+"NPC")>0 && GetLocalString(GetPCSpeaker(),"QuestTarget") == GetTag(OBJECT_SELF))
        iResult=TRUE;
    }


//Detects if there is anything to say.
if (sString=="")
    iResult=FALSE;

return iResult;
}

void LineDone()
{
object oQuestNPC;
string sScript;
int iStep;
int iSteps;
int iLine;
int iCheckDone;

oQuestNPC=GetConvoQuestNPC();

iStep=GetLocalInt(oQuestNPC,"QuestStep");
iSteps=GetLocalInt(oQuestNPC,"QuestSteps");
iLine=GetLocalInt(oQuestNPC,"QuestLine");
if (iStep<1)
    iStep=1;

iCheckDone=GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iStep) + "Line" +  IntToString(iLine) + "Done");
sScript=GetLocalString(oQuestNPC,"QuestStep" + IntToString(iStep) + "Line" +  IntToString(iLine) + "Script");

if (sScript != "")
    ExecuteScript(sScript,OBJECT_SELF);
if (iCheckDone>0)
    QuestDone(GetPCSpeaker(),oQuestNPC);
}

object GetConvoQuestNPC(object oQuestNPC=OBJECT_SELF)
{
object oPC;

oPC=GetPCSpeaker();
if (GetLocalString(oPC,"QuestNPC") != "" && GetLocalString(oPC,"QuestNPC") != GetTag(OBJECT_SELF))
    oQuestNPC=GetObjectByTag(GetLocalString(oPC,"QuestNPC"));

return oQuestNPC;
}

void StepDone(object oPC,object oQuestNPC)
{
int iStep;
string sZone;
string sQS;
string sTarget;
string sDescription;
object oBoss;
int iQuestStepType;
int iSA;

iStep=GetLocalInt(oQuestNPC,"QuestStep") + 1;
SetLocalInt(oQuestNPC,"QuestStep",iStep);
sZone = GetLocalString(oQuestNPC,"QuestZone");
SetLocalString(GetModule(),"SPAWN_Zone",sZone);

iQuestStepType=GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iStep) + "Type");
iSA=GetLocalInt(oQuestNPC,"QuestStep" + IntToString(iStep) + "SpecialArea");

if (iQuestStepType==1)
    GetMobQuest(oQuestNPC);
if (iQuestStepType==2 || iQuestStepType==4 || iQuestStepType==6 || (iQuestStepType==7 && iSA !=9))
    GetCampQuest(oQuestNPC);
if (iQuestStepType==3)
    GetNPCQuest(oQuestNPC);
if (iQuestStepType==7 && iSA == 9)
    DelayCommand(1.0,GetTRQuest(oQuestNPC));

}

