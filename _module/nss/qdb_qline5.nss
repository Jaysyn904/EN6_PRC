#include "qdb_include"

void main()
{
string sText;
int iRandom;

iRandom=Random(8)+1;
sText="Excellent.";
switch (iRandom)
    {
    case 1: sText="Excellent."; break;
    case 2: sText="Superb."; break;
    case 3: sText="Very good."; break;
    case 4: sText="Well done."; break;
    case 5: sText="Good."; break;
    case 6: sText="Great."; break;
    case 7: sText="Thank you."; break;
    case 8: sText="Many thanks."; break;
    }

SetLine(sText);
SetResponseNumber(1);
SetResponse("Done.");
SetLineInt("Done",1);

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
