#include "qdb_include"

void main()
{

SetResponseNumber(1);
SetResponse("Yes.");
SetResponseNumber(2);
SetResponse("No.");
SetResponseString("Script","en6_quitquest");

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
