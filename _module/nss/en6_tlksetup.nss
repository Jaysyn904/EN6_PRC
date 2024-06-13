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
        case 1: sText = "Not much to tell. I try to keep my nose out of folks business."; break;
        case 2: sText = "I ate me some pancakes for breakfast.  Ain't got much use for talk right now, too full to concentrate."; break;
        case 3: sText = "I hear the mage's guild is giving out enchantments to those that do them enough favors.  What, with times being as they is, I suppose it's their way to help out."; break;
        case 4: sText = "That Craig, he's a fine one, heard he bagged himself some type of magical critter.  Had claws that dripped venom and a mouth full of fangs from the way I hear it told."; break;
        case 5: sText = "Adventurer passed through here the other day and cleared out a nest of undead for the church and I hear they blessed him with a divine favor."; break;
        case 6: sText = "I hear Daniel killed himself an ogre.  Don't know what we'd do without him around helping us out."; break;
        case 7: sText = "If you see my brother tell him he still owes me that silver piece.  He's a tall fellow, not too bright, not nice to look at either."; break;
        case 8: sText = "I swear I heard a scream the other night.  Didn't much figure to go check it out though, what with times being as they is and all."; break;
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
