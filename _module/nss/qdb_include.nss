string GetDBName();
void SetNewQuestNumber();
string GetQuestString(string sVarName);
void SetQuestString(string sVarName,string sValue);
int GetQuestInt(string sVarName);
void SetQuestInt(string sVarName,int iValue);
string GetStepString(string sVarName);
void SetStepString(string sVarName,string sValue);
int GetStepInt(string sVarName);
void SetStepInt(string sVarName,int iValue);
int GetLineNumber();
void SetLineNumber(int iLine);
int GetResponseNumber();
void SetResponseNumber(int iResponse);
string GetLineString(string sVarName);
void SetLineString(string sVarName,string sValue);
int GetLineInt(string sVarName);
void SetLineInt(string sVarName,int iValue);
string GetResponseString(string sVarName);
void SetResponseString(string sVarName,string sValue);
int GetResponseInt(string sVarName);
void SetResponseInt(string sVarName,int iValue);
string GetQuestInfo();
string GetLine();
void SetResponse(string sValue);
string GetResponse();
void SetLine(string sValue);
int GetStepNumber();
void SetupResponse(int iResponse);
void GrabQuest(string sZone,int iQuest=0);
void SetStepNumber(int iStep);
string GetLineInfo();
string GetStepInfo();

string GetDBName()
{
string sDB;

sDB=GetLocalString(GetModule(),"EN_QST_DB");

return sDB;
}

string GetQuestString(string sVarName)
{
string sDB;
string sValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest")) + sVarName;
sValue=GetCampaignString(sDB,sVarName);

return sValue;
}

void SetQuestString(string sVarName,string sValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest")) + sVarName;
SetCampaignString(sDB,sVarName,sValue);
}

int GetQuestInt(string sVarName)
{
string sDB;
int iValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest")) + sVarName;
iValue=GetCampaignInt(sDB,sVarName);

return iValue;
}

void SetQuestInt(string sVarName,int iValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest")) + sVarName;
SetCampaignInt(sDB,sVarName,iValue);
}

void SetNewQuestNumber()
{
string sDB;
string sQuest;
int iIndex;
int iFlag;

sDB=GetDBName();

iIndex=1;
iFlag=TRUE;
while (iFlag && iIndex<5000)
    {
    SetLocalInt(GetModule(),"QDB_Quest",iIndex);
    sQuest=GetQuestString("Name");
    if (sQuest=="" || sQuest =="DELETE")
        iFlag=FALSE;
    else
        iIndex++;
    }
}



int GetStepNumber()
{
int iStep;

iStep=GetLocalInt(GetModule(),"QDB_QuestStep");

return iStep;
}

int GetQuestNumber()
{
int iStep;

iStep=GetLocalInt(GetModule(),"QDB_Quest");

return iStep;
}


int GetStepInt(string sVarName)
{
string sDB;
int iValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber()) +sVarName;

iValue=GetCampaignInt(sDB,sVarName);

return iValue;
}

string GetStepString(string sVarName)
{
string sDB;
string sValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber()) +sVarName;

sValue=GetCampaignString(sDB,sVarName);

return sValue;
}

void SetStepInt(string sVarName, int iValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber()) +sVarName;

SetCampaignInt(sDB,sVarName,iValue);

}

void SetStepString(string sVarName, string sValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber()) +sVarName;

SetCampaignString(sDB,sVarName,sValue);

}

string GetLineString(string sVarName)
{
string sDB;
string sValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber()) + sVarName;

sValue=GetCampaignString(sDB,sVarName);

return sValue;
}

int GetLineInt(string sVarName)
{
string sDB;
int iValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber()) + sVarName;

iValue=GetCampaignInt(sDB,sVarName);

return iValue;
}

void SetLineInt(string sVarName, int iValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber()) + sVarName;

SetCampaignInt(sDB,sVarName,iValue);

}

void SetLineString(string sVarName, string sValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber()) + sVarName;

SetCampaignString(sDB,sVarName,sValue);

}

