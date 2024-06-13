//::///////////////////////////////////////////////
//:: FileName en3_gypsy1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/26/2004 12:52:56 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
int iRandom;
int iRandom2;
string sStore;

sStore = GetLocalString(OBJECT_SELF,"GypsyStore");
if (sStore == "")
    {
    sStore = "NW_STORETHIEF001";
    iRandom = Random(12)+1;
    switch (iRandom)
        {
        case 1: iRandom2 = Random(3)+1;
                sStore = "NW_STORETHIEF00" + IntToString(iRandom2);
                break;
        case 2: iRandom2 = Random(3)+1;
                sStore = "X2_STORETHIEF00" + IntToString(iRandom2);
                break;
        case 3: iRandom2 = Random(3)+1;
                sStore = "NW_STORGENRAL00" + IntToString(iRandom2);
                break;
        case 4:
                sStore = "X2_STOREGENL001";
                break;
        case 5: iRandom2 = Random(3)+1;
                sStore = "X2_STOREMAGE00" + IntToString(iRandom2);
                break;
        case 6: iRandom2 = Random(4)+1;
                sStore = "NW_STOREMAGIC00" + IntToString(iRandom2);
                break;
        case 7: iRandom2 = Random(4)+1;
                sStore = "NW_STORENATU00" + IntToString(iRandom2);
                break;
        case 8:
                sStore = "X2_STORENATR001";
                break;
        case 9: iRandom2 = Random(4)+1;
                sStore = "NW_STORETMPLE00" + IntToString(iRandom2);
                break;
        case 10: iRandom2 = Random(2)+1;
                sStore = "X2_STORETEMPL00" + IntToString(iRandom2);
                break;
        case 11: iRandom2 = Random(4)+1;
                sStore = "NW_STOREWEAP00" + IntToString(iRandom2);
                break;
        case 12: iRandom2 = Random(3)+1;
                sStore = "X2_STOREWEAP00" + IntToString(iRandom2);
                break;
        }
    SetLocalString(OBJECT_SELF,"GypsyStore",sStore);
    }
    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetObjectByTag(sStore);
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
        }
    else
        {
        SendMessageToPC(GetPCSpeaker(),"Could not open store : " + sStore);
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
        }
}
