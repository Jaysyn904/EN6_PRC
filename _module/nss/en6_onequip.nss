void main()
{
object oPC   = GetPCItemLastEquippedBy();

ExecuteScript("x2_mod_def_equ",OBJECT_SELF);

if (GetIsPC(oPC))
    ExecuteScript("en6_special",oPC);
}
