#include "nw_i0_tool"
#include "utl_i_sqluuid"

int StartingConditional()
{
//:: Declare major variables
	object oPC = GetPCSpeaker();
	
	string sTag = SQLocalsUUID_GetString(oPC,"QPTag");

	if (!(sTag == "") && HasItem(oPC, sTag))
		return FALSE;

	return TRUE;
}