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

iOriginalLine=GetLineNumber();
iLine=GetResponseInt("Goto");

SetLineNumber(iLine);
if (GetLine() == "")
    {
    DelayCommand(0.1,SendMessageToPC(GetPCSpeaker(),"No Line To Goto."));
    iLine=iOriginalLine;
    SetLineNumber(iLine);
    }

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
