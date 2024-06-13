//::///////////////////////////////////////////////
//:: FileName en5_openshop
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/4/2005 1:16:52 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"
#include "en5_treasure"
#include "en5_misc"

void SetupFence(string sFence);

void main()
{
string sTag;

    sTag=GetLocalString(OBJECT_SELF,"Shop");
    if (sTag=="")
        {
        if (GetLocalInt(OBJECT_SELF,"Fence") == 0)
            sTag="en6_random" + IntToString(Random(6)+1);
        else
            {
            sTag="en6_fence" + IntToString(Random(3)+1);
            SetupFence(sTag);
            }

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


void SetupFence(string sFence)
{
object oMer;
//object oPC;
string sTag;
int iIndex;

if (GetLocalInt(GetModule(),sFence) == 0)
    {

    //oPC = GetFirstPC();
    oMer = GetObjectByTag(sFence);

    iIndex = 1;
    while (iIndex < 11)
        {
        GetMagicItem(oMer,Random(6)+1,0,GetRandomPC());
        iIndex++;
        }

    SetLocalInt(GetModule(),sFence,1);
    }
}
