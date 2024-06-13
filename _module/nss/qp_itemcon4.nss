#include "utl_i_sqluuid"

int StartingConditional()
{
//:: Declare major variables
	object oPC = GetPCSpeaker();
	
	string sTag = SQLocalsUUID_GetString(oPC,"QPWeaponTag");

	SQLocalsUUID_SetString(oPC,"QPTag",sTag);
	//sTag = GetLocalString(GetPCSpeaker(),"QPRingTag");

	if (sTag == "")
		return TRUE;

	return FALSE;

}