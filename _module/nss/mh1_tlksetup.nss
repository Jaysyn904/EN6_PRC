#include "en5_misc"

int StartingConditional()
{
int iResult;
int iRandom;
string sText;
string sAccomplishment;

iResult = FALSE;

if (GetLocalInt(OBJECT_SELF,"Talk") == 0)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sText = "What ya want?"; break;
        case 2: sText = "What ya need?"; break;
        case 3: sText = "What can I do for ya?"; break;
        case 4: sText = "How can I help you?"; break;
        case 5: sText = "Is there something you need?"; break;
        }
    sAccomplishment = GetLocalString(GetPCSpeaker(),GetMyZone()+ "_Accomplishment");
    if (sAccomplishment != "" && GetLocalInt(OBJECT_SELF,"Brag") == 0 && Random(3)==0)
        {
        sText = "I heard you " + sAccomplishment + ".  You have my thanks.  How can I help you?";
        SetLocalInt(OBJECT_SELF,"Brag",1);
        }
    SetCustomToken(401,sText);
    SetLocalString(OBJECT_SELF,"Talk1",sText);
    iRandom = Random(8)+1;
    switch (iRandom)
        {
        case 1: sText = "Not much to tell. We live.  We eat.  We come in here and drink, har har."; break;
        case 2: sText = "It's a long way from no where, and a little ways from nothing."; break;
        case 3: sText = "The hills have been getting more dangerous in recent times."; break;
        case 4: sText = "I hear there is great treasure in a cave not too far from here, if one were brave enough to face its dangers."; break;
        case 5: sText = "Used to be that you could come in here and get something to eat without a bunch of adventurer's bothering you."; break;
        case 6: sText = "It's been tough going here lately."; break;
        case 7: sText = "There was a fine adventurer through here not too long ago.  Nice fellow, looked handy with a sword too.  Not anymore though, an ogre got him."; break;
        case 8: sText = "The ale here is the finest within a league.  Mostly because it is the only ale for a league."; break;
        }
    if (sAccomplishment != "" && GetLocalInt(OBJECT_SELF,"Brag") == 0 && Random(5)==0)
        {
        sText = "Not much to tell, but I did hear you " + sAccomplishment + ".  You have my thanks.";
        SetLocalInt(OBJECT_SELF,"Brag",1);
        }
    SetCustomToken(402,sText);
    SetLocalString(OBJECT_SELF,"Talk2",sText);
    SetLocalInt(OBJECT_SELF,"Talk",1);
    } else {
    SetCustomToken(401,GetLocalString(OBJECT_SELF,"Talk1"));
    SetCustomToken(402,GetLocalString(OBJECT_SELF,"Talk2"));
    }

return iResult;
}
