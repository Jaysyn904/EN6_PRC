//:://////////////////////////////////////////////////
//:: prc_pwonspawn.nss
/*
	PRC onSpawn catchall
 */
//:://////////////////////////////////////////////////

void main()
{
	ExecuteScript("en5_onspawn",OBJECT_SELF);
	ExecuteScript("prc_npc_spawn",OBJECT_SELF);
}