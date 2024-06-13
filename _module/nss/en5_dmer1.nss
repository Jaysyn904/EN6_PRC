//::///////////////////////////////////////////////
//:: FileName en5_dmer1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/12/2005 2:35:26 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetObjectByTag("en5_dmer1");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