void SetLine(string sValue)
{
string sDB;
string sVarName;

sDB=GetDBName();

sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber());

SetCampaignString(sDB,sVarName,sValue);

}

string GetLine()
{
string sDB;
string sValue;
string sVarName;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber());

sValue=GetCampaignString(sDB,sVarName);

return sValue;
}

void SetResponse(string sValue)
{
string sDB;
string sVarName;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber())
            + "R" + IntToString(GetResponseNumber());

SetCampaignString(sDB,sVarName,sValue);

}

string GetResponse()
{
string sDB;
string sValue;
string sVarName;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber())
            + "R" + IntToString(GetResponseNumber());

sValue=GetCampaignString(sDB,sVarName);

return sValue;
}

string GetResponseString(string sVarName)
{
string sDB;
string sValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber())
            + "R" + IntToString(GetResponseNumber()) + sVarName;

sValue=GetCampaignString(sDB,sVarName);

return sValue;
}

int GetResponseInt(string sVarName)
{
string sDB;
int iValue;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber())
            + "R" + IntToString(GetResponseNumber()) + sVarName;

iValue=GetCampaignInt(sDB,sVarName);

//SendMessageToPC(GetFirstPC(),"Get Response using " + sVarName + " which is " + IntToString(iValue));

return iValue;
}

void SetResponseInt(string sVarName, int iValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber())
            + "R" + IntToString(GetResponseNumber()) + sVarName;

//SendMessageToPC(GetFirstPC(),"Set Response using " + sVarName + " to " + IntToString(iValue));
SetCampaignInt(sDB,sVarName,iValue);

}

void SetResponseString(string sVarName, string sValue)
{
string sDB;

sDB=GetDBName();
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "S" + IntToString(GetStepNumber())
            + "L" + IntToString(GetLineNumber())
            + "R" + IntToString(GetResponseNumber()) + sVarName;

SetCampaignString(sDB,sVarName,sValue);

}

void SetStepNumber(int iStep)
{
string sDB;
int iType;

SetLocalInt(GetModule(),"QDB_QuestStep",iStep);

}

int GetLineNumber()
{
int iLine;

iLine=GetLocalInt(GetModule(),"QDB_QuestStepLine");

return iLine;
}

void SetLineNumber(int iLine)
{
SetLocalInt(GetModule(),"QDB_QuestStepLine",iLine);
}

int GetResponseNumber()
{
int iResponse;

iResponse=GetLocalInt(GetModule(),"QDB_QSLR");

return iResponse;
}

void SetResponseNumber(int iResponse)
{
SetLocalInt(GetModule(),"QDB_QSLR",iResponse);
}

string GetLineInfo()
{
string sLine;
string sResponse;
string sToken;
string sScript;
int iDone;
int iNPC;
int iIndex;
int iStep;
int iLine;

sLine=GetLine();
iStep=GetStepNumber();
iLine=GetLineNumber();
iDone=GetLineInt("Done");
iNPC=GetLineInt("NPC");
sScript = GetLineString("Script");

sToken=sLine + "\n\n";
sToken=sToken + "Step=" + IntToString(iStep) + " | Line=" + IntToString(iLine) + "\n";
sToken=sToken + "Done=" + IntToString(iDone) + " | NPC=" + IntToString(iNPC) + "\n";
if (sScript == "")
    sToken=sToken + "(No Script)";
else
    sToken=sToken + "Script=" + sScript;

return sToken;
}

