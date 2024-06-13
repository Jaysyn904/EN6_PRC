#include "qdb_include"

void main()
{

SetResponseNumber(1);
SetResponse("I'm looking for work.");
SetResponseNumber(2);
SetResponse("Sorry, just passing through.");

SetCustomToken(100,GetLineInfo());

int iIndex=1;
while (iIndex<=5)
    {
    SetResponseNumber(iIndex);
    string sResponse=GetResponse();
    if (sResponse=="")
        sResponse="(No Response)";
    SetCustomToken(100+iIndex,sResponse);
    iIndex++;
    }
}
