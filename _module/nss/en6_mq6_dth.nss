#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "qst_include"

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

if (GetLocalInt(OBJECT_SELF,"Betrayal") > 0)
    {
    SendMessageToPC(oKiller,"You have overcome " + GetName(OBJECT_SELF) + "'s betrayal.");
    RewardPartyXP(3000, oKiller);
    SetPartyVariables(oKiller);
    SetPartyInt(oKiller,"OnQuest",0);
    SetLocalInt(GetModule(),"MainQuest",98);
    AddJournalQuestEntry("jQuest",21,oKiller);
    }
}
