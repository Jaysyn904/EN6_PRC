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

if (iNPC==0)
    iNPC=1;
else
    iNPC=0;

SetLineInt("NPC",iNPC);

SetCustomToken(100,GetLineInfo());

}
