#include "qdb_include"

void main()
{

SetLine("Is the [mob] dead?");
SetResponseNumber(1);
SetResponse("Yes, it is dead.");
SetResponseInt("Check",1);
SetResponseNumber(2);
SetResponse("Not yet.");

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
