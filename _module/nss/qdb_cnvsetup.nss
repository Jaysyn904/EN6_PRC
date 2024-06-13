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

SetLineNumber(1);
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
