//::///////////////////////////////////////////////
//:: FileName en5_openshop
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/4/2005 1:16:52 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("en5_shop");
    if (!GetIsObjectValid(oStore))
        oStore = GetObjectByTag("NH1_General");

    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
