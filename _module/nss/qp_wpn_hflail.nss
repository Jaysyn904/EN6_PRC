#include "utl_i_sqluuid"

void main()
{
object oPC;

oPC=GetPCSpeaker();

CreateItemOnObject("en3_qhflail",oPC);
SQLocalsUUID_SetString(oPC,"QPTag","en3_qhflail");

}
