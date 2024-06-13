#include "qst_include"

void main()
{
int iIndex;
string sTag;
object oWP;

iIndex=1;
sTag="TST_C" + IntToString(iIndex) + "_1";
oWP=GetObjectByTag(sTag);
while (GetIsObjectValid(oWP))
    {
    SetLocalInt(oWP,"Quest",0);
    iIndex++;
    sTag="TST_C" + IntToString(iIndex) + "_1";
    oWP=GetObjectByTag(sTag);
    }

iIndex=1;
sTag="TST_S_" + IntToString(iIndex);
oWP=GetObjectByTag(sTag);
while (GetIsObjectValid(oWP))
    {
    SetLocalInt(oWP,"Quest",0);
    iIndex++;
    sTag="TST_S_" + IntToString(iIndex);
    oWP=GetObjectByTag(sTag);
    }


if (CheckQuest("TST"))
    SetupQuest("TST");
else
    SendMessageToPC(GetPCSpeaker(),"Could not setup quest for this zone");
}
