#include "qdb_include"

void main()
{
int iIndex3;

SetLine("");
SetLineInt("Done",0);
SetLineInt("NPC",0);

iIndex3=1;
while (iIndex3<=5)
    {
    SetResponseNumber(iIndex3);

    SetResponse("");
    SetResponseInt("Goto",0);
    SetLineString("Script","");
    SetLineInt("Check",0);
    SetLineInt("Accept",0);
    SetLineInt("DeleteItem",0);
    SetLineInt("StepDone",0);
    SetLineInt("LineStart",0);

    iIndex3++;
    }

SetLineNumber(GetLineNumber()-1);

string sLine;
string sResponse;
string sToken;
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

sToken=GetLineInfo();
SetCustomToken(100,sToken);

iIndex=1;
while (iIndex<=5)
    {
    SetResponseNumber(iIndex);
    sResponse=GetResponse();
    if (sResponse=="")
        sResponse="(No Response)";
    SetCustomToken(100+iIndex,sResponse);
    iIndex++;
    }
}
