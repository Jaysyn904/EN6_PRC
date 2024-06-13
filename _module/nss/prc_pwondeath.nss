//:://////////////////////////////////////////////////
//:: prc_pwondeath
/*
	PRC's onDeath catch all
 */
//:://////////////////////////////////////////////////

void main()
{
    ExecuteScript("en4_mobdeath",OBJECT_SELF);
	ExecuteScript("prc_npc_death", OBJECT_SELF);
}
