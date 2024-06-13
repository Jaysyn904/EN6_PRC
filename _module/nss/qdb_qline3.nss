#include "qdb_include"

void main()
{

SetLine("Did you find the [item]?");
SetResponseNumber(1);
SetResponse("Yes, I have the [item].");
SetResponseInt("Check",2);
SetResponseNumber(2);
SetResponse("No, but I can go back and look for it.");

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
