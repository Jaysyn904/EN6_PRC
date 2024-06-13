#include "utl_i_sqluuid"

void main()
{
//:: Declare major variables
	object oPC = GetPCSpeaker();
	
	string sTag;

	if (SQLocalsUUID_GetString(oPC,"QPWeaponTag") == "" && SQLocalsUUID_GetString(oPC,"QPTag") != "")
	{
		sTag = SQLocalsUUID_GetString(oPC,"QPTag");
		SQLocalsUUID_SetString(oPC,"QPWeaponTag",sTag);
	}
}