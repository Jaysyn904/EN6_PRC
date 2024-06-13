#include "utl_i_sqluuid"

void main()
{
object oPC;

oPC=GetPCSpeaker();

CreateItemOnObject("en3_qstaff",oPC);
SQLocalsUUID_SetString(oPC,"QPTag","en3_qstaff");

}