string GetQuestInfo()
{
string sQuest;
string sName;
int iMinLevel;
int iMaxLevel;
int iFrequency;
int iDoOnce;
int iGold;
int iItemChanceMod;
string sItemReward;
int iNPCType;
int iNPCSpawn;
string sOneLiner;
string sFreq;
string sNPCType;
string sScript;

sName=GetQuestString("Name");
iMinLevel=GetQuestInt("MinLevel");
iMaxLevel=GetQuestInt("MaxLevel");
iFrequency=GetQuestInt("Frequency");
iDoOnce=GetQuestInt("DoOnce");
iGold=GetQuestInt("Gold");
iItemChanceMod=GetQuestInt("ItemChanceMod");
sItemReward=GetQuestString("ItemReward");
iNPCType=GetQuestInt("NPCType");
iNPCSpawn=GetQuestInt("NPCSpawn");
sOneLiner=GetQuestString("OneLiner");
sScript = GetQuestString("Script");

sFreq="Common";
if (iFrequency==1)
    sFreq="Rare";
if (iFrequency==2)
    sFreq="Standard";

sNPCType="Unknown";
switch (iNPCType)
    {
    case 1: sNPCType="General"; break;
    case 2: sNPCType="Guard"; break;
    case 3: sNPCType="Scholar/Wizard"; break;
    case 4: sNPCType="Priest"; break;
    case 5: sNPCType="Hunter"; break;
    case 6: sNPCType="Commoner"; break;
    case 7: sNPCType="Merchant"; break;
    }

sQuest = "Name: " + sName + "\n";
sQuest = sQuest + "Lvls=" + IntToString(iMinLevel) + "-" + IntToString(iMaxLevel) + " | Freq=" + sFreq + " | DoOnce=" + IntToString(iDoOnce) + " \n";
sQuest = sQuest + "Gold=" + IntToString(iGold) + " | ItemChance=" + IntToString(iItemChanceMod) + " | Item=" + sItemReward + " \n";
sQuest = sQuest + "NPCType=" + sNPCType + " | NPCSpawn=" + IntToString(iNPCSpawn) + " | OneLiner=" + sOneLiner + " \n";
sQuest = sQuest + "Script = " + sScript + " | Execute = " + IntToString(GetQuestInt("Execute")) + " | Type = " + IntToString(GetQuestInt("Type")) + "\n";
sQuest = sQuest + "Main Quest = " + IntToString(GetQuestInt("MQNumber")) + " | Theme = " + IntToString(GetQuestInt("ThemeNumber")) + " | NPC Num  = " + IntToString(GetQuestInt("NPCNumber")) + "\n";
sQuest = sQuest + "NPCTag = " + GetQuestString("NPCTag");

return sQuest;
}

string GetStepInfo()
{
string sQuest;
string sName;
string sItem;
string sMobTag;
string sLine;
int iStep;
int iType;
int iCreateItem;
int iHideItem;
int iCamp;
int iNPCType;
int iNPCSpawn;
int iSpecialArea;
int iAmbush;
int iBossOnly;
int iBoss;
int iRepeatCamp;
int iMobType;
int iCampTheme;

sName=GetQuestString("Name");
SetLineNumber(1);
sLine=GetLine();
iStep=GetStepNumber();
iType=GetStepInt("Type");
iCreateItem=GetStepInt("CreateItem");
iHideItem=GetStepInt("HideItem");
sItem=GetStepString("Item");
iCamp=GetStepInt("Camp");
iNPCType=GetStepInt("NPCType");
iNPCSpawn=GetStepInt("NPCSpawn");
sMobTag=GetStepString("MobTag");
iSpecialArea=GetStepInt("SpecialArea");
iAmbush=GetStepInt("Ambush");
iBossOnly=GetStepInt("BossOnly");
iBoss=GetStepInt("Boss");
iRepeatCamp=GetStepInt("RepeatCamp");
iMobType=GetStepInt("MobType");
iCampTheme=GetStepInt("CampTheme");

sQuest = "Name: " + sName + " \n";
sQuest = sQuest +  "Line1: " + sLine + " \n";
sQuest = sQuest + "Step=" + IntToString(iStep) + " | Type=" + IntToString(iType) + " | CreateItem=" + IntToString(iCreateItem) + " | HideItem=" + IntToString(iHideItem) + " | Item=" + sItem + " \n";
sQuest = sQuest + "Camp=" + IntToString(iCamp) + " | NPCType=" + IntToString(iNPCType) + " | NPCSpawn=" + IntToString(iNPCSpawn) + " | MobTag=" + sMobTag + " \n";
sQuest = sQuest + "SpecialArea=" + IntToString(iSpecialArea) + " | Ambush=" + IntToString(iAmbush) + " | BossOnly=" + IntToString(iBossOnly) + " | Boss=" + IntToString(iBoss) + " \n";
sQuest = sQuest + "RepeatCamp=" + IntToString(iRepeatCamp) + " | MobType=" + IntToString(iMobType) + " | CampTheme=" + IntToString(iCampTheme);

return sQuest;
}


