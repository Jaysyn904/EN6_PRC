#include "en5_misc"

int SetupArea(string sZone,int iLevel,object oWP);
int OpenArea(string sZone);
string GetZoneSpecialArea(int iLevel);
int GetMaxSpecialAreas();
string GetSpecialAreaPrefix(int iRandom);
void SetupSpecialAreaText(string sText,string sText2,string sZone,int iLevel);
string GetQuestNPCTalk(string sZone);
string GetMinstrelTalk();

int SetupArea(string sZone,int iLevel,object oWP)
{
int iResult;
string sArea;
string sDescription;
string sLocation;
string sCity;
string sText;
string sText2;
object oTransfer;
object oArea;

if (OpenArea(sZone))
    {
    sArea=GetZoneSpecialArea(iLevel);
    if (sArea != "")
        {
        SetLocalInt(GetModule(),sZone + "_SPECIAL_1",1);
        oTransfer = GetObjectByTag(sZone + "_SPECIAL_1");
        SetLocalString(oTransfer,"Area",sArea + "_Enter");
        oTransfer = GetObjectByTag(sArea + "_Exit");
        SetLocalString(oTransfer,"Area",sZone + "_1_Enter");

        oArea = GetArea(GetObjectByTag(sArea + "_Enter"));
        SetLocalInt(oArea,"MinLevel",iLevel);
        SetLocalInt(oArea,"MaxLevel",iLevel);
        SetLocalInt(GetModule(),"SPECIAL_" + sArea,1);

        //GetError("Special Setup: " + sZone + " = " + sArea);

        sDescription = GetLocalString(oArea,"Description");
        sLocation = GetLocalString(oWP,"Location");
        sCity = GetLocalString(oWP,"City");

        if (sCity=="")
            sText=sDescription + " " + sLocation;
        else
            sText="the people of " + sCity + " are worried because " + sDescription + " " + sLocation;

        sText2 = "I am troubled because " + sDescription + " " + sLocation;

        if (sDescription == "")
            GetError("ERROR: No Special Description for " + sArea);
        if (sLocation == "")
            GetError("ERROR: No Special Location for " + sZone);

        SetupSpecialAreaText(sText,sText2,sZone,iLevel);

        iResult=TRUE;
        } else {
        iResult=FALSE;
        //GetError("Special Setup: Failed for " + sZone + " = " + sArea);
        }
    } else {
    iResult=FALSE;
    //GetError("Special Setup: No Open Area in " + sZone);
    }

return iResult;
}

int OpenArea(string sZone)
{
int iMaxNumber;
int iNumber;
string sType;
string sTag;
int iResult;

iResult = FALSE;

if (GetLocalInt(GetModule(),sZone + "_SPECIAL_1") == 0)
    iResult = TRUE;

return iResult;
}

string GetZoneSpecialArea(int iLevel)
{
int iRandom;
int iIndex;
int iMaxAreas;
string sArea;

iMaxAreas=GetMaxSpecialAreas();
iRandom = Random(iMaxAreas)+1;
//GetError("Max Special Areas=" + IntToString(iMaxAreas));
iRandom=10;
sArea = GetSpecialAreaPrefix(iRandom);

if (GetLocalInt(GetModule(),"SPECIAL_" + sArea)==1)
    {
    iIndex=1;
    while (iIndex<=iMaxAreas)
        {
        sArea = GetSpecialAreaPrefix(iIndex);
        if (GetLocalInt(GetModule(),"SPECIAL_" + sArea)==0)
            iIndex=iMaxAreas+1;
        else
            iIndex++;
        }
    }

//GetError(sArea + " check = " + IntToString(GetLocalInt(GetModule(),"SPECIAL_" + sArea)));
if (GetLocalInt(GetModule(),"SPECIAL_" + sArea)==1)
    sArea="";

return sArea;
}

string GetSpecialAreaPrefix(int iRandom)
{
string sArea;

sArea="";
switch (iRandom)
    {
    case 1: sArea="SA1"; break;
    case 2: sArea="SA2"; break;
    case 3: sArea="SA3"; break;
    case 4: sArea="SA4"; break;
    case 5: sArea="SA5"; break;
    case 6: sArea="SA6"; break;
    case 7: sArea="SA7"; break;
    case 8: sArea="SA8"; break;
    case 9: sArea="SA9"; break;
    case 10: sArea="SA10"; break;
    }

return sArea;
}

int GetMaxSpecialAreas()
{
int iIndex;
int iFlag;
string sArea;

iIndex=1;
while (iFlag==FALSE)
    {
    sArea=GetSpecialAreaPrefix(iIndex);
    if (sArea=="")
        iFlag=TRUE;
    else
        iIndex++;
    }
iIndex--;

return iIndex;
}

void SetupSpecialAreaText(string sText,string sText2,string sZone,int iLevel)
{
int iSpecialAreas;
string sTag;

iSpecialAreas = GetLocalInt(GetModule(),"SpecialAreas") + 1;
SetLocalInt(GetModule(),"SpecialAreas",iSpecialAreas);
sTag="SpecialArea" + IntToString(iSpecialAreas);
SetLocalInt(GetModule(),sTag + "Level",iLevel);
SetLocalString(GetModule(),sTag + "Zone",sZone);
SetLocalString(GetModule(),sTag + "Text",sText);
SetLocalString(GetModule(),sTag + "Text2",sText2);
SetLocalInt(GetModule(),sTag + "Told",0);
}

string GetQuestNPCTalk(string sZone)
{
int iIndex;
int iSpecialAreas;
string sTag;
string sText;

sText="";
iIndex=1;
iSpecialAreas = GetLocalInt(GetModule(),"SpecialAreas");

while (iIndex<=iSpecialAreas)
    {
    sTag="SpecialArea" + IntToString(iIndex);
    if (GetLocalString(GetModule(),sTag + "Zone") == sZone)
        {
        if (GetLocalInt(GetModule(),sTag + "Told") == 0)
            {
            sText= GetLocalString(GetModule(),sTag + "Text2");
            SetLocalInt(GetModule(),sTag + "Told",1);
            } else {
            if (Random(3)==0)
                sText= GetLocalString(GetModule(),sTag + "Text2");
            }
        }
    iIndex++;
    }

return sText;
}

string GetMinstrelTalk()
{
int iIndex;
int iSpecialAreas;
int iAdventure;
string sTag;
string sText;
string sTalk;

sText="";
iIndex=1;
iAdventure=0;

iSpecialAreas = GetLocalInt(GetModule(),"SpecialAreas");

sTalk = " I have heard that " + GetLocalString(GetModule(),"MainQuestNPC1") + " is in search of an adventurer for a task.";

while (iIndex<=iSpecialAreas)
    {
    sTag="SpecialArea" + IntToString(iIndex);
    if (GetLocalInt(GetModule(),sTag + "Told") == 0)
        {
        sText= GetLocalString(GetModule(),sTag + "Text");
        sTalk = sTalk + "\n \n I have also heard " + sText + ".";
        }
    iIndex++;
    }

return sTalk;
}
