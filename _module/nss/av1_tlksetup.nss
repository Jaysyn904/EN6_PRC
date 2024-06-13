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
        case 2: sText = "We sure are getting a lot of adventurers traveling through here these days."; break;
        case 3: sText = "The guards are beginning to look frayed with all the worry about creatures in the wilderness."; break;
        case 4: sText = "I used to go fishing in the Adon Woods, but not anymore.  It's just too dangerous these days."; break;
        case 5: sText = "Used to be that you could come in here and get something to eat without a bunch of adventurer's bothering you."; break;
        case 6: sText = "Tom Miller has been looking frazzled recently."; break;
        case 7: sText = "The other day I saw a rat the size of my foot.  And I have big feet."; break;
        case 8: sText = "The ale here is the finest within a hundred leagues."; break;
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
