void main()
{
object oHenchman;
object oHenchToRez;
string sTag;

oHenchman=OBJECT_SELF;
sTag=GetLocalString(OBJECT_SELF,"RezTag");
oHenchToRez=GetObjectByTag(sTag);

if (GetLocalInt(oHenchman,"RESURRECTION") ==0 && GetLevelByClass(CLASS_TYPE_CLERIC,oHenchman)>12)
    {
    AssignCommand(oHenchman,ClearAllActions());
    AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_RESURRECTION,oHenchToRez,METAMAGIC_ANY,TRUE));
    SetLocalInt(oHenchman,"RESURRECTION",1);
    } else {
    AssignCommand(oHenchman,ClearAllActions());
    AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_RAISE_DEAD,oHenchToRez,METAMAGIC_ANY,TRUE));
    SetLocalInt(oHenchman,"RAISE_DEAD",1);
    }

}
