#include "qdb_include"

void main()
{
string sLine;
string sResponse;
string sToken;
int iDone;
int iAccept;
int iNPC;
int iIndex;
int iStep;
int iLine;
int iOriginalLine;

iLine=GetLineNumber();
iOriginalLine=iLine;
iNPC=GetLineInt("NPC");
iDone=GetResponseInt("Done");
iAccept=GetResponseInt("Accept");

while (GetLine()!="")
    {
    iLine++;
    SetLineNumber(iLine);
    }

SetLineInt("NPC",iNPC);

//Link Goto To This Line.
SetLineNumber(iOriginalLine);
SetResponseInt("Goto",iLine);
SetLineNumber(iLine);

//sLine=GetLine();
//iStep=GetStepNumber();


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
