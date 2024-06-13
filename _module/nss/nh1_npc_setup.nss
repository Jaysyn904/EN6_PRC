int StartingConditional()
{
int iResult;

string sTalk;
string sResponse;
string sTalk2;

sTalk = GetLocalString(OBJECT_SELF,"QUEST_Talk");
sResponse = GetLocalString(OBJECT_SELF,"QUEST_Response");
sTalk2 = GetLocalString(OBJECT_SELF,"QUEST_Talk2");

if (sTalk != "")
    {
    SetCustomToken(301,sTalk);
    SetCustomToken(302,sResponse);
    SetCustomToken(303,sTalk2);
    SendMessageToPC(GetFirstPC(),"Talk=" + sTalk);
    } else {
    SetCustomToken(301,"How can I help you?");
    }

iResult = FALSE;
return iResult;
}
