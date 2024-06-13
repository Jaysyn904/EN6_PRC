#include "en5_misc"

int StartingConditional()
{
int iResult;

string sTalk;
string sResponse;
string sTalk2;
string sAccomplishment;

sTalk = GetLocalString(OBJECT_SELF,"QUEST_Talk");
sResponse = GetLocalString(OBJECT_SELF,"QUEST_Response");
sTalk2 = GetLocalString(OBJECT_SELF,"QUEST_Talk2");

SetCustomToken(301,sTalk);
SetCustomToken(302,sResponse);
SetCustomToken(303,sTalk2);

sAccomplishment = GetLocalString(GetPCSpeaker(),GetMyZone()+ "_Accomplishment");
if (sAccomplishment == "" || GetLocalInt(OBJECT_SELF,"Accomplishment") == 1)
    SetCustomToken(201,"What can I do for you?");
else
    {
    SetCustomToken(201,"Sally told me you " + sAccomplishment + ".  The hamlett thanks you.  What can I do for you?");
    SetLocalInt(OBJECT_SELF,"Accomplishment",1);
    }

iResult = FALSE;
return iResult;
}
