void main()
{
object oPC;
effect eVis;
effect eDam;

oPC=GetEnteringObject();

if (GetIsPC(oPC) || GetIsPC(GetMaster(oPC)))
    {
    if (GetLocalInt(OBJECT_SELF,"Active")==1)
        {
        object oWP=GetObjectByTag("TM1_TPDest");
        AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
        SendMessageToPC(oPC,"You feel the winds of magic sweep you to a different location.");
        } else {
        if (Random(6)==0 && GetLocalInt(OBJECT_SELF,"TrapSprung")==0)
            {
            SetLocalInt(OBJECT_SELF,"TrapSprung",1);
            eVis = EffectVisualEffect(VFX_FNF_SWINGING_BLADE);
            DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC),3.0));
            if (ReflexSave(oPC,24) == 0)
                {
                eDam = EffectDamage(d6(3), DAMAGE_TYPE_SLASHING);
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
                }
            }
        }
    }
}
