#include "utl_i_sqluuid"

void main()
{
object oPC;

oPC=GetPCSpeaker();

CreateItemOnObject("en3_qlflail",oPC);
SQLocalsUUID_SetString(oPC,"QPTag","en3_qlflail");

}
