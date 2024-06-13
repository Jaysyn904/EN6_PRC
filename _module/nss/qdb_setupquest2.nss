#include "qdb_include"

void main()
{
string sAccomplishment;
string sSA;
int iType2;
int iType;
int iSA;

sAccomplishment=GetQuestString("Accomplishment");
if (sAccomplishment=="")
    {
    //SetStepNumber(2);
    //iType2=GetStepInt("Type2");
    SetStepNumber(1);
    iType=GetStepInt("Type");
    iSA=GetStepInt("SpecialArea");
    switch (iSA)
        {
        case 1: sSA="some farm fields"; break;
        case 3: sSA="a fort"; break;
        case 4: sSA="an ant field"; break;
        case 5: sSA="a graveyard"; break;
        case 6: sSA="a lake"; break;
        case 7: sSA="a grove of trees"; break;
        case 8: sSA="an abandoned tower"; break;
        }

    if (iType==1)
        SetQuestString("Accomplishment","helped [npc] by defeating a [mob] near [area].");
    if (iType==2)
        SetQuestString("Accomplishment","aided [npc] in defeating some [camp] near [area].");
    if (iType==3)
        SetQuestString("Accomplishment","delivered something for [npc] in [area].");
    if (iType==4)
        SetQuestString("Accomplishment","rescued [npc] from [camp] in [area].");
    if (iType==5)
        SetQuestString("Accomplishment","helped [npc] in [area].");
    if (iType==6)
        SetQuestString("Accomplishment","aided [npc] in defeating some [camp] in [area].");
    if (iType==7)
        SetQuestString("Accomplishment","helped [npc] in clearing out some [camp] in " + sSA + " near [area].");
    }

GrabQuest("TST");
SendMessageToPC(GetPCSpeaker(),"Quest setup on waypoint.");
}

