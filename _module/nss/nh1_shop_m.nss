//::///////////////////////////////////////////////
//:: FileName nh1_shop_m
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/29/2005 10:37:45 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

	// Either open the store with that tag or let the user know that no store exists.
	object oStore = GetNearestObjectByTag("NH1_Magic");
	if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
		gplotAppraiseOpenStore(oStore, GetPCSpeaker());
	else
		ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
