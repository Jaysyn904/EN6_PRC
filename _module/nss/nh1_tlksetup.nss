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
        case 2: sText = "I think Hank has a crush on Sally.  They are always sitting together."; break;
        case 3: sText = "I can tell you that Daniel dresses very fine."; break;
        case 4: sText = "I saw Craig battling with a giant spider the other day.  Things sure are dangerous here lately."; break;
        case 5: sText = "Used to be that you could come in here and get something to eat without a bunch of adventurer's bothering you."; break;
        case 6: sText = "Berister has been working late into the night lately.  Not good considering he's supposed to keep us safe.  Only thing that can mean is it's been tough going."; break;
        case 7: sText = "Farmer John really doesn't like his cousin that much.  Comes in here grumpy anytime his cousin comes to stay with him."; break;
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