void SetupResponse(int iResponse)
{
string sResponse;
string sQuest;
int iGoto;
string sScript;
int iCheck;
int iAccept;
int iDeleteItem;
int iStepDone;
int iLineStart;
int iLines;
int iStop;

SetResponseNumber(iResponse);
sResponse=GetResponse();
iGoto=GetResponseInt("Goto");
sScript=GetResponseString("Script");
iCheck=GetResponseInt("Check");
iAccept=GetResponseInt("Accept");
iDeleteItem=GetResponseInt("DeleteItem");
iStepDone=GetResponseInt("StepDone");
iStop=GetResponseInt("Stop");

sQuest = sResponse + " \n";
sQuest = sQuest + "Goto=" + IntToString(iGoto) + " | Check=" + IntToString(iCheck) + " | Accept=" + IntToString(iAccept) + " \n";
sQuest = sQuest + "DeleteItem=" + IntToString(iDeleteItem) + " | StepDone=" + IntToString(iStepDone) + " \n";
sQuest = sQuest + "Stop=" + IntToString(iStop) + " | Script=" + sScript + " \n";

SetCustomToken(101,sQuest);
}

void GrabQuest(string sZone,int iQuest=0)
{
int iIndex;
int iIndex3;
int iLines;
string sQS;
string sQSL;
string sQSLR;
object oQuestWP;

if (iQuest>0)
    SetLocalInt(GetModule(),"QDB_Quest",iQuest);

oQuestWP=GetObjectByTag("EN6_QUESTWP");

if (GetQuestInt("Steps")<1)
    SetQuestInt("Steps",1);
SetLocalString(oQuestWP,"QuestName",GetQuestString("Name"));
SetLocalString(oQuestWP,"QuestZone",sZone);
SetLocalInt(oQuestWP,"QuestLevel",GetQuestInt("MinLevel"));
SetLocalInt(oQuestWP,"QuestSteps",GetQuestInt("Steps"));
SetLocalInt(oQuestWP,"QuestItemChanceMod",GetQuestInt("ItemChanceMod"));
SetLocalString(oQuestWP,"QuestItemReward",GetQuestString("ItemReward"));
SetLocalInt(oQuestWP,"QuestGold",GetQuestInt("Gold"));
SetLocalInt(oQuestWP,"QuestNPCType",GetQuestInt("NPCType"));
SetLocalInt(oQuestWP,"QuestNPCSpawn",GetQuestInt("NPCSpawn"));
SetLocalString(oQuestWP,"QuestOneLiner",GetQuestString("OneLiner"));
SetLocalInt(oQuestWP,"QuestFrequency",GetQuestInt("Frequency"));
SetLocalInt(oQuestWP,"QuestDoOnce",GetQuestInt("DoOnce"));
SetLocalInt(oQuestWP,"QuestMinLevel",GetQuestInt("MinLevel"));
SetLocalInt(oQuestWP,"QuestMaxLevel",GetQuestInt("MaxLevel"));
SetLocalString(oQuestWP,"QuestScript",GetQuestString("Script"));
SetLocalString(oQuestWP,"QuestAccomplishment",GetQuestString("Accomplishment"));

SetLocalInt(oQuestWP,"QuestExecute",GetQuestInt("Execute"));
SetLocalInt(oQuestWP,"QuestType",GetQuestInt("Type"));
SetLocalInt(oQuestWP,"QuestMQNumber",GetQuestInt("MQNumber"));
SetLocalInt(oQuestWP,"QuestThemeNumber",GetQuestInt("ThemeNumber"));
SetLocalInt(oQuestWP,"QuestNPCNumber",GetQuestInt("NPCNumber"));
SetLocalString(oQuestWP,"QuestNPCTag",GetQuestString("NPCTag"));

iIndex=1;
while (iIndex<=GetQuestInt("Steps"))
    {
    SetStepNumber(iIndex);
    sQS="QuestStep" + IntToString(iIndex);

    SetLocalInt(oQuestWP,sQS + "Type",GetStepInt("Type"));
    SetLocalInt(oQuestWP,sQS + "SpecialArea",GetStepInt("SpecialArea"));
    SetLocalString(oQuestWP,sQS + "Item",GetStepString("Item"));
    SetLocalInt(oQuestWP,sQS + "HideItem",GetStepInt("HideItem"));
    SetLocalInt(oQuestWP,sQS + "Camp",GetStepInt("Camp"));
    SetLocalString(oQuestWP,sQS + "MobTag",GetStepString("MobTag"));
    SetLocalString(oQuestWP,sQS + "NPC",GetStepString("NPC"));
    SetLocalInt(oQuestWP,sQS + "NPCType",GetStepInt("NPCType"));
    SetLocalInt(oQuestWP,sQS + "NPCSpawn",GetStepInt("NPCSpawn"));
    SetLocalInt(oQuestWP,sQS + "Ambush",GetStepInt("Ambush"));
    SetLocalInt(oQuestWP,sQS + "BossOnly",GetStepInt("BossOnly"));
    SetLocalInt(oQuestWP,sQS + "Boss",GetStepInt("Boss"));
    SetLocalInt(oQuestWP,sQS + "CreateItem",GetStepInt("CreateItem"));
    SetLocalInt(oQuestWP,sQS + "MobClass",GetStepInt("MobClass"));
    SetLocalInt(oQuestWP,sQS + "RepeatCamp",GetStepInt("RepeatCamp"));
    SetLocalInt(oQuestWP,sQS + "CampTheme",GetStepInt("CampTheme"));
    SetLocalString(oQuestWP,sQS + "Zone",""); //Clear Zone to allow it to be set during setup

    iLines=1;
    SetLineNumber(iLines);
    while (GetLine() != "")
        {
        sQSL="QuestStep" + IntToString(iIndex) + "Line" + IntToString(iLines);

        //SendMessageToPC(GetFirstPC(),sQSL + "=" + GetLine());
        SetLocalString(oQuestWP,sQSL,GetLine());
        SetLocalInt(oQuestWP,sQSL + "Done",GetLineInt("Done"));
        SetLocalInt(oQuestWP,sQSL + "NPC",GetLineInt("NPC"));
        SetLocalString(oQuestWP,sQSL + "Script",GetLineString("Script"));

        iIndex3=1;
        while (iIndex3<=5)
            {
            SetResponseNumber(iIndex3);
            sQSLR="QuestStep" + IntToString(iIndex) + "Line" + IntToString(iLines) + "Response" + IntToString(iIndex3);

            SetLocalString(oQuestWP,sQSLR,GetResponse());
            SetLocalInt(oQuestWP,sQSLR + "Goto",GetResponseInt("Goto"));
            SetLocalString(oQuestWP,sQSLR + "Script",GetResponseString("Script"));
            SetLocalInt(oQuestWP,sQSLR + "Check",GetResponseInt("Check"));
            SetLocalInt(oQuestWP,sQSLR + "Accept",GetResponseInt("Accept"));
            SetLocalInt(oQuestWP,sQSLR + "DeleteItem",GetResponseInt("DeleteItem"));
            SetLocalInt(oQuestWP,sQSLR + "StepDone",GetResponseInt("StepDone"));
            //SetLocalInt(oQuestWP,sQSLR + "LineStart",GetResponseInt("LineStart"));
            SetLocalInt(oQuestWP,sQSLR + "Stop",GetResponseInt("Stop"));

            iIndex3++;
            }
        iLines++;
        SetLineNumber(iLines);
        if (GetLine() == "" && iLines < 100)
            {
            iLines=100;
            SetLineNumber(iLines);
            }
        }
    iIndex++;
    }

}

