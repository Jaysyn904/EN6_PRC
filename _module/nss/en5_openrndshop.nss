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
string sTag;

    // Either open the store with that tag or let the user know that no store exists.
    sTag=GetLocalString(OBJECT_SELF,"Shop");
    if (sTag=="")
        {
        sTag="en6_random" + IntToString(Random(3)+1);
        SetLocalString(OBJECT_SELF,"Shop",sTag);
        }
    object oStore = GetObjectByTag(sTag);
    if (!GetIsObjectValid(oStore))
        oStore = GetObjectByTag("NH1_General");

    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
