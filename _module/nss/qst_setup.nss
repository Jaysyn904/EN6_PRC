#include "en5_misc"
#include "en5_specialareas"

int StartingConditional()
{
int iResult;
int iRandom;
int iLevel;
int iQuestLevel;
string sText;
string sAccomplishment;
string sTalk;
string sResponse;
string sTalk2;
string sItem;
string sItemReply;
string sQuestDone;
string sItemName;
object oItem;

iResult = FALSE;

sItem = GetLocalString(GetPCSpeaker(),"QuestItem");
oItem = GetObjectByTag(sItem);
if (GetIsObjectValid(oItem))
    sItemName = GetName(oItem);
else
    sItemName = "interesting item";
sItemReply = GetLocalString(GetPCSpeaker(),"QuestItemReply");
sQuestDone = GetLocalString(OBJECT_SELF,"QuestDone");

if (sQuestDone == "")
    sQuestDone = "Excellent.";

if (GetLocalString(OBJECT_SELF,"QuestTarget")=="")
    SetCustomToken(101,GetLocalString(GetPCSpeaker(),"QuestTarget"));
else
    SetCustomToken(101,GetLocalString(OBJECT_SELF,"QuestTarget"));
SetCustomToken(102,GetLocalString(OBJECT_SELF,"QuestLocation"));
if (GetLocalString(OBJECT_SELF,"QuestMobName")=="")
    SetCustomToken(103,GetLocalString(GetPCSpeaker(),"QuestMobName"));
else
    SetCustomToken(103,GetLocalString(OBJECT_SELF,"QuestMobName"));

if (GetIsObjectValid(oItem))
    SetCustomToken(104,GetName(oItem));
SetCustomToken(105,sItemReply);
SetCustomToken(109,sItemName);
SetCustomToken(110,sQuestDone);
if (GetLocalString(GetPCSpeaker(),"QuestNotComplete") == "")
    SetCustomToken(199,GetLocalString(OBJECT_SELF,"QuestNotComplete"));
else
    SetCustomToken(199,GetLocalString(GetPCSpeaker(),"QuestNotComplete"));
SetCustomToken(200,GetLocalString(OBJECT_SELF,"QuestInitiate"));
SetCustomToken(211,GetLocalString(GetPCSpeaker(),"QuestReply"));
SetCustomToken(212,GetLocalString(GetPCSpeaker(),"QuestContinue"));
//SetCustomToken(212,GetLocalString(OBJECT_SELF,"QuestNotComplete"));

sAccomplishment = GetAreaAccomplishment(GetPCSpeaker());

if (sAccomplishment == "")
    if (Random(4)>0)
        SetCustomToken(201,"I don't know much about you, but maybe you can help.");
    else
        SetCustomToken(201,"You must be newly arrived here, but maybe you can help.");
else
    SetCustomToken(201,"I hear you " + sAccomplishment + ".");

if (GetLocalInt(OBJECT_SELF,"QuestComplete") == 0)
    SetCustomToken(198,GetLocalString(OBJECT_SELF,"QuestNotComplete2"));
else
    {
    iRandom = Random(5)+1;
    sText = "Hi...";
    switch (iRandom)
        {
        case 1: sText = "Hi..."; break;
        case 2: sText = "Nice weather we are having..."; break;
        case 3: sText = "I hope it doesn't rain..."; break;
        case 4: sText = "I need to go make dinner soon..."; break;
        case 5: sText = "Nice weather we are having..."; break;
        }
     SetCustomToken(198,sText);
    }

if  (GetLocalString(OBJECT_SELF,"Talk") == "")
    {
    sText=GetQuestNPCTalk(GetLocalString(GetArea(OBJECT_SELF),"Zone"));
    if (sText=="")
        {
        iRandom = Random(4)+1;
        sText = "Hi...";
        switch (iRandom)
            {
            case 1: sText = "Fair to middlin' I suppose."; break;
            case 2: sText = "Good.  Looks like rain.  We need a good rain."; break;
            case 3: sText = "I'm worried about the increased dangers in the lands.  What could be causing it?"; break;
            case 4: sText = "I've heard gossip of some strange creatures roaming in the wilderness."; break;
            }
        }
     SetCustomToken(300,sText);
     SetLocalString(OBJECT_SELF,"Talk",sText);
    } else {
    SetCustomToken(300,GetLocalString(OBJECT_SELF,"Talk"));
    }


sTalk = GetLocalString(OBJECT_SELF,"QUEST_Talk");
sResponse = GetLocalString(OBJECT_SELF,"QUEST_Response");
sTalk2 = GetLocalString(OBJECT_SELF,"QUEST_Talk2");
if (sTalk=="")
    sTalk = "How may I help you?";

SetCustomToken(301,sTalk);
SetCustomToken(302,sResponse);
SetCustomToken(303,sTalk2);

SetLocalInt(OBJECT_SELF,"QuestIsDead",0);

return iResult;
}
