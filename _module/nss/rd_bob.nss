#include "nw_i0_plot"

void HealPC(object oPC);
void RemoveBadEffects(object oDead);

void main()
{
object oPC;
int iLevel;
int iGold;
int iPCGold;

oPC = GetPCSpeaker();
iLevel = GetLocalInt(GetArea(OBJECT_SELF),"MinimumLevel");
iGold = 250;

iPCGold = GetGold(oPC);

if (iPCGold >= iGold)
    {
    TakeGold(iGold,oPC);
    HealPC(oPC);
    } else {
    SpeakString("I need a donation of " + IntToString(iGold) + " before I can heal you.");
    }

}

void HealPC(object oPC)
{
int iIndex;
object oHenchman;

DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_HEAL,oPC)));
DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC));
DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC));
DelayCommand(3.0,RemoveBadEffects(oPC));

iIndex=1;
oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,iIndex);
while (GetIsObjectValid(oHenchman) && iIndex<11)
    {
    DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oHenchman));
    DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oHenchman)), oHenchman));
    DelayCommand(3.0,RemoveBadEffects(oHenchman));
    iIndex++;
    }

}

void RemoveBadEffects(object oDead)
{
    //Declare major variables
    object oTarget = oDead;
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    int bValid;

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE
                )
            {
                //Remove effect if it is negative.
                RemoveEffect(oTarget, eBad);
            }
        eBad = GetNextEffect(oTarget);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);

    // * May 2002: Removed this because ActionRest is no longer an instant.
    // * rest the player
    //AssignCommand(oDead, ActionRest());
}
