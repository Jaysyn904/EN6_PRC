#include "qst_include"

int StartingConditional()
{
int iResult;
string sLocation;
string sZone;

SetupTokens(OBJECT_SELF);

sZone=GetLocalString(OBJECT_SELF,"QuestZone");
sLocation=GetLocalString(GetObjectByTag(sZone + "_1_Enter"),"Location");

SetCustomToken(102,sLocation);
SetCustomToken(100,GetLocalString(GetModule(),"T3Mobs"));
iResult = FALSE;
return iResult;
}
