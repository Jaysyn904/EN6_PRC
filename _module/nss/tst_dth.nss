void main()
{
object oPC=GetEnteringObject();

if (GetIsPC(oPC))
    {
    SendMessageToPC(oPC,"Boom! Tough actin' death.");
    effect eEff=EffectDamage(GetMaxHitPoints(oPC)+1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEff,oPC);
    }
}
