void main()
{
object oHench=OBJECT_SELF;

SendMessageToPC(GetFirstPC(),"Check Hench=" + GetName(oHench) + " | Master = " + GetName(GetMaster(oHench)));
SendMessageToPC(GetFirstPC(),"Rez=" + IntToString(GetHasSpell(SPELL_RESURRECTION)) + " | Raise = " + IntToString(GetHasSpell(SPELL_RAISE_DEAD)));
ClearAllActions();
ActionCastSpellAtObject(SPELL_RESURRECTION,GetMaster(oHench),METAMAGIC_ANY,TRUE);

//nw_i0_generic
//AssignCommand(oHench, ClearAllActions());
//AssignCommand(oHench,ActionCastSpellAtObject(SPELL_RESURRECTION,GetMaster(oHench),METAMAGIC_ANY,TRUE));


//DelayCommand(0.1,AssignCommand(oHench,ActionCastSpellAtObject(SPELL_RESURRECTION,oPlayer)));
//DelayCommand(0.1,AssignCommand(oHench,ActionCastSpellAtObject(SPELL_RAISE_DEAD,oPlayer)));

}
