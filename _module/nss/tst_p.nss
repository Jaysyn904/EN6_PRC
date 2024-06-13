void main()
{
object oSparks;



oSparks=GetObjectByTag("en6_gsparks");

location lLoc=GetLocation(oSparks);

ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY),GetFirstPC());

DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),lLoc,6.0));
DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION),lLoc));
DelayCommand(3.0,DestroyObject(oSparks));
}
