#include "nw_i0_plot"
#include "rd_level"

void main()
{
object oHench;
int iGold;

iGold = GetHitDice(GetPCSpeaker()) * 250;



if (GetLocalString(GetPCSpeaker(),"Henchman") != "")
    oHench = GetObjectByTag(GetLocalString(OBJECT_SELF,"RezTag"));

if (GetIsObjectValid(oHench))
    {
    ActionCastFakeSpellAtObject(SPELL_RESURRECTION,GetPCSpeaker());
    TakeGoldFromCreature(iGold,GetPCSpeaker(),TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oHench);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oHench)), oHench);
    RemoveEffects(oHench);

    object oPC = GetPCSpeaker();
    AddHenchman(oPC, oHench);
    if (GetHitDice(OBJECT_SELF) < GetHitDice(oPC))
        LevelMob(OBJECT_SELF,GetHitDice(oPC)-GetHitDice(OBJECT_SELF));

    DelayCommand(0.1f,AssignCommand(oHench,ActionJumpToLocation(GetLocation(oPC))));
    effect eRaise = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    DelayCommand(1.5f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRaise,oHench));
    //SetLocalInt(oPC,"RestGold",GetGold(oPC));
    }
else
    SendMessageToPC(GetPCSpeaker(),"Henchman could not be found.");
}
