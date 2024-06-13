#include "qdb_include"

void main()
{
string sLine;
string sResponse;
string sToken;
int iDone;
int iNPC;
int iIndex;
int iStep;
int iLine;
int iOriginalLine;

iLine=GetLineNumber();
iOriginalLine=iLine;
while (GetLine()!="")
    {
    iLine++;
    SetLineNumber(iLine);
    }

//SetLine("Enter your text.");

//Link Goto To This Line.
SetLineNumber(iOriginalLine);
SetResponseInt("Goto",0);
SetResponseInt("Accept",iLine);
SetLineNumber(iLine);

sLine=GetLine();
iStep=GetStepNumber();

iDone=GetLineInt("Done");
iNPC=GetLineInt("NPC");

sToken=sLine + "\n\n";
sToken=sToken + "Step=" + IntToString(iStep) + " | Line=" + IntToString(iLine) + "\n";
sToken=sToken + "Done=" + IntToString(iDone) + " | NPC=" + IntToString(iNPC);

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
