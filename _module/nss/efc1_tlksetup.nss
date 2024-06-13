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
        case 2: sText = "I saw a giant beetle in the forest yesterday.  Darned thing was as big as a wolf."; break;
        case 3: sText = "The woodland creatures seem unusually quiet here of late."; break;
        case 4: sText = "Things sure are dangerous here lately."; break;
        case 5: sText = "Used to be that you could come in here and get something to eat without a bunch of adventurer's bothering you."; break;
        case 6: sText = "All the hunters were tracking some strange creature in the forest earlier this morning."; break;
        case 7: sText = "My cousin in Nova said that the merchants were too scared to travel through Evari these days."; break;
        case 8: sText = "The ale here isn't as fine as you'd find in a city, but it's smooth and good."; break;
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
