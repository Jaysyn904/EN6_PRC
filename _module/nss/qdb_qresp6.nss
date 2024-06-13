#include "qdb_include"

void main()
{

SetResponseNumber(1);
SetResponse("I'll take care of the [camp].");
SetResponseNumber(2);
SetResponse("I'm busy right now.");

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
