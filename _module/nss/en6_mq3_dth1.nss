#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "en5_misc"
#include "nw_i0_tool"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    // If we're a good/neutral commoner,
    // adjust the killer's alignment evil
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    craft_drop_items(oKiller);
    ExecuteScript("en4_mobdeath",OBJECT_SELF);


object oSparks;
location lLoc;

oSparks=GetObjectByTag("en6_gsparks");
lLoc=GetLocation(oSparks);

DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),lLoc,6.0));
DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION),lLoc));
DelayCommand(3.0,DestroyObject(oSparks));

DelayCommand(6.0,ENSendMessageToParty(oKiller,"With the death of " + GetName(OBJECT_SELF) + " his magic fades and the poisonous ritual is disrupted."));
DelayCommand(6.2,RewardPartyXP(5000, oKiller));
SetLocalInt(GetModule(),"MainQuest",4);
}
