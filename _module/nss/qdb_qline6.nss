#include "qdb_include"

void main()
{

SetLine("May I help you?");
SetResponseNumber(1);
SetResponse("Yes, I have this [item] from [giver].");
SetResponseInt("Check",2);
SetResponseInt("DeleteItem",1);
SetResponseNumber(2);
SetResponse("Not right now, thanks.");

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
