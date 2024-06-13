void main()
{
object oPC;
effect eVis;
effect eDam;

oPC=GetEnteringObject();

if (GetIsPC(oPC) && GetLocalInt(OBJECT_SELF,"Active") == 1)
    {
    eVis = EffectVisualEffect(VFX_COM_HIT_FIRE);
    DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC),3.0));
    eDam = EffectDamage(d6(2), DAMAGE_TYPE_FIRE);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));

    }
}
