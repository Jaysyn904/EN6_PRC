#include "utl_i_sqluuid"

void main()
{
object oPC;

oPC=GetPCSpeaker();

CreateItemOnObject("en3_qkama",oPC);
SQLocalsUUID_SetString(oPC,"QPTag","en3_qkama");

}
