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

iLine=GetLineNumber()-1;
SetLineNumber(iLine);
if (GetLine() == "")
    {
    DelayCommand(0.1,SendMessageToPC(GetPCSpeaker(),"No Previous Line To Goto."));
    iLine++;
    SetLineNumber(iLine);
    }

sLine=GetLine();
iStep=GetStepNumber();

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
