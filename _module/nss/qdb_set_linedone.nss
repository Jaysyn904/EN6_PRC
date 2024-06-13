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

sLine=GetLine();
iStep=GetStepNumber();
iLine=GetLineNumber();
iDone=GetLineInt("Done");
iNPC=GetLineInt("NPC");

if (iDone==0)
    iDone=1;
else
    iDone=0;

SetLineInt("Done",iDone);

SetCustomToken(100,GetLineInfo());

}
